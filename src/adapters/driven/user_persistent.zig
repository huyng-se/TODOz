const std = @import("std");
const UserPorts = @import("../../ports/outbound/user_repository.zig");
const UserEntity = @import("../../domain/user.zig").UserEntity;

pub const Persistent = struct {
    // connection_pool: _,
};

pub fn asUserRepository(self: *Persistent) UserPorts.UserRepository {
    return .{
        .self = @ptrCast(@alignCast(self)),
        .vtable = &IUserPersistent,
    };
}

const IUserPersistent = UserPorts.IUserRepository{
    .save = saveHandler,
    .findById = findByIdHandler,
};

fn saveHandler(user: UserEntity) !void {
    std.debug.print("Save new user: {s}!\n", .{user.name});
}

fn findByIdHandler(id: u32) !void {
    std.debug.print("Find user by id: {}!\n", .{id});
}
