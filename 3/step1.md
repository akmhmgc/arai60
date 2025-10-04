# step1 何も見ずに解く
文字を前から一つずつみていって、開始時点から今見てるところまでの文字列がすべてユニークな文字を含む文字列かどうかをチェックしたい。
見た文字を管理すれば今見ている文字が既に見たことあるかどうかがわかる。
既に見た文字があるとき、この文字を含む場合どこまで後ろであれば問題ないかを知りたい。
例えばabcdec....という文字列がある時に、二回目のcが来た時にdecは問題ないので次を見に行く、ということをしたい。
それを実現するには、今見ている文字がなくなるまで開始時点を進めればよい。
こういう感じの発想でいけるはず。

時間計算量はO(N)で空間計算量もO(N)
Nの最大値は5 * 10^4なので1秒以内に終わる。

```ruby
# @param {String} str
# @return {Integer}
def length_of_longest_substring(str)
    chars_in_substr = Set.new
    l = 0
    res = 0
    str.size.times do |r|
        while chars_in_substr.include?(str[r])
            chars_in_substr.delete(str[l])
            l += 1
        end
        chars_in_substr << str[r]
        res = [res, r - l + 1].max
    end
    res
end
```
