const std = @import("std");
const ports = @import("../ports/index.zig");
const domain = @import("../domain/index.zig");

const Task = domain.TaskEntity;

pub const TaskService = struct {
    allocator: std.mem.Allocator,
    repo: ports.TaskInMemPort,
    next_id: u32,

    pub fn taskServicePort(self: *TaskService) ports.TaskServicePort {
        return .{
            .ptr = self,
            .createTaskFn = TaskService.createTask,
            .findTaskFn = TaskService.findTask,
            .listTasksFn = TaskService.listTasks,
            .deleteTaskFn = TaskService.deleteTask,
        };
    }

    pub fn createTask(ptr: *anyopaque, payload: Task) anyerror!void {
        var self: *TaskService = @ptrCast(@alignCast(ptr));
        const new_task = try Task.new(
            self.allocator,
            payload.id,
            payload.title,
            payload.description,
            payload.status,
        );

        self.next_id += 1;
        try self.repo.save(self.allocator, new_task);
        return;
    }

    pub fn findTask(ptr: *anyopaque, id: u32) anyerror!?Task {
        var self: *TaskService = @ptrCast(@alignCast(ptr));
        const task = try self.repo.findById(self.allocator, id);

        if (task) |t| {
            return t;
        } else {
            return error.TaskNotFound;
        }
    }

    pub fn listTasks(ptr: *anyopaque) anyerror![]Task {
        var self: *TaskService = @ptrCast(@alignCast(ptr));
        return self.repo.findAll(self.allocator);
    }

    pub fn deleteTask(ptr: *anyopaque, id: u32) anyerror!void {
        var self: *TaskService = @ptrCast(@alignCast(ptr));
        const task = try self.repo.findById(self.allocator, id);

        if (task) |t| {
            try self.repo.delete(self.allocator, t);
        } else {
            return error.TaskNotFound;
        }
    }
};
