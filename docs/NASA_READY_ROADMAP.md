# NASA-Ready Roadmap

## Current maturity
- RTL de ronda ASCON operativo.
- Coprocesador con control secuencial y detección de corrupción por recomputación.
- Interfaz RISC-V tipo custom instruction (opcode `custom0`).
- Regresión automática para core e integración.

## Next gates (target: internship/research-grade demo)
1. Sustituir mock interface por integración con core concreto (VexRiscv / CV32E40P / PicoRV32).
2. Añadir soporte multi-ronda con latencia parametrizable.
3. Conectar conjunto de test vectors oficiales ASCON (NIST LWC).
4. Incluir síntesis FPGA (LUT/FF/Fmax) y estimación energética por operación.
5. Añadir verificación formal básica (assertions SVA + cover points).

## Evidence package expected by reviewers
- Arquitectura en bloque + timing diagram.
- Reporte de cobertura de test.
- Tabla comparativa baseline software vs hardware-accelerated.
- Limitaciones, riesgos y mitigaciones.
