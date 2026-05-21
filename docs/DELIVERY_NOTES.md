# Delivery Notes

## Scope (MVP)
- Núcleo de ronda ASCON en SystemVerilog.
- Wrapper secuencial con handshake y comprobación de integridad por duplicación temporal.
- Banco de pruebas con regresión extendida.
- Modelo dorado Python para referencia funcional de una ronda.

## Known limitations
- Implementa una sola ronda por operación (no pipeline multi-ronda completo).
- Detección sin corrección de errores.
- Sin síntesis PPA incluida en este paquete.

## Recommended next phase
1. Integrar interfaz custom instruction con core RISC-V objetivo.
2. Añadir suite de vectores NIST ASCON completos.
3. Ejecutar lint formal (verilator/slang) y cobertura funcional.
4. Añadir resultados de síntesis FPGA (LUT/FF/Fmax) y estimación energética.
