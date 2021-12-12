load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

http_archive(
    name = "rules_perl",
    urls = ["https://github.com/bazelbuild/rules_perl/archive/2f4f36f454375e678e81e5ca465d4d497c5c02da.tar.gz"],
    strip_prefix = "rules_perl-2f4f36f454375e678e81e5ca465d4d497c5c02da",
    sha256 = "55fbe071971772758ad669615fc9aac9b126db6ae45909f0f36de499f6201dd3",
)

load("@rules_perl//perl:deps.bzl", "perl_register_toolchains", "perl_rules_dependencies",)

perl_rules_dependencies()

perl_register_toolchains()

http_archive(
    name = "rules_dart",
    urls = ["https://github.com/cbracken/rules_dart/archive/refs/tags/2.13.1.tar.gz"],
    strip_prefix = "rules_dart-2.13.1",
    sha256 = "6112595be3d626aef509a85ef96aece90e8ee09fb224172faaec599228d83b3e",
)
load("@rules_dart//dart/build_rules:repositories.bzl", "dart_repositories")

dart_repositories()

http_archive(
    name = "build_bazel_rules_nodejs",
    sha256 = "cfc289523cf1594598215901154a6c2515e8bf3671fd708264a6f6aefe02bf39",
    urls = ["https://github.com/bazelbuild/rules_nodejs/releases/download/4.4.6/rules_nodejs-4.4.6.tar.gz"],
)

load("@build_bazel_rules_nodejs//:index.bzl", "node_repositories")

node_repositories()

http_archive(
    name = "sqlite3",
    urls = ["https://www.sqlite.org/2021/sqlite-amalgamation-3370000.zip"],
    sha256 = "a443aaf5cf345613492efa679ef1c9cc31ba109dcdf37ee377f61ab500d042fe",
    strip_prefix = "sqlite-amalgamation-3370000",
    build_file_content = "cc_binary(name = 'sqlite3', srcs = ['shell.c', 'sqlite3.c', 'sqlite3.h'], visibility = ['//visibility:public'])",
)

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

http_archive(
    name = "rules_d",
    urls = ["https://github.com/bazelbuild/rules_d/archive/bcf137e3c9381545ce54715632bc1d31c51ee4da.tar.gz"],
    sha256 = "a32847bf2ae634563dece49c4dc8353956b64ba5c2d01ce811ea243e1a21b5b7",
    strip_prefix = "rules_d-bcf137e3c9381545ce54715632bc1d31c51ee4da",
)

load("@rules_d//d:d.bzl", "DMD_BUILD_FILE")

http_archive(
    name = "dmd_darwin_x86_64",
    urls = ["https://downloads.dlang.org/releases/2021/dmd.2.098.0.osx.tar.xz"],
    sha256 = "7780aad4429d499a647e7e907706f775656be77f4425c8b4aeab798024c7f342",
    build_file_content = DMD_BUILD_FILE,
)

http_archive(
    name = "io_bazel_rules_dotnet",
    urls = ["https://github.com/bazelbuild/rules_dotnet/archive/02d7f4fbfa05ce2a8651a29dba7be997555e3642.tar.gz"],
    sha256 = "41cf8febab49f80210a4adb7caab5ffa6572925955f3acfea1271fff09f9541e",
    strip_prefix = "rules_dotnet-02d7f4fbfa05ce2a8651a29dba7be997555e3642",
)

load("@io_bazel_rules_dotnet//dotnet:deps.bzl", "dotnet_repositories")

dotnet_repositories()

load("@io_bazel_rules_dotnet//dotnet:defs.bzl", "dotnet_register_toolchains")

dotnet_register_toolchains()

http_archive(
    name = "j_software",
    urls = ["https://www.jsoftware.com/download/j902/install/j902_mac64.zip"],
    sha256 = "c65f39a68c98132fd2ffd44491a10448e590fc9ea92299176bfde68d735eff41",
    strip_prefix = "j902",
    build_file_content = "exports_files(['bin/jconsole'])",
)

http_archive(
    name = "io_bazel_rules_go",
    sha256 = "8e968b5fcea1d2d64071872b12737bbb5514524ee5f0a4f54f5920266c261acb",
    urls = ["https://github.com/bazelbuild/rules_go/releases/download/v0.28.0/rules_go-v0.28.0.zip"],
)

load("@io_bazel_rules_go//go:deps.bzl", "go_register_toolchains", "go_rules_dependencies")

go_rules_dependencies()

go_register_toolchains(version = "1.17.1")

http_archive(
    name = "coinbase_rules_ruby",
    urls = ["https://github.com/coinbase/rules_ruby/archive/a4bcd8e84cc20b097c7f84a319436698894bf87e.tar.gz"],
    strip_prefix = "rules_ruby-a4bcd8e84cc20b097c7f84a319436698894bf87e",
    sha256 = "9a449b2cdf06873314ad9640bde7d70780083ae223fed320b03ccbc6eb639352",
)

load("@coinbase_rules_ruby//ruby:deps.bzl", "ruby_register_toolchains", "rules_ruby_dependencies")

rules_ruby_dependencies()

ruby_register_toolchains()