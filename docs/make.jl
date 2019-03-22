using Documenter, Atmosphere

makedocs(
    sitename = "Atmosphere",
    modules = [Atmosphere],
    pages   = ["Home" => "index.md",
        "Library" => "library.md"]
)

deploydocs(
    repo   = "github.com/byuflowlab/Atmosphere.jl")
