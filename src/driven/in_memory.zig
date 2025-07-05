const std = @import("std");
const ports = @import("../ports/index.zig");
const domain = @import("../domain/index.zig");

const Task = domain.TaskEntity;

pub const TaskInMemRepository = struct {
    allocator: std.mem.Allocator,
    todos: std.ArrayList(Task),

    pub fn save(ptr: *anyopaque, task: Task) anyerror!void {
        const self: *TaskInMemRepository = @ptrCast(@alignCast(ptr));
        try self.todos.append(task);
    }

    pub fn findById(ptr: *anyopaque, id: u32) anyerror!?Task {
        const self: *TaskInMemRepository = @ptrCast(@alignCast(ptr));
        for (self.todos.items) |item| {
            if (item.id == id) {
                return item;
            }
        }
        return error.TaskNotFound;
    }

    pub fn findAll(ptr: *anyopaque) anyerror![]Task {
        const self: *TaskInMemRepository = @ptrCast(@alignCast(ptr));
        return self.todos.items;
    }

    // TODO: fix error here
    pub fn delete(_: *anyopaque, _: u32) anyerror!void {
        // const self: *TaskInMemRepository = @ptrCast(@alignCast(ptr));
        // for (self.todos.items) |it| {
        //     if (it.id == id) {
        //         try self.todos.pop();
        //         return;
        //     }
        // }
        return error.TaskNotFound;
    }

    pub fn taskInMemRepository(self: *TaskInMemRepository) ports.TaskInMemPort {
        return .{
            .ptr = self,
            .saveFn = TaskInMemRepository.save,
            .findByIdFn = TaskInMemRepository.findById,
            .findAllFn = TaskInMemRepository.findAll,
            .deleteByIdFn = TaskInMemRepository.delete,
        };
    }

    // TODO: fix error here
    pub fn deinit(self: *TaskInMemRepository) void {
        // for (self.todos.items) |item| {
        //     item.deinit(&self.allocator);
        // }
        self.todos.deinit();
    }
};
