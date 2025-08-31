# step1 何も見ずに解く
以下の方法を考えた。
1. 先頭から文字の数をカウントしてハッシュテーブルに保存する。
1. 先頭から文字を見て、ハッシュテーブルに1つしか追加されてなければそれを返す。最後まで文字列を見て該当するものがなければ-1を返す。

文字数の長さは最大でも10^5なのでO(N)の時間計算量で1秒以内に間に合う。
空間計算量もO(N)

不正な文字が含まれる場合の出力は以下が考えられる
- 正常終了
  - 不正な文字はスキップする
  - 不正な文字も返り値に含める
- 異常終了

以下は正常終了して、不正な文字も返り値に含めるパターン

```ruby
# @param {String} string
# @return {Integer}
def first_uniq_char(string)
    character_to_count = Hash.new(0)
    string.each_char do |character|
        character_to_count[character] += 1
    end

    string.each_char.with_index do |character, index|
        return index if character_to_count[character] == 1
    end

    -1
end
```

次に正常終了して、不正な値は返り値に含めないパターン

```ruby
# @param {String} string
# @return {Integer}
def first_uniq_char(string)
    ord_a = "a".ord
    ord_z = "z".ord
    lower_english_letter_counts = Array.new(ord_z - ord_a + 1, 0)
    string.each_byte do |byte|
        next if byte < ord_a || byte > ord_z

        lower_english_letter_counts[byte - ord_a] += 1
    end

    string.each_byte.with_index do |byte, index|
        return index if lower_english_letter_counts[byte - ord_a] == 1
    end

    -1
end
```

こっちだとハッシュテーブルではなく配列を使えばよい。
ちなみに、不正な値が含まれていれば異常終了する場合でも配列を使うことができる。



次に、ループを1度で済ませる方法を考える。挿入順序を保持しているハッシュテーブルがあれば良い。
Rubyは1.9以降挿入順序を保証しているので以下のように書ける。

登場したすべての文字を管理するSet(existing_characters)と、一度しか登場していない文字とインデックスの組(unique_character_to_index)を用意する
文字列を先頭からみて、以下をループする
1. existing_characters に含まれていればunique_characters_to_indexから削除して終了
2. existing_characters に含まれていなければunique_characters_to_index に文字とインデックスを追加してexisting_characters に文字を追加する

ループを抜けた後に、unique_character_to_indexの先頭を取り出す。なければ-1を返す。

```ruby
# @param {String} string
# @return {Integer}
def first_uniq_char(string)
    unique_character_to_index = {}
    existing_characters = Set.new
    string.each_char.with_index do |character, index|
        if existing_characters.include?(character)
            unique_character_to_index.delete(character)
            next
        end
        unique_character_to_index[character] = index
        existing_characters.add(character)
    end

    # Ruby1.9以降のHashは挿入順序を保証している
    unique_character_to_index.first ? unique_character_to_index.first.last : -1
end
```
