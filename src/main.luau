local fs = (require)("@zcore/fs")

local gl_luau= require("../gl-luau")
local glfw = gl_luau.glfw
local gl = gl_luau.gl
local stb_image = gl_luau.stb_image
local gl_math = gl_luau.math
local ffi = gl_luau.ffi
local ctype = ffi.c.types
local csize = ffi.c.sizes

stb_image.set_flip_vertically_on_load(1)

local function loadTexture(path: string)
    local _textureId = buffer.create(csize.uint)
    gl.GenTextures(1, ffi.getRef(_textureId))
    local textureId = buffer.readu32(_textureId, 0)
    gl.BindTexture(gl.TEXTURE_2D, textureId)

    local width = buffer.create(csize.int)
    local height: buffer = buffer.create(csize.int)
    local channelCount = buffer.create(csize.int)
    local data = stb_image.load(path, ffi.getRef(width), ffi.getRef(height), ffi.getRef(channelCount), 0)
    if (ffi.isNullPtr(data)) then
        stb_image.free(data)
        error("Failed to load image: " .. path)
    end

    if (buffer.readi32(channelCount, 0) == 3) then
        gl.TexImage2D(gl.TEXTURE_2D, 0, gl.RGB, width, height, 0, gl.RGB, gl.UNSIGNED_BYTE, data)
    elseif (buffer.readi32(channelCount, 0) == 4) then
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
    local bLinked = buffer.create(csize.int)
    gl.GetProgramiv(program, gl.LINK_STATUS, ffi.getRef(bLinked))
    local linked = buffer.readi32(bLinked, 0);
    if (linked == 0) then
        local maxLength = buffer.create(csize.int)
        gl.GetProgramiv(program, gl.INFO_LOG_LENGTH, ffi.getRef(maxLength))

        local infoLog = buffer.create(buffer.readi32(maxLength, 0))
        gl.GetProgramInfoLog(program, buffer.readi32(maxLength, 0), ffi.getRef(maxLength), ffi.getRef(infoLog))

        gl.DeleteProgram(program)

        error("Shader linking failed: " .. ffi.readString(infoLog))
    end

    return true
end

local function createShader(path: string, type: number): buffer
    local success, source = fs.readFile(path, true)
    assert(success, "Failed to read file: " .. path)

    local sourcePtr= ffi.getRef(source)
    local sourcePtrPtr = ffi.getRef(sourcePtr)

    local length = buffer.create(csize.int)
    buffer.writei32(length, 0, buffer.len(source))
    local lengthPtr = ffi.getRef(length)

    local shader = gl.CreateShader(type)
    gl.ShaderSource(shader, 1, sourcePtrPtr, lengthPtr)
    gl.CompileShader(shader)

    local _compiled = buffer.create(csize.int)
    gl.GetShaderiv(shader, gl.COMPILE_STATUS, ffi.getRef(_compiled))
    local compiled = buffer.readi32(_compiled, 0)
    if (compiled == 0) then
        local logLength = buffer.create(csize.int)
        gl.GetShaderiv(shader, gl.INFO_LOG_LENGTH, ffi.getRef(logLength))

        local infoLog = buffer.create(buffer.readi32(logLength, 0))
        -- TODO: find out why this is crashing every single time...
        -- gl.GetShaderInfoLog(shader, logLength, ffi.getRef(logLength), ffi.getRef(infoLog))

        return error("Failed to compile shader: " .. ffi.readString(infoLog))
    end

    return shader
end

local function glfwGetError(): (number, string)
    local description = ffi.nullptr()
    local ptr = ffi.getRef(description)
    local code = glfw.GetError(ptr)
    if (code == 0) then
        return code, ""
    end
    
    return code, ffi.readString(ptr)
end

