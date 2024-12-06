lines = readlines("data/05.txt")
rules = split.(filter(line -> '|' in line, lines), "|")
pages = split.(filter(line -> !('|' in line), lines), ",")
rules = [parse.(Int, rule) for rule in rules]
pages = [parse.(Int, page) for page in pages if page != [""]]

function sum_valid_prints(prints, rules)
    sum = 0
    for pages in prints
        valid = true
        for (i, page) in enumerate(pages)
            numbers_before = getindex.(filter(rule -> rule[2] == page, rules), 1)
            if length(intersect(numbers_before, @view pages[i+1:end])) != 0
                valid = false
                break
            end
        end
        sum += valid * pages[(length(pages) + 1) ÷ 2]
    end
    return sum
end
sum_valid_prints(pages, rules)

