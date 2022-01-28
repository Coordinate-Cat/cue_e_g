# CUE_E_G

チュートリアル
https://cuetorials.com/overview

- ConjunctionsとかDisjunctions上手く使いこなしたい
- 小さく定義を設定していき「積み上げる」感覚を意識する(building-up)
  - string, intなど型定義
    ```
    // 例
    #Base: {
      name: string
      os: string
    }
    ```

  - regex(正規表現)や配列に入る型の設定
    ```
    #Meta: {
      // a~zまでの文字列が入るよ
      version: =~"[a-zA-Z_0-9]+"
      // 配列には文字列が入るよ
      labels: [...string]
    }
    #Permissions: {
      role: string
      // デフォルトfalse
      public: bool | *false
    }
    ```

  - スキーマを作って再利用可能に
    ```
    #Schema-1: {
      #Base
      #Meta

      #Permissions
    }
    #Schema-2: {
      #Base
      #Permissions
    }
    ```

  - 上記で色々設定したものをまとめて出力
    ```
    value: #Schema-1 & {
      name:    "app"
      os:    "mac"
      version: "catalina"
      labels: ["server", "prod"]
      role: "backend"
      // public: false  (by default)
    }
    ```
- 値の設定とルールの分離を行う
  ```
  cue/order/order-1.cue // 値
  cue/order/order-2.cue // ルール
  ↓
  cue/order/order-unification.cue
  ```

- ショートハンド
  ```
  a: {
    foo: "bar"
  }

  // shorthand nested field
  a: hello: "world"
  ```

- 接頭辞アンダーバー(_)で非表示
  ```
  A: {                               →
    _hidden: "a hidden field"        →
    isshown: "I can be seen"         →
    hidrefd: _hidden + " sort of?"   →
  }                                  →

  _#NoshowDefn: {                    →
    hello: string                    →
    num:   int | *42                 →
  }                                  →

  B: _#NoshowDefn & {hello: "world"} →
  ```

## COMMAND
このレポジトリでよく使ったコマンド
```
# 結果を表示
## json
cue export cue/Foundations.cue --out json
## yaml
cue export cue/Foundations.cue --out yaml

# output(アウトプットコマンドがないのでシェルで出力)
cue export cue/Foundations.cue > json/Foundations.json

# 値とルールのファイル分割、統合
cue export cue/order/order-1.cue cue/order/order-2.cue --out json > cue/order/order-unification.cue

# eval(cueファイルを評価する)
cue eval cue/Foundations.cue
```

## BUILTIN TYPES
ビルトインで用意されている型
```
N:   null
B:   bool
S:   string
By:  bytes
Num: number // Decimals or integers, a superclass if you will
Int: int    // Big Int which can represent values without limits
List: [...]
Struct: {...}
```

## SUGAR SYNTACTIC
糖衣構文
```
hex:  0xdeadbeef            → hex:  3735928559
oct:  0o755                 → oct:  493
bin:  0b0101_0001           → bin:  81
cpu:  0.5Mi                 → cpu:  524288
mem:  4Gi                   → mem:  4294967296
mill: 1M                    → mill: 1000000
bill: 1G                    → bill: 1000000000
zero: 0.0                   → zero: 0
half: 0.5                   → half: 0.5
trim: 01.23                 → trim: 1.23
mole: 6.022_140_76e+23      → mole: 6.02214076e+23
tiny: 1.2345e-12            → tiny: 1.2345e-12
long: 23_456_789_000_000000 → long: 23456789000000000
```

## REFERNCE

### CUE
- cuelnag 公式docs  
https://cuelang.org/docs/
- cuelangの公式tutorial  
https://cuelang.org/docs/tutorials/tour/intro/
- cue discuss  
https://github.com/cuelang/cue/discussions
- cue spec  
https://github.com/cuelang/cue/blob/master/doc/ref/spec.md
- cuetutorial by the Hofstadter team  
https://cuetorials.com/introduction/  
https://github.com/hofstadter-io/cuetorials.com
- cue example  
https://github.com/hofstadter-io/cue-examples
- zenn  
https://zenn.dev/riita10069/articles/plactice_cuelang
- 公式Package（goでcueを扱うために）  
https://pkg.go.dev/cuelang.org/go/cue
- CUEを試して見る  
https://future-architect.github.io/articles/20191002/
- ngkcl/vscode-cuelang(highlight ext)  
https://github.com/ngkcl/vscode-cuelang
- シェルスクリプトでJSONを扱う  
https://qiita.com/unhurried/items/c62d29540de3e10a50ad


### REGEX
- 基本的な正規表現一覧
https://murashun.jp/article/programming/regular-expression.html
