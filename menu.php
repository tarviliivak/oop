<?php
/**
 * Created by PhpStorm.
 * User: tarvi.liivak
 * Date: 23.01.2018
 * Time: 14:13
 */

// loome menüü ehitamiseks vajalikud objektid
$menuTmpl = new template('menu.menu'); //menüü mall
$itemTmpl = new template('menu.item'); //item mall

$itemTmpl->set('name', 'esimene');
// lisame antud elemendi menüüsse
$menuItem = $itemTmpl->parse(); // string mis sisaldab ühe nimekirja elemente
$menuTmpl->add('menu_items', $menuItem); //


$itemTmpl->set('name', 'teine');
// lisame antud elemendi menüüsse
$menuItem = $itemTmpl->parse(); // string mis sisaldab ühe nimekirja elemente
$menuTmpl->add('menu_items', $menuItem); //

// ehitame valmis menüü
$menu = $menuTmpl->parse();


// lisame valmis menüü lehele
$mainTmpl->set('menu', $menu);