extends Node

@onready var loading_scene: PackedScene = preload("res://Scenes/loading_bar.tscn")

var scene_to_load_path: String = ""
var loading_screen_scene_instance: Node = null
var loading: bool = false
var progress_bar: ProgressBar = null
var current_progress: float = 0.0  # Stores the progress value
var progress_smoothing: float = 5.0  # Adjust speed loading bar transition
var scene_ready: bool = false  # Ensures scene only loads after reaching 100%

func load_scene(path: String) -> void:
	if loading:
		return  # Prevent multiple load calls

	loading_screen_scene_instance = loading_scene.instantiate()
	get_tree().root.call_deferred("add_child", loading_screen_scene_instance)

	# Find ProgressBar safely after instance is added
	await get_tree().process_frame  # Ensures node is fully added
	progress_bar = loading_screen_scene_instance.get_node_or_null("Control/ProgressBar")

	# Start loading process
	if ResourceLoader.has_cached(path):
		ResourceLoader.load_threaded_get(path)
	else:
		ResourceLoader.load_threaded_request(path)

	loading = true
	scene_to_load_path = path
	scene_ready = false  # Scene is not ready until progress bar reaches 100%

func _process(delta: float) -> void:
	if not loading:
		return
	
	var progress := []
	var status := ResourceLoader.load_threaded_get_status(scene_to_load_path, progress)

	if progress_bar:
		var target_progress: float = 100.0 if status == ResourceLoader.THREAD_LOAD_LOADED else float(progress[0]) * 100.0
		current_progress = lerp(current_progress, target_progress, delta * progress_smoothing)
		progress_bar.value = current_progress  # Apply smooth transition

		# When the bar reaches 99.9%+, lock it to 100 and allow scene change
		if current_progress >= 99.9 and status == ResourceLoader.THREAD_LOAD_LOADED:
			current_progress = 100.0
			progress_bar.value = 100.0
			scene_ready = true

	# Only change scene after reaching 100%
	if scene_ready and current_progress >= 100.0:
		await get_tree().process_frame  # Wait one more frame to ensure visual update
		get_tree().change_scene_to_packed(ResourceLoader.load_threaded_get(scene_to_load_path))
		loading_screen_scene_instance.queue_free()
		loading = false
		current_progress = 0.0  # Reset for next load
