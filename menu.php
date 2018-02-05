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
$result = $db->getData($sql); //
echo '<pre>';
print_r($result);
echo '</pre>';



$itemTmpl->set('name', 'avaleht');
// lisame antud elemendi menüüsse
// http://tl.ikt.khk.ee/oop/index.php/control/avaleht
$link = $http->getLink(array('control'=>'avaleht'));
$itemTmpl->set('link', $link);
//
$menuItem = $itemTmpl->parse(); // string mis sisaldab ühe nimekirja elemente
$menuTmpl->add('menu_items', $menuItem);
//
//
$itemTmpl->set('name', 'esimene');
// lisame antud elemendi menüüsse
// http://tl.ikt.khk.ee/oop/index.php/control/esimene
$link = $http->getLink(array('control'=>'esimene'));
$itemTmpl->set('link', $link);
//
$menuItem = $itemTmpl->parse(); // string mis sisaldab ühe nimekirja elemente
$menuTmpl->add('menu_items', $menuItem); //


$itemTmpl->set('name', 'teine');
//
$link = $http->getLink(array('control'=>'teine'));
$itemTmpl->set('link', $link);
// lisame antud elemendi menüüsse
$menuItem = $itemTmpl->parse(); // string mis sisaldab ühe nimekirja elemente
$menuTmpl->add('menu_items', $menuItem); //

// ehitame valmis menüü
$menu = $menuTmpl->parse();


// lisame valmis menüü lehele
$mainTmpl->set('menu', $menu);