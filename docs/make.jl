using Documenter, Atmosphere

makedocs(
    sitename = "Atmosphere",
    modules = [Atmosphere],
    format=Documenter.HTML(prettyurls = get(ENV, "CI", nothing)=="true"),
    pages   = ["Home" => "index.md",
        "Example Usage" => "example.md",
        "Library" => "library.md"]
)
