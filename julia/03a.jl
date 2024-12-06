memory = reduce(*, readlines("data/03.txt"))

matches = collect(eachmatch(r"mul\((\d{1,3},\d{1,3})\)", memory))
products = map(match -> prod(parse.(Int, split(match.captures[1], ','))), matches)
print(sum(products))