# step2 他の方の解答を見る

- https://github.com/t0hsumi/leetcode/pull/14
- https://github.com/SuperHotDogCat/coding-interview/pull/30
- https://github.com/seal-azarashi/leetcode/pull/14
- https://github.com/hayashi-ay/leetcode/pull/25
- https://github.com/colorbox/leetcode/pull/28

## 文字列の追記
https://discord.com/channels/1084280443945353267/1200089668901937312/1210619083385479258
文字列操作のメソッドを使わずに、先頭から文字列を見て正規化された local と domain を構築する方法では、文字列の追記を行う。
このとき文字列がイミュータブルであれば文字列の再構築が走る。
自分はこの解法を選択してないが、選択していたとしても絶対に意識できてなかった。

Ruby の場合文字列はミュータブルなので再構築は行われないのか…？と思ったが実装を見たところ再構築が行われている。 +では元のオブジェクトを変更するわけではなくて新しいオブジェクトを作っているようだ。
ref: https://github.com/ruby/ruby/blob/5257e1298c4dc4e854eaa0a9fe5e6dc5c1495c91/string.c#L2446-L2474

```ruby
string = ""
pointer = string
string += "aaaa"
p string.object_id # 60
p pointer.object_id # 80
```
新しいオブジェクトが作られている。

`String#<<`(`String#concat`)は再構築は行われず、元の文字列オブジェクトのメモリ領域を拡張してそこに追加する。
配列を作って join する方法も比較するためにベンチマークを取る。

```ruby
require "benchmark"

strings = "a" * 10 ** 5

Benchmark.bm do |x|
    x.report("+=") do
        res = ""
        strings.each_char do |str|
            res += str
        end
    end
    x.report("<<") do
        res = ""
        strings.each_char do |str|
            res << str
        end
    end
    x.report("join") do
        res = []
        strings.each_char do |str|
            res << str
        end
        res.join
    end
end

```

```
          user     system      total        real
+=    0.234665   0.244710   0.479375 (  0.479551)
<<    0.005511   0.000213   0.005724 (  0.005725)
join  0.007502   0.000538   0.008040 (  0.008040)
```

ステートマシンの方法で実装してみる。
invalidなメールアドレスは弾いていない。

```ruby
# @param {String[]} emails
# @return {Integer}
def num_unique_emails(emails)
    unique_canonicalized_emails = Set.new

    emails.each do |email|
        unique_canonicalized_emails.add(canonicalize_email(email))
    end

    unique_canonicalized_emails.count
end

# @param {String} email
# @return {String}
def canonicalize_email(email)
    local, domain = email.split("@")

    canonicalized_email = ""
    local.each_char do |character|
        break if character == "+"
        next if character == "."

        canonicalized_email << character
    end

    canonicalized_email.concat("@", domain)
end
```
