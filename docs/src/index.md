# AdaptableFunctions.jl

AdaptableFunctions provides an API for functions that can be optimized/specialized for specific input types, sizes and the computing devices the input resides on.

This package defines a function [`adapt_to_input(f, example_input)`](@ref) that can be specialized to generate input-optimized versions of functions for specific function and input types.
