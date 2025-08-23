# step2 他の方の解答を見る
括弧の組み合わせを入れる変数名が微妙だったが、`key_to_value`にすると確かに分かりやすい。

```ruby
# @param {String} s
# @return {Boolean}
def is_valid(brackets)
    open_to_close = {
        '(' => ')',
        '{' => '}', 
        '[' => ']'
    }
    opens = []
    brackets.each_char do |bracket|
        if open_to_close.keys.include?(bracket)
            opens << bracket
        elsif open_to_close.values.include?(bracket)
            open = opens.pop
            return false if bracket != open_to_close[open]
        else
            raise ArgumentError, "Unexpected bracket: #{bracket}"
        end
    end

    opens.size == 0
end
```

変更点は以下
- String#each_charを使った
- popして判定する部分を副作用のある処理を条件式に利用しないようにした
  - 自分も読むときだと分けられているほうが好みなので
- `open_to_close.keys`や`open_to_close.values` を変数にいれないようにした
  - 解いた時の気持ちを振り返ってみると、変数にいれた理由はHashMap(RubyだとHash)の命名`parenthesis_combinations`が微妙だったので`parenthesis_combinations.keys`等だとなんか気持ち悪いな…、という感覚があったことが理由かも。なので`open_to_close`にすれば変数に入れななくても良い。
