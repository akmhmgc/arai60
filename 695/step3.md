# step3 3回続けて10分以内に書いてエラーを出さなければOKとする

```ruby
# @param {Integer[][]} grid
# @return {Integer}
def max_area_of_island(grid)
    water = 0
    row_size = grid.size
    col_size = grid.first.size
    visited = Array.new(row_size) { |i| Array.new(col_size, false) }
    offsets = [ [1, 0], [-1, 0], [0, 1], [0, -1]]
    visit_island = ->(row, col) {
        visited[row][col] = true
        area = 1
        offsets.each do |row_offset, col_offset|
            new_row = row + row_offset
            new_col = col + col_offset
            is_in_grid = new_row >= 0 && new_row < row_size && new_col >= 0 && new_col < col_size
            next unless is_in_grid
            next if visited[new_row][new_col] || grid[new_row][new_col] == water

            area += visit_island.call(new_row, new_col)
        end
        area
    }

    result = 0
    row_size.times do |row|
        col_size.times do |col|
            next if visited[row][col] || grid[row][col] == water

            result = [result, visit_island.call(row, col)].max
        end
    end
    result
end
```
