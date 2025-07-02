const UserEntity = @import("../../domain/user.zig").UserEntity;

pub const IUserRepository = struct {
    save: fn (self: *anyopaque, user: UserEntity) anyerror!void,
    findById: fn (self: *anyopaque, id: u32) anyerror!?UserEntity,
};

pub const UserRepository = struct {
    self: *anyopaque,
    vtable: *const IUserRepository,

    pub fn save(self: UserRepository, user: UserEntity) anyerror!void {
        return self.vtable.save(self.self, user);
    }

    pub fn findById(self: UserRepository, id: u32) anyerror!?UserEntity {
        return self.vtable.findById(self.self, id);
    }
};