package questionary1::Web::Config;
use strict;
use warnings;
use utf8;
use Config::Tiny;

# .envファイルを読み込む
my $config = Config::Tiny->read('.env');

# 環境変数の取得
sub get {
    my ($key) = @_;
    return $config->{_}->{$key}; # { _ } の中に環境変数が入る
}

1;
