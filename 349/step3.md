# step3 3回続けて10分以内に書いてエラーを出さなければOKとする
https://github.com/ruby/ruby/blob/5257e1298c4dc4e854eaa0a9fe5e6dc5c1495c91/array.c#L5687
Array#&では、引数がSetに変換されるので片方の配列がとても大きいときは、小さい方の配列を引数にすると良い。
それを踏まえて実装した。

それぞれの配列の長さをM,Nとする。
時間計算量だとどちらもO(M + N)だが、片方は配列を先頭から舐めてSetにあるかどうか確認するだけで、もう片方はSetに変換しているのでコストが異なる。
Setへの変換はハッシュ値の計算、そしてハッシュ値の衝突時のバケットの探索、負荷率上昇に伴うrehashなど、配列を先頭から舐めてSetに存在するかチェックする処理に比べてコストが大きい。
また、短い配列をSetにすることでSetに必要な空間はMIN(M,N)で済み、結果を格納する配列もMIN(M,N)で良い。よって空間計算量はO(MIN(M,N))となる。

```ruby
# @param {Integer[]} numbers1
# @param {Integer[]} numbers2
# @return {Integer[]}
def intersection(numbers1, numbers2)
    # numbers1が非常に小さく、numbers2が非常に大きい前提
    if numbers1.size < numbers2.size
        return numbers2 & numbers1
    end

    numbers1 & numbers2
end
```
