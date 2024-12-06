memory = reduce(*, readlines("data/03.txt"))

first_valid = match(r"(.*?)don't\(\)", memory).captures[1]
middle_valid = getfield.(eachmatch(r"do\(\)(.*?)don't\(\)", memory[length(first_valid):end]), :match)
end_valid = match(r"do\(\)((?!.*don't\(\)).*)$", memory)
end_valid = isnothing(end_valid) ? "" : end_valid.captures[1]
valid = first_valid * reduce(*, middle_valid) * end_valid

matches = getfield.(eachmatch(r"mul\((\d{1,3},\d{1,3})\)", valid), :captures)
products = map(match -> prod(parse.(Int, split(match[1], ','))), matches)
print(sum(products))
