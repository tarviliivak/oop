<?php
/**
 * Created by PhpStorm.
 * User: tarvi.liivak
 * Date: 19.01.2018
 * Time: 14:18
 */
// nõuame konfiguratsiooni faili
require_once 'conf.php';
// loome peamalli objekti
$mainTmpl = new template('main');
// reaalväärtuste määramine
$mainTmpl->set('site_lang', 'et');
$mainTmpl->set('site_title', 'PV');
$mainTmpl->set('user', 'Kasutaja');
$mainTmpl->set('title', 'Pealkiri');
$mainTmpl->set('lang_bar', 'Keeleriba');
// lisame menüü failist
require_once 'menu.php';

// väljastame sisuga täidetud mall
echo $mainTmpl->parse();
// kontrollime http objekti tööd

$control = $http->get('control');
echo $control.'<br />';