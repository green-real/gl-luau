local ffi = require("../ffi")
local t_void = ffi.c.types.void
local t_int = ffi.c.types.int
local t_voidptr = ffi.c.types.voidptr

local imageDefs: {[string]: any} = {
	stbi_load = {returns = t_voidptr, args = {t_voidptr, t_voidptr, t_voidptr, t_voidptr, t_int}},
	stbi_image_free = {returns = t_void, args = {t_voidptr}},
	stbi_set_flip_vertically_on_load = {returns = t_void, args = {t_int}},
}

local imageDll = ffi.loadLib("./resources/bin/stb_image.dll", imageDefs)

local image = {
	set_flip_vertically_on_load = imageDll.stbi_set_flip_vertically_on_load,
	free = imageDll.stbi_image_free,
	load = imageDll.stbi_load,
}

return image