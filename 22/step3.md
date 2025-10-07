# step3 3回続けて10分以内に書いてエラーを出さなければOKとする

```ruby
# @param {Integer} n
# @return {String[]}
def generate_parenthesis(n)
    result = []
    generate_parenthesis_helper = lambda do |left, right, parenthesis|
        if right == n
            result << parenthesis.join
            return
        end
        if left < n
            parenthesis << "("
            generate_parenthesis_helper.call(left + 1, right, parenthesis)
            parenthesis.pop
        end
        if right < left
            parenthesis << ")"
            generate_parenthesis_helper.call(left, right + 1, parenthesis)
            parenthesis.pop
        end
    end
    generate_parenthesis_helper.call(0, 0, [])
    result
end
```
