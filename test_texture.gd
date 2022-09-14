tool
extends ImageTexture
class_name TestTexture

export var image_size := Vector2(96, 96) setget set_image_size
export var cells := Vector2(2, 2) setget set_cells
export var show_grid := true setget set_show_grid
export var color1 := Color('ccc') setget set_color1
export var color2 := Color('999') setget set_color2
export var grid_color := Color('333') setget set_grid_color

func _init() -> void:
	_update_image()

func set_image_size(value: Vector2) -> void:
	image_size = Vector2(int(clamp(value.x, 1, 1024)), int(clamp(value.y, 1, 1024)))
	_update_image()

func set_cells(value: Vector2) -> void:
	cells = Vector2(int(clamp(value.x, 1, 64)), int(clamp(value.y, 1, 64)))
	_update_image()

func set_show_grid(value: bool) -> void:
	show_grid = value
	_update_image()

func set_color1(value: Color) -> void:
	color1 = value
	_update_image()

func set_color2(value: Color) -> void:
	color2 = value
	_update_image()

func set_grid_color(value: Color) -> void:
	grid_color = value
	_update_image()

func _update_image() -> void:
	var img := Image.new()
	img.create(int(image_size.x), int(image_size.y), false, Image.FORMAT_RGBA8)
	img.fill(color1)
	
	var cell_size := image_size / cells
	
	for i in int(cells.x):
		for j in int(cells.y):
			if i % 2 != j % 2:
				img.fill_rect(Rect2(Vector2(i, j) * cell_size, cell_size), color2)
	
	if show_grid:
		for i in int(cells.x):
			img.fill_rect(Rect2(i * cell_size.x, 0, 1, image_size.y), grid_color)
		img.fill_rect(Rect2(image_size.x - 1, 0, 1, image_size.y), grid_color)
		for j in int(cells.y):
			img.fill_rect(Rect2(0, j * cell_size.y, image_size.x, 1), grid_color)
		img.fill_rect(Rect2(0, image_size.y - 1, image_size.x, 1), grid_color)
	
	create_from_image(img, flags)
