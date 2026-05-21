# RISC-V ASCON Coprocessor MVP

Engineering deliverable package for evaluation in safety- and mission-critical embedded systems.

## Scope
- ASCON round RTL core in SystemVerilog.
- Sequential coprocessor wrapper with `start/busy/done` handshake.
- Temporal recomputation-based corruption detection signal.
- RISC-V `custom0` style interface module.
- Reproducible verification flow and release packaging.

## Repository Structure
- `rtl/`: hardware modules.
- `tb/`: testbenches and regression scenarios.
- `scripts/`: golden-reference helper tools.
- `docs/`: contractual and technical delivery documents.

## Build and Verification
```bash
make golden
make test_core
make test_if
make verify
make package
```

## Deliverable Documents
- `docs/STATEMENT_OF_WORK.md`
- `docs/ACCEPTANCE_CRITERIA.md`
- `docs/DELIVERY_NOTES.md`
- `docs/TECHNICAL_NOTE.md`
- `docs/METRICS_TEMPLATE.md`
- `docs/RISK_REGISTER.md`
- `docs/HANDOFF_CHECKLIST.md`

## Important Commercial Note
This repository is a technical MVP and evaluation deliverable. It is not, by itself, a procurement contract, award, or guarantee of engagement with NASA or any other organization.
