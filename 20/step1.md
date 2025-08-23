# step1 何も見ずに解く
入力サイズは最大で10^4

1. 配列を用意する。
1. 入力値を前から見ていく、左かっこ(例: `(`)があれば1の配列に入れてポインタを進める
1. 右かっこであれば1の配列の末尾を確認して、括弧の種類が同じであればポインタを進めて配列の末尾をpopする。同じでなければfalseを返す
1. 入力値の最後までみることができたらtrueを返す

Stackを使うところで良い変数名を思いつくのに時間がかかった。
時間計計算量はO(N)で空間計算量は最悪でO(N)となる。

解答時間 8:24(Wrong Answer)
```ruby
# @param {String} s
# @return {Boolean}
def is_valid(characters)
    parenthesis_combinations = {
        ')' => '(',
        '}' => '{',
        ']' => '['
    }
    right_parentheses = parenthesis_combinations.keys
    left_parentheses = parenthesis_combinations.values
    open_parentheses = []

    characters.size.times do |i|
        parenthesis = characters[i]
        if left_parentheses.include?(parenthesis)
            open_parentheses << parenthesis
        elsif right_parentheses.include?(parenthesis)
            return false if parenthesis_combinations[parenthesis] != open_parentheses.pop
        else
          raise ArgumentError, "Unexpected character: #{parenthesis}"
        end
    end

    true
end
```

左とじの格好が多いパターンの考慮が漏れていた。

```ruby
# @param {String} s
# @return {Boolean}
def is_valid(characters)
    parenthesis_combinations = {
        ')' => '(',
        '}' => '{',
        ']' => '['
    }
    right_parentheses = parenthesis_combinations.keys
    left_parentheses = parenthesis_combinations.values
    open_parentheses = []

    characters.size.times do |i|
        parenthesis = characters[i]
        if left_parentheses.include?(parenthesis)
            open_parentheses << parenthesis
        elsif right_parentheses.include?(parenthesis)
            return false if parenthesis_combinations[parenthesis] != open_parentheses.pop
        else
          raise ArgumentError, "Unexpected character: #{parenthesis}"
        end
    end

    return false if open_parentheses.size >= 1

    true
end
```

練習として再帰をつかった解き方も試した。
```ruby
def is_valid(characters)
    i = 0
    open_parentheses = []
    length = characters.length

    valid?(i, characters, open_parentheses, length)
end

PARENTHESIS_COMBINATIONS = {
    ')' => '(',
    '}' => '{',
    ']' => '['
}.freeze
RIGHT_PARENTHESES = PARENTHESIS_COMBINATIONS.keys.freeze
LEFT_PARENTHESES = PARENTHESIS_COMBINATIONS.values.freeze

def valid?(i, characters, open_parentheses, length)
    if i == length
        return open_parentheses.size == 0
    end

    parenthesis = characters[i]

    if LEFT_PARENTHESES.include?(parenthesis)
        open_parentheses << parenthesis
    elsif RIGHT_PARENTHESES.include?(parenthesis)
        return false if PARENTHESIS_COMBINATIONS[parenthesis] != open_parentheses.pop
    else
        raise ArgumentError, "Unexpected character: #{parenthesis}"
    end
    i += 1
    valid?(i, characters, open_parentheses, length)
end
```
