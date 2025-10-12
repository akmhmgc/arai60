# step1 何も見ずに解く

Nをスコアの長さとする。Mをadd操作の回数とする。
最初のスコアをソートしておくと、k番目のスコアはO(1)で取り出せる。
新しいスコアを追加する時は二分探索を使うとO(logN)で入れる場所を探せる。
ただ、配列の途中に挿入するときにO(N + M)の計算量がかかるので、最終的な時間計算量は
M * (log(M + N) + (M + N))となり、O(M * (M + N))となり、M,Nの最大値が10^4なので間に合わない気がする。

```ruby
class KthLargest

=begin
    :type k: Integer
    :type nums: Integer[]
=end
    def initialize(k, nums)
        raise ArgumentError, "k must be positive integer" if k <= 0
        @k = k
        @sorted_nums = nums.sort.reverse
    end


=begin
    :type val: Integer
    :rtype: Integer
=end
    def add(val)
        return @sorted_nums[@k - 1] if @sorted_nums.size >= @k && @sorted_nums[@k - 1] >= val

        index = @sorted_nums.bsearch_index { |num| num <= val }
        if index.nil?
            @sorted_nums << val
        else
            @sorted_nums.insert(index, val)
        end
        @sorted_nums[@k - 1]
    end
end
```

なぜか間に合った。テストケースに厳しいものが少なかったのかも。
一応Rubyのinsertメソッドの実装を見たが、やはりO(N)かかるっぽい。まあそりゃそうか。

今のコードでは、scoreは降順に並んでいて、@sorted_nums[@k - 1]より小さい値、つまり配列の後にくる値の挿入をスキップしている。
配列の挿入は後ろであればあるほどコストが小さいはずなので昇順にして、前の方に挿入する時にスキップした方がマシだったかもしれない。
