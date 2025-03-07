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
    columns qw(id name birthdate occupation_id drink_id remarks created_at updated_at);

    # occupation_id から occupation テーブルのデータを取得
    inflate 'occupation_id' => sub {
        my ($col_value, $row) = @_;
        return $row->handle->single('occupation', { id => $col_value });
    };

    # drink_id から drink テーブルのデータを取得
    inflate 'drink_id' => sub {
        my ($col_value, $row) = @_;
        return $row->handle->single('drink', { id => $col_value });
    };

};


1;
