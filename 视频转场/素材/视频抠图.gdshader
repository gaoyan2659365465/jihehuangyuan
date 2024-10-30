shader_type canvas_item;

uniform vec4 color:source_color;

void fragment() {
	COLOR = texture(TEXTURE,UV);
	COLOR.a = COLOR.g;
	COLOR.rgb = vec3(1.0)*color.rgb;
}
