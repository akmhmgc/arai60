# step3 3回続けて10分以内に書いてエラーを出さなければOKとする

HashSetのキーはるよ文字列である必要はないので配列を使用した。
外部からの入力を想定して、小文字アルファベット以外も分類できるようにしている。

```ruby
# @param {String[]} strings
# @return {String[][]}
def group_anagrams(strings)
    sorted_chars_to_original_strings = Hash.new {|hash, key| hash[key] = []}
    strings.each do |string|
        sorted_chars_to_original_strings[string.split("").sort] << string
    end

    sorted_chars_to_original_strings.values
end
```
