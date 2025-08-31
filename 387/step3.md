# step3 3回続けて10分以内に書いてエラーを出さなければOKとする

入力で期待していない値はスキップする方針

```ruby
# @param {String} string
# @return {Integer}
def first_uniq_char(string)
    a_codepoint = "a".ord
    z_codepoint = "z".ord
    lowercase_english_letter_counts = Array.new(z_codepoint - a_codepoint + 1, 0)
    string.each_byte do |byte|
        next if byte < a_codepoint || byte > z_codepoint

        lowercase_english_letter_counts[byte - a_codepoint] += 1
    end
    string.each_byte.with_index do |byte, index|
        return index if lowercase_english_letter_counts[byte - a_codepoint] == 1
    end

    -1
end
```

step1とほとんど同じだが、`ord_a`といった変数名が微妙だったので修正した。
