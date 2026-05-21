# Handoff Checklist

## Source Package
- [ ] RTL files present in `rtl/`
- [ ] Testbenches present in `tb/`
- [ ] Golden script present in `scripts/`
- [ ] Build orchestration in `Makefile`

## Verification
- [ ] `make golden` run and archived
- [ ] `make test_core` run and archived
- [ ] `make test_if` run and archived
- [ ] `make verify` run and archived

## Documentation
- [ ] `README.md` updated
- [ ] `STATEMENT_OF_WORK.md` included
- [ ] `ACCEPTANCE_CRITERIA.md` included
- [ ] `DELIVERY_NOTES.md` included
- [ ] `TECHNICAL_NOTE.md` included
- [ ] `RISK_REGISTER.md` included
- [ ] `METRICS_TEMPLATE.md` included

## Release
- [ ] `make package` generated tarball
- [ ] Archive integrity checked (`tar -tzf`)
- [ ] Git tag created for release baseline
