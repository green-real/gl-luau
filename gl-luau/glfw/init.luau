local ffi = require("../ffi")
local constants = require("./constants")

local t_void = ffi.c.types.void
local t_schar = ffi.c.types.schar
local t_uchar = ffi.c.types.uchar
local t_short = ffi.c.types.short
local t_ushort = ffi.c.types.ushort
local t_int = ffi.c.types.int
local t_uint = ffi.c.types.uint
local t_long = ffi.c.types.long
local t_ulong = ffi.c.types.ulong
local t_float = ffi.c.types.float
local t_double = ffi.c.types.double
local t_voidptr = ffi.c.types.voidptr

local glfwDefs: {[string]: any} = {
    glfwInit = {returns = t_int, args = {}},
    glfwTerminate = {returns = t_void, args = {}},
    glfwInitHint = {returns = t_void, args = {t_int, t_int}},
    glfwGetVersion = {returns = t_void, args = {t_voidptr, t_voidptr, t_voidptr}},
    glfwGetVersionString = {returns = t_voidptr, args = {}},
    glfwGetError = {returns = t_int, args = {t_voidptr}},
    glfwSetErrorCallback = {returns = t_voidptr, args = {t_voidptr}},
    glfwGetMonitors = {returns = t_voidptr, args = {t_voidptr}},
    glfwGetPrimaryMonitor = {returns = t_voidptr, args = {}},
    glfwGetMonitorPos = {returns = t_void, args = {t_voidptr, t_voidptr, t_voidptr}},
    glfwGetMonitorWorkarea = {returns = t_void, args = {t_voidptr, t_voidptr, t_voidptr, t_voidptr}},
    glfwGetMonitorPhysicalSize = {returns = t_void, args = {t_voidptr, t_voidptr, t_voidptr}},
    glfwGetMonitorContentScale = {returns = t_void, args = {t_voidptr, t_voidptr, t_voidptr}},
    glfwGetMonitorName = {returns = t_voidptr, args = {t_voidptr}},
    glfwSetMonitorUserPointer = {returns = t_void, args = {t_voidptr, t_voidptr}},
    glfwGetMonitorUserPointer = {returns = t_voidptr, args = {t_voidptr}},
    glfwSetMonitorCallback = {returns = t_voidptr, args = {t_voidptr}},
    glfwGetVideoModes = {returns = t_voidptr, args = {t_voidptr}},
    glfwGetVideoMode = {returns = t_voidptr, args = {t_voidptr}},
    glfwSetGamma = {returns = t_void, args = {t_voidptr, t_float}},
    glfwGetGammaRamp = {returns = t_voidptr, args = {t_voidptr}},
    glfwSetGammaRamp = {returns = t_void, args = {t_voidptr, t_voidptr}},
    glfwDefaultWindowHints = {returns = t_void, args = {}},
    glfwWindowHint = {returns = t_void, args = {t_int, t_int}},
    glfwWindowHintString = {returns = t_void, args = {t_int, t_voidptr}},
    glfwCreateWindow = {returns = t_voidptr, args = {t_int, t_int, t_voidptr, t_voidptr, t_voidptr}},
    glfwDestroyWindow = {returns = t_void, args = {t_voidptr}},
    glfwWindowShouldClose = {returns = t_int, args = {t_voidptr}},
    glfwSetWindowShouldClose = {returns = t_void, args = {t_voidptr, t_int}},
    glfwSetWindowTitle = {returns = t_void, args = {t_voidptr, t_voidptr}},
    glfwSetWindowIcon = {returns = t_void, args = {t_voidptr, t_int, t_voidptr}},
    glfwGetWindowPos = {returns = t_void, args = {t_voidptr, t_voidptr, t_voidptr}},
    glfwSetWindowPos = {returns = t_void, args = {t_voidptr, t_int, t_int}},
    glfwGetWindowSize = {returns = t_void, args = {t_voidptr, t_voidptr, t_voidptr}},
    glfwSetWindowSizeLimits = {returns = t_void, args = {t_voidptr, t_int, t_int, t_int, t_int}},
    glfwSetWindowAspectRatio = {returns = t_void, args = {t_voidptr, t_int, t_int}},
    glfwSetWindowSize = {returns = t_void, args = {t_voidptr, t_int, t_int}},
    glfwGetFramebufferSize = {returns = t_void, args = {t_voidptr, t_voidptr, t_voidptr}},
    glfwGetWindowFrameSize = {returns = t_void, args = {t_voidptr, t_voidptr, t_voidptr, t_voidptr, t_voidptr}},
    glfwGetWindowContentScale = {returns = t_void, args = {t_voidptr, t_voidptr, t_voidptr}},
    glfwGetWindowOpacity = {returns = t_float, args = {t_voidptr}},
    glfwSetWindowOpacity = {returns = t_void, args = {t_voidptr, t_float}},
    glfwIconifyWindow = {returns = t_void, args = {t_voidptr}},
    glfwRestoreWindow = {returns = t_void, args = {t_voidptr}},
    glfwMaximizeWindow = {returns = t_void, args = {t_voidptr}},
    glfwShowWindow = {returns = t_void, args = {t_voidptr}},
    glfwHideWindow = {returns = t_void, args = {t_voidptr}},
    glfwFocusWindow = {returns = t_void, args = {t_voidptr}},
    glfwRequestWindowAttention = {returns = t_void, args = {t_voidptr}},
    glfwGetWindowMonitor = {returns = t_voidptr, args = {t_voidptr}},
    glfwSetWindowMonitor = {returns = t_void, args = {t_voidptr, t_voidptr, t_int, t_int, t_int, t_int, t_int}},
    glfwGetWindowAttrib = {returns = t_int, args = {t_voidptr, t_int}},
    glfwSetWindowAttrib = {returns = t_void, args = {t_voidptr, t_int, t_int}},
    glfwSetWindowUserPointer = {returns = t_void, args = {t_voidptr, t_voidptr}},
    glfwGetWindowUserPointer = {returns = t_voidptr, args = {t_voidptr}},
    glfwSetWindowPosCallback = {returns = t_voidptr, args = {t_voidptr, t_voidptr}},
    glfwSetWindowSizeCallback = {returns = t_voidptr, args = {t_voidptr, t_voidptr}},
    glfwSetWindowCloseCallback = {returns = t_voidptr, args = {t_voidptr, t_voidptr}},
    glfwSetWindowRefreshCallback = {returns = t_voidptr, args = {t_voidptr, t_voidptr}},
    glfwSetWindowFocusCallback = {returns = t_voidptr, args = {t_voidptr, t_voidptr}},
    glfwSetWindowIconifyCallback = {returns = t_voidptr, args = {t_voidptr, t_voidptr}},
    glfwSetWindowMaximizeCallback = {returns = t_voidptr, args = {t_voidptr, t_voidptr}},
    glfwSetFramebufferSizeCallback = {returns = t_voidptr, args = {t_voidptr, t_voidptr}},
    glfwSetWindowContentScaleCallback = {returns = t_voidptr, args = {t_voidptr, t_voidptr}},
    glfwPollEvents = {returns = t_void, args = {}},
    glfwWaitEvents = {returns = t_void, args = {}},
    glfwWaitEventsTimeout = {returns = t_void, args = {t_double}},
    glfwPostEmptyEvent = {returns = t_void, args = {}},
    glfwGetInputMode = {returns = t_int, args = {t_voidptr, t_int}},
    glfwSetInputMode = {returns = t_void, args = {t_voidptr, t_int, t_int}},
    glfwRawMouseMotionSupported = {returns = t_int, args = {}},
    glfwGetKeyName = {returns = t_voidptr, args = {t_int, t_int}},
    glfwGetKeyScancode = {returns = t_int, args = {t_int}},
    glfwGetKey = {returns = t_int, args = {t_voidptr, t_int}},
    glfwGetMouseButton = {returns = t_int, args = {t_voidptr, t_int}},
    glfwGetCursorPos = {returns = t_void, args = {t_voidptr, t_voidptr, t_voidptr}},
    glfwSetCursorPos = {returns = t_void, args = {t_voidptr, t_double, t_double}},
    glfwCreateCursor = {returns = t_voidptr, args = {t_voidptr, t_int, t_int}},
    glfwCreateStandardCursor = {returns = t_voidptr, args = {t_int}},
    glfwDestroyCursor = {returns = t_void, args = {t_voidptr}},
    glfwSetCursor = {returns = t_void, args = {t_voidptr, t_voidptr}},
    glfwSetKeyCallback = {returns = t_voidptr, args = {t_voidptr, t_voidptr}},
    glfwSetCharCallback = {returns = t_voidptr, args = {t_voidptr, t_voidptr}},
    glfwSetCharModsCallback = {returns = t_voidptr, args = {t_voidptr, t_voidptr}},
    glfwSetMouseButtonCallback = {returns = t_voidptr, args = {t_voidptr, t_voidptr}},
    glfwSetCursorPosCallback = {returns = t_voidptr, args = {t_voidptr, t_voidptr}},
    glfwSetCursorEnterCallback = {returns = t_voidptr, args = {t_voidptr, t_voidptr}},
    glfwSetScrollCallback = {returns = t_voidptr, args = {t_voidptr, t_voidptr}},
    glfwSetDropCallback = {returns = t_voidptr, args = {t_voidptr, t_voidptr}},
    glfwJoystickPresent = {returns = t_int, args = {t_int}},
    glfwGetJoystickAxes = {returns = t_voidptr, args = {t_int, t_voidptr}},
    glfwGetJoystickButtons = {returns = t_voidptr, args = {t_int, t_voidptr}},
    glfwGetJoystickHats = {returns = t_voidptr, args = {t_int, t_voidptr}},
    glfwGetJoystickName = {returns = t_voidptr, args = {t_int}},
    glfwGetJoystickGUID = {returns = t_voidptr, args = {t_int}},
    glfwSetJoystickUserPointer = {returns = t_void, args = {t_int, t_voidptr}},
    glfwGetJoystickUserPointer = {returns = t_voidptr, args = {t_int}},
    glfwJoystickIsGamepad = {returns = t_int, args = {t_int}},
    glfwSetJoystickCallback = {returns = t_voidptr, args = {t_voidptr}},
    glfwUpdateGamepadMappings = {returns = t_int, args = {t_voidptr}},
    glfwGetGamepadName = {returns = t_voidptr, args = {t_int}},
    glfwGetGamepadState = {returns = t_int, args = {t_int, t_voidptr}},
    glfwSetClipboardString = {returns = t_void, args = {t_voidptr, t_voidptr}},
    glfwGetClipboardString = {returns = t_voidptr, args = {t_voidptr}},
    glfwGetTime = {returns = t_double, args = {}},
    glfwSetTime = {returns = t_void, args = {t_double}},
    glfwGetTimerValue = {returns = t_ulong, args = {}},
    glfwGetTimerFrequency = {returns = t_ulong, args = {}},
    glfwMakeContextCurrent = {returns = t_void, args = {t_voidptr}},
    glfwGetCurrentContext = {returns = t_voidptr, args = {}},
    glfwSwapBuffers = {returns = t_void, args = {t_voidptr}},
    glfwSwapInterval = {returns = t_void, args = {t_int}},
    glfwExtensionSupported = {returns = t_int, args = {t_voidptr}},
    glfwGetProcAddress = {returns = t_voidptr, args = {t_voidptr}},
    glfwVulkanSupported = {returns = t_int, args = {}},
    glfwGetRequiredInstanceExtensions = {returns = t_voidptr, args = {t_voidptr}},
}


local glfwDll = ffi.loadLib("./resources/bin/glfw3.dll", glfwDefs)

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