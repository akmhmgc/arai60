# step2 他の方の解答を見る
- https://github.com/quinn-sasha/leetcode/pull/13
- https://github.com/tarinaihitori/leetcode/pull/13
- https://github.com/Hurukawa2121/leetcode/pull/13

入力の条件を変えることでどのような解法が考えられるかを問う、という出題者の意図を理解していなかった。

## 両方ともソートされている前提
ソートされた配列の先頭にそれぞれポインタを用意する。
1. 今の要素と次の要素が同じであれば、次に違う要素がくるまで進め続ける
2. 要素同士を比較する
3. 同じであれば出力結果に含めて、両方のポインタを進める。異なる場合、小さい値の方のポインタを進める

という処理を繰り返せば良い。
それぞれの配列の長さをM,Nとすると時間計算量はO(M + N)
空間計算量はO(MIN(M,N))

```ruby
# @param {Integer[]} numbers1
# @param {Integer[]} numbers2
# @return {Integer[]}
def intersection(numbers1, numbers2)
    # 両方ともsortされている前提
    numbers1 = numbers1.sort
    numbers2 = numbers2.sort

    intersections = []
    numbers1_size = numbers1.size
    numbers2_size = numbers2.size
    i = 0
    j = 0
    while i < numbers1_size && j < numbers2_size
        while i + 1 < numbers1_size && numbers1[i] == numbers1[i + 1]
            i += 1
        end
        while j + 1 < numbers2_size && numbers2[j] == numbers2[j + 1]
            j += 1 
        end

        if numbers1[i] == numbers2[j]
            intersections << numbers1[i]
            i += 1
            next
        end
        if numbers1[i] < numbers2[j]
            i += 1
            next
        end
        if numbers1[i] > numbers2[j]
            j += 1
            next
        end
    end

    intersections
end
```

## 片方ソートされている前提
ソートされていない配列から順番に要素を取り出すして、ソートされている配列に含まれているかどうかを二分探索で探す。
含まれていればSetに入れて最後にリストに変形して出力する。
ソート済みの配列の長さをM,ソートされていない配列の長さをNとすると、時間計算量はO(MlogN)
空間計算量はO(MIN(M,N))
Rubyには二分探索用のメソッドが存在しているが今回はメソッドを自分で書いてみる。

```ruby
# @param {Integer[]} numbers1
# @param {Integer[]} numbers2
# @return {Integer[]}
def intersection(numbers1, numbers2)
    # 片方ソートされている前提
    sorted_numbers1 = numbers1.sort

    intersections = Set.new
    numbers2.each do |number2|
        intersection = binary_search(number2, sorted_numbers1)
        intersections << intersection if intersection
    end

    intersections.to_a
end

# @param {Integer} value
# @param {Integer[]} sorted_numbers
# @return {Integer}
def binary_search(value, sorted_numbers)
    numbers_size = sorted_numbers.size 
    if numbers_size == 1
        return sorted_numbers[0] == value ? value : nil
    end

    half = numbers_size / 2
    if sorted_numbers[half] <= value
        return binary_search(value, sorted_numbers[half..])
    end

    binary_search(value, sorted_numbers[0...half])
end
```
