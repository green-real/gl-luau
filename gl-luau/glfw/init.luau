local ffi = (require)("@zcore/ffi")
local constants = require("./constants")

local t_void = ffi.types.void
local t_i32 = ffi.types.i32
local t_u64 = ffi.types.u64
local t_float = ffi.types.float
local t_double = ffi.types.double
local t_pointer = ffi.types.pointer

local glfwDefs: {[string]: any} = {
    glfwInit = {returns = t_i32, args = {}},
    glfwTerminate = {returns = t_void, args = {}},
    glfwInitHint = {returns = t_void, args = {t_i32, t_i32}},
    glfwGetVersion = {returns = t_void, args = {t_pointer, t_pointer, t_pointer}},
    glfwGetVersionString = {returns = t_pointer, args = {}},
    glfwGetError = {returns = t_i32, args = {t_pointer}},
    glfwSetErrorCallback = {returns = t_pointer, args = {t_pointer}},
    glfwGetMonitors = {returns = t_pointer, args = {t_pointer}},
    glfwGetPrimaryMonitor = {returns = t_pointer, args = {}},
    glfwGetMonitorPos = {returns = t_void, args = {t_pointer, t_pointer, t_pointer}},
    glfwGetMonitorWorkarea = {returns = t_void, args = {t_pointer, t_pointer, t_pointer, t_pointer}},
    glfwGetMonitorPhysicalSize = {returns = t_void, args = {t_pointer, t_pointer, t_pointer}},
    glfwGetMonitorContentScale = {returns = t_void, args = {t_pointer, t_pointer, t_pointer}},
    glfwGetMonitorName = {returns = t_pointer, args = {t_pointer}},
    glfwSetMonitorUserPointer = {returns = t_void, args = {t_pointer, t_pointer}},
    glfwGetMonitorUserPointer = {returns = t_pointer, args = {t_pointer}},
    glfwSetMonitorCallback = {returns = t_pointer, args = {t_pointer}},
    glfwGetVideoModes = {returns = t_pointer, args = {t_pointer}},
    glfwGetVideoMode = {returns = t_pointer, args = {t_pointer}},
    glfwSetGamma = {returns = t_void, args = {t_pointer, t_float}},
    glfwGetGammaRamp = {returns = t_pointer, args = {t_pointer}},
    glfwSetGammaRamp = {returns = t_void, args = {t_pointer, t_pointer}},
    glfwDefaultWindowHints = {returns = t_void, args = {}},
    glfwWindowHint = {returns = t_void, args = {t_i32, t_i32}},
    glfwWindowHintString = {returns = t_void, args = {t_i32, t_pointer}},
    glfwCreateWindow = {returns = t_pointer, args = {t_i32, t_i32, t_pointer, t_pointer, t_pointer}},
    glfwDestroyWindow = {returns = t_void, args = {t_pointer}},
    glfwWindowShouldClose = {returns = t_i32, args = {t_pointer}},
    glfwSetWindowShouldClose = {returns = t_void, args = {t_pointer, t_i32}},
    glfwSetWindowTitle = {returns = t_void, args = {t_pointer, t_pointer}},
    glfwSetWindowIcon = {returns = t_void, args = {t_pointer, t_i32, t_pointer}},
    glfwGetWindowPos = {returns = t_void, args = {t_pointer, t_pointer, t_pointer}},
    glfwSetWindowPos = {returns = t_void, args = {t_pointer, t_i32, t_i32}},
    glfwGetWindowSize = {returns = t_void, args = {t_pointer, t_pointer, t_pointer}},
    glfwSetWindowSizeLimits = {returns = t_void, args = {t_pointer, t_i32, t_i32, t_i32, t_i32}},
    glfwSetWindowAspectRatio = {returns = t_void, args = {t_pointer, t_i32, t_i32}},
    glfwSetWindowSize = {returns = t_void, args = {t_pointer, t_i32, t_i32}},
    glfwGetFramebufferSize = {returns = t_void, args = {t_pointer, t_pointer, t_pointer}},
    glfwGetWindowFrameSize = {returns = t_void, args = {t_pointer, t_pointer, t_pointer, t_pointer, t_pointer}},
    glfwGetWindowContentScale = {returns = t_void, args = {t_pointer, t_pointer, t_pointer}},
    glfwGetWindowOpacity = {returns = t_float, args = {t_pointer}},
    glfwSetWindowOpacity = {returns = t_void, args = {t_pointer, t_float}},
    glfwIconifyWindow = {returns = t_void, args = {t_pointer}},
    glfwRestoreWindow = {returns = t_void, args = {t_pointer}},
    glfwMaximizeWindow = {returns = t_void, args = {t_pointer}},
    glfwShowWindow = {returns = t_void, args = {t_pointer}},
    glfwHideWindow = {returns = t_void, args = {t_pointer}},
    glfwFocusWindow = {returns = t_void, args = {t_pointer}},
    glfwRequestWindowAttention = {returns = t_void, args = {t_pointer}},
    glfwGetWindowMonitor = {returns = t_pointer, args = {t_pointer}},
    glfwSetWindowMonitor = {returns = t_void, args = {t_pointer, t_pointer, t_i32, t_i32, t_i32, t_i32, t_i32}},
    glfwGetWindowAttrib = {returns = t_i32, args = {t_pointer, t_i32}},
    glfwSetWindowAttrib = {returns = t_void, args = {t_pointer, t_i32, t_i32}},
    glfwSetWindowUserPointer = {returns = t_void, args = {t_pointer, t_pointer}},
    glfwGetWindowUserPointer = {returns = t_pointer, args = {t_pointer}},
    glfwSetWindowPosCallback = {returns = t_pointer, args = {t_pointer, t_pointer}},
    glfwSetWindowSizeCallback = {returns = t_pointer, args = {t_pointer, t_pointer}},
    glfwSetWindowCloseCallback = {returns = t_pointer, args = {t_pointer, t_pointer}},
    glfwSetWindowRefreshCallback = {returns = t_pointer, args = {t_pointer, t_pointer}},
    glfwSetWindowFocusCallback = {returns = t_pointer, args = {t_pointer, t_pointer}},
    glfwSetWindowIconifyCallback = {returns = t_pointer, args = {t_pointer, t_pointer}},
    glfwSetWindowMaximizeCallback = {returns = t_pointer, args = {t_pointer, t_pointer}},
    glfwSetFramebufferSizeCallback = {returns = t_pointer, args = {t_pointer, t_pointer}},
    glfwSetWindowContentScaleCallback = {returns = t_pointer, args = {t_pointer, t_pointer}},
    glfwPollEvents = {returns = t_void, args = {}},
    glfwWaitEvents = {returns = t_void, args = {}},
    glfwWaitEventsTimeout = {returns = t_void, args = {t_double}},
    glfwPostEmptyEvent = {returns = t_void, args = {}},
    glfwGetInputMode = {returns = t_i32, args = {t_pointer, t_i32}},
    glfwSetInputMode = {returns = t_void, args = {t_pointer, t_i32, t_i32}},
    glfwRawMouseMotionSupported = {returns = t_i32, args = {}},
    glfwGetKeyName = {returns = t_pointer, args = {t_i32, t_i32}},
    glfwGetKeyScancode = {returns = t_i32, args = {t_i32}},
    glfwGetKey = {returns = t_i32, args = {t_pointer, t_i32}},
    glfwGetMouseButton = {returns = t_i32, args = {t_pointer, t_i32}},
    glfwGetCursorPos = {returns = t_void, args = {t_pointer, t_pointer, t_pointer}},
    glfwSetCursorPos = {returns = t_void, args = {t_pointer, t_double, t_double}},
    glfwCreateCursor = {returns = t_pointer, args = {t_pointer, t_i32, t_i32}},
    glfwCreateStandardCursor = {returns = t_pointer, args = {t_i32}},
    glfwDestroyCursor = {returns = t_void, args = {t_pointer}},
    glfwSetCursor = {returns = t_void, args = {t_pointer, t_pointer}},
    glfwSetKeyCallback = {returns = t_pointer, args = {t_pointer, t_pointer}},
    glfwSetCharCallback = {returns = t_pointer, args = {t_pointer, t_pointer}},
    glfwSetCharModsCallback = {returns = t_pointer, args = {t_pointer, t_pointer}},
    glfwSetMouseButtonCallback = {returns = t_pointer, args = {t_pointer, t_pointer}},
    glfwSetCursorPosCallback = {returns = t_pointer, args = {t_pointer, t_pointer}},
    glfwSetCursorEnterCallback = {returns = t_pointer, args = {t_pointer, t_pointer}},
    glfwSetScrollCallback = {returns = t_pointer, args = {t_pointer, t_pointer}},
    glfwSetDropCallback = {returns = t_pointer, args = {t_pointer, t_pointer}},
    glfwJoystickPresent = {returns = t_i32, args = {t_i32}},
    glfwGetJoystickAxes = {returns = t_pointer, args = {t_i32, t_pointer}},
    glfwGetJoystickButtons = {returns = t_pointer, args = {t_i32, t_pointer}},
    glfwGetJoystickHats = {returns = t_pointer, args = {t_i32, t_pointer}},
    glfwGetJoystickName = {returns = t_pointer, args = {t_i32}},
    glfwGetJoystickGUID = {returns = t_pointer, args = {t_i32}},
    glfwSetJoystickUserPointer = {returns = t_void, args = {t_i32, t_pointer}},
    glfwGetJoystickUserPointer = {returns = t_pointer, args = {t_i32}},
    glfwJoystickIsGamepad = {returns = t_i32, args = {t_i32}},
    glfwSetJoystickCallback = {returns = t_pointer, args = {t_pointer}},
    glfwUpdateGamepadMappings = {returns = t_i32, args = {t_pointer}},
    glfwGetGamepadName = {returns = t_pointer, args = {t_i32}},
    glfwGetGamepadState = {returns = t_i32, args = {t_i32, t_pointer}},
    glfwSetClipboardString = {returns = t_void, args = {t_pointer, t_pointer}},
    glfwGetClipboardString = {returns = t_pointer, args = {t_pointer}},
    glfwGetTime = {returns = t_double, args = {}},
    glfwSetTime = {returns = t_void, args = {t_double}},
    glfwGetTimerValue = {returns = t_u64, args = {}},
    glfwGetTimerFrequency = {returns = t_u64, args = {}},
    glfwMakeContextCurrent = {returns = t_void, args = {t_pointer}},
    glfwGetCurrentContext = {returns = t_pointer, args = {}},
    glfwSwapBuffers = {returns = t_void, args = {t_pointer}},
    glfwSwapInterval = {returns = t_void, args = {t_i32}},
    glfwExtensionSupported = {returns = t_i32, args = {t_pointer}},
    glfwGetProcAddress = {returns = t_pointer, args = {t_pointer}},
    glfwVulkanSupported = {returns = t_i32, args = {}},
    glfwGetRequiredInstanceExtensions = {returns = t_pointer, args = {t_pointer}},
}

