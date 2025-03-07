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
        total_questions => 5,
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
        total_questions => 5,
    });
};

# 設問2の後に設問3のページ表示
any '/question/3' => sub {
    my ($c) = @_;
    my $birthdate = $c->req->param('birthdate');

    if (!$birthdate) {
        return $c->redirect('/question/2');
    }

    $c->session->set('birthdate' => $birthdate);
    return $c->render('question3.tx', {
        question_number => 3,
        total_questions => 5,
    });
};

# 設問3の後に設問4のページ表示
any '/question/4' => sub {
    my ($c) = @_;
    my $occupation_id = $c->req->param('occupation_id');

    if (!$occupation_id) {
        return $c->redirect('/question/3');
    }

    $c->session->set('occupation_id' => $occupation_id);
    return $c->render('question4.tx', {
        question_number => 4,
        total_questions => 5,
    });
};

# 設問4の後に設問5のページ表示
any '/question/5' => sub {
    my ($c) = @_;
    my $drink_id = $c->req->param('drink_id');

    if (!$drink_id) {
        return $c->redirect('/question/4');
    }

    $c->session->set('drink_id' => $drink_id);
    return $c->render('question5.tx', {
        question_number => 5,
        total_questions => 5,
    });
};

# 設問5ページから確認ページへの遷移に関わる処理
post '/confirm' => sub {
    my ($c) = @_;
    my $remarks = $c->req->param('remarks') // '';  # undefだった場合、代わりに ''（空文字）を入れる

    $c->session->set('remarks' => $remarks);

    return $c->render('confirm.tx', {
        name       => $c->session->get('name'),
        birthdate     => $c->session->get('birthdate'),
        occupation_id => $c->session->get('occupation_id'),
        drink_id      => $c->session->get('drink_id'),
        remarks    => $remarks,
    });
};


use DBI;

post '/submit' => sub {
    my ($c) = @_;

    # セッション(一時的にデータ保持する仕組み)からデータを取得
    my $name        = $c->session->get('name');
    my $birthdate   = $c->session->get('birthdate');
    my $occupation_id  = $c->session->get('occupation_id');
    my $drink_id       = $c->session->get('drink_id');
    my $remarks     = $c->session->get('remarks');

    use questionary1::Web::Config;
    # データベースに接続
    my $dbh = DBI->connect(
        "DBI:mysql:dbname=" . questionary1::Web::Config::get('DB_NAME') .
        ";host=" . questionary1::Web::Config::get('DB_HOST'),
        questionary1::Web::Config::get('DB_USER'),
        questionary1::Web::Config::get('DB_PASS'),
        { mysql_enable_utf8 => 1 }
    );

    # データをINSERT
    my $sth = $dbh->prepare("INSERT INTO member (name, birthdate, occupation_id, drink_id, remarks) VALUES (?, ?, ?, ?, ?)");
    $sth->execute($name, $birthdate, $occupation_id, $drink_id, $remarks);

    # セッションをクリア（不要になったので削除）
    $c->session->remove('name');
    $c->session->remove('birthdate');
    $c->session->remove('occupation_id');
    $c->session->remove('drink_id');
    $c->session->remove('remarks');

    return $c->redirect('/complete');  # 完了ページへリダイレクト
};

# /complete のルートを追加
get '/complete' => sub {
    my ($c) = @_;
    return $c->render('complete.tx');  # complete.tx を表示する
};

1;
