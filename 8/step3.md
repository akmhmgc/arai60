# step3 3回続けて10分以内に書いてエラーを出さなければOKとする

```ruby
# @param {String} str
# @return {Integer}
def my_atoi(str)
    str_without_left_space = str.lstrip

    index = 0
    sign = 1
    if str_without_left_space.start_with?("-")
        sign = -1
        index += 1
    end
    if str_without_left_space.start_with?("+")
        index += 1
    end

    max_value = 2 ** 31 - 1
    min_value = (-1) * 2 ** 31
    result = 0
    while index < str_without_left_space.size && str_without_left_space[index].between?("0", "9")
        digit = str_without_left_space[index].to_i
        
        if result > (max_value - digit) / 10
            return sign == 1 ? max_value : min_value
        end

        result = result * 10 + digit
        index += 1
    end
    result * sign
end
```
