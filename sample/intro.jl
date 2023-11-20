function foo(a, b)
    return a * a + b * b
end

function bar(a, b, c)
    foo(foo(a, b), foo(b, c))
end

static_compile!(bar, (Int64, Int64, Int64))
