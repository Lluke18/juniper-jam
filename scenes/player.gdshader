shader_type canvas_item;

uniform float progress : hint_range(0.0, 1.0) = 0.5;
uniform vec4 fill_color : source_color = vec4(0.0, 0.8, 1.0, 1.0); // Neon Cyan
uniform vec4 bg_color : source_color = vec4(0.05, 0.05, 0.1, 0.8); // Dark translucent blue
uniform vec4 border_color : source_color = vec4(0.0, 1.0, 1.0, 1.0);
uniform float border_width : hint_range(0.0, 0.1) = 0.02;
uniform float scanline_speed : hint_range(0.0, 10.0) = 5.0;

void fragment() {
    vec2 uv = UV;

    // 1. Calculate the borders
    bool is_border = uv.x < border_width || uv.x > 1.0 - border_width ||
                     uv.y < border_width || uv.y > 1.0 - border_width;

    // 2. Check if the current pixel is within the filled progress area
    // We subtract border_width so the fill doesn't overlap the right border
    bool is_filled = uv.x < progress * (1.0 - border_width * 2.0) + border_width && uv.x > border_width;

    // 3. Create a futuristic animated scanline effect
    float scanline = sin(uv.y * 60.0 - TIME * scanline_speed) * 0.15;

    vec4 final_color = bg_color;

    if (is_border) {
        final_color = border_color;
        // Make the border pulse slightly
        final_color.a += sin(TIME * 2.0) * 0.2; 
    } else if (is_filled) {
        final_color = fill_color;
        // Apply the scanlines to the fill
        final_color.rgb += vec3(scanline); 

        // Add a bright, concentrated laser edge at the very tip of the progress
        float tip_position = progress * (1.0 - border_width * 2.0) + border_width;
        if (abs(uv.x - tip_position) < 0.015) {
            final_color.rgb += vec3(0.6); // White-hot glow at the edge
        }
    }

    COLOR = final_color;
}
