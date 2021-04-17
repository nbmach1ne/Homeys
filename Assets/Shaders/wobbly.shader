shader_type canvas_item;

uniform float noise_scale;
uniform float time_snap;

float snapTime(float time)
{
	return time_snap * round(time / time_snap);
}

float rand(vec2 coord)
{
	return fract(sin(dot(coord, vec2(12.9898, 78.233))) * 43758.5453);
}

void vertex()
{
	float time = snapTime(TIME);
	vec2 noise = vec2(rand(VERTEX.xy + time)) * noise_scale;
	VERTEX += noise;
}