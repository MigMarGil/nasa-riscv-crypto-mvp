#!/usr/bin/env python3
"""Simple golden model for one ASCON round (320-bit state)."""

def rotr64(v, sh):
    return ((v >> sh) | ((v << (64 - sh)) & ((1 << 64) - 1))) & ((1 << 64) - 1)


def ascon_round(state, rnd):
    mask = (1 << 64) - 1
    x0 = (state >> 256) & mask
    x1 = (state >> 192) & mask
    x2 = (state >> 128) & mask
    x3 = (state >> 64) & mask
    x4 = state & mask

    c = 0xF0 ^ (rnd * 0x0F)
    x2 ^= c

    x0 ^= x4
    x4 ^= x3
    x2 ^= x1

    y0 = x0 ^ ((~x1 & mask) & x2)
    y1 = x1 ^ ((~x2 & mask) & x3)
    y2 = x2 ^ ((~x3 & mask) & x4)
    y3 = x3 ^ ((~x4 & mask) & x0)
    y4 = x4 ^ ((~x0 & mask) & x1)

    y1 ^= y0
    y0 ^= y4
    y3 ^= y2
    y2 = (~y2) & mask

    y0 ^= rotr64(y0, 19) ^ rotr64(y0, 28)
    y1 ^= rotr64(y1, 61) ^ rotr64(y1, 39)
    y2 ^= rotr64(y2, 1) ^ rotr64(y2, 6)
    y3 ^= rotr64(y3, 10) ^ rotr64(y3, 17)
    y4 ^= rotr64(y4, 7) ^ rotr64(y4, 41)

    return ((y0 & mask) << 256) | ((y1 & mask) << 192) | ((y2 & mask) << 128) | ((y3 & mask) << 64) | (y4 & mask)


if __name__ == "__main__":
    state = int("0123456789ABCDEFFEDCBA987654321000112233445566778899AABBCCDDEEFF0F0E0D0C0B0A0908", 16)
    rnd = 1
    out = ascon_round(state, rnd)
    print(f"input : 0x{state:080X}")
    print(f"round : {rnd}")
    print(f"output: 0x{out:080X}")
