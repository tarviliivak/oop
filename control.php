<?php
/**
 * Created by PhpStorm.
 * User: tarvi.liivak
 * Date: 31.01.2018
 * Time: 10:49
 */
$control = $http->get('control'); // kontrolleri faili nimi
$fail = CONTROL_DIR.$control.'php'; // kontrolleri faili tee
if (file_exists($fail) and is_file($file) and is_readable($file)){
    require_once $file;
}