const std = @import("std");
const domain = @import("../domain/index.zig");

const Task = domain.TaskEntity;

pub const TaskServicePort = struct {
    ptr: *anyopaque,
    createTaskFn: *const fn (*anyopaque, []const u8) anyerror!void,
    findTaskFn: *const fn (*anyopaque, u32) anyerror!?Task,
    listTasksFn: *const fn (*anyopaque) anyerror![]Task,
    deleteTaskFn: *const fn (*anyopaque, u32) anyerror!Task,

    pub fn createTask(self: TaskServicePort, title: []const u8) anyerror!void {
        return self.createTaskFn(self.ptr, title);
    }

    pub fn findTask(self: TaskServicePort, id: u32) anyerror!?Task {
        return self.findTaskFn(self.ptr, id);
    }

    pub fn listTasks(self: TaskServicePort) anyerror![]Task {
        return self.listTasksFn(self.ptr);
    }

    pub fn deleteTask(self: TaskServicePort, id: u32) anyerror!Task {
        return self.deleteTaskFn(self.ptr, id);
    }
};

pub const TaskInMemPort = struct {
    ptr: *anyopaque,
    saveFn: *const fn (*anyopaque, Task) anyerror!void,
    findByIdFn: *const fn (*anyopaque, u32) anyerror!?Task,
    findAllFn: *const fn (*anyopaque) anyerror![]Task,
    deleteByIdFn: *const fn (*anyopaque, u32) anyerror!Task,

    pub fn save(self: TaskInMemPort, payload: Task) anyerror!void {
        return self.saveFn(self.ptr, payload);
    }

    pub fn findById(self: TaskInMemPort, id: u32) anyerror!?Task {
        return self.findByIdFn(self.ptr, id);
    }

    pub fn findAll(self: TaskInMemPort) anyerror![]Task {
        return self.findAllFn(self.ptr);
    }

    pub fn deleteById(self: TaskInMemPort, id: u32) anyerror!Task {
        return self.deleteByIdFn(self.ptr, id);
    }
};
