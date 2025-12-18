//! By convention, root.zig is the root source file when making a library.
const std = @import("std");
const function = @import("function.zig");
// const cExample = @import("connecttonetwork.zig");

pub fn bufferedPrint() !void {
    // Stdout is for the actual output of your application, for example if you
    // are implementing gzip, then only the compressed bytes should be sent to
    // stdout, not any debugging messages.
    // cExample.helloWorldFromC();
    var stdout_buffer: [1024]u8 = undefined;
    // var name: []const u8 = undefined;
    var stdout_writer = std.fs.File.stdout().writer(&stdout_buffer);
    const stdout = &stdout_writer.interface;

    var myName: []const u8 = undefined;

    if (try function.input("Enter your name: ", &stdout_buffer)) |name| {
        myName = name;
        std.debug.print("Hello, {s}! Welcome to Zig!\n", .{name});
    } else {
        std.debug.print("No input received (EOF)\n", .{});
        return;
    }

    function.HandleFunction();
    std.debug.print("Your name is {s}\n", .{myName});

    const a = 10;
    const b = 20;

    try stdout.print("{} + {} = {}\n", .{ a, b, add(a, b) });
    try stdout.flush(); // Don't forget to flush!
}

pub fn add(a: i32, b: i32) i32 {
    return a + b;
}

test "basic add functionality" {
    try std.testing.expect(add(3, 7) == 10);
}
