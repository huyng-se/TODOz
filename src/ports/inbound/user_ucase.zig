const UserRepo = @import("../outbound/user_repository.zig").UserRepository;
const UserEntity = @import("../../domain/user.zig").UserEntity;

pub fn createUser(repo: UserRepo, name: []const u8) !void {
    const new_user = UserEntity{ .id = 123, .name = name };
    try repo.save(new_user);

    return;
}