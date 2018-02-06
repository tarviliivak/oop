<?php
/**
 * Created by PhpStorm.
 * User: tarvi.liivak
 * Date: 31.01.2018
 * Time: 11:04
 */


$page_id = (int)$http->get('page_id'); // lehe id
// Koostame päringu content jaoks
$sql = 'SELECT * FROM content '.
    'WHERE content_id='.fixDB($page_id);
//Küsime andmed andmebaasist
$result = $db->getData($sql);
if($result == false){
    $sql = 'SELECT * FROM content '.
        'WHERE is_first_page='.fixDB(1);
    $result = $db->getData($sql);
}
if($result != false){
    $page = $result[0];
    $mainTmpl->set('content', $page['content']);
}

