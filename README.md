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

## COMMAND
```
# echo(結果を表示)
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

### REGEX
- 基本的な正規表現一覧
https://murashun.jp/article/programming/regular-expression.html
