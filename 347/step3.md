# step3 3回続けて10分以内に書いてエラーを出さなければOKとする

```ruby
NumFreq = Struct.new(:num, :freq) do
    def greater_than(num_freq)
        return true if freq > num_freq.freq
        return true if freq == num_freq.freq && num < num_freq.num
        false
    end
end

def top_k_frequent(nums, k)
    return nums if k >= nums.size
    num_freqs = nums.each_with_object(Hash.new(0)) { |num, num_to_freq| num_to_freq[num] += 1 }
                    .map { |num, freq| NumFreq.new(num, freq) }
    quick_select!(num_freqs, k - 1)
    num_freqs.first(k).map(&:num)
end

def quick_select!(num_freqs, target)
    swap = -> (idx1, idx2) { num_freqs[idx1], num_freqs[idx2] = num_freqs[idx2], num_freqs[idx1] }
    left = 0
    right = num_freqs.size - 1
    while left <= right
        pivot_i = rand(left..right)
        pivot = num_freqs[pivot_i]
        swap.call(pivot_i, right)

        partition_idx = left
        (left...right).each do |i|
            next unless num_freqs[i].greater_than(pivot)

            swap.call(i, partition_idx)
            partition_idx += 1
        end
        swap.call(right, partition_idx)

        return if partition_idx == target
        if partition_idx < target
            left = partition_idx + 1
        else
            right = partition_idx - 1
        end
    end
end

```
