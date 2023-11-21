function generic_array_set!(arr::Vector{T}, index::I, value::T) where I <: Integer
    arr[i] = magic!(value * arr[i]);
end

function generic_configure!(env::Dict{String, T} where T, key, value)
    magic!(env, key, value)
end

struct MeinStruktur{T}
    x::T
    xs::Vector{T}
end

mutable struct SecondState{B} where B <: AbstractFloat
    a::Int64
    b::B
end

abstract type X <: AbstractFloat end
