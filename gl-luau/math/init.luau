-- WIP

local writef32 = buffer.writef32
local readf32 = buffer.readf32

local function vec3_new(x: number, y: number, z: number): buffer
	local buf = buffer.create(4 * 3)
	writef32(buf, 0, x)
	writef32(buf, 4, y)
	writef32(buf, 8 * 2, z)
	return buf
end

local function vec4_new(x: number, y: number, z: number, w: number): buffer
	local buf = buffer.create(4 * 4)
	writef32(buf, 0, x)
	writef32(buf, 4, y)
	writef32(buf, 8, z)
	writef32(buf, 12, w)
	return buf
end

local function mat4_identity(): buffer
	local buf = buffer.create(16 * 4)
	writef32(buf, 0, 1)
	writef32(buf, 20, 1)
	writef32(buf, 40, 1)
	writef32(buf, 60, 1)
	return buf
end

local function mat4_transform(x: number, y: number, z: number): buffer
	local buf = mat4_identity()
	writef32(buf, 48, x)
	writef32(buf, 52, y)
	writef32(buf, 56, z)
	
	return buf
end

local function mat4_matmul(a: buffer, b: buffer )
	local buf = buffer.create(16 * 4)
	for i = 0, 15, 4 do
		for j = 0, 15, 4 do
			local sum = 0
			for k = 0, 15, 4 do
				sum = sum + readf32(a, i * 4 + k) * readf32(b, k * 4 + j)
			end
			writef32(buf, i * 4 + j, sum)
		end
	end
	return buf
end

local gl_math = {
	vec3 = {
		new = vec3_new;
	};
	vec4 = {
		new = vec4_new;
	};
	mat4 = {
		identity = mat4_identity;
		transform = mat4_transform;
		matmul = mat4_matmul;
	};
}

return gl_math