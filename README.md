# ch-sh

チートシート用 Markdown ファイルを検索し表示するコマンドラインツール。


## Installation

- `ch` ファイルを PATH の通ったところに配置する
- 検索対象ディレクトリは `ch` ファイル内の `TARGET_PATH` 変数で指定する


## Usage

```sh
$ ch 'example'
```

- 検索した Markdown ファイルを `cat` で出力する
    - `bat` コマンドがインストールされていれば `bat` コマンドで出力する
    - それ以外のコマンドでファイルを出力したい場合は `ch` ファイル内の `FORCE_SHOW_CMD` 変数で指定する


## Author

[Neo](http://neo.s21.xrea.com/) ([@Neos21](https://twitter.com/Neos21))


## Links

- [Neo's World](http://neo.s21.xrea.com/)
- [Corredor](http://neos21.hatenablog.com/)
- [Murga](http://neos21.hatenablog.jp/)
- [El Mylar](http://neos21.hateblo.jp/)
- [Neo's GitHub Pages](https://neos21.github.io/)
- [GitHub - Neos21](https://github.com/Neos21/)
