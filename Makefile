# change it pointed to ckb-transaction-dumper
# https://github.com/nervosnetwork/ckb-transaction-dumper
DUMPER:=~/app/ckb-transaction-dumper
# ckb node
URL:=https://mainnet.ckbapp.dev

BUILDER_DOCKER := nervos/ckb-riscv-gnu-toolchain@sha256:7b168b4b109a0f741078a71b7c4dddaf1d283a5244608f7851f5714fbad273ba

run:
	ckb-debugger --tx-file sample-data/data1.json  --cell-index 0 --cell-type input --script-group-type lock

debug:
	ckb-debugger --listen 127.0.0.1:9999 --tx-file sample-data/data1.json  --cell-index 0 --cell-type input --script-group-type lock \
	--replace-binary deps/ckb-system-scripts/specs/cells/secp256k1_blake160_sighash_all

run-gdb:
	cd deps/ckb-system-scripts && riscv64-unknown-elf-gdb -ex "target remote 127.0.0.1:9999" build/secp256k1_blake160_sighash_all.debug

dump-tx:
	$(DUMPER) -r $(URL) --tx-hash 0x8fa080369a5b868405e49f9597df57214da5c3b0d5f80f42eab4ceeaf0951ddf -o sample-data/data1.json

