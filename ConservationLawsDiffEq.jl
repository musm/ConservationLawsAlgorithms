__precompile__()
module ConservationLawsDiffEq
  using DiffEqBase, DiffEqPDEBase

  using Parameters, Compat, Juno
  using ForwardDiff

  # Interfaces
  import DiffEqBase: solve, @def

  #Solutions
  @compat abstract type AbstractFVSolution{T,N} <: AbstractTimeseriesSolution{T,N} end
  # Mesh
  @compat abstract type AbstractFVMesh end
  @compat abstract type AbstractUniformFVMesh <: AbstractFVMesh end
  # Problems
  @compat abstract type PDEProblem <: DEProblem end
  @compat abstract type AbstractConservationLawProblem{MeshType} <: PDEProblem end
  # algorithms
  @compat abstract type PDEAlgorithm <: DEAlgorithm end
  @compat abstract type AbstractFVAlgorithm <: PDEAlgorithm end

  include("spatial_mesh.jl")
  include("ConservationLawsProblems.jl")
  include("fv_integrators.jl")
  include("algorithms.jl")
  include("KT_scheme.jl")
  include("solutions.jl")
  include("fv_solve.jl")

  export solve
  export Uniform1DFVMesh
  export ConservationLawsProblem, ConservationLawsWithDiffusionProblem
  export FVKTAlgorithm
end
