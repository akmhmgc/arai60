# step2 他の方の解答を見る
> Top K を見つけるには、priority_queue に放り込むのでもいいですが、計算量としてソートしているのと変わらないですね。
https://discord.com/channels/1084280443945353267/1183683738635346001/1185972070165782688

まさにそれを感じていて、最初のソートで良くないか？と思いつつstep1でHeapを書いていた。

step1のヒープの解法では、ヒープへの挿入でtopより頻度が低かったり、頻度は同じではあるが数字が大きいものは弾いて挿入のコストを減らしている。
しかし、先に頻度が低いものがきて後から頻度が高いものが来る場合では弾くことができない。

quick selectだと数字と頻度の組み合わせを作成するのにO(N)

その後に上位k個数を左に寄せる作業は、
最初はN個の操作が必要だが、αを0 - 1の確率変数とすると次はα * n個、その次はα^2 といった感じの計算量がかかり、合計するとαの部分は定数になるのでO(N)になる。
最後の左側k個をソートせずに出すのであれば計算量はO(N)で済む。

pivotの選び方が悪いと計算量はO(N^2)になるらしい。
Median-of-Mediansだと最悪計算量がO(N)であることが保証されるらしい。
一度のコストが大きい処理ではこういうのを使ったりするのかな。

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
    quickselect!(num_freqs, k - 1)
    num_freqs.first(k).map(&:num)
end

def quickselect!(num_freqs, target)
    swap = ->(idx1, idx2) { num_freqs[idx1], num_freqs[idx2] = num_freqs[idx2], num_freqs[idx1] }

    left = 0
    right = num_freqs.size - 1
    while left <= right
        pivot_idx = rand(left..right)
        pivot = num_freqs[pivot_idx]
        swap.call(pivot_idx, right)

        partition_idx = left
        (left...right).each do |i|
            next unless num_freqs[i].greater_than(pivot)

            swap.call(i, partition_idx)
            partition_idx += 1
        end
        swap.call(partition_idx, right)

        return if partition_idx == target
        if partition_idx > target
            right = partition_idx - 1
        else
            left = partition_idx + 1
        end
    end
end
```
