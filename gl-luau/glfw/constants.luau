local ffi = (require)("@zcore/ffi")

local t_void = ffi.types.void
local t_i32 = ffi.types.i32
local t_u32 = ffi.types.u32
local t_float = ffi.types.float
local t_double = ffi.types.double
local t_pointer = ffi.types.pointer

return {
    VERSION_MAJOR = 0x00000003,
    VERSION_MINOR = 0x00000003,
    VERSION_REVISION = 0x0000000A,
    TRUE = 0x00000001,
    FALSE = 0x00000000,
    RELEASE = 0x00000000,
    PRESS = 0x00000001,
    REPEAT = 0x00000002,
    HAT_CENTERED = 0x00000000,
    HAT_UP = 0x00000001,
    HAT_RIGHT = 0x00000002,
    HAT_DOWN = 0x00000004,
    HAT_LEFT = 0x00000008,
    HAT_RIGHT_UP = 0x00000003,
    HAT_RIGHT_DOWN = 0x00000006,
    HAT_LEFT_UP = 0x00000009,
    HAT_LEFT_DOWN = 0x0000000C,
    KEY_UNKNOWN = -1,
    KEY_SPACE = 0x00000020,
    KEY_APOSTROPHE = 0x00000027,
    KEY_COMMA = 0x0000002C,
    KEY_MINUS = 0x0000002D,
    KEY_PERIOD = 0x0000002E,
    KEY_SLASH = 0x0000002F,
    KEY_0 = 0x00000030,
    KEY_1 = 0x00000031,
    KEY_2 = 0x00000032,
    KEY_3 = 0x00000033,
    KEY_4 = 0x00000034,
    KEY_5 = 0x00000035,
    KEY_6 = 0x00000036,
    KEY_7 = 0x00000037,
    KEY_8 = 0x00000038,
    KEY_9 = 0x00000039,
    KEY_SEMICOLON = 0x0000003B,
    KEY_EQUAL = 0x0000003D,
    KEY_A = 0x00000041,
    KEY_B = 0x00000042,
    KEY_C = 0x00000043,
    KEY_D = 0x00000044,
    KEY_E = 0x00000045,
    KEY_F = 0x00000046,
    KEY_G = 0x00000047,
    KEY_H = 0x00000048,
    KEY_I = 0x00000049,
    KEY_J = 0x0000004A,
    KEY_K = 0x0000004B,
    KEY_L = 0x0000004C,
    KEY_M = 0x0000004D,
    KEY_N = 0x0000004E,
    KEY_O = 0x0000004F,
    KEY_P = 0x00000050,
    KEY_Q = 0x00000051,
    KEY_R = 0x00000052,
    KEY_S = 0x00000053,
    KEY_T = 0x00000054,
    KEY_U = 0x00000055,
    KEY_V = 0x00000056,
    KEY_W = 0x00000057,
    KEY_X = 0x00000058,
    KEY_Y = 0x00000059,
    KEY_Z = 0x0000005A,
    KEY_LEFT_BRACKET = 0x0000005B,
    KEY_BACKSLASH = 0x0000005C,
    KEY_RIGHT_BRACKET = 0x0000005D,
    KEY_GRAVE_ACCENT = 0x00000060,
    KEY_WORLD_1 = 0x000000A1,
    KEY_WORLD_2 = 0x000000A2,
    KEY_ESCAPE = 0x00000100,
    KEY_ENTER = 0x00000101,
    KEY_TAB = 0x00000102,
    KEY_BACKSPACE = 0x00000103,
    KEY_INSERT = 0x00000104,
    KEY_DELETE = 0x00000105,
    KEY_RIGHT = 0x00000106,
    KEY_LEFT = 0x00000107,
    KEY_DOWN = 0x00000108,
    KEY_UP = 0x00000109,
    KEY_PAGE_UP = 0x0000010A,
    KEY_PAGE_DOWN = 0x0000010B,
    KEY_HOME = 0x0000010C,
    KEY_END = 0x0000010D,
    KEY_CAPS_LOCK = 0x00000110,
    KEY_SCROLL_LOCK = 0x00000111,
    KEY_NUM_LOCK = 0x00000112,
    KEY_PRINT_SCREEN = 0x00000113,
    KEY_PAUSE = 0x00000114,
    KEY_F1 = 0x000001D2,
    KEY_F2 = 0x000001D3,
    KEY_F3 = 0x000001D4,
    KEY_F4 = 0x000001D5,
    KEY_F5 = 0x000001D6,
    KEY_F6 = 0x000001D7,
    KEY_F7 = 0x000001D8,
    KEY_F8 = 0x000001D9,
    KEY_F9 = 0x000001DA,
    KEY_F10 = 0x000001DB,
    KEY_F11 = 0x000001DC,
    KEY_F12 = 0x000001DD,
    KEY_F13 = 0x000001DE,
    KEY_F14 = 0x000001DF,
    KEY_F15 = 0x000001E0,
    KEY_F16 = 0x000001E1,
    KEY_F17 = 0x000001E2,
    KEY_F18 = 0x000001E3,
    KEY_F19 = 0x000001E4,
    KEY_F20 = 0x000001E5,
    KEY_F21 = 0x000001E6,
    KEY_F22 = 0x000001E7,
    KEY_F23 = 0x000001E8,
    KEY_F24 = 0x000001E9,
    KEY_F25 = 0x000001EA,
    KEY_KP_0 = 0x000001F0,
    KEY_KP_1 = 0x000001F1,
    KEY_KP_2 = 0x000001F2,
    KEY_KP_3 = 0x000001F3,
    KEY_KP_4 = 0x000001F4,
    KEY_KP_5 = 0x000001F5,
    KEY_KP_6 = 0x000001F6,
    KEY_KP_7 = 0x000001F7,
    KEY_KP_8 = 0x000001F8,
    KEY_KP_9 = 0x000001F9,
    KEY_KP_DECIMAL = 0x000001FA,
    KEY_KP_DIVIDE = 0x000001FB,
    KEY_KP_MULTIPLY = 0x000001FC,
    KEY_KP_SUBTRACT = 0x000001FD,
    KEY_KP_ADD = 0x000001FE,
    KEY_KP_ENTER = 0x000001FF,
    KEY_KP_EQUAL = 0x00000200,
    KEY_LEFT_SHIFT = 0x00000210,
    KEY_LEFT_CONTROL = 0x00000211,
    KEY_LEFT_ALT = 0x00000212,
    KEY_LEFT_SUPER = 0x00000213,
    KEY_RIGHT_SHIFT = 0x00000214,
    KEY_RIGHT_CONTROL = 0x00000215,
    KEY_RIGHT_ALT = 0x00000216,
    KEY_RIGHT_SUPER = 0x00000217,
    KEY_MENU = 0x00000218,
    KEY_LAST = 0x00000218,
    MOD_SHIFT = 0x00000001,
    MOD_CONTROL = 0x00000002,
    MOD_ALT = 0x00000004,
    MOD_SUPER = 0x00000008,
    MOD_CAPS_LOCK = 0x00000010,
    MOD_NUM_LOCK = 0x00000020,
    MOUSE_BUTTON_1 = 0x00000000,
    MOUSE_BUTTON_2 = 0x00000001,
    MOUSE_BUTTON_3 = 0x00000002,
    MOUSE_BUTTON_4 = 0x00000003,
    MOUSE_BUTTON_5 = 0x00000004,
    MOUSE_BUTTON_6 = 0x00000005,
    MOUSE_BUTTON_7 = 0x00000006,
    MOUSE_BUTTON_8 = 0x00000007,
    MOUSE_BUTTON_LAST = 0x00000007,
    MOUSE_BUTTON_LEFT = 0x00000000,
    MOUSE_BUTTON_RIGHT = 0x00000001,
    MOUSE_BUTTON_MIDDLE = 0x00000002,
    JOYSTICK_1 = 0x00000000,
    JOYSTICK_2 = 0x00000001,
    JOYSTICK_3 = 0x00000002,
    JOYSTICK_4 = 0x00000003,
    JOYSTICK_5 = 0x00000004,
    JOYSTICK_6 = 0x00000005,
    JOYSTICK_7 = 0x00000006,
    JOYSTICK_8 = 0x00000007,
    JOYSTICK_9 = 0x00000008,
    JOYSTICK_10 = 0x00000009,
    JOYSTICK_11 = 0x0000000A,
    JOYSTICK_12 = 0x0000000B,
    JOYSTICK_13 = 0x0000000C,
    JOYSTICK_14 = 0x0000000D,
    JOYSTICK_15 = 0x0000000E,
    JOYSTICK_16 = 0x0000000F,
    JOYSTICK_LAST = 0x0000000F,
    GAMEPAD_BUTTON_A = 0x00000000,
    GAMEPAD_BUTTON_B = 0x00000001,
    GAMEPAD_BUTTON_X = 0x00000002,
    GAMEPAD_BUTTON_Y = 0x00000003,
    GAMEPAD_BUTTON_LEFT_BUMPER = 0x00000004,
    GAMEPAD_BUTTON_RIGHT_BUMPER = 0x00000005,
    GAMEPAD_BUTTON_BACK = 0x00000006,
    GAMEPAD_BUTTON_START = 0x00000007,
    GAMEPAD_BUTTON_GUIDE = 0x00000008,
    GAMEPAD_BUTTON_LEFT_THUMB = 0x00000009,
    GAMEPAD_BUTTON_RIGHT_THUMB = 0x0000000A,
    GAMEPAD_BUTTON_DPAD_UP = 0x0000000B,
    GAMEPAD_BUTTON_DPAD_RIGHT = 0x0000000C,
    GAMEPAD_BUTTON_DPAD_DOWN = 0x0000000D,
    GAMEPAD_BUTTON_DPAD_LEFT = 0x0000000E,
    GAMEPAD_BUTTON_LAST = 0x0000000E,
    GAMEPAD_BUTTON_CROSS = 0x00000000,
    GAMEPAD_BUTTON_CIRCLE = 0x00000001,
    GAMEPAD_BUTTON_SQUARE = 0x00000002,
    GAMEPAD_BUTTON_TRIANGLE = 0x00000003,
    GAMEPAD_AXIS_LEFT_X = 0x00000000,
    GAMEPAD_AXIS_LEFT_Y = 0x00000001,
    GAMEPAD_AXIS_RIGHT_X = 0x00000002,
    GAMEPAD_AXIS_RIGHT_Y = 0x00000003,
    GAMEPAD_AXIS_LEFT_TRIGGER = 0x00000004,
    GAMEPAD_AXIS_RIGHT_TRIGGER = 0x00000005,
    GAMEPAD_AXIS_LAST = 0x00000005,
    NO_ERROR = 0x00000000,
    NOT_INITIALIZED = 0x00010001,
    NO_CURRENT_CONTEXT = 0x00010002,
    INVALID_ENUM = 0x00010003,
    INVALID_VALUE = 0x00010004,
    OUT_OF_MEMORY = 0x00010005,
    API_UNAVAILABLE = 0x00010006,
    VERSION_UNAVAILABLE = 0x00010007,
    PLATFORM_ERROR = 0x00010008,
    FORMAT_UNAVAILABLE = 0x00010009,
    NO_WINDOW_CONTEXT = 0x0001000A,
    FOCUSED = 0x00020001,
    ICONIFIED = 0x00020002,
    RESIZABLE = 0x00020003,
    VISIBLE = 0x00020004,
    DECORATED = 0x00020005,
    AUTO_ICONIFY = 0x00020006,
    FLOATING = 0x00020007,
    MAXIMIZED = 0x00020008,
    CENTER_CURSOR = 0x00020009,
    TRANSPARENT_FRAMEBUFFER = 0x0002000A,
    HOVERED = 0x0002000B,
    FOCUS_ON_SHOW = 0x0002000C,
    RED_BITS = 0x00021001,
    GREEN_BITS = 0x00021002,
    BLUE_BITS = 0x00021003,
    ALPHA_BITS = 0x00021004,
    DEPTH_BITS = 0x00021005,
    STENCIL_BITS = 0x00021006,
    ACCUM_RED_BITS = 0x00021007,
    ACCUM_GREEN_BITS = 0x00021008,
    ACCUM_BLUE_BITS = 0x00021009,
    ACCUM_ALPHA_BITS = 0x0002100A,
    AUX_BUFFERS = 0x0002100B,
    STEREO = 0x0002100C,
    SAMPLES = 0x0002100D,
    SRGB_CAPABLE = 0x0002100E,
    REFRESH_RATE = 0x0002100F,
    DOUBLEBUFFER = 0x00021010,
    CLIENT_API = 0x00022001,
    CONTEXT_VERSION_MAJOR = 0x00022002,
    CONTEXT_VERSION_MINOR = 0x00022003,
    CONTEXT_REVISION = 0x00022004,
    CONTEXT_ROBUSTNESS = 0x00022005,
    OPENGL_FORWARD_COMPAT = 0x00022006,
    OPENGL_DEBUG_CONTEXT = 0x00022007,
    OPENGL_PROFILE = 0x00022008,
    CONTEXT_RELEASE_BEHAVIOR = 0x00022009,
    CONTEXT_NO_ERROR = 0x0002200A,
    CONTEXT_CREATION_API = 0x0002200B,
    SCALE_TO_MONITOR = 0x0002200C,
    COCOA_RETINA_FRAMEBUFFER = 0x00023001,
    COCOA_FRAME_NAME = 0x00023002,
    COCOA_GRAPHICS_SWITCHING = 0x00023003,
    X11_CLASS_NAME = 0x00024001,
    X11_INSTANCE_NAME = 0x00024002,
    NO_API = 0x00000000,
    OPENGL_API = 0x00030001,
    OPENGL_ES_API = 0x00030002,
    NO_ROBUSTNESS = 0x00000000,
    NO_RESET_NOTIFICATION = 0x00031001,
    LOSE_CONTEXT_ON_RESET = 0x00031002,
    OPENGL_ANY_PROFILE = 0x00000000,
    OPENGL_CORE_PROFILE = 0x00032001,
    OPENGL_COMPAT_PROFILE = 0x00032002,
    CURSOR = 0x00033001,
    STICKY_KEYS = 0x00033002,
    STICKY_MOUSE_BUTTONS = 0x00033003,
    LOCK_KEY_MODS = 0x00033004,
    RAW_MOUSE_MOTION = 0x00033005,
    CURSOR_NORMAL = 0x00034001,
    CURSOR_HIDDEN = 0x00034002,
    CURSOR_DISABLED = 0x00034003,
    ANY_RELEASE_BEHAVIOR = 0x00000000,
    RELEASE_BEHAVIOR_FLUSH = 0x00035001,
    RELEASE_BEHAVIOR_NONE = 0x00035002,
    NATIVE_CONTEXT_API = 0x00036001,
    EGL_CONTEXT_API = 0x00036002,
    OSMESA_CONTEXT_API = 0x00036003,
    WAYLAND_PREFER_LIBDECOR = 0x00038001,
    WAYLAND_DISABLE_LIBDECOR = 0x00038002,
    ARROW_CURSOR = 0x00036001,
    IBEAM_CURSOR = 0x00036002,
    CROSSHAIR_CURSOR = 0x00036003,
    HAND_CURSOR = 0x00036004,
    HRESIZE_CURSOR = 0x00036005,
    VRESIZE_CURSOR = 0x00036006,
    CONNECTED = 0x00040001,
    DISCONNECTED = 0x00040002,
    JOYSTICK_HAT_BUTTONS = 0x00050001,
    COCOA_CHDIR_RESOURCES = 0x00051001,
    COCOA_MENUBAR = 0x00051002,
    WAYLAND_LIBDECOR = 0x00053001,
    DONT_CARE = -1,

    -- Function pointer types
    errorfun = {returns = t_void, args = {t_i32, t_pointer}};
    windowposfun = {returns = t_void, args = {t_pointer, t_i32, t_i32}};
    windowsizefun = {returns = t_void, args = {t_pointer, t_i32, t_i32}};
    windowclosefun = {returns = t_void, args = {t_pointer}};
    windowrefreshfun = {returns = t_void, args = {t_pointer}};
    windowfocusfun = {returns = t_void, args = {t_pointer, t_i32}};
    windowiconifyfun = {returns = t_void, args = {t_pointer, t_i32}};
    windowmaximizefun = {returns = t_void, args = {t_pointer, t_i32}};
    framebuffersizefun = {returns = t_void, args = {t_pointer, t_i32, t_i32}};
    windowcontentscalefun = {returns = t_void, args = {t_pointer, t_float, t_float}};
    mousebuttonfun = {returns = t_void, args = {t_pointer, t_i32, t_i32, t_i32}};
    cursorposfun = {returns = t_void, args = {t_pointer, t_double, t_double}};
    cursorenterfun = {returns = t_void, args = {t_pointer, t_i32}};
    scrollfun = {returns = t_void, args = {t_pointer, t_double, t_double}};
    keyfun = {returns = t_void, args = {t_pointer, t_i32, t_i32, t_i32, t_i32}};
    charfun = {returns = t_void, args = {t_pointer, t_u32}};
    charmodsfun = {returns = t_void, args = {t_pointer, t_u32, t_i32}};
    dropfun = {returns = t_void, args = {t_pointer, t_i32, t_pointer}};
    monitorfun = {returns = t_void, args = {t_pointer, t_i32}};
    joystickfun = {returns = t_void, args = {t_i32, t_i32}};
}

