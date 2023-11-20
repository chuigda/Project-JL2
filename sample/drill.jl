function generic_array_set!(arr::Vector{T}, index::I, value::T) where I <: Integer
    arr[i] = value;
end

function generic_configure!(env::Dict{String, T} where T, key, value)
    magic!(env, key, value)
end

struct MeinStruktur{T}
    x::T
    xs::Vector{T}
end
