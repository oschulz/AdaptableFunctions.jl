# This file is a part of AdaptableFunctions.jl, licensed under the MIT License (MIT).

using AdaptableFunctions
using Test

import InverseFunctions
import ChangesOfVariables

@testset "adapt_to_input" begin
    @test adapt_to_input(log, 0.4)(0.7) == log(0.7)

    InverseFunctions.test_inverse(adapt_to_input(log, 0.4), 0.7)
    ChangesOfVariables.test_with_logabsdet_jacobian(adapt_to_input(log, 0.4), 0.7, (f::UnadaptedFunction{typeof(log)},x) -> 1/x)
end
