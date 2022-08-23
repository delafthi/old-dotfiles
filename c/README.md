# C Dev

This folder contains the configuration for tools related to C/C++ development.

## Clang

The configuration file for the `clang-format` tool, which is part of the clang
toolset.

### References

- [Clang](https://clang.llvm.org/)
- [Clang-Format](https://clang.llvm.org/docs/ClangFormat.html)

## GDB-Dashboard

GDB dashboard is a standalone `.gdbinit` file written using the Python API that
enables a modular interface showing relevant information about the program being
debugged. It automatically shows up, when hitting a breakpoint.

### Dependencies

- [pygments](https://pygments.org/) for text highlighting.
  - [nord-pygments](https://github.com/lewisacidic/nord-pygments)

### References

- [gdb-dashboard](https://github.com/cyrus-and/gdb-dashboard)
