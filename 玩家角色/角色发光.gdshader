shader_type canvas_item;
//用于精灵图片辉光效果
render_mode blend_add;

uniform vec4 color : source_color = vec4(1.0);
uniform float n = 1.0;
void fragment() {
	COLOR = texture(TEXTURE,UV);
	COLOR =  COLOR * color;
	COLOR.a = COLOR.a * n;
}