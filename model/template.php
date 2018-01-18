<?php
/**
 * Created by PhpStorm.
 * User: tarvi.liivak
 * Date: 18.01.2018
 * Time: 10:21
 */

class template
{
    // template objekti omadused
    var $file = ''; //html vaade faili nimi
    // html vaade faili sisu, mis on on klassis
    // vastava funktsiooni abil loetud
    var $content = false;
    // reaalsed väärtused html vaade sablooni
    // täitmiseks
    var $vars = array();

}