const std = @import("std");
const ports = @import("../ports/index.zig");

pub const CLIHandler = struct {
    allocator: std.mem.Allocator,
    service: ports.TaskServicePort,

    // TODO: fix error here
    pub fn handle(_: CLIHandler) !void {
        var input: [10]u8 = undefined;
        const stdin = std.io.getStdIn().reader();
        const stdout = std.io.getStdOut().writer();

        _ = try stdin.readUntilDelimiter(&input, '\n');

        try stdout.print("The user entered: {s}\n", .{input});

        // if (args.len < 2) {
        //     std.debug.print("Usage: <app> [list|add <title>]\n", .{});
        //     return error.InvalidArguments;
        // }

        // if (std.mem.eql(u8, command, "list")) {
        //     const todos = try self.service.listTasks();
        //     std.debug.print("--- TODO LIST ---\n", .{});

        //     if (todos.len == 0) {
        //         std.debug.print("(empty)\n", .{});
        //     }

        //     for (todos) |todo| {
        //         std.debug.print("[{d}] {s} {s} {s}", .{ todo.id, if (todo.completed) "✓" else "✗", todo.title, todo.created_at });
        //     }
        // } else

        // if (std.mem.eql(u8, command, "add")) {
        //     if (args.len < 3) {
        //         std.debug.print("Usage: <app> add <title>\n", .{});
        //         return error.InvalidArguments;
        //     }

        //     const title = args[2];
        //     try self.service.createTask(title);
        //     std.debug.print("Added task: {s}\n", .{title});
        // } else {
        //     std.debug.print("Unknown command: {s}\n", .{command});
        //     return error.UnknownCommand;
        // }
    }
};
