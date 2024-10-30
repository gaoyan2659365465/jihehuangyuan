extends Polygon2D


@onready var collision_polygon_2d: CollisionPolygon2D = $"物理空气墙/CollisionPolygon2D"


func _ready() -> void:
	collision_polygon_2d.polygon = polygon
