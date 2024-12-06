using IterTools
function check_all_xmas(grid, row, column)
    directions = [(-1, -1), (1, 1), (-1, 1), (1, -1)]
    checks = [['M', 'S'], ['M', 'S']]
    valid = true
    for (i, direction) in enumerate(directions)
        row_new = row + direction[1]
        column_new = column + direction[2]
        if !(1 <= row_new <= length(grid)) || !(1 <= column_new <= length(grid[1])) || !(grid[row_new][column_new] in checks[(i+1)÷2])
            valid = false
            break
        end
        filter!(check -> check != grid[row_new][column_new], checks[(i+1)÷2])
    end
    return valid
end

lines = readlines("data/04.txt")
lines = map(line -> only.(split(line, "")), lines)

# julia-native column-major
function count_xmas_grid_cols(grid)
    total = 0
    for (column, line) in enumerate(grid[1])
        for (row, char) in enumerate(grid)
            if grid[row][column] == 'A'
                total += check_all_xmas(grid, row, column)
            end
        end
    end
    return total
end
@time count_xmas_grid_cols(lines)

