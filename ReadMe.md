# uitex

## これはなに

某大学校において開催される「PTU フォーラム」の「職業能力開発研究発表講演会」に投稿する講演論文を LaTeX で書くためのクラスファイルです。

## ファイルの一覧

- **ReadMe.md**: このファイル
- **LICENSE**: BSD 二条項ライセンス
- **uitex.cls**: クラスファイル
- **mknmacro.sty**: 便利マクロ集
- **template.tex**: サンプル 兼 テンプレート

## つかいかた

詳細は **template.tex** をコンパイルしてください。
**latexmk** のインストールされている環境であれば、次のコマンドを実行して **template.pdf** を得ます。

```console
$ latexmk -lualatex
```

**uitex.cls** はクラスファイルですから、TeX ファイルの冒頭に次のように記述して使います。
クラスオプションとして、組版に使うエンジン（**lualatex** や **uplatex,dvipdfmx** など）を指定してください。また、数式を左側に寄せるために **fleqn** も指定してください。

```latex
\documentclass[lualatex,fleqn]{uitex}
```

**mknmacro.sty** はスタイルファイルですから、TeX ファイルのプレアンブル（`\documentclass` から `\begin{document}` までの間）に次のように記述して使います。
このパッケージは内部で **mathtools** パッケージを用います。

```latex
\usepackage{mknmacro}
```

## ライセンス

BSD 2-Clause License の下で利用可能です（Copyright (c) 2026, Tatsuma Matsunaga (a.k.a. KusaReMKN)）。

**uitex.cls** は、その一部に BSD 2-Clause License の下に公開されている [abenori/jlreq](https://github.com/abenori/jlreq) に由来するコードを含みます（Copyright 2017-2024, Noriyuki Abe.）。
