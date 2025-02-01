package questionary1::Web::Dispatcher;
use strict;
use warnings;
use utf8;
use Amon2::Web::Dispatcher::RouterBoom;

get '/' => sub {
    my ($c) = @_;
    return $c->render('index.tx');
};

# indexページの後に設問1のページを表示
post '/question/1' => sub {
    my ($c) = @_;
    return $c->render('question1.tx', {
        question_number => 1,
        total_questions => 5, # 全5問の場合
    });
};

# 設問1の後に設問2のページ表示
post '/question/2' => sub {
    my ($c) = @_;
    return $c->render('question2.tx', {
        question_number => 2,
        total_questions => 5, # 全5問の場合
    });
};

# アンケートの質問ページへのルーティング（3ページ目）
any '/question/3' => sub {
    my ($c) = @_;
    return $c->render('question3.tx', {
        question_number => 3,
        total_questions => 5, # 全5問の場合
    });
};

# アンケートの質問ページへのルーティング（4ページ目）
any '/question/4' => sub {
    my ($c) = @_;
    return $c->render('question4.tx', {
        question_number => 4,
        total_questions => 5, # 全5問の場合
    });
};

# アンケートの質問ページへのルーティング（5ページ目）
any '/question/5' => sub {
    my ($c) = @_;
    return $c->render('question5.tx', {
        question_number => 5,
        total_questions => 5, # 全5問の場合
    });
};

1;
