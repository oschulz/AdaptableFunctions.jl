# This file is a part of AdaptableFunctions.jl, licensed under the MIT License (MIT).

import Test
import Aqua
import AdaptableFunctions

Test.@testset "Aqua tests" begin
    Aqua.test_all(AdaptableFunctions)
end # testset
