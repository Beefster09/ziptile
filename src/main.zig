const std = @import("std");

const c = @import("c.zig");

const warn = std.debug.warn;
const panic = std.debug.panic;

// #include "renderer.h"

const screen_width = 512 * 2;
const screen_height = 288 * 2;

pub fn main() !void {
    if (c.glfwInit() == c.GL_FALSE) {
        panic("Failed to initialize GLFW.\n");
    }
    defer c.glfwTerminate();

    c.glfwWindowHint(c.GLFW_CONTEXT_VERSION_MAJOR, 3);
    c.glfwWindowHint(c.GLFW_CONTEXT_VERSION_MINOR, 3);
    c.glfwWindowHint(c.GLFW_OPENGL_PROFILE, c.GLFW_OPENGL_CORE_PROFILE);
    c.glfwWindowHint(c.GLFW_OPENGL_FORWARD_COMPAT, c.GL_TRUE);

    var window = c.glfwCreateWindow(screen_width, screen_height, c"Tilemapper", null, null) orelse {
        panic("Failed to create GLFW window!\n");
    };
    defer c.glfwDestroyWindow(window);

    c.glfwMakeContextCurrent(window);

    c.glViewport(0, 0, screen_width, screen_height);
}
