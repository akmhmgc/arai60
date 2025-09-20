# step1 何も見ずに解く
長さnの配列でlongest increasing subsequenceの長さを知りたい時は
先頭から長さn-1の部分配列に関してi番目(0 <= i < n - 1)の値が最後となるlongest increasing subsequenceの長さがわかれば良い。
n番目の値よりi番目の値が小さければ、n番目の値が最後となるlongest increasing subsequenceが答えの候補になりうるので更新すれば良い。

先頭から長さ1, 長さ2…と上記の考えを適用すればこの問題は解くことができそう。

配列の長さをNとすると時間計算量はO(N^2)になり、Nの最大値は2500なので1秒以内にはギリギリ間に合う気がする。
空間計算量はO(N)
numsの長さは1以上となっているが、将来0が来る可能性があるので対応しておく。

```ruby
# @param {Integer[]} nums
# @return {Integer}
def length_of_lis(nums)
    return 0 if nums.empty?

    longest_increasing_subsequence_sizes = Array.new(nums.size, 1)
    
    nums.size.times do |i|
        i.times do |j|
            next unless nums[j] < nums[i]

            longest_increasing_subsequence_sizes[i] = [longest_increasing_subsequence_sizes[i], longest_increasing_subsequence_sizes[j] + 1].max
        end
    end
    longest_increasing_subsequence_sizes.max
end
```

`longest_increasing_subsequence_sizes`という名前が微妙にわかりにくい。
「インデックスiの値が最後となるlongest increasing subsequenceの長さ」という意味を込めたい
