pub const TaskEntity = struct {
    id: u32,
    title: []const u8,
    status: bool,
    description: []const u8,
    createdAt: []const u8,
    updatedAt: []const u8
};