shader_type canvas_item;

uniform float speed = 0.01;

void fragment() {
	vec2 new_uv = vec2(UV.x + TIME * speed, UV.y);
	COLOR = texture(TEXTURE,new_uv);
}

