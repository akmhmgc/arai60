# step1 何も見ずに解く
まず、片方の配列を前から見ていってSetに入れる
もう片方の配列を前から見ていってSetに含まれているものをフィルターしてから、ユニークなものを抽出すれば良いと考えた。
配列の長さは10^2以下なので、それぞれの配列の長さをM,Nとした時に時間計算量はO(M + N)で一般的なCPUで1秒以内に間に合う。
空間計算量はO(M + N)。

```ruby
# @param {Integer[]} numbers1
# @param {Integer[]} numbers2
# @return {Integer[]}
def intersection(numbers1, numbers2)
    unique_numbers1 = Set.new(numbers1)
    numbers2.filter { |number2| unique_numbers1.include?(number2) }.uniq
end
```

配列にメソッドがあるかもしれないとドキュメントを見たところ、集合の積演算をするメソッドがあった。
内部実装を確認したところ、おおよそ似たようなことをやっていた。
値がSetに含まれているかどうかを判定して含まれていれば、出力結果の配列に含めた上でSetから値を削除する、という方法で重複をなくしていた。
ref: https://github.com/ruby/ruby/blob/5257e1298c4dc4e854eaa0a9fe5e6dc5c1495c91/array.c#L5667-L5698

```ruby
# @param {Integer[]} numbers1
# @param {Integer[]} numbers2
# @return {Integer[]}
def intersection(numbers1, numbers2)
    numbers1 & numbers2
end
```

Rubyの`Array#&`メソッドの内部を参考に最初の実装を修正すると以下のようになる。

```ruby
# @param {Integer[]} numbers1
# @param {Integer[]} numbers2
# @return {Integer[]}
def intersection(numbers1, numbers2)
    unique_numbers1 = Set.new(numbers1)
    numbers2.each_with_object([]) do |number2, intersections|
        next unless unique_numbers1.include?(number2)

        intersections << number2
        unique_numbers1.delete(number2)
    end
end
```
