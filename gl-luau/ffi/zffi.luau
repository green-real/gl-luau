local zffi = (require)("@zcore/ffi")

local zffi_bufferToPtr = zffi.bufferToPtr :: (data: buffer) -> buffer
local zffi_sizeOf = zffi.sizeOf :: (type: any) -> number
local zffi_call = zffi.call :: (definition: {returns: any, args: {any}}, address: buffer, ...any) -> any
local zffi_closure = zffi.closure :: (definition: {returns: any, args: {any}}, func: (...any) -> any) -> {ptr: buffer}
local zffi_dlopen = zffi.dlopen :: (path: string, definitions: {[string]: {returns: any, args: {any}}}) -> {[string]: (...any) -> any}

local t_void = zffi.types.void
local t_schar = zffi.types.i8
local t_uchar = zffi.types.u8
local t_short = zffi.types.i16
local t_ushort = zffi.types.u16
local t_int = zffi.types.i32
local t_uint = zffi.types.u32
local t_long = zffi.types.i64
local t_ulong = zffi.types.u64
local t_float = zffi.types.float
local t_double = zffi.types.double
local t_pointer = zffi.types.pointer

local size_schar = zffi_sizeOf(t_schar)
local size_uchar = zffi_sizeOf(t_uchar)
local size_short = zffi_sizeOf(t_short)
local size_ushort = zffi_sizeOf(t_ushort)
local size_int = zffi_sizeOf(t_int)
local size_uint = zffi_sizeOf(t_uint)
local size_long = zffi_sizeOf(t_long)
local size_ulong = zffi_sizeOf(t_ulong)
local size_float = zffi_sizeOf(t_float)
local size_double = zffi_sizeOf(t_double)
local size_pointer = zffi_sizeOf(t_pointer)

local function getRef(data: buffer)
	return zffi_bufferToPtr(data)
end

local function createPtr(data: buffer)
	return data
end

local function createRawPtr(address: number)
	assert(address < 2^52, "address precision loss")

	local ptr = buffer.create(size_pointer)
	buffer.writeu32(ptr, 0, address)
	buffer.writeu32(ptr, 4, address // 0x100000000)
	return ptr
end

local function isNullPtr(ptr: buffer)
	return (buffer.readu32(ptr, 0) + buffer.readu32(ptr, 4)) == 0
end

local function floatToBuffer(data: {number})
	local buf = buffer.create(size_float * #data)
	for i, v in ipairs(data) do
		buffer.writef32(buf, (i-1) * size_float, v)
	end
	return buf
end

local function uintToBuffer(data: {number})
	local buf = buffer.create(size_uint * #data)
	for i, v in ipairs(data) do
		buffer.writeu32(buf, (i-1) * size_uint, v)
	end
	return buf
end

local function loadLib(path, definitions: {[string]: {returns: any, args: {any}}}, prefixLen: number?)
	local lib = zffi_dlopen(path, definitions)
	local funcs = {}
	for name, def in pairs(definitions) do
		local strippedName = name
		if prefixLen then
			strippedName = string.sub(name, prefixLen + 1)
		end
		funcs[strippedName] = lib[name]
	end
	return funcs
end

local function ptrToFunction(ptr: buffer, definition: {returns: any, args: {any}}, name: string?)
	if (isNullPtr(ptr)) then
		return function()
			error("Failed to load OpenGL function: " .. (name or ""))
		end
	end

	return function(...)
		return zffi_call(definition, ptr, ...)
	end
end

local function readString(ptr: buffer)
	return buffer.tostring(zffi.spanFromPtr(ptr, 0))
end

local function newClosure(definition: {returns: any, args: {any}}, func: (...any) -> any?)
	local closure = zffi_closure(definition, func)
	return closure.ptr
end

local function incrementPtr(ptr: buffer, offset: number)
	local newPtr = buffer.create(size_pointer)
	local low = buffer.readu32(ptr, 0)
	local high = buffer.readu32(ptr, 4)
	local newLow = (low + offset) % 0x100000000
	if newLow < low then
		buffer.writeu32(newPtr, 4, high + 1)
	end
	buffer.writeu32(newPtr, 0, newLow)
	return newPtr
end

local ffi = {
	c = {
		types = {
			void = t_void;
			schar = t_schar;
			uchar = t_uchar;
			short = t_short;
			ushort = t_ushort;
			int = t_int;
			uint = t_uint;
			long = t_long;
			ulong = t_ulong;
			float = t_float;
			double = t_double;
			voidptr = t_pointer;
		};

		sizes = {
			schar = size_schar;
			uchar = size_uchar;
			short = size_short;
			ushort = size_ushort;
			int = size_int;
			uint = size_uint;
			long = size_long;
			ulong = size_ulong;
			float = size_float;
			double = size_double;
			ptr = size_pointer;
		};
	};

	loadLib = loadLib;
	sizeOf = zffi_sizeOf;

	getRef = getRef;
	createPtr = createPtr;
	createRawPtr = createRawPtr;
	isNullPtr = isNullPtr;
	ptrToFunction = ptrToFunction;
	incrementPtr = incrementPtr;
	nullptr = function() return buffer.create(size_pointer) end;

	floatToBuffer = floatToBuffer;
	uintToBuffer = uintToBuffer;
	readString = readString;
	newClosure = newClosure;
}

return ffi