using Atmosphere
using Base.Test

tests = ["propertytests", "windtests"]

for t in tests
	include("$(t).jl")
end
