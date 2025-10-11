# step1 何も見ずに解く
複数の例で考えた。
先頭から隣同士の数字を見ていき、最後に増加した手前のインデックスをiとする
そのインデックスの値より大きい値で、最も後ろにあるものをjとする
iとjの値を交換すると、i + 1から末尾までは降順になるので、順序を逆にすればnext permutationになる。

例えば[1, 9, 5, 4, 3, 2]を考える。
最後に増加した手前のインデックスは0
その値より大きい値で最も後ろにあるのは5
それぞれを入れ替えると[2, 9, 5, 4, 3, 1]になる。
次に、9, 5, 4, 3, 1の部分を逆にすると[2, 1, 3, 4, 5, 9]となり、next permutationが出る。
時間計算量は配列の長さをNとするとO(N)でNの最大値は100なので時間は問題ない。
空間計算量はO(1)


last_increasing_indexが見つからない時の処理を忘れて最初に間違えた。
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
  
    last_increasing_index = -1
    (nums.size - 1).times do |i|
        j = i + 1
        next if nums[i] >= nums[j]
        last_increasing_index = i
    end
    if last_increasing_index == -1
        reverse.call(0, nums.size - 1)
        return
    end
    last_greater_index = -1
    (nums.size - 1).downto(0).each do |i|
        if nums[i] > nums[last_increasing_index]
            last_greater_index = i
            break
        end
    end
    nums[last_increasing_index], nums[last_greater_index] = nums[last_greater_index], nums[last_increasing_index]
    reverse.call(last_increasing_index + 1, nums.size - 1)
end
```
