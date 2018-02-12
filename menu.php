<?php
/**
 * Created by PhpStorm.
 * User: tarvi.liivak
 * Date: 23.01.2018
 * Time: 14:13
 */
//määrame menüüd väljastades elemendi nime
// loome menüü ehitamiseks vajalikud objektid
$menuTmpl = new template('menu.menu'); //menüü mall
$itemTmpl = new template('menu.item'); //item mall

// Koostame menüü ja sisu loomise päringu

$sql = 'SELECT content_id, content, title '.
    'FROM content WHERE parent_id='.fixDB(0).
    ' AND  show_in_menu='.fixDB(1);
$result = $db->getData($sql); // loeme andmed andmebaasist


// Kui andmed on andmebaasis olemas, siis loome menüü nende põhjal
if($result != false){
    foreach ($result as $page){
        $itemTmpl->set('name', $page['title']);
        $link = $http->getLink(array('page_id'=>$page['content_id']));
        $itemTmpl->set('link', $link);
        $menuTmpl->add('menu_items', $itemTmpl->parse());
    }
}
// Need elemendid ei ole juba andmebaasist
//sisse logimine
// loome mitte sisse logitud kasutaja jaoks user_id
define('USER_ID', 0);
// näitame antud kasutajale logi sisse menüüd
$itemTmpl->set('name', 'logi sisse');
$link = $http->getLink(array('control'=>'login'));
$itemTmpl->set('link', $link);
$menuTmpl->add('menu_items', $itemTmpl->parse());

//Trükime valmis menüü
$mainTmpl->set('menu', $menuTmpl->parse());
