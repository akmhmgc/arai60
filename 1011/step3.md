# step3 3回続けて10分以内に書いてエラーを出さなければOKとする

```ruby
def ship_within_days(weights, days)
    return 0 if weights.size.zero?
    return -1 if days <= 0 # 運べない

    can_ship_within_days = lambda do |max_load_capacity|
        package_weight = 0
        day_count = 1
        weights.each do |weight|
            package_weight += weight
            next if package_weight <= max_load_capacity

            day_count += 1
            return false if day_count > days
            package_weight = weight
        end
        true
    end

    left = weights.max
    right = weights.sum
    while left < right
        middle = (left + right) / 2
        if can_ship_within_days.call(middle)
            right = middle
        else
            left = middle + 1
        end
    end
    left
end
```
