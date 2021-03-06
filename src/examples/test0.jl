# 1D Burgers Equation
# u_t+(0.5*u²)_{x}=0

include("./../ConservationLawsDiffEq.jl")
using ConservationLawsDiffEq

const CFL = 0.1
const Tend = 1.0

function Jf(u::Vector)
  diagm(u)
end

f(u::Vector) = u.^2/2

function u0_func(xx)
  N = size(xx,1)
  uinit = zeros(N, 1)
  uinit[:,1] = sin(2*π*xx)
  return uinit
end

N = 200
mesh = Uniform1DFVMesh(N,0.0,1.0,:PERIODIC)
u0 = u0_func(mesh.x)
prob = ConservationLawsProblem(u0,f,CFL,Tend,mesh;Jf=Jf)
@time sol = solve(prob, FVKTAlgorithm();progressbar=true)
@time sol2 = solve(prob, LaxFriedrichsAlgorithm();progressbar=true)
@time sol3 = solve(prob, LaxWendroff2sAlgorithm();progressbar=true)
@time sol4 = solve(prob, FVCompWENOAlgorithm();progressbar=true, TimeIntegrator = :SSPRK33)
@time sol5 = solve(prob, FVCompMWENOAlgorithm();progressbar=true, TimeIntegrator = :SSPRK33)

#Plot
using Plots
plot(mesh.x, sol.u[1][:,1], lab="uo",line=(:dot,2))
plot!(mesh.x, sol.u[end][:,1],lab="KT u")
plot!(mesh.x, sol2.u[end][:,1],lab="L-F h")
plot!(mesh.x, sol3.u[end][:,1],lab="2S L-W h")
plot!(mesh.x, sol4.u[end][:,1],lab="Comp WENO5 h")
plot!(mesh.x, sol5.u[end][:,1],lab="Comp MWENO5 h")
