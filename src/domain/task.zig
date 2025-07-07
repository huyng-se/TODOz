const std = @import("std");

pub const TaskEntity = struct {
    id: u32,
    title: []const u8,
    completed: bool,

    pub fn new(
        allocator: std.mem.Allocator,
        id: u32,
        title: []const u8,
        completed: bool,
    ) !TaskEntity {
        return TaskEntity{
            .id = id,
            .title = try allocator.dupe(u8, title),
            .completed = completed,
        };
    }

    pub fn deinit(self: TaskEntity, allocator: std.mem.Allocator) void {
        allocator.free(self.title);
    }
};
