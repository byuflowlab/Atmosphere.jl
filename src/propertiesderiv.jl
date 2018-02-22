function atmospherefitderiv(altitude::Real)
  function fun(x)
    result = atmospherefit(x[1])
    return [i for i in result]
  end
  x = [altitude]
  out = DiffResults.DiffResult(zeros(3),zeros(3,1))
  ForwardDiff.jacobian!(out,fun,x)
  f = DiffResults.value(out)
  dfdx = DiffResults.jacobian(out)
  # rho, mu, a, drho, dmu, da
  return f[1],f[2],f[3],dfdx[1],dfdx[2],dfdx[3]
end

function atmospheretablederiv(altitude::Real)
  function fun(x)
    result = atmospheretable(x[1])
    return [i for i in result]
  end
  x = [altitude]
  out = DiffResults.DiffResult(zeros(3),zeros(3,1))
  ForwardDiff.jacobian!(out,fun,x)
  f = DiffResults.value(out)
  dfdx = DiffResults.jacobian(out)
  # rho, mu, a, drho, dmu, da
  return f[1],f[2],f[3],dfdx[1],dfdx[2],dfdx[3]
end

function gravityderiv(altitude::Real,latitude::Real=0.7853981633974483)
  function fun(x)
    result = gravity(x[1],x[2])
    return result
  end
  x = vcat(altitude,latitude)
  out = DiffResults.GradientResult(x)
  ForwardDiff.gradient!(out,fun,x)
  f = DiffResults.value(out)
  dfdx = DiffResults.jacobian(out)
  # gravity, d(gravity)/da, d(latitude)/da
  return f[1],dfdx[1],dfdx[2]
end
