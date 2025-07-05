const std = @import("std");

pub const TaskEntity = struct {
    id: u32,
    title: []const u8,
    completed: bool,
    created_at: []const u8,

    pub fn new(
        allocator: std.mem.Allocator,
        id: u32,
        title: []const u8,
        completed: bool,
        created_at: []const u8,
    ) !TaskEntity {
        return TaskEntity{
            .id = id,
            .title = try allocator.dupe(u8, title),
            .completed = completed,
            .created_at = try allocator.dupe(u8, created_at),
        };
    }

    // TODO: fix error here
    pub fn deinit(self: *TaskEntity, allocator: std.mem.Allocator) void {
        allocator.free(self.title);
        allocator.free(self.created_at);
    }
};
