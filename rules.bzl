def _gen_binary(ctx):
    launcher = ctx.actions.declare_file("launch_{}.sh".format(ctx.attr.name))

    content = ctx.expand_location("""
#!/bin/bash
set -euo pipefail
{setup_cmd}
exec {tool} {tool_args} "$@"
""".format(
        setup_cmd = ctx.attr.setup_cmd,
        tool = ctx.file.tool.short_path,
        tool_args = " ".join(ctx.attr.tool_args),
    )).strip() + "\n"

    ctx.actions.write(
        output = launcher,
        content = content,
        is_executable = True,
    )

    return [
        DefaultInfo(
            executable = launcher,
            runfiles = ctx.runfiles(
                files = [launcher] + ctx.files.srcs,
                transitive_files = depset([ctx.file.tool]),
            ),
        ),
    ]

gen_binary = rule(
    implementation = _gen_binary,
    executable = True,
    attrs = {
        "tool": attr.label(
            mandatory = True,
            allow_single_file = True,
            executable = True,
            cfg = 'host',
        ),
        "srcs": attr.label_list(
            allow_files = True,
        ),
        "setup_cmd": attr.string(
            default = "",
        ),
        "tool_args": attr.string_list(
            default = [],
        ),
    },
)
