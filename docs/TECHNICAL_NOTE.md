# Technical Note (v0)

## Contexto
Sistemas espaciales operan bajo restricción energética y exposición a SEU (single event upsets). Un acelerador dedicado reduce consumo por operación criptográfica y mejora previsibilidad temporal.

## Modelo de fallo
Este MVP usa inyección de fallo por flip de 1 bit y comprobación de paridad global para detectar corrupción.

Limitaciones actuales:
- La paridad detecta número impar de errores, no todos los patrones múltiples.
- No existe corrección, solo detección.

## Plan de validación
- Pruebas funcionales por ronda.
- Pruebas de robustez para múltiples posiciones de bit.
- Cobertura de estados FSM (`IDLE`, `EXEC`, `DONE`).

## Métricas a reportar en una versión extendida
- Latencia por ronda y throughput efectivo.
- LUT/FF (FPGA) o área equivalente (ASIC).
- Energía por operación (estimada por switching activity + P&R).
