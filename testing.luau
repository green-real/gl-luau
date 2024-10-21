local ffi = require("@lune/ffi")

local glfwDll = ffi.open("./deps/glfw3.dll")
local glfwInit = ffi.fnInfo({}, ffi.i32):callable(glfwDll:find("glfwInit"))

print(ffi)

local result = ffi.box(ffi.i32.size)
glfwInit:call(result)


-- local function test_add_i32()
-- 	local add_i32 = ffi.fnInfo({ ffi.i32, ffi.i32 }, ffi.i32)

-- 	local add_i32_caller = add_i32:callable(lib:find("add_i32"))

-- 	local resultBox = ffi.box(ffi.i32.size)
-- 	local arg1 = ffi.i32:box(100)
-- 	local arg2 = ffi.i32:box(200)

-- 	add_i32_caller:call(resultBox, arg1, arg2)
-- 	local result = ffi.i32:readData(resultBox)

-- 	assert(result == 300, `add_i32 failed. result expected 300, got {result}`)
-- end

-- test_add_i32()

-- local function test_mul_i32()
-- 	local mul_i32 = ffi.fnInfo({ ffi.i32, ffi.i32 }, ffi.i32)

-- 	local mul_i32_caller = mul_i32:callable(lib:find("mul_i32"))

-- 	local resultBox = ffi.box(ffi.i32.size)
-- 	local arg1 = ffi.i32:box(100)
-- 	local arg2 = ffi.i32:box(200)

-- 	mul_i32_caller:call(resultBox, arg1, arg2)
-- 	local result = ffi.i32:readData(resultBox)

-- 	assert(result == 20000, `mul_i32 failed. result expected 20000, got {result}`)
-- end

-- test_mul_i32()
