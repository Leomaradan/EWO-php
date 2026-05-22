<?php

/**
 * Class de log
 *
 * Classe abtraite qui définir le comportement d'un logger d'AT
 * @author Herbomez Benjamin <benjamin.herbomez@gmail.com>
 * @version 1.0
 * @package antitriche
 */

namespace at;

use conf\ConnecteurDAO;

require_once __DIR__ . '/../../../conf/master.php';

define('DEBUG', true);

abstract class Logger
{
    public function __construct()
    {
    }

    /*
         * id       : id du peros qui subit l'aciton
     */
    public function log($id)
    {
        $conn = ConnecteurDAO::getInstance();
        $sql    = 'INSERT INTO `at_log` (compte,date) VALUES(:compte,NOW());';
        $conn->prepare($sql);
        $conn->executePreparedStatement(null, array(":compte" => $id));
        return $conn->lastId();
    }
}
