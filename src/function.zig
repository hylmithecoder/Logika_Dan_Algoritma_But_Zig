const std = @import("std");
const print = std.debug.print;
const stdin = std.fs.File.stdin;
const crypto = std.crypto;
const uuid = @import("uuid");
const equal = std.mem.eql;

pub fn helloWorld() void {
    print("Hello World\n", .{});
}

pub fn hashPassword(password: []const u8) void {
    // std.log.info("Hashing password: {s}", .{password});
    var sha3_256 = crypto.hash.sha3.Sha3_256.init(.{});
    sha3_256.update(password);
    var out: [crypto.hash.sha3.Sha3_256.digest_length]u8 = undefined;
    sha3_256.final(&out);
    // std.log.info("End Hashing", .{});
    print("{s} \n", .{out});
    // return &out;
}

fn sha256Hash(password: []const u8) void {
    var sha256 = crypto.hash.sha2.Sha256.init(.{});
    sha256.update(password);
    var out: [crypto.hash.sha2.Sha256.digest_length]u8 = undefined;
    sha256.final(&out);
    print("{s} \n", .{out});
    // return &out;
}

fn sha3_256Hash(password: []const u8) void {
    var sha3_256 = crypto.hash.sha3.Sha3_256.init(.{});
    sha3_256.update(password);
    var out: [crypto.hash.sha3.Sha3_256.digest_length]u8 = undefined;
    sha3_256.final(&out);
    print("{s} \n", .{out});
    // return &out;
}

pub fn uuidGenerator() void {
    // Generate a random UUID v4
    const uuid4 = uuid.v4.new();

    // Use {} instead of {s} - the Uuid type has a custom formatter
    std.debug.print("Secure UUID: {}\n", .{uuid4});
}

pub fn readLine(buffer: []u8) !?[]const u8 {
    const stdin_file = stdin();

    // Read bytes directly from stdin handle
    const bytes_read = stdin_file.read(buffer) catch |err| {
        return err;
    };

    if (bytes_read == 0) {
        return null; // EOF
    }

    // Find newline and return slice without it
    var line = buffer[0..bytes_read];
    if (line.len > 0 and line[line.len - 1] == '\n') {
        line = line[0 .. line.len - 1];
    }
    // Also handle Windows CRLF
    if (line.len > 0 and line[line.len - 1] == '\r') {
        line = line[0 .. line.len - 1];
    }

    return line;
}

pub fn input(message: []const u8, buffer: []u8) !?[]const u8 {
    std.debug.print("{s}", .{message});
    return readLine(buffer);
}

pub fn cin(message: []const u8) ![]const u8 {
    var buffer: [1024]u8 = undefined;
    if (try input(message, &buffer)) |line| {
        return line;
    }
    return error.NoInput;
}

pub fn Login() void {
    var username: []const u8 = undefined;
    var password: []const u8 = undefined;

    username = cin("Username: ") catch return;
    password = cin("Password: ") catch return;

    hashPassword(password);
    sha256Hash(password);
    sha3_256Hash(password);
    uuidGenerator();

    print("Your Name: {s}\n Password: {s}\n", .{ username, password });
    if (equal(u8, username, "hylmi") and equal(u8, password, "hylmi123")) {
        std.debug.print("Login Success\n", .{});
    } else {
        std.debug.print("Login Failed\n", .{});
    }
}

fn standarLooping(target: usize) void {
    for (0..target) |i| {
        std.debug.print("{d}\n", .{i});
    }
}

fn arrayLooping() void {
    const array = [_]u8{ 'a', 'b', 'c', 'd', 'e' };
    for (array) |c| {
        std.debug.print("{c}\n", .{c});
    }
}

fn whileLooping() void {
    var i: u8 = 0;
    while (i < 10) {
        std.debug.print("{d}\n", .{i});
        i += 1;
    }
}

pub fn Looping() void {
    var target: []const u8 = undefined;
    target = cin("Input Target: ") catch return;
    const targetInt = std.fmt.parseInt(usize, target, 10) catch return;
    standarLooping(targetInt);
    arrayLooping();
    whileLooping();
}

pub fn testFileStream() void {
    const cwd = std.fs.cwd();

    // Create a new file named "example.txt"
    // Use catch to handle potential errors since function returns void
    const file = cwd.createFile("example.txt", .{ .read = true }) catch |err| {
        std.debug.print("Failed to create file: {}\n", .{err});
        return;
    };

    // Ensure the file is closed when the function exits
    defer file.close();

    const content = "Hello, Zig file system example!\nThis is a second line.";

    // Write the string content to the file
    file.writeAll(content) catch |err| {
        std.debug.print("Failed to write to file: {}\n", .{err});
        return;
    };

    // Print a confirmation message
    std.debug.print("Successfully wrote to 'example.txt'\n", .{});
}

pub fn HandleFunction() void {
    helloWorld();
    print("Login Method\n", .{});
    Login();
    print("Looping Method\n", .{});
    Looping();
    testFileStream();
}
