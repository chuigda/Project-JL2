function add(a::Int64, b::Int64)::Int64
    a + b
end

static_compile!(add, (Int64, Int64))
