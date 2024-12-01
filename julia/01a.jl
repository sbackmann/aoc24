# more fun than just using sort() ^^
function merge_sort(arr) 
    length(arr) == 1 && return arr
    mid = (length(arr) + 1) ÷ 2
    first = arr[1:mid]
    second = arr[mid+1:end]
    merge_sort(first)
    merge_sort(second)
    merge_parts(arr, first, second)
end

function merge_parts(arr, first, second)
    tmp = zeros(Float64, length(arr))
    i_first = 1
    len_first = length(first)
    i_second = 1
    len_second = length(second)
    for i in 1:length(arr)
        if i_second > len_second || i_first <= len_first && first[i_first] <= second[i_second]
            tmp[i] = first[i_first]
            i_first += 1
        else
            tmp[i] = second[i_second]
            i_second += 1
        end
    end
    arr .= tmp
end

lines = readlines("data/01.txt")
nums = split.(lines)
first_list = parse.(Int, [x[1] for x in nums])
second_list = parse.(Int, [x[2] for x in nums])

merge_sort(first_list)
merge_sort(second_list)
diffs = first_list .- second_list
print(sum(abs.(diffs)))