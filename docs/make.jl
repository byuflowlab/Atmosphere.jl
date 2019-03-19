using Documenter, Atmosphere

makedocs(
    sitename = "Atmosphere",
    modules = [Atmosphere],
    pages   = ["Home" => "index.md",
        "Example Usage" => "example.md",
        "Library" => "library.md"]
)

deploydocs(
    repo   = "github.com/byuflowlab/Atmosphere.jl")
