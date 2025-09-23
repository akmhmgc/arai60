# step3 3回続けて10分以内に書いてエラーを出さなければOKとする

```ruby
# @param {Integer[][]} obstacle_grid
# @return {Integer}
def unique_paths_with_obstacles(obstacle_grid)
    return 0 if obstacle_grid.nil?

    row_size = obstacle_grid.size
    col_size = obstacle_grid.first.size
    obstacle = 1
    return 0 if row_size.zero? || col_size.zero? || obstacle_grid.first.first == obstacle || obstacle_grid.last.last == obstacle

    unique_paths_count = Array.new(row_size) { Array.new(col_size, 0) }
    unique_paths_count[0][0] = 1

    row_size.times do |row|
        col_size.times do |col|
            next if obstacle_grid[row][col] == obstacle

            unique_paths_count[row][col] += unique_paths_count[row - 1][col] if row > 0
            unique_paths_count[row][col] += unique_paths_count[row][col - 1] if col > 0
        end
    end
    unique_paths_count.last.last
end
```
