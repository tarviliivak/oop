<?php
/**
 * Created by PhpStorm.
 * User: tarvi.liivak
 * Date: 18.01.2018
 * Time: 9:36
 */
// konfiguratsiooni fail

define('MODEL_DIR', 'model/');
define('VIEWS_DIR', 'views/');
define('CONTROL_DIR', 'controllers/');
define('LIB_DIR', 'lib/');

// lisame vaikimisi kontrolleri faili nimi
define('DEFAULT_CONTROL', 'default');

// nõuame abifuntksioonide olemasolu
require_once LIB_DIR.'utils.php';

// nõuame vajalikke failide olemasolu
require_once MODEL_DIR.'template.php'; // html vaade failide töötlus
require_once MODEL_DIR.'http.php'; // HTTP töötlus klass
require_once MODEL_DIR.'linkobjekt.php'; // Lingi töötluse klass
// loome vajalikud objektid, mis on pidevalt tööl
$http = new linkobject();