lines = split.(readlines("data/01.txt"))
first_list = parse.(Int, getindex.(lines, 1))
second_list = parse.(Int, getindex.(lines, 2))

# could be solved more easily with DataStructures::countmap()
first_count = Dict()
second_count = Dict()

for (first, second) in zip(first_list, second_list)
    first_count[first] = get(first_count, first, 0) + 1
    second_count[second] = get(second_count, second, 0) + 1
end

prods = [k * v * get(second_count, k, 0) for (k, v) in pairs(first_count)]
print(sum(prods))