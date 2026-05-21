# Technical Note (v1)

## Problem Context
Mission and safety-critical embedded systems require predictable cryptographic operations under strict power and robustness constraints. Hardware acceleration can reduce software overhead and improve timing determinism.

## Implemented Architecture
- `ascon_round_core.sv`: combinational/round transformation over 320-bit state.
- `riscv_ascon_coprocessor.sv`: sequential control shell with handshake and temporal recomputation check.
- `rv_custom_ascon_if.sv`: RISC-V custom instruction style integration stub/interface.

## Reliability Strategy
The design includes temporal recomputation and result comparison to raise `fault_detected_o` under mismatch conditions.

## Verification Strategy
- Golden-reference script for repeatable check vectors.
- Core regression with nominal and fault-injection cases.
- Interface integration test for custom instruction path behavior.

## Known Technical Limits
- One ASCON round per operation in current MVP.
- Detection-oriented robustness, not correction.
- No formal proof package included.
- No FPGA/ASIC post-synthesis PPA report included.

## Path to Production Readiness
1. Multi-round and parameterized latency pipeline.
2. Official NIST ASCON vectors and expanded conformance coverage.
3. Assertions/coverage closure and formal checks.
4. FPGA synthesis/timing/power characterization.
5. Target-core integration (for example CV32E40P/PicoRV32/VexRiscv).
