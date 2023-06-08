shader_type canvas_item;

uniform vec4 color: source_color = vec4(.5, .5, 1.0, 1.0);
uniform float width : hint_range(0.0, 0.5) = 0.01;

float border(vec2 uv, float border_width)
{
    vec2 bottom_left = step(vec2(border_width), uv);
    vec2 top_right = step(vec2(border_width), 1.0 - uv);
    return bottom_left.x * bottom_left.y * top_right.x * top_right.y;
}

void fragment()
{
    COLOR = mix(color, COLOR, border(UV, width));
}