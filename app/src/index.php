<?php
require_once __DIR__ . '/../vendor/autoload.php';

$client = new MongoDB\Client(
    'mongodb+srv://root:password@server.ip.com/dbname?retryWrites=true&w=majority'
);

$db = $client->test;
