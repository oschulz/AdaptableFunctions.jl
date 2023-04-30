# This file is a part of AdaptableFunctions.jl, licensed under the MIT License (MIT).

import Test

Test.@testset "Package AdaptableFunctions" begin
    include("test_aqua.jl")
    include("test_adapt_to_input.jl")
    include("test_docs.jl")
    isempty(Test.detect_ambiguities(AdaptableFunctions))
end # testset
