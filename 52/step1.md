# step1 何も見ずに解く
ある地点に到達する経路の数は、その地点のすぐ上の地点に到達するための経路の数 + その地点のすぐ左の地点に到達するための経路の数
で表すことができる。
スタート地点に到達するための経路の数は1なので、それを広げていけばよい。
時間計算量はO(n * m)で空間計算量もO(n * m)
n,mの最大値は100なので1秒以内に間に合う。

m, nの引数をrow, colとかに変えたかったが、問題文にm,nが出ているので今回は変えていない。

```ruby
# @param {Integer} m
# @param {Integer} n
# @return {Integer}
def unique_paths(m, n)
    unique_path_counts = Array.new(m) { Array.new(n, 0) }
    unique_path_counts[0][0] = 1
    m.times do |row|
        n.times do |col|
            unique_path_counts[row][col] += unique_path_counts[row - 1][col] if row - 1 >= 0
            unique_path_counts[row][col] += unique_path_counts[row][col - 1] if col - 1 >= 0
        end
    end
    unique_path_counts.last.last
end
```
unique_path_countsを1次元配列にすることもできる。

```ruby
# @param {Integer} m
# @param {Integer} n
# @return {Integer}
def unique_paths(m, n)
    unique_path_counts = Array.new(n, 0)
    unique_path_counts[0] = 1
    m.times do |row|
        (1...n).each do |col|
            unique_path_counts[col] += unique_path_counts[col - 1]
        end
    end
    unique_path_counts.last
end
```
