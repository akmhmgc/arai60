# step1 何も見ずに解く
アナグラムは同じソート順であれば同じ文字列になるので、ソートした単語をキーとして元の文字列の配列をバリューとして管理すればよいと考えた。
ソートを使う方法は、単語の長さをM,単語の個数をNすると時間計算量はO(N*MlogM)となる。
単語の長さの最大が10^2で、文字列の個数の最大が10^4なので、一般的なCPUで1秒以内に計算を終わらせることはできそう。
元の単語をソートする文字列を変数に保存しているのと、HashSetの分で空間計算量はO(M + N)となる。

単語は小文字の英語からなるので、ソートを使わずに書く英単語が現れた個数をキーにする方法も思いついた。
そちらの方法だとO(M * N)の時間計算量で済むが、コードの理解のしやすさを優先してソートする方法を選択した。


```ruby
# @param {String[]} strings
# @return {String[][]}
def group_anagrams(strings)
    sorted_string_to_strings = {}
    strings.each do |string|
        sorted_string = string.split("").sort.join
        if sorted_string_to_strings[sorted_string]
            sorted_string_to_strings[sorted_string] << string
        else
            sorted_string_to_strings[sorted_string] = [string]
        end
    end

    sorted_string_to_strings.values
end
```

HashSetの初期値を設定することでより簡潔にかけるので修正した。
あと、`sorted_string_to_strings`だと対比が分かりづらいので修正した。

```ruby
# @param {String[]} strings
# @return {String[][]}
def group_anagrams(strings)
    sorted_string_to_original_strings = Hash.new{ |hash, key| hash[key] = [] }
    strings.each do |string|
        sorted_string = string.split("").sort.join
        sorted_string_to_original_strings[sorted_string] << string
    end

    sorted_string_to_original_strings.values
end
```

次にソートを使わない方法を考える。aからzの出現頻度を数えて、組み合わせた値をキーにすれば良いだろう。
これだとそれぞれの単語を末尾まで一回舐めるだけなので時間計算量はO(MN)に抑えられる。
ただ、少しコードが複雑になる。
確か文字コードに変換するメソッドがあったが思い出せなかったのでドキュメントを見た。


```ruby
# @param {String[]} strings
# @return {String[][]}
def group_anagrams(strings)
    joined_english_letter_count_to_strings = Hash.new{ |hash, key| hash[key] = [] }
    strings.each do |string|
        joined_english_letter_count_to_strings[joined_english_letter_count(string)] << string
    end
    
    joined_english_letter_count_to_strings.values
end

def joined_english_letter_count(string)
    english_letter_counts = Array.new("z".ord - "a".ord + 1, 0)
    string.each_char do |character|
        english_letter_counts[character.ord - "a".ord] += 1
    end

    english_letter_counts.join("_")
end
```

ソートを使った方法よりも遅くなった。
`joined_english_letter_count_to_strings`のキーを文字列をしている部分が怪しいかもしれないので調査した。
普段配列をキーにすることがないのであまり考えずに文字列に変換してしまったが、配列をキーにしても問題ないだろう。
Rubyのコードを確認したところ、配列をハッシュ化する時は、`Array#hash`というメソッドが呼ばれていて、`Array#hash`では配列の要素にハッシュ関数を累積して適用していることがわかった。
ref: https://github.com/ruby/ruby/blob/5257e1298c4dc4e854eaa0a9fe5e6dc5c1495c91/array.c#L5323-L5342

文字列の場合はバイト文字列にハッシュ化しているようだった。

- 数値からなる文字列をハッシュ化する
- 数値からなる配列をハッシュ化する
- 数値からなる配列を文字列にしてからハッシュ化する

それぞれのベンチマークをとったところ以下のようになった。

```ruby
require 'benchmark'

SIZE = 10 ** 7
string = "1" * SIZE
list = [1] * SIZE

Benchmark.bm do |x|
    x.report { string.hash }
    x.report { list.hash }
    x.report { list.join.hash }
end
```

```
    user     system      total        real
0.002612   0.000014   0.002626 (  0.002627)
0.041918   0.000504   0.042422 (  0.042455)
0.939179   0.006042   0.945221 (  0.945869)
```

配列を文字列に変換してからハッシュ化するよりも、配列をそのままハッシュ化する方が早いことがわかった。

```ruby
# @param {String[]} strings
# @return {String[][]}
def group_anagrams(strings)
    english_letter_count_to_strings = Hash.new{ |hash, key| hash[key] = [] }
    strings.each do |string|
        english_letter_count_to_strings[english_letter_count(string)] << string
    end
    
    english_letter_count_to_strings.values
end

def english_letter_count(string)
    a_byte = "a".ord
    english_letter_counts = Array.new("z".ord - a_byte + 1, 0)
    string.each_byte do |byte|
        english_letter_counts[byte - a_byte] += 1
    end
    english_letter_counts
end
```

120ms -> 30msほどになったが、ソートを利用したものとほとんど変わらなかった。
