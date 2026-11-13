# TODO: Add `fixed(arg)` - also needed for adapt_function(ctx, broadcast, f, ...)?


"""
    adapt_function(ctx, f, xs...)

Returns a tuple `(g, y)` with the adapted/optimized function `g` and `y`
of the same shape, but not necessarily the exact type, of `f(ys...)`.
"""
function adapt_function end

# adapt_function replaces AdaptableFunctions adapt_to_input and
# HeterogenousComputing.on_device (HeterogenousComputing will depend on
# AdaptableFunctions and make specializations). Some code in
# HeterogenousComputing related to on_device (e.g. for Reactant) could move
# into AdaptableFunctions.

@inline function adapt_function(ctx, f, xs...; kwargs...)
    converted_ctx = convert_context(ctx)
    adapt_function_impl(ctx, f, f_args...)
end

function adapt_function_impl(ctx, f::ComposedFunction, xs...; kwargs...)
    adapted_inner, y_inner = adapt_function(ctx, f.inner, xs...; kwargs...)
    adapted_outer, y_outer = adapt_function(ctx, f.outer, y_inner)
    adapted_f = ComposedFunction(adapted_outer, adapted_inner)
    return (adapted_f, y_outer)
end

function adapt_function_impl(ctx, ::typeof(broadcast), f::ComposedFunction, xs...)
    # TODO: Doesn't quite work without making `broadcast` a fixed argument? But it's not an argument?
    adapted_inner, y_inner = adapt_function(ctx, broadcast, f.inner, xs...; kwargs...)
    adapted_outer, y_outer = adapt_function(ctx, broadcast, f.outer, y_inner)
    adapted_f = Base.Broadcast.Broadcasted(ComposedFunction(adapted_outer, adapted_inner))
    return (adapted_f, y_outer)
end

# FunctionChains will need a Pkg extension to support `adapt_function` for
# its various types of combined functions (chained, fan-outs, etc.) and
# broadcasting of combined functions.


"""
    adapt_function_impl(ctx, f, xs...)
"""
function adapt_function_impl end
@compat public adapt_function_impl

# adapt_function_impl will be the primary specialization target
# for specific function and combinations of specific functions and
# converted contexts.


"""
    convert_context(ctx)
"""
function convert_context end
@compat public convert_context

convert_context(ctx) = ctx

# Need to specialize convert_context to support HeterogenousComputing,
# MLDataDevices, Reactant (directly), ... (at least for some of those)
# via Pkg extensions in AdaptableFunctions


"""
    struct DummyArray{T,N,AXS} <: AbstractArray{T,N}

...
"""
struct DummyArray{T,N,AXS} <: AbstractArray{T,N}
    axes::AXS
end

# DummyArray can be use in data structures `y` returned by adapt_function
# so the function doesn't have to be run but input will be available for
# the next function in a composed function or function chain. Likely not
# required for Reactant, since it has its own traced types.

Base.axes(A::DummyArray) = A.axes

# Will need to specialize several Base functions including `show`.
# Get/set index functions could probably throw an `ArgumentError` or
# Return a `DummyValue{T}()` or so.
