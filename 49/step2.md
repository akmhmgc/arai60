# step2 他の方の解答を見る
## https://github.com/Fuminiton/LeetCode/pull/12

ソートしない解法で、想定していない文字列が来た時の考慮が漏れていた。
step1のコードだと"a"と"G"が同じ文字列であると判定されてしまう。

外部からの入力など、一定以上不正なデータが入る可能性があるのであれば不正なデータでも処理できるようにした方が良いし、
内部で利用するライブラリ等では早めにエラーを出すことで入力値が正しいことを保証して、後続の処理に不正なデータを流さないようにするのが良いだろう。
今回は外部からの入力を想定する。

```ruby
# @param {String[]} strings
# @return {String[][]}
def group_anagrams(strings)
    english_letter_count_to_strings = Hash.new{ |hash, key| hash[key] = [] }
    strings.each do |string|
        english_letter_count_to_strings[english_letter_count(string)] << string
    end
    
    english_letter_count_to_strings.values
end

def english_letter_count(string)
    a_byte = "a".ord
    z_byte = "z".ord
    english_letter_counts = Array.new(z_byte - a_byte + 1, 0)
    string.each_byte do |byte|
        next if byte < a_byte || z_byte < byte
        english_letter_counts[byte - a_byte] += 1
    end
    english_letter_counts
end
```

