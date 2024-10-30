shader_type canvas_item;
render_mode blend_add;

uniform float edge:hint_range(0.0,0.5);
uniform float size:hint_range(0.0,1.0);

void fragment(){
	float a = length(UV-0.5);
	float b = 1.- smoothstep(edge,size,a);
	COLOR = vec4(COLOR.r,COLOR.g,COLOR.b,b*COLOR.a);
}
