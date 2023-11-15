//
#if defined(__INTEL_COMPILER)
#include <mkl.h>
#else
#include <cblas.h>
#endif

//
#include "types.h"

// Baseline - naive implementation
f64 reduc_base(f64 *restrict a, u64 n)
{
  double d = 0.0;

  for (u64 i = 0; i < n; i++)
    d += a[i];

  return d;
}

f64 reduc_unroll(f64 *restrict a, u64 n)
{

#define UNROLL4 4

  double d0 = 0.0;
  double d1 = 0.0;
  double d2 = 0.0;
  double d3 = 0.0;

  for (u64 i = 0; i < (n - (n & (UNROLL4 - 1))); i += UNROLL4)
  {
    d0 += a[i];
    d1 += a[i + 1];
    d2 += a[i + 2];
    d3 += a[i + 3];
  }

  // Manage the leftovers
  for (u64 j = (n - (n & 3)); j < n; j++)
    d0 += a[j];

  return d0 + d1 + d2 + d3;
}

f64 reduc_unroll_8(f64 *restrict a, u64 n)
{

#define UNROLL8 8

  double d0 = 0.0;
  double d1 = 0.0;
  double d2 = 0.0;
  double d3 = 0.0;
  double d4 = 0.0;
  double d5 = 0.0;
  double d6 = 0.0;
  double d7 = 0.0;

  for (u64 i = 0; i < (n - (n & (UNROLL8 - 1))); i += UNROLL8)
  {
    d0 += a[i];
    d1 += a[i + 1];
    d2 += a[i + 2];
    d3 += a[i + 3];
    d1 += a[i + 4];
    d2 += a[i + 5];
    d3 += a[i + 6];
    d1 += a[i + 7];
  }

  // Manage the leftovers
  for (u64 j = (n - (n & 7)); j < n; j++)
    d0 += a[j];

  return d0 + d1 + d2 + d3 + d4 + d5 + d6 + d7;
}

// Baseline - naive implementation
f64 reduc_cblas(f64 *restrict a, u64 n)
{
  return cblas_dasum(n, a, 1);
}
