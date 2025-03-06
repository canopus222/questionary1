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
    
    # 外部キー制約を設定
    belongs_to 'occupation' => 'questionary1::DB::Occupation', 'occupation_id';
    belongs_to 'drink' => 'questionary1::DB::Drink', 'drink_id';
};

1;
