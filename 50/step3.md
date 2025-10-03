# step3 3回続けて10分以内に書いてエラーを出さなければOKとする

```ruby
# @param {Float} base
# @param {Integer} exponent
# @return {Float}
def my_pow(base, exponent)
    return 1 if exponent.zero?
    return 1.0 / my_pow(base, -exponent) if exponent < 0

    if exponent.even?
        return my_pow(base, exponent / 2) ** 2
    else
        return base * my_pow(base, exponent - 1)
    end
end
```
