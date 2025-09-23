# step1 何も見ずに解く
左に到達するためのパスの数 + 上に到達するためのパスの数で今いる場所に到達するためのパスの数が計算できる。
ただし、その場所に障害物がある場合到達することはできない

縦のマス、横のマスのサイズをそれぞれM,Nとすると
時間計算量はO(M * N)
空間計算量も同様にO(M * N)
M,Nそれぞれ最大値は100なので1秒以内に間に合う

```ruby
# @param {Integer[][]} obstacle_grid
# @return {Integer}
def unique_paths_with_obstacles(obstacle_grid)
    row_size = obstacle_grid.size
    col_size = obstacle_grid.first.size
    obstacle = 1
    return 0 if row_size.zero? || col_size.zero? || obstacle_grid.first.first == obstacle || obstacle_grid.last.last == obstacle

    unique_paths_count = Array.new(row_size) { Array.new(col_size, 0) }
    row_size.times do |i|
        break if obstacle_grid[i][0] == obstacle
        unique_paths_count[i][0] = 1
    end
    col_size.times do |i|
        break if obstacle_grid[0][i] == obstacle
        unique_paths_count[0][i] = 1
    end

    (1...row_size).each do |row|
        (1...col_size).each do |col|
            next if obstacle_grid[row][col] == obstacle

            unique_paths_count[row][col] = unique_paths_count[row - 1][col] + unique_paths_count[row][col - 1]
        end
    end
    unique_paths_count.last.last
end
```
