const std = @import("std");
const UserUCase = @import("./ports/inbound/user_ucase.zig");
const UserDriven = @import("./adapters/driven/user_persistent.zig");

pub fn main() void {
    var db_persistent = UserDriven.Persistent{};
    const userRepo = UserDriven.asUserRepository(&db_persistent);
    try UserUCase.createUser(userRepo, "Elon Musk");
}
