shader_type spatial;

uniform vec3 water_color: source_color;
uniform float time_scale: hint_range(0.0, 10.0, 0.25) = 1.0;
uniform sampler2D water_normal_noise;


void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec2 _uv = UV;
	_uv.x += sin(TIME * time_scale + (_uv.x + _uv.y) * 25.0) * 0.01f;
	_uv.y += cos(TIME * time_scale + (_uv.x - _uv.y) * 25.0) * 0.01f;
	ALBEDO = water_color;
	NORMAL_MAP = texture(water_normal_noise, UV).rgb;
	NORMAL *= 0.5f;
	ROUGHNESS = 0.2f;
	ALPHA = 0.5;
}

void light() {
	// Called for every pixel for every light affecting the CanvasItem.
}
