# ckb-debugger-playground


```bash
git submodule update --init --recursive
cd deps/ckb-system-scripts
make install-tools
make all-via-docker

cd ../..
make debug
# in another terminal
make run-gdb

```

### GDB usage

```
p/x
p/x *temp@16
```

