# This file is a part of AdaptableFunctions.jl, licensed under the MIT License (MIT).

using Test
using AdaptableFunctions
import Documenter

Documenter.DocMeta.setdocmeta!(
    AdaptableFunctions,
    :DocTestSetup,
    :(using AdaptableFunctions);
    recursive=true,
)
Documenter.doctest(AdaptableFunctions)
