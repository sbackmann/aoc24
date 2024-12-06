lines = readlines("data/05.txt")
rules = split.(filter(line -> '|' in line, lines), "|")
pages = split.(filter(line -> !('|' in line), lines), ",")
rules = [parse.(Int, rule) for rule in rules]
pages = [parse.(Int, page) for page in pages if page != [""]]

function sum_valid_prints(prints, rules)
    sum = 0
    for pages in prints
        valid = false
        indices = collect(1:length(pages))
        for (i, page) in enumerate(pages)
            numbers_before = getindex.(filter(rule -> rule[2] == page, rules), 1)
            for succ_index in i+1:length(pages)
                if pages[succ_index] in numbers_before
                    valid = true
                    indices[i] += 1
                    indices[succ_index] -= 1
                end
            end
        end
        middle_index = findfirst(isequal((length(pages) + 1) ÷ 2), indices)
        sum += valid * pages[middle_index]
    end
    return sum
end
sum_valid_prints(pages, rules)
