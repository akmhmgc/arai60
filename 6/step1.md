# step1 何も見ずに解く

3行の場合であれば、
文字の先頭から1行目->2行目->3行目->2行目->1行目->2行目
みたいな感じで進んでいって、各行の文字を左から見た文字を追加していけば良い。

Nを文字列の長さとすると、
時間計算量はO(N)
空間計算量もO(N)
Nの最大値は1000なので余裕で1秒以内に間に合う。

```ruby
# @param {String} s
# @param {Integer} num_rows
# @return {String}
def convert(s, num_rows)
    return s if num_rows == 1

    chars_by_row = Array.new(num_rows) { [] }
    row = 0
    is_down = true
    s.each_char do |char|
        chars_by_row[row] << char

        if row.zero?
            is_down = true
            row = 1
        elsif row == num_rows - 1
            is_down = false
            row = num_rows - 2
        else
            row = is_down ? row + 1 : row - 1
        end
    end
    chars_by_row.inject("") { |result, chars| result << chars.join }
end
```

Rubyの文字列はミュータブルなので以下のように書いてもコストは変わらない。

```ruby
# @param {String} s
# @param {Integer} num_rows
# @return {String}
def convert(s, num_rows)
    return s if num_rows == 1

    strings_by_row = Array.new(num_rows) { "" }
    row = 0
    is_down = true
    s.each_char do |char|
        strings_by_row[row] << char

        if row.zero?
            is_down = true
            row = 1
        elsif row == num_rows - 1
            is_down = false
            row = num_rows - 2
        else
            row = is_down ? row + 1 : row - 1
        end
    end
    strings_by_row.join
end
```

むしろ手元でベンチマークをとったらこっちの方がわずかにパフォーマンスがよかった。
わかりやすさは変わらないのでどっちでもいいな。
