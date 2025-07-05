const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const domain_mod = b.addModule("domain", .{
        .root_source_file = b.path("src/domain/index.zig"),
        .target = target,
        .optimize = optimize,
    });

    const driven_mod = b.addModule("driven", .{
        .root_source_file = b.path("src/driven/index.zig"),
        .target = target,
        .optimize = optimize,
    });

    const driving_mod = b.addModule("driving", .{
        .root_source_file = b.path("src/driving/index.zig"),
        .target = target,
        .optimize = optimize,
    });

    const ports_mod = b.addModule("ports", .{
        .root_source_file = b.path("src/ports/index.zig"),
        .target = target,
        .optimize = optimize,
    });

    const services_mod = b.addModule("services", .{
        .root_source_file = b.path("src/services/index.zig"),
        .target = target,
        .optimize = optimize,
    });

    const exe_mod = b.createModule(.{
        .root_source_file = b.path("src/main.zig"),
        .target = target,
        .optimize = optimize,
    });

    const exe = b.addExecutable(.{
        .name = "TODOz",
        .root_module = exe_mod,
    });
    b.installArtifact(exe);

    exe.root_module.addImport("domain", domain_mod);
    exe.root_module.addImport("driven", driven_mod);
    exe.root_module.addImport("driving", driving_mod);
    exe.root_module.addImport("ports", ports_mod);
    exe.root_module.addImport("services", services_mod);

    const run_cmd = b.addRunArtifact(exe);
    run_cmd.step.dependOn(b.getInstallStep());

    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);
}
