# RISC-V ASCON Coprocessor (NASA-Oriented Deliverable)

Proyecto técnico orientado a sistemas críticos: acelerador criptográfico ligero en RTL con integración RISC-V custom instruction, verificación reproducible y documentación de entrega profesional.

## Arquitectura
- [rtl/ascon_round_core.sv](rtl/ascon_round_core.sv): una ronda ASCON (320-bit state).
- [rtl/riscv_ascon_coprocessor.sv](rtl/riscv_ascon_coprocessor.sv): wrapper secuencial con `start/busy/done` y detección de corrupción por recomputación.
- [rtl/rv_custom_ascon_if.sv](rtl/rv_custom_ascon_if.sv): interfaz tipo RISC-V `custom0` para invocar el acelerador desde pipeline integer.

## Verificación
- [tb/tb_riscv_ascon_coprocessor.sv](tb/tb_riscv_ascon_coprocessor.sv): regresión del coprocesador.
- [tb/tb_rv_custom_ascon_if.sv](tb/tb_rv_custom_ascon_if.sv): test de integración instrucción custom.
- [scripts/ascon_golden.py](scripts/ascon_golden.py): vector dorado de referencia.

## Comandos
```bash
make golden
make test_core
make test_if
make verify
make package
```

## Entrega
- Criterios: [docs/ACCEPTANCE_CRITERIA.md](docs/ACCEPTANCE_CRITERIA.md)
- Notas de entrega: [docs/DELIVERY_NOTES.md](docs/DELIVERY_NOTES.md)
- Plan NASA-ready: [docs/NASA_READY_ROADMAP.md](docs/NASA_READY_ROADMAP.md)
- Plantilla de métricas: [docs/METRICS_TEMPLATE.md](docs/METRICS_TEMPLATE.md)
- Texto CV/LinkedIn: [docs/LINKEDIN_CV_BULLETS.md](docs/LINKEDIN_CV_BULLETS.md)
