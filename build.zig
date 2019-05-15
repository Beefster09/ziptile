const Builder = @import("std").build.Builder;
const builtin = @import("builtin");

pub fn build(b: *Builder) void {
    const mode = b.standardReleaseOptions();
    const windows = b.option(bool, "windows", "create windows build") orelse false;

    // const exe = b.addExecutable("demo", "src/main.zig");
    const exe = b.addExecutable("hello", "hello.zig");
    exe.setBuildMode(mode);
    exe.setOutputDir("./build");
    // b.addNativeSystemIncludeDir("X:\\Documents\\Development\\libs\\libepoxy-1.5.3\\include");
    // b.addNativeSystemIncludeDir("X:\\Documents\\Development\\libs\\glfw\\include");
    // b.detectNativeSystemPaths();

    if (windows) {
        exe.setTarget(builtin.Arch.x86_64, builtin.Os.windows, builtin.Abi.gnu);
    }

    exe.linkSystemLibrary("c");
    exe.linkSystemLibrary("glfw");
    exe.linkSystemLibrary("epoxy");

    const run_cmd = exe.run();

    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);

    b.default_step.dependOn(&exe.step);
    b.installArtifact(exe);
}
