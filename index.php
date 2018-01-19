<?php
/**
 * Created by PhpStorm.
 * User: tarvi.liivak
 * Date: 19.01.2018
 * Time: 14:18
 */
require_once 'conf.php';

$mainTmpl = new template('main');
//
$mainTmpl->set('site_lang', 'et');
$mainTmpl->set('site_title', 'PV');
$mainTmpl->set('user', 'Kasutaja');
$mainTmpl->set('title', 'Pealkiri');
$mainTmpl->set('lang_bar', 'Keeleriba');
$mainTmpl->set('menu', 'lehe menüü');
$mainTmpl->set('content', 'Lehe sisu');
//väljastame objekti sisu test kujul
echo '<pre>';
print_r($mainTmpl);
echo '</pre>';