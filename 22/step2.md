# step2 他の方の解答を見る
https://github.com/olsen-blue/Arai60/pull/54/files/a0087de7fa136c0c271a07ec29a364c67f40d849#r2022389382

> はじめの括弧とそれに対応する括弧に注目して「(A)B」と分けるのも分類ですね。

この考え方は全く頭になかった。

```ruby
# @param {Integer} n
# @return {String[]}
def generate_parenthesis(n)
    return [""] if n == 0

    combinations = []
    n.times do |i|
        lefts = generate_parenthesis(i)
        rights = generate_parenthesis(n - i - 1)
        lefts.each do |left|
            rights.each do |right|
                combinations << "(" + left + ")" + right
            end
        end
    end
    combinations
end
```


https://github.com/tokuhirat/LeetCode/pull/53/files#diff-edeaf9ab4fec143afff62d1f44e6f5d9ca2d7c345ff74d8c89f41ee178034827R81-R101
使った括弧の数か、残りの括弧の数か。
