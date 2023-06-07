shader_type canvas_item;
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

void fragment() {
    vec4 c = texture(SCREEN_TEXTURE,SCREEN_UV);
    vec4 v = texture(TEXTURE,UV);
//    c.rgb += .25*v.a;
	c.rgb += .1*v.a;
	
    COLOR = c;

}