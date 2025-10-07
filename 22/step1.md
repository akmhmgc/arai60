# step1 何も見ずに解く

backtracking を使う。

- `(`の数が n 個より少なければ`(`を 1 つつなげる
- `)`の数が`(`より少なければ`)`を 1 つつなげる

というパターンで分類。`)`の数が n と一致した時に parenthesis が完成するので答えに含める。

```ruby
# @param {Integer} n
# @return {String[]}
def generate_parenthesis(n)
    combinations = []
    generate_parenthesis_helper = lambda do |parenthesis, left ,right|
        if right == n
            combinations << parenthesis.join
            return
        end
        if left < n
            parenthesis << "("
            generate_parenthesis_helper.call(parenthesis, left + 1, right)
            parenthesis.pop
        end
        if right < left
            parenthesis << ")"
            generate_parenthesis_helper.call(parenthesis, left, right + 1)
            parenthesis.pop
        end
    end
    generate_parenthesis_helper.call([], 0, 0)
    combinations
end
```

他には、
可能なだけ左を入れる + 右を一つ入れる
という分類もできる。

```ruby
# @param {Integer} n
# @return {String[]}
def generate_parenthesis(n)
    combinations = []
    generate_parenthesis = lambda do |parenthesis, left ,right|
        if right == n
            combinations << parenthesis.join
            return
        end
        (1..(n - left)).each do |i|
            i.times { parenthesis << "(" }
            parenthesis << ")"
            generate_parenthesis.call(parenthesis, left + i, right + 1)
            (i + 1).times { parenthesis.pop }
        end
        if left > right
            parenthesis << ")"
            generate_parenthesis.call(parenthesis, left, right + 1)
            parenthesis.pop
        end
    end
    generate_parenthesis.call([], 0, 0)
    combinations
end
```
