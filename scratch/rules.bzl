def _smalltalk_repositories(ctx):
    ctx.file("BUILD.bazel", "exports_files(['foo/bar'])")

    ctx.download_and_extract(
        url = "https://files.pharo.org/get-files/90/pharo64-mac-stable.zip",
        sha256 = "c8ad6f4a37a06fd61b6088ede81904ea51f7dbc9cc9043e7d82bc115e155c290",
        stripPrefix = "Pharo.app/Contents",
    )

    ctx.download_and_extract(
        url = "https://files.pharo.org/get-files/90/pharo64.zip",
        sha256 = "5fcb782c39663391402d915d29251815be3fa378f1398a41a702387b5fcc8577",
    )

smalltalk_repositories = repository_rule(
    implementation = _smalltalk_repositories,
)


def _prolog_repositories(ctx):
    ctx.file("BUILD.bazel", "alias(name = 'gprolog', actual = 'opt/local/lib/gprolog-1.5.0/bin/gprolog')")

    ctx.download_and_extract(
        url = "http://www.gprolog.org/gprolog-1.5.0.pkg.zip",
        sha256 = "43f3cc00d0d863cff90350e80c2c02a8fcbb41df5753cab3867bc3815efe67cb",
        stripPrefix = "gprolog-1.5.0.pkg",
    )

    result = ctx.execute(
        ["tar", "-xf", "Contents/Archive.pax.gz"],
    )
    if result.return_code != 0:
        fail("Failed to extract gprolog archive ({}): {}".format(result.return_code, result.stderr))

prolog_repositories = repository_rule(
    implementation = _prolog_repositories,
)
