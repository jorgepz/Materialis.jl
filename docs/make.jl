using Materialis
using Documenter

DocMeta.setdocmeta!(Materialis, :DocTestSetup, :(using Materialis); recursive=true)

makedocs(;
    modules=[Materialis],
    authors="",
    repo="https://github.com/jorgepz/Materialis.jl/blob/{commit}{path}#{line}",
    sitename="Materialis.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://jorgepz.github.io/Materialis.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/jorgepz/Materialis.jl",
    devbranch="main",
)