local function main()
    if (glfw.Init() == 0) then
        print("Failed to initialize GLFW:", glfwGetError())
        return false
    end

    glfw.WindowHint(glfw.CONTEXT_VERSION_MAJOR, 3)
    glfw.WindowHint(glfw.CONTEXT_VERSION_MINOR, 3)
    glfw.WindowHint(glfw.OPENGL_PROFILE, glfw.OPENGL_CORE_PROFILE)

    local width = 800
    local height = 600
    local window = glfw.CreateWindow(width, height, "OpenGL in Luau", nil, nil)
    if (ffi.isNullPtr(window)) then
        print("Failed to create window:", glfwGetError())
        glfw.Terminate()
        return false
    end

    print(ffi.readString(glfw.GetVersionString()))

    glfw.MakeContextCurrent(window)
    glfw.SwapInterval(0)

    gl.LoadGL(glfw.GetProcAddress)

    gl.Enable(gl.CULL_FACE)
    gl.CullFace(gl.BACK)
    gl.Enable(gl.DEPTH_TEST)

    local texture = loadTexture("./resources/textures/luau.png")

    local vertices = ffi.floatToBuffer({
      -- positions      -- texture coords
        -0.5, -0.5, 0.0, 	0.0, 0.0,
         0.5, -0.5, 0.0, 	1.0, 0.0,
         0.5,  0.5, 0.0, 	1.0, 1.0,
        -0.5,  0.5, 0.0,	0.0, 1.0
    })

    local indices = ffi.uintToBuffer({
        0, 1, 2,
        2, 3, 0
    })

    local _vao = buffer.create(csize.uint)
    gl.GenVertexArrays(1, ffi.getRef(_vao))
    local vao = buffer.readu32(_vao, 0)
    gl.BindVertexArray(vao)

    local buffers = buffer.create(csize.uint * 2)
    gl.GenBuffers(2, ffi.getRef(buffers))
    local vbo = buffer.readu32(buffers, 0)
    gl.BindBuffer(gl.ARRAY_BUFFER, vbo)
    gl.BufferData(gl.ARRAY_BUFFER, buffer.len(vertices), ffi.getRef(vertices), gl.STATIC_DRAW)
    local ebo = buffer.readu32(buffers, csize.uint)
    gl.BindBuffer(gl.ELEMENT_ARRAY_BUFFER, ebo)
    gl.BufferData(gl.ELEMENT_ARRAY_BUFFER, buffer.len(indices), ffi.getRef(indices), gl.STATIC_DRAW)

    gl.EnableVertexAttribArray(0)
    gl.VertexAttribPointer(0, 3, gl.FLOAT, 0, csize.float * 5, nil)
    gl.EnableVertexAttribArray(1)
    gl.VertexAttribPointer(1, 2, gl.FLOAT, 0, csize.float * 5, ffi.createRawPtr(3 * csize.float))
    
    local vertexShader = createShader("./resources/shaders/tex.vert", gl.VERTEX_SHADER)
    local fragmentShader = createShader("./resources/shaders/tex.frag", gl.FRAGMENT_SHADER)

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

    local widthBuffer, heightBuffer = buffer.create(csize.int), buffer.create(csize.int)
    
    while (glfw.WindowShouldClose(window) == 0) do
        gl.Clear(gl.COLOR_BUFFER_BIT + gl.DEPTH_BUFFER_BIT)

        -- update fps
        do
            local currentTime = os.clock()
            local deltaTime = currentTime - lastTime
            lastTime = currentTime

            table.insert(fpsLog, deltaTime)
            if (#fpsLog > 500) then table.remove(fpsLog, 1) end

            local fps = 0
            for _, v in ipairs(fpsLog) do fps = fps + v end
            fps = 1 / (fps / #fpsLog)

            glfw.SetWindowTitle(window, "OpenGL in Luau - FPS: " .. math.floor(fps))
        end

        -- update uniforms
        do
            local glfwTime = glfw.GetTime() + 1000
        
            local r = math.sin(glfwTime * 5) * 0.5 + 0.5
            local g = math.cos(glfwTime * 2) * 0.5 + 0.5
            local b = math.sin(glfwTime * 3) * 0.5 + 0.5
            gl.Uniform4f(colorLocation, r, g, b, 1.0)

            local x = math.noise(glfwTime / 2, 0, 0) * 2
            local y = math.noise(glfwTime / 2, 10, 10) * 2

            gl.UniformMatrix4fv(modelLocation, 1, 0, ffi.getRef(gl_math.mat4.transform(x, y, 0.0)))
        end

        -- bind texture
        do
            gl.ActiveTexture(gl.TEXTURE0)
            gl.BindTexture(gl.TEXTURE_2D, texture)
            gl.Uniform1i(texture1Location, 0)
        end

        gl.DrawElements(gl.TRIANGLES, 6, gl.UNSIGNED_INT, ffi.nullptr())

        glfw.SwapBuffers(window)
        glfw.PollEvents()

        glfw.GetWindowSize(window, ffi.getRef(widthBuffer), ffi.getRef(heightBuffer))

        local widthOld, heightOld = width, height

        width = buffer.readi32(widthBuffer, 0)
        height = buffer.readi32(heightBuffer, 0)

        if (width ~= widthOld or height ~= heightOld) then
            gl.Viewport(0, 0, width, height)
        end
    end

    glfw.Terminate()

    return true
end

main()