# step3 3回続けて10分以内に書いてエラーを出さなければOKとする
02:21

```ruby
# @param {String} s
# @return {Boolean}
def is_valid(brackets)
    open_to_close = {
        '(' => ')',
        '{' => '}', 
        '[' => ']'
    }
    opens = []

    brackets.each_char do |bracket|
        if open_to_close.keys.include?(bracket)
            opens << bracket
        elsif open_to_close.values.include?(bracket)
            open = opens.pop
            return false if bracket != open_to_close[open]
        else
            raise ArgumentError, "Unexpected bracket: #{bracket}" 
        end
    end

    opens.size == 0
end
```

02:01

```ruby
# @param {String} s
# @return {Boolean}
def is_valid(brackets)
    open_to_close = {
        '(' => ')',
        '{' => '}', 
        '[' => ']'
    }
    opens = []
    brackets.each_char do |bracket|
        if open_to_close.keys.include?(bracket)
            opens << bracket
        elsif open_to_close.values.include?(bracket)
            open = opens.pop
            return false if bracket != open_to_close[open]
        else
            raise ArgumentError, "Unexpected bracket: #{bracket}"
        end
    end
    
    opens.size == 0
end
```

```ruby
# @param {String} s
# @return {Boolean}
def is_valid(brackets)
    open_to_close = {
        '(' => ')',
        '{' => '}', 
        '[' => ']'
    }
    opens = []
    brackets.each_char do |bracket|
        if open_to_close.keys.include?(bracket)
            opens << bracket
        elsif open_to_close.values.include?(bracket)
            open = opens.pop
            return false if bracket != open_to_close[open]
        else
            raise ArgumentError, "Unexpected bracket: #{bracket}"
        end
    end

    opens.size == 0
end
```
