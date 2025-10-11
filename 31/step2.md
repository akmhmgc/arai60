# step2 他の方の解答を見る
## step1の解法の改善
- https://github.com/olsen-blue/Arai60/pull/59

step1の`last_increasing_index`も、`last_greater_index`と同様に右から探せばよかった。
Rubyにはないが、伝わりやすいのでrfindという名前を参考にした。
> rfind という名前を使うなら built-in の規則に合わせたくなります。

確かに。RubyだとArrayの捜査系のメソッドで-1を返すことはないのでnilでも良いのかもしれない…と思ったけどモンキーパッチ当ててArrayにメソッドを生やしているわけではないからどっちも良いかもしれん。

- https://github.com/tokuhirat/LeetCode/pull/58
`rfind_pivot`, `rfind_successor`としていて、コメントで補足する方法。

- https://github.com/ryosuketc/leetcode_arai60/pull/58
`rfind_not_descending`

1135みたいな並びだと最初の右側の1を探したいのでnot_descendingはいいかも

```ruby
# @param {Integer[]} nums
# @return {Void} Do not return anything, modify nums in-place instead.
def next_permutation(nums)
    return nums if nums.size == 1

    reverse = lambda do |left, right|
        while left < right
            nums[left], nums[right] = nums[right], nums[left]
            left += 1
            right -= 1
        end
    end
    rfind_first_not_descending = lambda do
        (nums.size - 2).downto(0).each do |i|
            return i if nums[i] < nums[i + 1]
        end
        nil
    end
    rfind_first_greater_than = lambda do |target|
         (nums.size - 1).downto(0).each do |i|
            return i if nums[i] > target
         end
         nil
    end

    pivot_index = rfind_first_not_descending.call
    if pivot_index.nil?
        nums.reverse!
        return
    end
    swap_index = rfind_first_greater_than.call(nums[pivot_index])
    nums[pivot_index], nums[swap_index] = nums[swap_index], nums[pivot_index]
    reverse.call(pivot_index + 1, nums.size - 1)
end
```

