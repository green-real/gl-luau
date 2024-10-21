local ffi = (require)("@zcore/ffi")
local fs = (require)("@zcore/fs")

local gl = require("./gl")
local glfw = require("./glfw")
local stb_image = require("./stb_image")
local glmath = require("./glmath")

stb_image.set_flip_vertically_on_load(1)

local function getRef(data: buffer): buffer
    return ffi.bufferToPtr(data)
end

local function isNull(ptr: buffer)
    return (buffer.readu32(ptr, 0) + buffer.readu32(ptr, 4)) == 0
end

local function getPtrOffset(offset: number)
    local ptr = buffer.create(ffi.sizeOf(ffi.types.pointer))
    buffer.writeu32(ptr, 0, offset)
    return ptr
end

local function arrayToFloat(data: {number}): buffer
    local buf = buffer.create(ffi.sizeOf(ffi.types.float) * #data)
    for i, v in ipairs(data) do
        buffer.writef32(buf, (i-1) * ffi.sizeOf(ffi.types.float), v)
    end
    return buf
end

local function arrayToU32(data: {number}): buffer
    local buf = buffer.create(ffi.sizeOf(ffi.types.u32) * #data)
    for i, v in ipairs(data) do
        buffer.writeu32(buf, (i-1) * ffi.sizeOf(ffi.types.u32), v)
    end
    return buf
end

local function loadTexture(path: string)
    local _textureId = buffer.create(ffi.sizeOf(ffi.types.u32))
    gl.GenTextures(1, getRef(_textureId))
    local textureId = buffer.readu32(_textureId, 0)
    gl.BindTexture(gl.TEXTURE_2D, textureId)

    local _width = buffer.create(ffi.sizeOf(ffi.types.i32))
    local _height = buffer.create(ffi.sizeOf(ffi.types.i32))
    local _channelCount = buffer.create(ffi.sizeOf(ffi.types.i32))
    local data = stb_image.load(path, getRef(_width), getRef(_height), getRef(_channelCount), 0)
    if (isNull(data)) then
        stb_image.free(data)
        error("Failed to load image: " .. path)
    end

    local width = buffer.readi32(_width, 0)
    local height = buffer.readi32(_height, 0)
    local channelCount = buffer.readi32(_channelCount, 0)

    if (channelCount == 3) then
        gl.TexImage2D(gl.TEXTURE_2D, 0, gl.RGB, width, height, 0, gl.RGB, gl.UNSIGNED_BYTE, data)
    elseif (channelCount == 4) then
        gl.TexImage2D(gl.TEXTURE_2D, 0, gl.RGBA, width, height, 0, gl.RGBA, gl.UNSIGNED_BYTE, data)
    else
        stb_image.free(data)
        error("Unsupported channel count: " .. channelCount)
    end

    gl.GenerateMipmap(gl.TEXTURE_2D)

    gl.TexParameteri(gl.TEXTURE_2D, gl.TEXTURE_WRAP_S, gl.REPEAT)
    gl.TexParameteri(gl.TEXTURE_2D, gl.TEXTURE_WRAP_T, gl.REPEAT)
    gl.TexParameteri(gl.TEXTURE_2D, gl.TEXTURE_MIN_FILTER, gl.LINEAR_MIPMAP_LINEAR)
    gl.TexParameteri(gl.TEXTURE_2D, gl.TEXTURE_MAG_FILTER, gl.LINEAR)

    stb_image.free(data)

    return textureId
end

local function checkProgramLinkStatus(program: number): boolean
    local bLinked = buffer.create(ffi.sizeOf(ffi.types.i32))
    gl.GetProgramiv(program, gl.LINK_STATUS, getRef(bLinked))
    local linked = buffer.readi32(bLinked, 0);
    if (linked == 0) then
        local maxLength = buffer.create(ffi.sizeOf(ffi.types.i32))
        gl.GetProgramiv(program, gl.INFO_LOG_LENGTH, getRef(maxLength))

        local infoLog = buffer.create(buffer.readi32(maxLength, 0))
        gl.GetProgramInfoLog(program, buffer.readi32(maxLength, 0), getRef(maxLength), getRef(infoLog))

        gl.DeleteProgram(program)

        error("Shader linking failed: " .. buffer.tostring(ffi.spanFromPtr(infoLog, 0)))
    end

    return true
end

local function createShader(path: string, type: number): buffer
    local success, source = fs.readFile(path, true)
    assert(success, "Failed to read file: " .. path)

    local sourcePtr= getRef(source)
    local sourcePtrPtr = getRef(sourcePtr)

    local shader: buffer = gl.CreateShader(type)
    gl.ShaderSource(shader, 1, sourcePtrPtr, nil)
    gl.CompileShader(shader)

    local _compiled = buffer.create(ffi.sizeOf(ffi.types.i32))
    gl.GetShaderiv(shader, gl.COMPILE_STATUS, getRef(_compiled))
    local compiled = buffer.readi32(_compiled, 0)
    if (compiled == 0) then
        local maxLength = buffer.create(ffi.sizeOf(ffi.types.i32))
        gl.GetShaderiv(shader, gl.INFO_LOG_LENGTH, getRef(maxLength))

        local infoLog = buffer.create(buffer.readi32(maxLength, 0))
        gl.GetShaderInfoLog(shader, buffer.readi32(maxLength, 0), getRef(maxLength), getRef(infoLog))

        gl.DeleteShader(shader)

        error("Shader compilation failed: " .. buffer.tostring(ffi.spanFromPtr(infoLog, 0)))
    end

    return shader
end

local function glfwGetError(): (number, string)
    local description = buffer.create(ffi.sizeOf(ffi.types.pointer))
    local ptr = ffi.intFromPtr(buffer.create(ffi.sizeOf(ffi.types.pointer)), description)
    local code = glfw.GetError(ptr)
    if (code == 0) then
        return code, ""
    end
    
    return code, buffer.tostring(ffi.spanFromPtr(description, 0))
end

local glfwErrorCallback = ffi.closure(glfw.errorfun, function(error, descPtr)
    local description = buffer.tostring(ffi.spanFromPtr(descPtr, 0))

    print("GLFW Error:", error, description)
end).ptr

local n = 0

local function glfwWindowSizeChanged(window: number, width: number, height: number)
    n += 1
    print(n)
    gl.Viewport(0, 0, width, height)
end

local glfwWindowSizeCallback: buffer = ffi.closure(glfw.windowsizefun, glfwWindowSizeChanged).ptr

local function main()

    glfw.SetErrorCallback(glfwErrorCallback)

    -- Initialize GLFW
    if (glfw.Init() == 0) then
        print("Failed to initialize GLFW:", glfwGetError())
        return false
    end

    -- OpenGL 3.3 Core Profile
    glfw.WindowHint(glfw.CONTEXT_VERSION_MAJOR, 3)
    glfw.WindowHint(glfw.CONTEXT_VERSION_MINOR, 3)
    glfw.WindowHint(glfw.OPENGL_PROFILE, glfw.OPENGL_CORE_PROFILE)

    -- Create a windowed mode window and its OpenGL context
    local window = glfw.CreateWindow(800, 600, "OpenGL in Luau", nil, nil)
    if (isNull(window)) then
        print("Failed to create window:", glfwGetError())
        glfw.Terminate()
        return false
    end

    print(buffer.tostring(ffi.spanFromPtr(glfw.GetVersionString(), 0)))

    glfw.MakeContextCurrent(window)
    glfw.SetWindowSizeCallback(window, glfwWindowSizeCallback)
    glfw.SwapInterval(1)

    gl.LoadGL(glfw.GetProcAddress)

    gl.Enable(gl.CULL_FACE)
    gl.CullFace(gl.BACK)
    gl.Enable(gl.DEPTH_TEST)

    -- Load texture
    local texture = loadTexture("./textures/luau.png")

    -- define vertex data and indices
    local vertices = arrayToFloat({
      -- positions      -- texture coords
        -0.5, -0.5, 0.0, 	0.0, 0.0,
         0.5, -0.5, 0.0, 	1.0, 0.0,
         0.5,  0.5, 0.0, 	1.0, 1.0,
        -0.5,  0.5, 0.0,	0.0, 1.0
    })

    local indices = arrayToU32({
        0, 1, 2,
        2, 3, 0
    })

    local _vao = buffer.create(ffi.sizeOf(ffi.types.u32))
    gl.GenVertexArrays(1, getRef(_vao))
    local vao = buffer.readu32(_vao, 0)
    gl.BindVertexArray(vao)

    local buffers = buffer.create(ffi.sizeOf(ffi.types.u32) * 2)
    gl.GenBuffers(2, getRef(buffers))
    local vbo = buffer.readu32(buffers, 0)
    gl.BindBuffer(gl.ARRAY_BUFFER, vbo)
    gl.BufferData(gl.ARRAY_BUFFER, buffer.len(vertices), getRef(vertices), gl.STATIC_DRAW)
    local ebo = buffer.readu32(buffers, ffi.sizeOf(ffi.types.u32))
    gl.BindBuffer(gl.ELEMENT_ARRAY_BUFFER, ebo)
    gl.BufferData(gl.ELEMENT_ARRAY_BUFFER, buffer.len(indices), getRef(indices), gl.STATIC_DRAW)

    gl.EnableVertexAttribArray(0)
    gl.VertexAttribPointer(0, 3, gl.FLOAT, 0, ffi.sizeOf(ffi.types.float) * 5, nil)
    gl.EnableVertexAttribArray(1)
    gl.VertexAttribPointer(1, 2, gl.FLOAT, 0, ffi.sizeOf(ffi.types.float) * 5, getPtrOffset(3 * ffi.sizeOf(ffi.types.float)))

    local vertexShader = createShader("./shaders/tex.vert", gl.VERTEX_SHADER)
    local fragmentShader = createShader("./shaders/tex.frag", gl.FRAGMENT_SHADER)

    local shaderProgram = gl.CreateProgram()
    gl.AttachShader(shaderProgram, vertexShader)
    gl.AttachShader(shaderProgram, fragmentShader)
    gl.LinkProgram(shaderProgram)
    checkProgramLinkStatus(shaderProgram)

    gl.UseProgram(shaderProgram)

    gl.DeleteShader(vertexShader)
    gl.DeleteShader(fragmentShader)

    gl.ClearColor(0.0, 0.0, 0.0, 1.0)

    local colorLocation = gl.GetUniformLocation(shaderProgram, "objectColor"); assert(colorLocation ~= -1)
    local modelLocation = gl.GetUniformLocation(shaderProgram, "model"); assert(modelLocation ~= -1)

    local texture1Location = gl.GetUniformLocation(shaderProgram, "texture1"); assert(texture1Location ~= -1)

    local fpsLog = table.create(60)
    local lastTime = os.clock()

    while (glfw.WindowShouldClose(window) == 0) do
        gl.Clear(gl.COLOR_BUFFER_BIT + gl.DEPTH_BUFFER_BIT)

        -- update fps
        do
            local currentTime = os.clock()
            local deltaTime = currentTime - lastTime
            lastTime = currentTime

            table.insert(fpsLog, deltaTime)
            if (#fpsLog > 60) then table.remove(fpsLog, 1) end

            local fps = 0
            for _, v in ipairs(fpsLog) do fps = fps + v end
            fps = 1 / (fps / #fpsLog)

            glfw.SetWindowTitle(window, "OpenGL in Luau - FPS: " .. math.floor(fps))
        end

        -- update uniforms
        do
            local glfwTime = glfw.GetTime()
        
            local r = math.sin(glfwTime * 5) * 0.5 + 0.5
            local g = math.cos(glfwTime * 2) * 0.5 + 0.5
            local b = math.sin(glfwTime * 3) * 0.5 + 0.5
            gl.Uniform4f(colorLocation, r, g, b, 1.0)

            local x = math.noise(glfwTime / 2, 0, 0) * 2
            local y = math.noise(glfwTime / 2, 10, 10) * 2

            gl.UniformMatrix4fv(modelLocation, 1, 0, getRef(glmath.mat4.transform(x, y, 0.0)))
        end

        -- bind texture
        do
            gl.ActiveTexture(gl.TEXTURE0)
            gl.BindTexture(gl.TEXTURE_2D, texture)
            gl.Uniform1i(texture1Location, 0)
        end
        
        gl.DrawElements(gl.TRIANGLES, 6, gl.UNSIGNED_INT, nil)

        glfw.SwapBuffers(window)
        n += 1
        glfw.PollEvents()
    end

    gl.DeleteVertexArrays(1, getRef(_vao))
    gl.DeleteBuffers(2, getRef(buffers))

    glfw.Terminate()

    return true
end

main()