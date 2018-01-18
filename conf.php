<?php
/**
 * Created by PhpStorm.
 * User: tarvi.liivak
 * Date: 18.01.2018
 * Time: 9:36
 */
// konfiguratsiooni fail

// loome vajalikud abikonstandid
define('MODEL_DIR', 'model/');
define('VIEWS_DIR', 'views/');
define('CONTROL_DIR', 'controllers/');

//  nõuame vajalike failide olemasolu
require_once MODEL_DIR.'template.php'; // html vaade failide töötlus