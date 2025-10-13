# step1 何も見ずに解く

最初に全ての組み合わせを作って合計の降順にソートして先頭k個を出す方法が浮かんだ。
nums1,nums2の個数をM,Nとすると時間計算量はO(M*N*log(M*N))かかるので厳しそう。

Memory Limit Exceeded
```ruby
# @param {Integer[]} nums1
# @param {Integer[]} nums2
# @param {Integer} k
# @return {Integer[][]}
def k_smallest_pairs(nums1, nums2, k)
    sum_and_pairs = []
    nums1.each do |num1|
        nums2.each do |num2|
          sum_and_pairs << [num1 + num2, [num1, num2]]
        end
    end
    sorted_top_k_sum_and_pairs = sum_and_pairs.sort_by { |sum_and_pair| sum_and_pair.first }.first(k)
    sorted_top_k_sum_and_pairs.map { |sum_and_pair| sum_and_pair.last }
end
```

時間計算量及び空間計算量を落とすことを考える。

[a1, a2, a3, ....] 
[b1, b2, b3, ....] 
とある時、まだ何も答えに入れていない時は[a1, b1]が絶対に答えに入るし、次は[a1, b2]もしくは[a2, b1]が候補になる
などとしばらく考えていたが、わからず答えを見ることにした。
