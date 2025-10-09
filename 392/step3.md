# step3 3回続けて10分以内に書いてエラーを出さなければOKとする

```ruby
# @param {String} s
# @param {String} t
# @return {Boolean}
def is_subsequence(s, t)
    lcs_last_index = 0
    t.each_char { |char| lcs_last_index += 1 if s[lcs_last_index] == char }
    lcs_last_index == s.size
end
```
