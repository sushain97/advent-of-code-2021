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

http_archive(
    name = "build_bazel_rules_swift",
    sha256 = "4f167e5dbb49b082c5b7f49ee688630d69fb96f15c84c448faa2e97a5780dbbc",
    urls = ["https://github.com/bazelbuild/rules_swift/releases/download/0.24.0/rules_swift.0.24.0.tar.gz"],
)

load("@build_bazel_rules_swift//swift:repositories.bzl", "swift_rules_dependencies")

swift_rules_dependencies()

load("@build_bazel_rules_swift//swift:extras.bzl", "swift_rules_extra_dependencies")

swift_rules_extra_dependencies()

http_archive(
    name = "lisp",
    urls = ["https://prdownloads.sourceforge.net/sbcl/sbcl-1.1.6-x86-64-darwin-binary.tar.bz2"],
    sha256 = "1ddeec53da1d9b1f8d5f33d518e2c416388e9a327492c9ebfec06c929fc1b4e7",
    strip_prefix = "sbcl-1.1.6-x86-64-darwin",
    build_file_content = "exports_files(['src/runtime/sbcl', 'output/sbcl.core'])",
)

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

http_archive(
    name = "rules_rust",
    sha256 = "29650f658fa49d797e068f5d3a3254efa714ad172c626be1e815035500231e55",
    strip_prefix = "rules_rust-5a79d72fbdd44980dfa424607dd646d8303d6fc1",
    urls = ["https://github.com/bazelbuild/rules_rust/archive/5a79d72fbdd44980dfa424607dd646d8303d6fc1.tar.gz"],
)

load("@rules_rust//rust:repositories.bzl", "rust_repositories")

rust_repositories()

http_archive(
    name = "rules_foreign_cc",
    strip_prefix = "rules_foreign_cc-605a80355dae9e1855634b733b98a5d97a92f385",
    url = "https://github.com/bazelbuild/rules_foreign_cc/archive/605a80355dae9e1855634b733b98a5d97a92f385.tar.gz",
    sha256 = "08b2d21ea7a52fbc2faf202dba8e260b503785975903f183c56e7118876fdf62",
)

load("@rules_foreign_cc//foreign_cc:repositories.bzl", "rules_foreign_cc_dependencies")

rules_foreign_cc_dependencies()

http_archive(
    name = "php_src",
    build_file_content = "filegroup(name = 'all', srcs = glob(['**']), visibility = ['//visibility:public'])",
    sha256 = "848705043ea4a6e022246ae12a1bff6afcf5c73ea98c6ac4d2108d6028c5c125",
    strip_prefix = "php-8.1.0",
    urls = ["https://www.php.net/distributions/php-8.1.0.tar.gz"],
)

http_archive(
    name = "io_bazel_rules_kotlin",
    urls = ["https://github.com/bazelbuild/rules_kotlin/releases/download/v1.5.0-beta-4/rules_kotlin_release.tgz"],
    sha256 = "6cbd4e5768bdfae1598662e40272729ec9ece8b7bded8f0d2c81c8ff96dc139d",
)

load("@io_bazel_rules_kotlin//kotlin:repositories.bzl", "kotlin_repositories")

kotlin_repositories()

load("@io_bazel_rules_kotlin//kotlin:core.bzl", "kt_register_toolchains")

kt_register_toolchains()

http_archive(
    name = "ghostscript_src",
    urls = ["https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/gs9550/ghostscript-9.55.0.tar.gz"],
    build_file_content = "filegroup(name = 'all', srcs = glob(['**']), visibility = ['//visibility:public'])",
    sha256 = "31e2064be67e15b478a8da007d96d6cd4d2bee253e5be220703a225f7f79a70b",
    strip_prefix = "ghostscript-9.55.0",
)

http_archive(
    name = "io_bazel_rules_scala",
    sha256 = "19d37e639b20abd36ed63d45659d760a5ad784e13b305bc4f387f00b725be250",
    strip_prefix = "rules_scala-5ab2eda264739d4687fbc7935f424def0f3fafd7",
    urls = ["https://github.com/bazelbuild/rules_scala/archive/5ab2eda264739d4687fbc7935f424def0f3fafd7.zip"],
)

load("@io_bazel_rules_scala//:scala_config.bzl", "scala_config")

scala_config()

load("@io_bazel_rules_scala//scala:scala.bzl", "scala_repositories")

scala_repositories()

load("@io_bazel_rules_scala//scala:toolchains.bzl", "scala_register_toolchains")

scala_register_toolchains()

http_archive(
    name = "rules_haskell",
    urls = ["https://github.com/tweag/rules_haskell/archive/0c31ab717cf82c1ebcba275b6adf68244e47fe74.tar.gz"],
    sha256 = "7d5002f5fc9211d6ce0bfc610bcdc80d4661117f21979e2eed18883089810171",
    strip_prefix = "rules_haskell-0c31ab717cf82c1ebcba275b6adf68244e47fe74",
)

load("@rules_haskell//haskell:repositories.bzl", "rules_haskell_dependencies")

rules_haskell_dependencies()

load("@rules_haskell//haskell:toolchain.bzl", "rules_haskell_toolchains")

rules_haskell_toolchains()

http_archive(
    name = "lua",
    urls = ["https://downloads.sourceforge.net/project/luabinaries/5.2.4/Tools%20Executables/lua-5.2.4_MacOS1011_bin.tar.gz"],
    sha256 = "0da72cf3418667ca8eada3b450b9a1fb349d4eac916cab2ec39339b4032e2fce",
    build_file_content = "alias(name = 'lua', actual = 'lua52', visibility = ['//visibility:public'])",
)


# breaker


http_archive(
    name = "cobol_src",
    urls = ["https://sourceforge.net/projects/gnucobol/files/gnucobol/3.1/gnucobol-3.1.2.tar.xz"],
    build_file_content = "filegroup(name = 'all', srcs = glob(['**']), visibility = ['//visibility:public'])",
    sha256 = "597005d71fd7d65b90cbe42bbfecd5a9ec0445388639404662e70d53ddf22574",
    strip_prefix = "gnucobol-3.1.2",
)

http_archive(
    name = "erlang_src",
    urls = ["https://github.com/erlang/otp/releases/download/OTP-24.2/otp_src_24.2.tar.gz"],
    sha256 = "af0f1928dcd16cd5746feeca8325811865578bf1a110a443d353ea3e509e6d41",
    build_file_content = "filegroup(name = 'all', srcs = glob(['**']), visibility = ['//visibility:public'])",
    strip_prefix = "otp_src_24.2",
)
