use questionary1::Web::Config;

+{
    'DBI' => [
        "dbi:mysql:dbname=" . questionary1::Web::Config::get('DB_NAME') .
        ";host=" . questionary1::Web::Config::get('DB_HOST'),
        questionary1::Web::Config::get('DB_USER'),
        questionary1::Web::Config::get('DB_PASS'),
        +{
            mysql_enable_utf8 => 1,
        }
    ],
};
