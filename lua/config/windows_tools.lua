if vim.fn.has("win32") ~= 1 then
    return
end

-- Some Windows shells export C.UTF-8, which Neovim's Windows C runtime treats
-- as the plain C locale. Restore UTF-8 character handling for that case.
if vim.v.ctype == "C" then
    pcall(vim.cmd, "language ctype en_US.UTF-8")
end

-- winget portable packages do not always add their executable directories to PATH.
-- Keep these additions in Neovim's process only so WezTerm's PATH stays untouched.
local function add_if_missing(command, pattern)
    if vim.fn.executable(command) == 1 then
        return
    end
    local matches = vim.fn.glob(pattern, false, true)
    for _, executable in ipairs(matches) do
        if vim.fn.filereadable(executable) == 1 then
            vim.env.PATH = vim.fn.fnamemodify(executable, ":h") .. ";" .. vim.env.PATH
            return
        end
    end
end

local winget = vim.env.LOCALAPPDATA .. "/Microsoft/WinGet/Packages/"
add_if_missing("rg", winget .. "BurntSushi.ripgrep.MSVC_*/ripgrep-*/rg.exe")
add_if_missing("fd", winget .. "sharkdp.fd_*/fd-*/fd.exe")
add_if_missing("clang", (vim.env.ProgramFiles or "C:/Program Files") .. "/LLVM/bin/clang.exe")
add_if_missing("7z", (vim.env.ProgramFiles or "C:/Program Files") .. "/7-Zip/7z.exe")
add_if_missing(
    "cmake",
    (vim.env.ProgramFiles or "C:/Program Files")
        .. "/Microsoft Visual Studio/*/*/Common7/IDE/CommonExtensions/Microsoft/CMake/CMake/bin/cmake.exe"
)
add_if_missing(
    "ninja",
    (vim.env.ProgramFiles or "C:/Program Files")
        .. "/Microsoft Visual Studio/*/*/Common7/IDE/CommonExtensions/Microsoft/CMake/Ninja/ninja.exe"
)

-- Visual Studio's compiler needs INCLUDE and LIB as well as cl.exe on PATH.
-- Import its developer environment only when no standalone compiler is available.
if vim.fn.executable("clang") == 0 and vim.fn.executable("cl") == 0 then
    local vsdevcmd = vim.fn.glob(
        (vim.env.ProgramFiles or "C:/Program Files")
            .. "/Microsoft Visual Studio/*/*/Common7/Tools/VsDevCmd.bat",
        false,
        true
    )[1]
    if vsdevcmd then
        local lines = vim.fn.systemlist({
            "cmd.exe",
            "/d",
            "/s",
            "/c",
            '""' .. vsdevcmd .. '" -arch=x64 -host_arch=x64 >nul && set"',
        })
        if vim.v.shell_error == 0 then
            for _, line in ipairs(lines) do
                local name, value = line:match("^([^=]+)=(.*)$")
                if name and ({ path = true, include = true, lib = true, libpath = true })[name:lower()] then
                    vim.env[name:upper()] = value:gsub("\r$", "")
                end
            end
        end
    end
end
