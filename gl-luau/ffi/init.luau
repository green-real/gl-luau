local isZune = pcall(require, "@zcore/ffi")

return isZune and require("./zffi") or error("runtime is not supported")
