<?php
/**
 * Created by PhpStorm.
 * User: tarvi.liivak
 * Date: 2.02.2018
 * Time: 8:57
 */

class mysql
{
 // klassi väljad
    var $conn = false; // ühendus db serveriga
    var $host = false; // db server
    var $user = false; // db serveri kasutaja
    var $pass = false; // db server kasutaja parool
    var $dbname = false;

    /**
     * mysql constructor.
     * @param bool $host
     * @param bool $user
     * @param bool $pass
     * @param bool $dbname
     */
    public function __construct($host, $user, $pass, $dbname)

        $this->host = $host;
        $this->user = $user;
        $this->pass = $pass;
        $this->dbname = $dbname;
        $this->connect();
    {
        $this->host = $host;
        $this->user = $user;
        $this->pass = $pass;
        $this->dbname = $dbname;
    } // db nimi, mis on kasutusel

    function $connect($host, $user, $pass, $dbname) {
        $this->conn = mysqli_connect($host, $user, $pass, $dbname);
        if(!$this->conn){
            echo 'Probleem andmebaasi ühendusega <br/>';
            exit;

}
}

}