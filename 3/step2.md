# step2 他の方の解答を見る
https://github.com/olsen-blue/Arai60/pull/49
ハッシュテーブルを使う方法

```ruby
# @param {String} str
# @return {Integer}
def length_of_longest_substring(str)
    visited_char_to_index = Hash.new(-1)
    max_length = 0
    left = 0
    str.size.times do |right|
        left = [left, visited_char_to_index[str[right]] + 1].max
        max_length = [max_length, right - left + 1].max
        visited_char_to_index[str[right]] = right
    end
    max_length
end
```

こっちの方がシンプルでわかりやすいかも
