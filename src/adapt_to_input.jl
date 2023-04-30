# This file is a part of AdaptableFunctions.jl, licensed under the MIT License (MIT).


"""
    struct UnadaptedFunction{F,T} <: Function

An instance `FunctionNotAdaptable{F,T}()` signifies that functions of type
`F` can't be adapted to inputs of type `T`.

`(f::UnadaptedFunction).f`` contains the original function, and
`(f::UnadaptedFunction)(args...; kwargs...)` calls the original function.
"""
struct UnadaptedFunction{F,T}
    f::F
end
export UnadaptedFunction

@inline (f::UnadaptedFunction)(args...; kwargs...) = f.f(args...; kwargs...)


@inline InverseFunctions.inverse(f::UnadaptedFunction) =
    InverseFunctions.inverse(f.f)

@inline ChangesOfVariables.with_logabsdet_jacobian(f::UnadaptedFunction, x) =
    ChangesOfVariables.with_logabsdet_jacobian(f.f, x)


"""
    adapt_to_input(f::F, example_input::T) where {F,T}

Generates a function that performs the same operation as `f`, but this is
optimized/specialized for the type and size of `example_input` and
the computing device `example_input` resides on.

Returns the optimized/specialized version of f, or
[`UnadaptedFunction{F,T}(f)`](@ref) if this is not possible.
"""
adapt_to_input(f::F, example_input::T) where {F,T} = UnadaptedFunction{F,T}(f)
export adapt_to_input
