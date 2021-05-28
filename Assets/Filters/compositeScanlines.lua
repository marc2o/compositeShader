--[[
  composite video signal shader with color fragments
  based on https://www.shadertoy.com/view/Mdffz7 by John Leffingwell
  license CC BY-SA

  usage:
  myShader = require("compositeScanlines")
  myShader:send("screen", {
    canvas:getWidth(),
    canvas:getHeight()
  })

]]
return love.graphics.newShader[[
    #define TAU 6.28318530717958647693
    extern vec2 screen;
    const mat3 YIQ2RGB = mat3(
      1.000,  1.000,  1.000,
      0.956, -0.272, -1.106,
      0.621, -0.647,  1.703
    );
    vec4 effect(vec4 sys_color, Image texture, vec2 texture_coords, vec2 screen_coords) {
      vec4 pixel = Texel(texture, texture_coords);

      vec3 YIQ = vec3(0);
      for (int n = -2; n < 2; n++) {
        vec2 pos = texture_coords + vec2(float(n) / screen.x, 0.0);
        float phase = (texture_coords.x + float(n)) * TAU / 4.0;
        YIQ += Texel(texture, pos).rgb * vec3(1.0, cos(phase), sin(phase));
      }
      YIQ /= 4.0;
      
      pixel *= vec4(YIQ2RGB * YIQ, 1.0) + 0.4;

      float scanline = clamp(mod(screen_coords.y, 2) * 0.2 + 0.8, 0, 1);
      pixel.rgb *= scanline;
    
      return pixel * sys_color;
    }
  ]]