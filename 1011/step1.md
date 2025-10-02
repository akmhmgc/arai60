# step1 何も見ずに解く
まず左から荷物を分類していって、すべてのパターンを計算することを思いついたが指数関数時間かかるので他の方法にする。
絶対一発で荷物の範囲を決めることはできないので何回も調査することになる。
求めたいのは、指定された日数で荷物を全て移動できる最小の最大積載量になる。
この範囲は、weightsの最大値とwights全ての合計の間にあり、下限は1で上限が500 * 5 * 10^4 = 2.5 * 10^7になる。
下限から愚直に+1して最小値を求めるのは効率が悪いので二分探索を使う。
ある最大積載量で指定された日数で荷物を運び切れるかはweightsの長さをLとすると時間計算量O(L)で計算できる。
よって、全ての荷物の合計をWとすると、時間計算量はO(L * log(W))で、Lは最大で5 * 10^4、Wも最大でおおよそ2.5 * 10^7なので1秒以内に間に合う

- 求めたいもの(target)
  - 荷物を全て移動できる最小の最大積載量
- 範囲
  - left
    - leftより左はtargetを満たさない（指定された日数で荷物を運びきれない）
  - right
    - rightより右はtargetを満たさない（targetより大きい）
- 終了条件
  - left == rightとなるとき
- middleは以下で分類する
  - middleがtargetより左にある
    - leftより左はtargetを満たさないのでleft = middle + 1に更新できる
  - middleがtargetあるいはtargetより右にある
    - rightより右はtargetを満たさないのでright = middleに更新できる
- middleの出し方
  - 常に区間を1狭めるためにはmiddle = (left + right) / 2


```ruby
# @param {Integer[]} weights
# @param {Integer} days
# @return {Integer}
def ship_within_days(weights, days)
    return 0 if weights.size.zero?

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
