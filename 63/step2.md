# step2 他の方の解答を見る
https://github.com/shintaro1993/arai60/pull/38/files#r2291320975

`obstacle_grid`がnilであるときの考慮が漏れていた。

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

ループの中で条件分岐をする以下のような書き方が多いが、個人的にはループの外で一列目と一行目を処理しておく方が好みかも。
いや、Unique Path Ⅰと比べて外側の処理が少し多いので微妙なラインかもしれない。

```ruby
# @param {Integer[][]} obstacle_grid
# @return {Integer}
def unique_paths_with_obstacles(obstacle_grid)
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
