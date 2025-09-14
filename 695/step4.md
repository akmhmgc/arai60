## step4 レビューを受けて解答を修正

```ruby
# @param {Integer[][]} grid
# @return {Integer}
def max_area_of_island(grid)
    water = 0
    row_size = grid.size
    col_size = grid.first.size
    visited = Array.new(row_size) { |i| Array.new(col_size, false) }
    traverse_and_count_island = -> (row, col) {
        return 0 unless (row.between?(0, row_size - 1) && col.between?(0, col_size - 1))
        return 0 if grid[row][col] == water || visited[row][col]

        visited[row][col] = true
        return 1 + traverse_and_count_island.call(row, col + 1) +
                   traverse_and_count_island.call(row, col - 1) +
                   traverse_and_count_island.call(row + 1, col) +
                   traverse_and_count_island.call(row - 1, col)
    }
    result = 0
    row_size.times do |row|
        col_size.times do |col|
            next if grid[row][col] == water || visited[row][col]

            result = [result, traverse_and_count_island.call(row, col)].max
        end
    end
    result
end
```
