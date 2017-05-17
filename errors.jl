function get_L2_errors{T,N,uType,tType,ProbType}(sol::FVSolution{T,N,uType,tType,
  ProbType,Uniform1DFVMesh}, ref::Function)
    x = sol.prob.mesh.x
    @unpack tend = sol.prob
    uexact = ref(x, tend)
    return(sum(abs(sol.u[end] - uexact)))
end

function estimate_L2_error(reference, M, uu,N)
  uexact = zeros(N)
  R = Int(round(M/N))
  for i = 1:N
      uexact[i] = 1.0/R*sum(reference[R*(i-1)+1:R*i])
  end
  sum(1.0/N*abs(uu - uexact))
end

function estimate_error_cubic(reference,M, xx,uu,N)
  uexact = zeros(N)
  itp = interpolate(reference[:,2], BSpline(Cubic(Flat())),OnCell())
  i = (M-1)/(reference[M,1]-reference[1,1])*(xx - reference[1,1])+1
  uexact = itp[i]
  sum(1.0/N*abs(uu - uexact))
end
