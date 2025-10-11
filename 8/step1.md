# step1 何も見ずに解く

正規表現で数値に対応する部分を取ってきてintegerに変換する方法を考えた。
Rubyでは64-bit以上の数値も扱うことができるのでstring to intに変換した時にoverflowのエラーが起きることはないが、
他の言語だとoverflolwエラーを捕捉して最大値、最小値に変換するのが良いのだろうか。
ただ、例外処理はスタックトレースの生成などオーバヘッドが大きいので桁数が一定以上を超えた場合は上限、下限の値を早期に返す、という工夫をした方が良さそう。

時間計算量はO(N)
空間計算量はO(N)
Nの最大値は200なので1秒以内に間に合う

```ruby
# @param {String} str
# @return {Integer}
def my_atoi(str)
    numeric_string = str.match(/^\s*(\+|-)?([0-9]+)/)
    return 0 if numeric_string.nil?

    sign_string = numeric_string.captures[0] || "+"
    value_string = numeric_string.captures[1] || "0"

    number_of_digits = 0
    value_string.size.times do |i|
       next if value_string[i] == "0"

        number_of_digits = value_string.size - i
        break
    end

    if number_of_digits > 10
        if sign_string == "+"
            return 2 ** 31 - 1
        else
            return (-1) * 2 ** 31
        end
    end

    if sign_string == "+"
        return [2 ** 31 - 1, value_string.to_i].min
    else
        return [(-1) * 2 ** 31, - value_string.to_i].max
    end
end
```

解き終わった後にRubyのメソッドを調べたところ、String#[]でキャプチャできることを知った。
また、`Comparable#clamp`という範囲内の値を返すメソッドがあったので以下のように書ける。

```ruby
# @param {String} str
# @return {Integer}
def my_atoi(str)
    num = str.lstrip[/^[\+\-]?\d+/].to_i
    num.clamp(-2**31, 2**31 - 1)
end
```
