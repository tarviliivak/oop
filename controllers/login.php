<?php
/**
 * Created by PhpStorm.
 * User: tarvi.liivak
 * Date: 12.02.2018
 * Time: 11:08
 */
$loginform = new template('login');
// kasutaja andmete töötlusfaili link
$link = $http->getLink(array('control'=>'login_do'));
// lisame vajalikud andmed malli
$loginform->set('link', $link);
$loginform->set('kasutaja', 'Sisesta kasutajanimi');
$loginform->set('parool', 'Sisesta Parool');
$loginform->set('nupp', 'Logi sisse');
// nüüd tuleb see sisu väljastada peamalli sees
$mainTmpl->set('content', $loginform->parse());