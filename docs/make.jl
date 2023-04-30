# Use
#
#     DOCUMENTER_DEBUG=true julia --color=yes make.jl local [nonstrict] [fixdoctests]
#
# for local builds.

using Documenter
using AdaptableFunctions

# Doctest setup
DocMeta.setdocmeta!(
    AdaptableFunctions,
    :DocTestSetup,
    :(using AdaptableFunctions);
    recursive=true,
)

makedocs(
    sitename = "AdaptableFunctions",
    modules = [AdaptableFunctions],
    format = Documenter.HTML(
        prettyurls = !("local" in ARGS),
        canonical = "https://oschulz.github.io/AdaptableFunctions.jl/stable/"
    ),
    pages = [
        "Home" => "index.md",
        "API" => "api.md",
        "LICENSE" => "LICENSE.md",
    ],
    doctest = ("fixdoctests" in ARGS) ? :fix : true,
    linkcheck = !("nonstrict" in ARGS),
    strict = !("nonstrict" in ARGS),
)

deploydocs(
    repo = "github.com/oschulz/AdaptableFunctions.jl.git",
    forcepush = true,
    push_preview = true,
)
