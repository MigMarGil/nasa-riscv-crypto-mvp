# Statement of Work (SOW)

## Project
RISC-V ASCON Coprocessor MVP

## Objective
Deliver a verifiable hardware MVP for lightweight cryptographic acceleration suitable for assessment in resilient embedded-system programs.

## In Scope
- SystemVerilog implementation of one ASCON round and coprocessor wrapper.
- RISC-V custom instruction style interface module.
- Deterministic golden-reference script for consistency checks.
- Automated simulation-based verification and packaging.
- Delivery documentation for acceptance, risks, and handoff.

## Out of Scope
- Flight qualification or mission certification.
- Formal radiation-hard qualification.
- Full ASCON multi-round production core.
- FPGA/ASIC timing closure and sign-off PPA report.

## Deliverables
- Source RTL, testbenches, scripts, and Makefile.
- Verification outputs from `make verify`.
- Release archive from `make package`.
- Technical delivery documents in `docs/`.

## Acceptance Basis
Acceptance is based on criteria defined in `docs/ACCEPTANCE_CRITERIA.md`.

## Assumptions
- Toolchain includes `iverilog` and `vvp`.
- Linux-like environment for `make` and shell scripts.

## Constraints
- MVP architecture prioritizes clarity and reproducibility over peak throughput.
