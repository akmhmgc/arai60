# step3 3回続けて10分以内に書いてエラーを出さなければOKとする

```ruby
# @param {Integer} m
# @param {Integer} n
# @return {Integer}
def unique_paths(m, n)
    unique_path_counts = Array.new(m) { Array.new(n, 0) }
    m.times { |row| unique_path_counts[row][0] = 1 }
    n.times { |col| unique_path_counts[0][col] = 1 }
    (1...m).each do |row|
        (1...n).each do |col|
            unique_path_counts[row][col] = unique_path_counts[row - 1][col] + unique_path_counts[row][col - 1]
        end
    end
    unique_path_counts.last.last
end
```
