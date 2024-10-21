local ffi = (require)("@zcore/ffi")

-- stb_image
-- only include the minimum required functions for loading images for opengl
local imageDefs: {[string]: any} = {
	stbi_load = {returns = ffi.types.pointer, args = {ffi.types.pointer, ffi.types.pointer, ffi.types.pointer, ffi.types.pointer, ffi.types.i32}},
	stbi_image_free = {returns = ffi.types.void, args = {ffi.types.pointer}},
	stbi_set_flip_vertically_on_load = {returns = ffi.types.void, args = {ffi.types.i32}},
}

local imageDll = ffi.dlopen("./deps/stb_image.dll", imageDefs)

local image = {
	set_flip_vertically_on_load = imageDll.stbi_set_flip_vertically_on_load,
	free = imageDll.stbi_image_free,
	load = imageDll.stbi_load,
}

return image