# step3 3回続けて10分以内に書いてエラーを出さなければOKとする

```ruby
# @param {String} s
# @param {Integer} num_rows
# @return {String}
def convert(s, num_rows)
    return s if num_rows == 1

    strings_by_row = Array.new(num_rows) { "" }
    row = 0
    is_downward = true
    s.each_char do |char|
        strings_by_row[row] << char

        is_downward = true if row.zero?
        is_downward = false if row == num_rows - 1
        row = is_downward ? row + 1 : row - 1
    end
    strings_by_row.join
end
```
