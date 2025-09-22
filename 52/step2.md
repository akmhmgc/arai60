# step2 他の方の解答を見る

## メモ化しない再帰での計算量の見積もり

- https://github.com/olsen-blue/Arai60/pull/33

```ruby
# @param {Integer} m
# @param {Integer} n
# @return {Integer}
def unique_paths(m, n)
    return 1 if m == 1 || n == 1

    unique_paths(m - 1, n) + unique_paths(m, n - 1)
end
```

この時の計算量は以下の通り。
経路の数は`((n - 1) + (m - 1))C(n - 1)`となる。
これは完全二分木になるので、ノードの数は`葉 * 2 - 1`で計算できる。ノードの数が計算量になるので、
2 \* ((n - 1) + (m - 1))C(n - 1) - 1
よって計算量は(n + m - 2)C(n - 1)となり、1 秒以内には間に合わない。

メモ化すると O(n \* m)に抑えることができる。

```ruby
# @param {Integer} m
# @param {Integer} n
# @return {Integer}
def unique_paths(m, n)
    unique_path_counts = Array.new(m) { Array.new(n, nil) }
    m.times { |i| unique_path_counts[i][0] = 1 }
    n.times { |i| unique_path_counts[0][i] = 1 }
    unique_paths_helepr = -> (m, n) {
        return unique_path_counts[m - 1][n - 1] if unique_path_counts[m - 1][n - 1]

        result = unique_paths_helepr.call(m - 1, n) + unique_paths_helepr.call(m, n - 1)
        unique_path_counts[m - 1][n - 1] = result
        result
    }
    unique_paths_helepr.call(m, n)
end
```

## 先に値を入れておく
自分は特別な前処理がある方が認知負荷が高いと思って先に端の値を入れておくのをやめたが、人のコードを読んでいるとループの中でif文を走らせている自分のコードの方が認知負荷が高いように感じた。
なので以下が良いだろう。

```ruby
def unique_paths(m, n)
    return 0 if m.zero? || n.zero?

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
