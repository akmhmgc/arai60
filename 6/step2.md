# step2 他の方の解答を見る
- https://github.com/olsen-blue/Arai60/pull/61

step1で`is_down`としていたが、`is_going_down`の方がいいかも。`is_downward`とか。
あとis_downの切り替えとrowの更新を同時にやらずに分けた方が見やすいな。

```ruby
# @param {String} s
# @param {Integer} num_rows
# @return {String}
def convert(s, num_rows)
    return s if num_rows == 1

    chars_by_row = Array.new(num_rows) { [] }
    row = 0
    is_downward = true
    s.each_char do |char|
        chars_by_row[row] << char

        is_downward = true if row.zero?
        is_downward = false if row == num_rows - 1
        row = is_downward ? row + 1 : row - 1
    end
    chars_by_row.inject("") { |result, chars| result << chars.join }
end
```
