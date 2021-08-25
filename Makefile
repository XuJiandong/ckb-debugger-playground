# change it pointed to ckb-transaction-dumper
# https://github.com/nervosnetwork/ckb-transaction-dumper
DUMPER:=~/app/ckb-transaction-dumper
# ckb node
URL:=https://mainnet.ckbapp.dev
PORT:=9999

TARGET := riscv64-unknown-linux-gnu
CC := $(TARGET)-gcc
LD := $(TARGET)-gcc
OBJCOPY := $(TARGET)-objcopy
# copy ckb-c-stdlib here before continue
CFLAGS := -O0 -fno-builtin-printf -nostdinc \
-nostdlib -nostartfiles -I deps/ckb-c-stdlib/libc -I deps/ckb-c-stdlib -g
LDFLAGS := -Wl,-static

BUILDER_DOCKER := nervos/ckb-riscv-gnu-toolchain@sha256:aae8a3f79705f67d505d1f1d5ddc694a4fd537ed1c7e9622420a470d59ba2ec3

all: build/fib build/panic

all-via-docker:
	docker run --rm -v `pwd`:/code ${BUILDER_DOCKER} bash -c "cd /code && make"

build/fib: c/fib.c
	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $<

build/panic: c/panic.c
	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $<

run:
	ckb-debugger --tx-file sample-data/data1.json  --cell-index 0 --cell-type input --script-group-type lock

run-simple-binary:
	ckb-debugger --simple-binary build/fib

run-simple-binary-panic:
	ckb-debugger --simple-binary build/panic

run-simple-binary-pprof:
	ckb-debugger --simple-binary build/fib --pprof=build/fib.pprof
	cat build/fib.pprof | inferno-flamegraph > build/fib.svg

run-debugger:
	ckb-debugger --listen 127.0.0.1:${PORT} --tx-file sample-data/data1.json  --cell-index 0 --cell-type input --script-group-type lock \
	--replace-binary deps/ckb-system-scripts/specs/cells/secp256k1_blake160_sighash_all

run-gdb:
	cd deps/ckb-system-scripts && riscv64-unknown-linux-gnu-gdb -ex "target remote host.docker.internal:${PORT}" build/secp256k1_blake160_sighash_all.debug

run-docker:
	docker run --rm -it -v `pwd`:/code ${BUILDER_DOCKER} bash

dump-tx:
	$(DUMPER) -r $(URL) --tx-hash 0x8fa080369a5b868405e49f9597df57214da5c3b0d5f80f42eab4ceeaf0951ddf -o sample-data/data1.json

