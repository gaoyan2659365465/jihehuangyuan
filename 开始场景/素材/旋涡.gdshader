shader_type canvas_item;

uniform float offset : hint_range(0.0, 20.0, 0.01);
uniform float speed : hint_range(0.0, 1.0, 0.01);
uniform float mask : hint_range(0.0, 1.0, 0.01);
uniform vec4 color : source_color;

vec2 rotate(vec2 p, float angle){
	return vec2(cos(angle)*p.x-sin(angle)*p.y, sin(angle)*p.x + cos(angle)*p.y);
}

void fragment(){
	
	vec2 uv = UV;
	float c = length(UV - vec2(0.5));
	
	uv = rotate(uv-vec2(0.5),offset * c) + vec2(0.5);
	uv.x = abs((uv.x-0.5)*2.0);
	uv.x = fract(uv.x + speed*TIME);
	
	vec4 tex_color = texture(TEXTURE,uv);
	
	COLOR = tex_color * color;
	float mask_color = 1.0-step(mask,c);
	//COLOR = vec4(mask_color,0.0,0.0,1.0);
	COLOR.a = COLOR.a * mask_color;
	
}
