shader_type canvas_item;

uniform bool on_hit = false;
uniform bool on_kill = false;

uniform float progress : hint_range(0.0, 1.0);
uniform float noise_desnity = 60;
uniform float beam_size : hint_range(0.01, 0.15);

uniform vec4 color : hint_color = vec4(0.0, 1.02, 1.2, 1.0);

vec2 random(vec2 uv){
	uv = vec2( dot(uv, vec2(127.1,311.7) ),
	           dot(uv, vec2(269.5,183.3) ) );
	return -1.0 + 2.0 * fract(sin(uv) * 43758.5453123);
}

float noise(vec2 uv) {
	vec2 uv_index = floor(uv);
	vec2 uv_fract = fract(uv);
	
	vec2 blur = smoothstep(0.0, 1.0, uv_fract);
	
	return mix( mix( dot( random(uv_index + vec2(0.0,0.0) ), uv_fract - vec2(0.0,0.0) ),
					 dot( random(uv_index + vec2(1.0,0.0) ), uv_fract - vec2(1.0,0.0) ), blur.x),
				mix( dot( random(uv_index + vec2(0.0,1.0) ), uv_fract - vec2(0.0,1.0) ),
					 dot( random(uv_index + vec2(1.0,1.0) ), uv_fract - vec2(1.0,1.0) ), blur.x), blur.y) * 0.5 + 0.5;
}

void fragment() {
	vec4 texture_color = texture(TEXTURE, UV);
	
	if (on_hit) {
		texture_color.rgb = vec3(1.0, 1.0, 1.0);
	}
	
	if (on_kill) {
		float noise = noise(UV * noise_desnity) * UV.y;
	
		float d1 = step(progress, noise);
		float d2 = step(progress - beam_size, noise);
		
		vec3 beam = vec3(d2 - d1) * color.rgb;
		
		texture_color.rgb += beam;
		texture_color.a *= d2;
	}
	
	COLOR = texture_color;
}