local glfwDll = ffi.dlopen("./deps/glfw3.dll", glfwDefs)

local glfw = table.clone(constants)

for index, _ in glfwDefs do
	glfw[string.sub(index, 5)] = glfwDll[index]
end

type ptr = buffer

return glfw :: {
	Init: () -> number;
	Terminate: () -> ();
    InitHint: (hint: number, value: number) -> ();
    GetVersion: (major: ptr, minor: ptr, rev: ptr) -> ();
    GetVersionString: () -> ptr;
    GetError: (description: ptr) -> number;
    SetErrorCallback: (cbfun: ptr) -> ptr;
    GetMonitors: (count: ptr) -> ptr;
    GetPrimaryMonitor: () -> ptr;
    GetMonitorPos: (monitor: ptr, xpos: ptr, ypos: ptr) -> ();
    GetMonitorWorkarea: (monitor: ptr, xpos: ptr, ypos: ptr, width: ptr, height: ptr) -> ();
    GetMonitorPhysicalSize: (monitor: ptr, widthMM: ptr, heightMM: ptr) -> ();
    GetMonitorContentScale: (monitor: ptr, xscale: ptr, yscale: ptr) -> ();
    GetMonitorName: (monitor: ptr) -> ptr;
    SetMonitorUserPointer: (monitor: ptr, pointer: ptr) -> ();
    GetMonitorUserPointer: (monitor: ptr) -> ptr;
    SetMonitorCallback: (cbfun: ptr) -> ptr;
    GetVideoModes: (monitor: ptr, count: ptr) -> ptr;
    GetVideoMode: (monitor: ptr) -> ptr;
    SetGamma: (monitor: ptr, gamma: number) -> ();
    GetGammaRamp: (monitor: ptr) -> ptr;
    SetGammaRamp: (monitor: ptr, ramp: ptr) -> ();
    DefaultWindowHints: () -> ();
    WindowHint: (hint: number, value: number) -> ();
    WindowHintString: (hint: number, value: ptr) -> ();
    CreateWindow: (width: number, height: number, title: ptr | string, monitor: ptr?, share: ptr?) -> ptr;
    DestroyWindow: (window: ptr) -> ();
    WindowShouldClose: (window: ptr) -> number;
    SetWindowShouldClose: (window: ptr, value: number) -> ();
    SetWindowTitle: (window: ptr, title: ptr | string) -> ();
    SetWindowIcon: (window: ptr, count: number, images: ptr) -> ();
    GetWindowPos: (window: ptr, xpos: ptr, ypos: ptr) -> ();
    SetWindowPos: (window: ptr, xpos: number, ypos: number) -> ();
    GetWindowSize: (window: ptr, width: ptr, height: ptr) -> ();
    SetWindowSizeLimits: (window: ptr, minwidth: number, minheight: number, maxwidth: number, maxheight: number) -> ();
    SetWindowAspectRatio: (window: ptr, numer: number, denom: number) -> ();
    SetWindowSize: (window: ptr, width: number, height: number) -> ();
    GetFramebufferSize: (window: ptr, width: ptr, height: ptr) -> ();
    GetWindowFrameSize: (window: ptr, left: ptr, top: ptr, right: ptr, bottom: ptr) -> ();
    GetWindowContentScale: (window: ptr, xscale: ptr, yscale: ptr) -> ();
    GetWindowOpacity: (window: ptr) -> number;
    SetWindowOpacity: (window: ptr, opacity: number) -> ();
    IconifyWindow: (window: ptr) -> ();
    RestoreWindow: (window: ptr) -> ();
    MaximizeWindow: (window: ptr) -> ();
    ShowWindow: (window: ptr) -> ();
    HideWindow: (window: ptr) -> ();
    FocusWindow: (window: ptr) -> ();
    RequestWindowAttention: (window: ptr) -> ();
    GetWindowMonitor: (window: ptr) -> ptr;
    SetWindowMonitor: (window: ptr, monitor: ptr, xpos: number, ypos: number, width: number, height: number, refreshRate: number) -> ();
    GetWindowAttrib: (window: ptr, attrib: number) -> number;
    SetWindowAttrib: (window: ptr, attrib: number, value: number) -> ();
    SetWindowUserPointer: (window: ptr, pointer: ptr) -> ();
    GetWindowUserPointer: (window: ptr) -> ptr;
    SetWindowPosCallback: (window: ptr, cbfun: ptr) -> ptr;
    SetWindowSizeCallback: (window: ptr, cbfun: ptr) -> ptr;
    SetWindowCloseCallback: (window: ptr, cbfun: ptr) -> ptr;
    SetWindowRefreshCallback: (window: ptr, cbfun: ptr) -> ptr;
    SetWindowFocusCallback: (window: ptr, cbfun: ptr) -> ptr;
    SetWindowIconifyCallback: (window: ptr, cbfun: ptr) -> ptr;
    SetWindowMaximizeCallback: (window: ptr, cbfun: ptr) -> ptr;
    SetFramebufferSizeCallback: (window: ptr, cbfun: ptr) -> ptr;
    SetWindowContentScaleCallback: (window: ptr, cbfun: ptr) -> ptr;
    PollEvents: () -> ();
    WaitEvents: () -> ();
    WaitEventsTimeout: (timeout: number) -> ();
    PostEmptyEvent: () -> ();
    GetInputMode: (window: ptr, mode: number) -> number;
    SetInputMode: (window: ptr, mode: number, value: number) -> ();
    RawMouseMotionSupported: () -> number;
    GetKeyName: (key: number, scancode: number) -> ptr;
    GetKeyScancode: (key: number) -> number;
    GetKey: (window: ptr, key: number) -> number;
    GetMouseButton: (window: ptr, button: number) -> number;
    GetCursorPos: (window: ptr, xpos: ptr, ypos: ptr) -> ();
    SetCursorPos: (window: ptr, xpos: number, ypos: number) -> ();
    CreateCursor: (image: ptr, xhot: number, yhot: number) -> ptr;
    CreateStandardCursor: (shape: number) -> ptr;
    DestroyCursor: (cursor: ptr) -> ();
    SetCursor: (window: ptr, cursor: ptr) -> ();
    SetKeyCallback: (window: ptr, cbfun: ptr) -> ptr;
    SetCharCallback: (window: ptr, cbfun: ptr) -> ptr;
    SetCharModsCallback: (window: ptr, cbfun: ptr) -> ptr;
    SetMouseButtonCallback: (window: ptr, cbfun: ptr) -> ptr;
    SetCursorPosCallback: (window: ptr, cbfun: ptr) -> ptr;
    SetCursorEnterCallback: (window: ptr, cbfun: ptr) -> ptr;
    SetScrollCallback: (window: ptr, cbfun: ptr) -> ptr;
    SetDropCallback: (window: ptr, cbfun: ptr) -> ptr;
    JoystickPresent: (jid: number) -> number;
    GetJoystickAxes: (jid: number, count: ptr) -> ptr;
    GetJoystickButtons: (jid: number, count: ptr) -> ptr;
    GetJoystickHats: (jid: number, count: ptr) -> ptr;
    GetJoystickName: (jid: number) -> ptr;
    GetJoystickGUID: (jid: number) -> ptr;
    SetJoystickUserPointer: (jid: number, pointer: ptr) -> ();
    GetJoystickUserPointer: (jid: number) -> ptr;
    JoystickIsGamepad: (jid: number) -> number;
    SetJoystickCallback: (cbfun: ptr) -> ptr;
    UpdateGamepadMappings: (string: ptr) -> number;
    GetGamepadName: (jid: number) -> ptr;
    GetGamepadState: (jid: number, state: ptr) -> number;
    SetClipboardString: (window: ptr, string: ptr) -> ();
    GetClipboardString: (window: ptr) -> ptr;
    GetTime: () -> number;
    SetTime: (time: number) -> ();
    GetTimerValue: () -> number;
    GetTimerFrequency: () -> number;
    MakeContextCurrent: (window: ptr) -> ();
    GetCurrentContext: () -> ptr;
    SwapBuffers: (window: ptr) -> ();
    SwapInterval: (interval: number) -> ();
    ExtensionSupported: (extension: ptr) -> number;
    GetProcAddress: (procname: ptr | string) -> ptr;
    VulkanSupported: () -> number;
    GetRequiredInstanceExtensions: (count: ptr) -> ptr;
} & typeof(constants)