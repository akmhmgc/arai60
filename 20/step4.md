## step4 レビューを受けて解答を修正

```ruby
# @param {String} s
# @return {Boolean}
def is_valid(brackets)
    open_to_close = { '(' => ')', '{' => '}', '[' => ']' }
    opens = []
    brackets.each_char do |bracket|
        if open_to_close.keys.include?(bracket)
            opens << bracket
        elsif open_to_close.values.include?(bracket)
            return false if opens.empty?

            open = opens.pop
            return false if bracket != open_to_close[open]
        else
            raise ArgumentError, "Unexpected bracket: #{bracket}"
        end
    end

    opens.empty?
end
```

再帰下降で書いてみた

```ruby
# @param {String} s
# @return {Boolean}
def is_valid(brackets)
    i = 0
    consume = ->(bracket) {
        if i < brackets.size && brackets[i] == bracket
            i += 1
            true
        else
            false
        end
    }
    open_to_close = { '(' => ')', '{' => '}', '[' => ']' }
    parens = -> {
        while true do
            bracket = brackets[i]
            if open_to_close.keys.include?(bracket) && consume.call(bracket)
                return false unless parens.call && consume.call(open_to_close[bracket])
            else
                return true
            end
        end
    }

    parens.call && i == brackets.size
end
```
