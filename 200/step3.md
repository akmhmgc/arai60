# step3 3回続けて10分以内に書いてエラーを出さなければOKとする

```ruby
# @param {Character[][]} grid
# @return {Integer}
def num_islands(grid)
    water = "0".freeze
    row_size = grid.size
    col_size = grid.first.size
    visited = Array.new(row_size) { |i| Array.new(col_size, false) }
    offsets = [ [1, 0], [-1, 0], [0, 1], [0, -1] ]
    visit_island = ->(row, col) {
        visited[row][col] = true
        offsets.each do |row_offset, col_offset|
            new_row = row + row_offset
            new_col = col + col_offset
            is_in_grid = 0 <= new_row && new_row < row_size && 0 <= new_col && new_col < col_size
            next unless is_in_grid
            next if grid[new_row][new_col] == water || visited[new_row][new_col]

            visit_island.call(new_row, new_col)
        end
    }

    result = 0
    row_size.times do |row|
        col_size.times do |col|
            next if grid[row][col] == water || visited[row][col]

            visit_island.call(row, col)
            result += 1
        end
    end
    result
end
```
