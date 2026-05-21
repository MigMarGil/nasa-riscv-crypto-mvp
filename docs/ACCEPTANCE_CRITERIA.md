# Acceptance Criteria

## Functional Criteria
1. Coprocessor processes one ASCON round per request.
2. `done_o` asserts for exactly one cycle at completion.
3. `busy_o` remains asserted during active execution.
4. With single-bit injected fault, `fault_detected_o` must assert.
5. Without injected fault, `fault_detected_o` must remain deasserted.

## Interface Criteria
1. `rv_custom_ascon_if` correctly decodes the custom-op path used by the testbench.
2. Interface testbench completes with explicit PASS status.

## Verification Criteria
1. `make golden` executes successfully and is deterministic for fixed vectors.
2. `make test_core` completes with PASS status.
3. `make test_if` completes with PASS status.
4. `make verify` completes end-to-end with no simulation errors.

## Packaging Criteria
1. `make package` creates `dist/nasa-riscv-crypto-mvp.tar.gz`.
2. Archive includes `README.md`, `Makefile`, `rtl/`, `tb/`, `scripts/`, `docs/`.

## Documentation Criteria
1. SOW, technical note, delivery notes, risk register, and handoff checklist are present.
2. Known limitations are explicitly stated.

## Non-Criteria (Explicit)
- This MVP does not imply certification, flight readiness, export approval, or procurement award.
