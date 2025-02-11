export hs84

function hs84(; n::Int = default_nvar, type::Val{T} = Val(Float64), kwargs...) where {T}
  a = Array{Rational{Int}}(undef, 21)
  a[1:7] = [
    -24345,
    -8720288849 // 1000,
    1505125253 // 10000,
    -1566950325 // 10000000,
    4764703222 // 10000,
    7294828271 // 10000,
    -145421402 // 1000,
  ]
  a[8:14] = [
    29311506 // 10000,
    -40427932 // 1000000,
    5106192 // 1000,
    1571136 // 100,
    -1550111084 // 10000,
    436053352 // 100000,
    129492344 // 10000000,
  ]
  a[15:21] = [
    10236884 // 1000,
    13176786 // 1000,
    -3266695104 // 10000,
    739068412 // 100000,
    -278986976 // 10000000,
    16643076 // 1000,
    30988146 // 1000,
  ]
  function f(x)
    n = length(x)
    return -a[1] - a[2] * x[1] - a[3] * x[1] * x[2] - a[4] * x[1] * x[3] - a[5] * x[1] * x[4] -
           a[6] * x[1] * x[5]
  end
  x0 = T[2.52, 2, 37.5, 9.25, 6.8]
  lvar = T[0, 1.2, 20, 9, 6.5]
  uvar = T[1000, 2.4, 60, 9.3, 7]
  function c!(cx, x)
    cx[1] =
      a[7] * x[1] +
      a[8] * x[1] * x[2] +
      a[9] * x[1] * x[3] +
      a[10] * x[1] * x[4] +
      a[11] * x[1] * x[5]
    cx[2] =
      a[12] * x[1] +
      a[13] * x[1] * x[2] +
      a[14] * x[1] * x[3] +
      a[15] * x[1] * x[4] +
      a[16] * x[1] * x[5]
    cx[3] =
      a[17] * x[1] +
      a[18] * x[1] * x[2] +
      a[19] * x[1] * x[3] +
      a[20] * x[1] * x[4] +
      a[21] * x[1] * x[5]
    return cx
  end
  lcon = zeros(T, 3)
  ucon = T[294000, 294000, 277200]
  return ADNLPModels.ADNLPModel!(f, x0, lvar, uvar, c!, lcon, ucon, name = "hs84"; kwargs...)
end
