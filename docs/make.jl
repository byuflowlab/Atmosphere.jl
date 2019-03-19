using Documenter, Atmosphere

makedocs(
    sitename = "Atmosphere",
    modules = [Atmosphere],
    pages   = ["Home" => "index.md",
        "Example Usage" => "example.md",
        "Library" => "library.md"]
)

deploydocs(
    root = ".",
    target = "./build",
    repo   = "github.com/byuflowlab/Atmosphere.jl",
    branch = "gh-pages",
    devbranch = "master"
)
