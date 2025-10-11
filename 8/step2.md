# step2 他の方の解答を見る
- https://github.com/katsukii/leetcode/pull/9

例外で処理しなくても確かにこの書き方で対応できる。

```java
        while (index < length && Character.isDigit(s.charAt(index))) {
            int digit = s.charAt(index) - '0';

            // Check for overflow before adding the digit
            if (result > (Integer.MAX_VALUE - digit) / 10) {
                return sign == 1 ? Integer.MAX_VALUE : Integer.MIN_VALUE;
            }
            result = result * 10 + digit;
            index++;
        }
```

```ruby
# @param {String} str
# @return {Integer}
def my_atoi(str)
    index = 0

    # skip white space
    str = str.lstrip

    # check sign
    sign = 1
    if str.start_with?("-")
        sign = -1
        index += 1
    end
    if str.start_with?("+")
        index += 1
    end

    # build result
    max_value = 2 ** 31 - 1
    min_value = (-1) * 2 ** 31
    result = 0
    is_integer = ->(string) { string.bytes.first.between?("0".bytes.first, "9".bytes.first )}
    while index < str.size && is_integer.call(str[index])
        digit = str[index].to_i
        
        if result > (max_value - digit) / 10
            return sign == 1 ? max_value : min_value
        end

        result = result * 10 + digit
        index += 1
    end
    result * sign
end
```
