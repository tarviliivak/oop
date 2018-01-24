<?php
/**
 * Created by PhpStorm.
 * User: tarvi.liivak
 * Date: 24.01.2018
 * Time: 9:26
 */

class linkobject extends http
{
    // klassi muutujad/väljad
    var $baseLink = false; // põhilink
    var $protocol = 'http://'; // HTTP protokoll
    var $eq = '='; // =
    var $delim = '&amp;'; // &
    /**
     * linkobject constructor.
     */
    public function __construct(){
        // kõigepealt defineerime vajalikud eelandmed
        parent::__construct();
        $this->baseLink = $this->protocol.HTTP_HOST.SCRIPT_NAME;
    }
    // moodustame paarid kujul nimi = väärtus
    // ja ühendame paarid omavahel kujul:
    // nimi1=väärtus1&nimi2=väärtus2 jne
    function addToLink(&$link ,$name, $value){
        if ($link != ''){
            $link = $link.$this->delim;
        }
        $link = $link.fixUrl($name).$this->eq.fixUrl($value);

    }

    // moodustame valmis link kasutades põhilinki
    // ja $this->addToLink funktsiooni abil valmistatud paarid
    // $pairs = array('control'->'login','user'=>'test');
    //getLink($pairs);
    function getLink($add = array()){
        $link = '';
        foreach ($add as $name=>$value){
            $this->addToLink($link, $name, $value);
        }
        if($link != ''){
            $this->baseLink = $this->baseLink.'?'.$link;
        }
        return $this->baseLink;
    }
}