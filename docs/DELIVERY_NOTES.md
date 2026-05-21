# Delivery Notes

## Delivered MVP Scope
- ASCON round core in SystemVerilog.
- Sequential coprocessor control with `start/busy/done`.
- Temporal recomputation-based corruption detection output.
- RISC-V custom-instruction style interface test module.
- Regression and packaging automation via Makefile.

## Validation Summary
This package is considered acceptable when all criteria in `docs/ACCEPTANCE_CRITERIA.md` are met and commands in `README.md` execute successfully.

## Known Limitations
- Single-round operation per request (no full multi-round acceleration pipeline).
- Error detection signal only; no correction path.
- No formal verification sign-off in this delivery.
- No synthesis-based timing/area/power sign-off in this delivery.

## Recommended Next Phase
1. Multi-round architecture and complete ASCON operation support.
2. NIST vector integration and conformance matrix.
3. Formal properties and coverage closure.
4. FPGA/ASIC synthesis and power-performance characterization.
5. Integration into selected RISC-V core with software driver path.
