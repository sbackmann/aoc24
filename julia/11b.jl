line = parse.(Int, split(readline("data/11.txt")))
function num_stones(line)
    num_stones = Dict()
    sum = 0
    current = copy(line)
    for elem in current
        n = 75
        sum += get_stones(num_stones, elem, n)
    end
    return sum
end

function get_stones(num_stones, elem, n)
    if haskey(num_stones, (elem, n))
        return num_stones[(elem, n)]
    end
    if n == 0
        return 1
    end
    r = 0
    string_elem = string(elem)
    if elem == 0
        r += get_stones(num_stones, 1, n-1)
    elseif length(string_elem) % 2 == 0
        r += get_stones(num_stones, parse(Int, string_elem[1:length(string_elem) ÷ 2]), n-1)
        r += get_stones(num_stones, parse(Int, string_elem[length(string_elem)÷2+1:end]), n-1)
    else
        r += get_stones(num_stones, elem * 2024, n-1)
    end
    num_stones[(elem, n)] = r
    return r
end

@time num_stones(line)