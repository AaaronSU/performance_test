//
#pragma once

//
#include "types.h"

//
f64 dotprod_base(f64 *restrict a, f64 *restrict b, u64 n);
f64 dotprod_unroll(f64 *restrict a, f64 *restrict b, u64 n);
f64 dotprod_unroll_8(f64 *restrict a, f64 *restrict b, u64 n);
f64 dotprod_cblas(f64 *restrict a, f64 *restrict b, u64 n);