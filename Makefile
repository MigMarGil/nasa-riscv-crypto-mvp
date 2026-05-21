SIM ?= iverilog

RTL_CORE = rtl/ascon_round_core.sv rtl/riscv_ascon_coprocessor.sv
TB_CORE  = tb/tb_riscv_ascon_coprocessor.sv

RTL_IF = $(RTL_CORE) rtl/rv_custom_ascon_if.sv
TB_IF  = tb/tb_rv_custom_ascon_if.sv

all: verify

golden:
	./scripts/ascon_golden.py

test_core:
	$(SIM) -g2012 -Wall -Wimplicit -o simv_core $(RTL_CORE) $(TB_CORE)
	vvp simv_core

test_if:
	$(SIM) -g2012 -Wall -Wimplicit -o simv_if $(RTL_IF) $(TB_IF)
	vvp simv_if

test: test_core test_if

verify: golden test

package:
	mkdir -p dist
	tar -czf dist/nasa-riscv-crypto-mvp.tar.gz \
		README.md Makefile rtl tb docs scripts

clean:
	rm -f simv_core simv_if *.vcd
	rm -rf dist
