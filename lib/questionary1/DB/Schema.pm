package questionary1::DB::Schema;
use strict;
use warnings;
use utf8;

# Tengのスキーマ定義使うためモジュールインポート。DBテーブルとPerlオブジェクトを簡単に対応させるための構文が提供
use Teng::Schema::Declare;

base_row_class 'questionary1::DB::Row';

# テーブル member のカラムを定義
table {
    name 'member';
    pk 'id';
    columns qw(id name age occupation drink remarks);
};

1;
