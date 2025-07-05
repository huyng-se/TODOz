const std = @import("std");
const Task = @import("domain/index.zig").TaskEntity;
const Repository = @import("driven/index.zig").TaskInMemRepository;
const Service = @import("services/index.zig").TaskService;
const CLI = @import("driving/cli.zig").CLIHandler;

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    var in_memory = Repository{
        .allocator = allocator,
        .todos = std.ArrayList(Task).init(allocator),
    };
    defer in_memory.deinit();

    var service = Service{
        .allocator = allocator,
        .repo = in_memory.taskInMemRepository(),
        .next_id = 1,
    };

    var cli = CLI{
        .allocator = allocator,
        .service = service.taskServicePort(),
    };

    cli.handle() catch |err| {
        std.debug.print("Error: {}\n", .{err});
        return err;
    };
}
