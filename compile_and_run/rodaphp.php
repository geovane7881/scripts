#!/usr/bin/php
<?php

//script para rodar arquivo php a partir do vim no navegador (localhost), autor: Geovane7881

if(!isset($argv[1])) {
  exit;
}

$string = $argv[1];
//verifica se é um path do localhost
if(strpos($string, '/var/www/html') != -1) {
    //altera endereço
    //(ubuntu)
  //$string = str_replace('/var/www/html', 'http://localhost', $string);
  $string = str_replace('/srv/http', 'http://localhost', $string);
  //roda comando
  //shell_exec("xdg-open \"".$string."\" > /dev/null");
  shell_exec('$BROWSER '.$string.' > /dev/null');
}
