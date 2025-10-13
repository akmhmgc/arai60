# step2 他の方の解答を見るj
- https://github.com/TORUS0818/leetcode/pull/12

候補を二つMinHeapに突っ込んで、最初の組み合わせを取り出してkを満たすまで答えに加える。
取り出した組み合わせを元に次の候補を突っ込む、、、
という感じか。

> 座標を入れていくと、一番小さいやつが取り出せる魔法の箱を用意する。
https://github.com/TORUS0818/leetcode/pull/12/files/aff04af04a728a9d0f33741bb594c698be6aa896..09636a11c0c084c245f82bb029f198c2d0966455#r1697964514

こういう箱がある、という発想だと自然な考え方かもしれない。

訪問済みをSetで管理するか配列で管理するかを両方とも試す。

LeetCodeで利用可能なRubyのライブラリを確認したところ、push操作がO(1)とあって驚いた。Fibonacci heapというものらしい。
https://github.com/intelie/ruby-algorithms/blob/8b2cf66386cd85f05699d055d254215c1e30ba4f/lib/containers/heap.rb#L60-L66

## Setで管理する方法
nums1の長さをM, nums2の長さをNとする。
時間計算量はO(min(M * N * log(M * N), k * log(k)))で、kの最大値は10^4なので1秒以内に間に合う
空間計算量はvisitedがM * Nあるいはkまで増えて、heapも同様なのでO(min(M*N, k))

```ruby
# @param {Integer[]} nums1
# @param {Integer[]} nums2
# @param {Integer} k
# @return {Integer[][]}
def k_smallest_pairs(nums1, nums2, k)
    return [] if nums1.empty? || nums2.empty? || k <= 0

    top_k_smallest_pairs = []
    heap = MinHeap.new
    heap.push([nums1[0] + nums2[0], 0, 0])
    visited = Set.new
    visited << [0, 0]
    add_to_heap_if_necessary = lambda do |index1 , index2|
        return unless index1 < nums1.size && index2 < nums2.size
        return if visited.include?([index1, index2])

        visited << [index1, index2]
        heap.push([nums1[index1] + nums2[index2], index1, index2])
    end

    while top_k_smallest_pairs.size < k && !heap.empty?
        _, i, j = heap.pop
        top_k_smallest_pairs << [nums1[i], nums2[j]]
        add_to_heap_if_necessary.call(i, j + 1)
        add_to_heap_if_necessary.call(i + 1, j)
    end
    top_k_smallest_pairs
end
```

## 配列で管理する方法
Setの場合はあるindexの組み合わせ(i, j)を一番小さいものを取り出せる箱に入れる前に、その組み合わせを入れたことがあるかをチェックする方法

配列の場合(i, j)を箱から取り出した後は次の候補として(i + 1, j), (i, j + 1)を候補として考える。
(i + 1, j)を箱に入れる前に(i, j)と(i + 1, j - 1)が取り出されたことを確認する
(i, j + 1)を箱に入れる前に(i, j)と(i - 1, j + 1)が取り出されたことを確認する

素直にやろうとすると二次元配列にbooleanを入れることを考えるが、step1と同様メモリ不足になる。
配列2つで管理することができる。
nums1/nums2の各indexごとに出力に加えた数をカウントしておく。それぞれoutput_count_at_index1/output_count_at_index2とする。
取り出したindexを(i, j)とすると、それぞれのi番目、j番目のカウントを+1する。
(i + 1, j)の候補を確認する時は以下を確認すれば良い
- i + 1がnums1のインデックスの範囲にあることと、jがnums2のインデックスの範囲にあること
  - 出力(i, j)から候補を考えているので後者は調べなくても良い
- nums1のi + 1番目のカウントが合計j回であることと、nums2のj番目のカウントが合計i + 1回でであること
  - 出力(i, j)から候補を考えているので後者は調べなくても良い

時間計算量はO(min(M * N * log(M * N), k * log(k)))
空間計算量は配列でM + N, MinHeapはk必要なのでO(M + N + k)

```ruby
# @param {Integer[]} nums1
# @param {Integer[]} nums2
# @param {Integer} k
# @return {Integer[][]}
def k_smallest_pairs(nums1, nums2, k)
    return [] if nums1.empty? || nums2.empty? || k <= 0

    top_k_smallest_pairs = []
    heap = MinHeap.new

    heap.push([nums1[0] + nums2[0], 0, 0])
    output_count_at_index1 = Array.new(nums1.size, 0)
    output_count_at_index2 = Array.new(nums2.size, 0)
    add_to_heap_if_necessary = lambda do |index1 , index2|
        next unless index1 < nums1.size && index2 < nums2.size
        next unless index2 == output_count_at_index1[index1] && index1 == output_count_at_index2[index2]
    
        heap.push([nums1[index1] + nums2[index2], index1, index2])
    end

    while top_k_smallest_pairs.size < k && !heap.empty?
        _, i, j = heap.pop
        top_k_smallest_pairs << [nums1[i], nums2[j]]
        output_count_at_index1[i] += 1
        output_count_at_index2[j] += 1
        add_to_heap_if_necessary.call(i, j + 1)
        add_to_heap_if_necessary.call(i + 1, j)
    end
    top_k_smallest_pairs
end
```
両方とも組み合わせの数よりkの方が大きい場合、組み合わせ全部を小さい順に出力するようにしている。
