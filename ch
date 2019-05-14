#!/bin/bash

# チートシートファイルを検索し表示する


# 環境設定
# ================================================================================

# 強制的に表示に使いたいコマンドがあれば指定する・なければ未入力か未定義にする
FORCE_SHOW_CMD=
# チートシートがあるディレクトリのパス・末尾はスラッシュを含めないこと
TARGET_PATH="./cheat-sheets"


# 実処理
# ================================================================================

# 未入力の場合
if [ -z "$@" ]; then
  echo '検索文字列を入力してください'
  exit 1
fi

# 引数を全部 grep コマンドに渡す・ヒットした文字列を含むファイル名を配列に入れる
# -l : ファイル名のみ表示する
# -h : ヒットした行のみ表示する (ファイル名を表示しない)
# -n : ファイルの行数を表示する
# -r : 再帰的に検索する
# grep コマンドの結果を改行で区切るため IFS を一時的に変更する
ORIGINAL_IFS=$IFS
IFS=$'\n'
files=( $( eval grep -ilr --include='*.md' \""$@"\" \"${TARGET_PATH}\" 2> /dev/null | sort ) )
IFS=$ORIGINAL_IFS

# ヒットしなかった場合
if [ "${#files[@]}" = '0' ]; then
  echo ''
  echo '見つかりませんでした'
  exit 1
fi

# ファイルの出力用コマンドを特定する : 基本は cat コマンドを使用する
show_cmd='cat'
# bat コマンドがあれば bat コマンドを使用する
if ( type -p bat &> /dev/null ); then
  show_cmd='bat'
fi
# 強制利用したいコマンドがあれば指定する
if [ -n "${FORCE_SHOW_CMD}" ]; then
  show_cmd="${FORCE_SHOW_CMD}"
fi

# ヒットした文字列を含むファイルを順に表示する
echo ''
for file in "${files[@]}"; do
  if [ "${show_cmd}" = 'bat' ]; then
    # bat コマンドで表示する : ファイル名も一緒に出力される・ページングを行わない
    bat --paging=never "${file}"
  elif [ "${show_cmd}" = 'cat' ]; then
    # cat コマンドで表示する
    echo ''
    echo "${file}"
    echo '=================================================='
    echo ''
    cat "${file}"
    echo ''
  else
    # 指定のコマンドで表示する
    echo ''
    echo "${file}"
    echo '=================================================='
    echo ''
    eval "${show_cmd}" "${file}"
    echo ''
  fi
done

echo ''
echo '--------------------------------------------------'
echo ''
echo "${#files[@]} 件見つかりました"
