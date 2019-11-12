load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository", "new_git_repository")
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("//third_party:sorbet_version.bzl", "SORBET_VERSION")

# We define our externals here instead of directly in WORKSPACE
# because putting the `new_git_repository` calls here instead of there
# works around https://github.com/bazelbuild/bazel/issues/1465 when
# passing `build_file` to the `new_git_repository`.
def sorbet_llvm_externals():
    use_local = False
    if not use_local:
        git_repository(
            name = "com_stripe_ruby_typer",
            remote = "https://github.com/sorbet/sorbet.git",
            commit = SORBET_VERSION,
            # git log -n 1 --pretty=format:"%cd" --date=raw origin/master
            shallow_since = "1573682809 -0800",
        )
    else:
        native.local_repository(
            name = "com_stripe_ruby_typer",
            path = "../sorbet/",
        )

    http_archive(
        name = "org_llvm",
        url = "https://releases.llvm.org/9.0.0/clang+llvm-9.0.0-x86_64-darwin-apple.tar.xz",
        build_file = "//third_party:llvm.BUILD",
        sha256 = "b46e3fe3829d4eb30ad72993bf28c76b1e1f7e38509fbd44192a2ef7c0126fc7",
        strip_prefix = "clang+llvm-9.0.0-x86_64-darwin-apple",
    )
    
    http_archive(
        name = "org_llvm_linux",
        url = "https://releases.llvm.org/9.0.0/clang%2bllvm-9.0.0-x86_64-linux-gnu-ubuntu-18.04.tar.xz",
        build_file = "//third_party:llvm.BUILD",
        sha256 = "a23b082b30c128c9831dbdd96edad26b43f56624d0ad0ea9edec506f5385038d",
        strip_prefix = "clang+llvm-9.0.0-x86_64-linux-gnu-ubuntu-18.04",
    )
