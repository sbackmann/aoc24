using IterTools
function check_all_xmas(grid, row, column)
    directions = [-1, 0, 1]
    checks = ['M', 'A', 'S']
    num_valid = 0
    for direction in IterTools.product(directions, directions)
        row_new = row
        column_new = column
        if direction == (0, 0)
            continue
        end
        valid = true
        for check in checks
            row_new += direction[1]
            column_new += direction[2]
            if !(1 <= row_new <= length(grid)) || !(1 <= column_new <= length(grid[1])) || grid[row_new][column_new] != check
                valid = false
                break
            end
        end
        num_valid += valid
    end
    return num_valid
end

lines = readlines("data/04.txt")
lines = map(line -> only.(split(line, "")), lines)

# naive row-major
function count_xmas_grid_rows(grid)
    total = 0
    for (row, line) in enumerate(grid)
        for (column, char) in enumerate(line)
            if char == 'X'
                total += check_all_xmas(grid, row, column)
            end
        end
    end
    return total
end

# julia-native column-major
function count_xmas_grid_cols(grid)
    total = 0
    for (column, line) in enumerate(grid[1])
        for (row, char) in enumerate(grid)
            if grid[row][column] == 'X'
                total += check_all_xmas(grid, row, column)
            end
        end
    end
    return total
end
@time count_xmas_grid_rows(lines)
@time count_xmas_grid_cols(lines)
# factor ~2.5
