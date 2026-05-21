# Acceptance Criteria

## Functional
- El coprocesador procesa una ronda ASCON por operación solicitada.
- `done_o` se activa exactamente un ciclo al finalizar.
- `busy_o` permanece activo durante la ejecución.
- Ante inyección de fallo de 1 bit, `fault_detected_o` debe ser `1`.
- Sin inyección de fallo, `fault_detected_o` debe ser `0`.

## Verification
- `make golden` produce salida determinista del modelo de referencia.
- `make test` finaliza con `[PASS] Extended regression completed`.
- Regresión incluye casos nominales, fault-injection y barrido de 32 variantes.

## Deliverable quality
- Estructura modular (`rtl/`, `tb/`, `scripts/`, `docs/`).
- Documentación técnica trazable y orientada a revisión.
- Paquete generado con `make package`.
