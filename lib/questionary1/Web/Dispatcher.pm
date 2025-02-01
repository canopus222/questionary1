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
    my $name = $c->req->param('name');  # フォームから入力を取得

    if (!$name) {
        return $c->redirect('/question/1');  # 未入力なら設問1へ戻る
    }

    $c->session->set('name' => $name);  # セッションに保存
    return $c->render('question2.tx', {
        question_number => 2,
        total_questions => 5, # 全5問の場合
    });
};

# 設問2の後に設問3のページ表示
any '/question/3' => sub {
    my ($c) = @_;
    my $age = $c->req->param('age');

    if (!$age) {
        return $c->redirect('/question/2');
    }

    $c->session->set('age' => $age);
    return $c->render('question3.tx', {
        question_number => 3,
        total_questions => 5, # 全5問の場合
    });
};

# 設問3の後に設問4のページ表示
any '/question/4' => sub {
    my ($c) = @_;
    my $occupation = $c->req->param('occupation');

    if (!$occupation) {
        return $c->redirect('/question/3');
    }

    $c->session->set('occupation' => $occupation);
    return $c->render('question4.tx', {
        question_number => 4,
        total_questions => 5, # 全5問の場合
    });
};

# 設問4の後に設問5のページ表示
any '/question/5' => sub {
    my ($c) = @_;
    my $drink = $c->req->param('drink');

    if (!$drink) {
        return $c->redirect('/question/4');
    }

    $c->session->set('drink' => $drink);
    return $c->render('question5.tx', {
        question_number => 5,
        total_questions => 5, # 全5問の場合
    });
};

post '/confirm' => sub {
    my ($c) = @_;
    my $remarks = $c->req->param('remarks');

    if (!$remarks) {
        return $c->redirect('/question/5');
    }

    $c->session->set('remarks' => $remarks);

    return $c->render('confirm.tx', {
        name   => $c->session->get('name'),
        age  => $c->session->get('age'),
        occupation => $c->session->get('occupation'),
        drink  => $c->session->get('drink'),
        remarks => $remarks,
    });
};

1;
