# ckb-debugger-playground

Use with slides/presentation.pptx

# Quick Start

```
git clone https://github.com/XuJiandong/ckb-debugger-playground.git
git submodule update --init --recursive
make all-via-docker
cd deps/ckb-system-scripts
make install-tools
make all-via-docker
```
Then play with commands mentioned in slides/presentation.pptx. 

# Play with Rust contracts
First install [capsule](https://github.com/nervosnetwork/capsule).
Then build contract:
```
cd rust/contract1
capsule build
```

After that, replace binary with `$(RUST_BIN)` in Makefile and play with them.
