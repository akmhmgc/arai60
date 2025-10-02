# step2 他の方の解答を見る
https://github.com/Satorien/LeetCode/pull/44

step1のコードはdaysが0以下の時にweighsの合計を出してしまっていたので、-1を返すことにする。

```ruby
# @param {Integer[]} weights
# @param {Integer} days
# @return {Integer}
def ship_within_days(weights, days)
    return 0 if weights.size.zero?
    return -1 if days <= 0 # 運べない

    can_ship_within_days = lambda do |max_load_capacity|
        package = 0
        day_count = 1
        weights.each do |weight|
            package += weight
            next if package <= max_load_capacity
            day_count += 1
            return false if day_count > days
            package = weight
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

https://github.com/ruby/ruby/blob/5257e1298c4dc4e854eaa0a9fe5e6dc5c1495c91/array.c#L3543
Rubyの`Array#bsearch`はオーバーフロー回避のために
```
mid = low + ((high - low) / 2);
```
と計算していて面白かった。
