# Risk Register

## R1: Incomplete Algorithm Coverage
- Description: MVP validates one-round behavior, not full production ASCON pipeline behavior.
- Impact: Medium
- Probability: Medium
- Mitigation: Add multi-round implementation and NIST conformance vectors.

## R2: Limited Fault Model
- Description: Current testing emphasizes single-bit injected corruption scenarios.
- Impact: Medium
- Probability: Medium
- Mitigation: Expand to burst/multi-bit and transient timing fault campaigns.

## R3: No Formal Sign-Off
- Description: Assertions/formal property proof is not part of this package.
- Impact: High
- Probability: Medium
- Mitigation: Add SVA properties and run formal/lint closure flow.

## R4: No PPA Characterization
- Description: Resource, timing, and power numbers are absent.
- Impact: High
- Probability: High
- Mitigation: Run FPGA synthesis and report utilization/Fmax/power.

## R5: Integration Uncertainty
- Description: Interface is validated in TB context but not integrated into a specific shipping core.
- Impact: High
- Probability: Medium
- Mitigation: Integrate and validate on selected RISC-V core and software stack.
