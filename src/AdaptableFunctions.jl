# This file is a part of AdaptableFunctions.jl, licensed under the MIT License (MIT).

"""
    AdaptableFunctions

Provides an API for functions that can be optimized/specialized for specific
input types, sizes and the computing devices the input resides on.
"""
module AdaptableFunctions

import ChangesOfVariables
import InverseFunctions

include("adapt_to_input.jl")

end # module
