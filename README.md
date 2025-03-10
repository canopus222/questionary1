## 概要
このプロジェクトは、PerlのAmon2フレームワークを使用して開発したアンケートフォームです。基本構成は回答入力、確認、完了の3つのページです。


## 開発環境
- 言語: Perl
- フレームワーク: Amon2
- データベース: MySQL
- PC：Windows


## 🫛より理解してインストールしてもらう為の豆知識

### 1. Perl と Amon2 の関係
- **Perl**は**プログラミング言語**です。Amon2を動かすためには、まずPerlが必要になります。
- **Amon2**はPerlで作られた**フレームワーク**（アプリを開発するための仕組み）です。Amon2自体はPerlのモジュール（クラスや関数を機能ごとに分類してまとめる仕組み）の1つなので、Perlをインストールした後、Amon2を追加でインストールすれば使えます。

---

### 2. 閲覧側はAmon2をセットアップする必要があるのか？

- 閲覧側が**このアプリを動かすためには、Amon2が必要**です。
- ただし、**Carton（Perlのパッケージ管理ツール）を使えば、Amon2を含む依存モジュールを一括でインストール**できます。
- なので、「Perlをインストール → CartonでAmon2などをインストール → サーバーを起動」の手順が必要になります。

---

### 3. GitHubリポジトリをクローンしただけでは閲覧できません

- このアプリは **サーバーサイドのWebアプリ** だからです。
- **HTMLファイルのように開くだけでは動かない**（ブラウザでファイルを開いても何も表示されません）。
- **サーバーを起動して、Webブラウザでアクセスする必要があります**。


## 閲覧のためのセットアップ手順 
1. **GitHubリポジトリをクローン**
    ```ターミナル
    git clone <リポジトリのURL>
    cd <プロジェクトディレクトリ>
    ```
   <br>

2. **Perlインストール**
    ```terminal
    ・Perlがインストールされているか確認
    $ perl -v

    ・なければインストール
    Ubuntu:$ sudo apt-get install perl
    Mac:$ brew install perl

    ・「cpanm」のインストール確認
    $ cpanm -v
    
    ・Perlのパッケージ管理ツールである「cpanm」をインストール。
    ・Amon2 やその他の必要なライブラリを簡単にインストールできるようにする
    $ curl -L https://cpanmin.us | perl - --sudo App::cpanminus

    ```

    👇こちらはスキップしても大丈夫です。
    ```
    ・「Task::Amon2」のインストール(Amon2 をインストール)
    ・(Amon2 を使うための「推奨パッケージセット」) 
    $ cpanm Task::Amon2

    ・Amon2 をプロジェクトに取り込む
    $ amon2-setup.pl <取り込みたいディレクトリ名>
    
    ```
    <br>


3. **Cartonをインストール**（Amon2などの依存関係を解決するため）
    ```
    $ cpanm Carton
    ```
   <br>
    
4. **プロジェクト内の依存モジュール（Amon2など）をインストール**
    cartonは既にインストールされているパッケージはスキップするので、「スキップしても大丈夫」のコマンドを仮に実行していたとしても問題ありません。
    ```
    $ carton install
    ```
   <br>
    
5. **サーバーを起動・終了する**
    - 下記コマンド実行後表示されたURLにアクセスすることで閲覧することが可能です
    ```
    ・起動
    $ carton exec perl -Ilib script/questionary1-server
    
    ・終了
    ctrl + cキー
    ```

## MySQLのセット手順
```
1：MySQLにログイン
$ mysql -u root

2：以下mysql内で実行するコマンド
CREATE DATABASE <DB名>;
CREATE USER '<ユーザー名>'@'localhost' IDENTIFIED BY '<パスワード>';
GRANT ALL PRIVILEGES ON <DB名>.* TO '<ユーザー名>'@'localhost';
FLUSH PRIVILEGES;


※「FLUSH PRIVILEGES;」はMySQLに設定されたユーザー権限情報を即時反映させる ためのものになります。
```

## **環境変数の設定**
データベース接続情報は `.env` ファイルに記載してください。  
**`.env` の作成手順**
```
$ touch .env
```
**`.env` に記載**
```
DB_NAME=<DB名>
DB_USER=<ユーザー名>
DB_PASS=<パスワード>
DB_HOST=localhost
```

⚠️`.gitignore`に`.env`を追加しているため、GitHub には公開されないようになっていますが、注意してください。
