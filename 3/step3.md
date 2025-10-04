# step3 3回続けて10分以内に書いてエラーを出さなければOKとする

```ruby
# @param {String} str
# @return {Integer}
def length_of_longest_substring(str)
    visited_char_to_index = Hash.new(-1)
    max_size = 0
    left = 0
    str.size.times do |right|
        left = [left, visited_char_to_index[str[right]] + 1].max
        max_size = [max_size, right - left + 1].max
        visited_char_to_index[str[right]] = right
    end
    max_size
end
```
