shader_type canvas_item;

uniform float intensity = 0;

void fragment() {
	
	vec2 uv = UV;
	vec4 c = texture(TEXTURE, uv);
	vec4 cr = texture(TEXTURE, uv + vec2(.01,0));
	vec4 cl = texture(TEXTURE, uv - vec2(.01,0));
	c.r += cr.r;
	c.b += cl.b;
	
	
	COLOR.a = 0.;
		
	
//	COLOR = c;

}
