# L/Log(LifeLog)

## サイト概要
何気ない日常の様々なワンシーンを切り取っていく。このサイトは、そんないつの間にか忘れてしまうような"人生"の"記録"をつけていくサイトです。

### サイトテーマ
Youtubeのようなサイト。

### テーマを選んだ理由
楽しかった思い出などを残して、自分がどんなふうに生きてきたのかを振り返れるツールがあると良いなと感じました。
Youtubeよりも手軽で、Instagramよりももっと思い出に残せるようなサイトがあったら良いなと感じ選びました。

### ターゲットユーザ
10代〜40代のVlogに興味のある人向けです。

### 主な利用シーン
自分用の動画記録として、またグループの思い出作りとして、など。

## 設計書


### 機能一覧
https://docs.google.com/spreadsheets/d/14TFi8kAOpiDLktZ2ulnUEtPzVRp8pghXeDiATV-1jfE/edit#gid=0

## 開発環境
- OS：mac(Catalina)
- 言語：HTML,CSS,JavaScript,Ruby,SQL
- フレームワーク：Ruby on Rails
- JSライブラリ：jQuery
- 仮想環境：Vagrant,VirtualBox

## その他
動画のサイズは大きく、AWSの無料制限の中だと厳しい可能性があるのでデプロイ後は必要最低限の動画（１つ当り数秒程度）とし、それでも厳しいようであればPF公開中に限りAWS S3を検討します。
機能一覧を一部修正しました。（制作コストを考え実装したい機能のみに絞りました。）
