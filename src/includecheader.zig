const Cpp = @cImport({
    @cDefine("_NO_CRT_STDIO_INLINE", "1");
    @cInclude("stdio.h");
});

pub fn helloWorldFromC() void {
    Cpp.printf("Hello");
}
