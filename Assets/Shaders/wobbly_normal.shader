shader_type canvas_item;

uniform sampler2D normal_map : hint_black;
uniform vec2 normal_noise_scale = vec2(1.0, 1.0);
uniform float noise_scale;
uniform float time_snap;

float snapTime(float time)
{
	return time_snap * round(time / time_snap);
}

void fragment()
{
	float time = snapTime(TIME);
	vec2 scaled_uv = UV * normal_noise_scale;
	scaled_uv += time;
	
	vec2 noise = texture(normal_map, scaled_uv).rg;
	noise = noise * 2.0 - 1.0;
	
	COLOR = texture(TEXTURE, UV + noise * noise_scale);
}