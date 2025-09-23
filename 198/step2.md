# step2 他の方の解答を見る
## メモ化をつかわない場合の計算量
https://github.com/hroc135/leetcode/pull/33#discussion_r1899009212
`1.6^n`になるらしい。知らなかった。


## スレッドセーフかどうか
https://github.com/Mike0121/LeetCode/pull/47#discussion_r1799964450

```python
from concurrent.futures import ThreadPoolExecutor

class Solution:
    def rob(self, nums, thread_id):
        memo = {}

        def find_max_value(i):
            if i >= len(nums):
                return 0

            if i in memo:
                return memo[i]

            max_value = max(nums[i] + find_max_value(i + 2), find_max_value(i + 1))

            memo[i] = max_value
            return max_value

        return find_max_value(0)

if __name__ == "__main__":
    pool = ThreadPoolExecutor(max_workers=4)
    solution = Solution()
    nums = [0, 0, 0, 0, 0]
    futures = [pool.submit(solution.rob, [1, 1, 1, 1, 1], 1), pool.submit(solution.rob, [0, 0, 0, 0, 0], 2),]

    for f in futures:
```

上のような処理を書いて、「スレッドセーフなのでは？」と思いながらGILをオフにしたPythonで試していたが理解が間違っていた。
`rob`メソッドが複数スレッドで呼ばれたときの話ではなく、`find_max_value`が複数スレッドで呼ばれたときの話だった。
そのときは複数のスレッドから同じメモリに格納されている`memo`を更新するのでスレッドセーフではなくなる。
ただ、find_max_valueの処理は独立していないので、並列で実行することで効率がよくなるとは考えにくい。
気になったので質問中: https://github.com/Mike0121/LeetCode/pull/47#discussion_r2371281226


https://github.com/h1rosaka/arai60/pull/37/files#diff-3cad6c6001234a922d7e9a0b5da82cd9db4dc34edcb80f9dc139f5e9bc09ced4R49-R67
GILがあってもプリエンプションでスレッドが切り替わることがある。
