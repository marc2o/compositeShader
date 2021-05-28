# LÖVE Retro-Shader

![Screenshot](https://raw.githubusercontent.com/marc2o/compositeShader/screenshot.png)

Composite video signal shader with color fragments and scaliness for LÖVE (https://love2d.or).

Based on **NTSC Decoder** by John Leffingwell ([https://www.shadertoy.com/view/Mdffz7](https://www.shadertoy.com/view/Mdffz7)).

SMPTE color bars test image taken from https://en.wikipedia.org/wiki/SMPTE_color_bars.

Basic usage:

```lua
myShader = require("path.to.compositeScanlines")
myShader:send("screen", {
	canvas:getWidth(),
	canvas:getHeight()
})
```

License CC BY-SA
