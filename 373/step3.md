# step3 3回続けて10分以内に書いてエラーを出さなければOKとする

```ruby
# @param {Integer[]} nums1
# @param {Integer[]} nums2
# @param {Integer} k
# @return {Integer[][]}
def k_smallest_pairs(nums1, nums2, k)
    return [] if nums1.empty? || nums2.empty? || k <= 0

    top_k_smallest_pairs = []
    heap = MinHeap.new
    visited = Set.new
    heap.push([nums1[0] + nums2[0], 0, 0])
    visited << [0, 0]
    add_to_heap_if_necessary = lambda do |index1, index2|
        return unless index1 < nums1.size && index2 < nums2.size
        return if visited.include?([index1, index2])

        visited << [index1, index2]
        heap.push([nums1[index1] + nums2[index2], index1, index2])
    end
    while top_k_smallest_pairs.size < k && !heap.empty?
        sum, i, j = heap.pop
        top_k_smallest_pairs << [nums1[i], nums2[j]]
        add_to_heap_if_necessary.call(i, j + 1)
        add_to_heap_if_necessary.call(i + 1, j)
    end
    top_k_smallest_pairs
end
```
