<?php

/**
 * Configuration
 *
 *  Configuration des informations de base de donnée
 *
 * @author Simonet Fabrice <aigleblanc@ewo.fr>
 * @version 1.0
 * @package conf
 */

if (!defined("CONNECT.CONF")) {
    define("CONNECT.CONF", true);




/**
 * Connecteur de base de donnée
 */
    function bdd_connect($bdd)
    {

        $conf = info_connect($bdd);
        $connect = mysqli_connect($conf['serveur'], $conf['user'], $conf['pass']);
        mysqli_select_db($connect, $conf['bdd']);
        mysqli_set_charset($connect, 'utf8');
        return $connect;
    }

/**
 * Info de connexion pour les bases de données
 *
 * Rajouter autant de configuration que voulue ^^
 *
 */
    function info_connect($i)
    {
        if ($i == "ewo") {
            $conf['serveur'] = "mysql";
            $conf['user'] = "root";
            $conf['pass'] = "root";
            $conf['bdd'] = "ewo";
        } elseif ($i == "forum") {
            $conf['serveur'] = "mysql";
            $conf['user'] = "root";
            $conf['pass'] = "root";
            $conf['bdd'] = "ewo_forum";
        } elseif ($i == "blog") {
            $conf['serveur'] = "mysql";
            $conf['user'] = "root";
            $conf['pass'] = "root";
            $conf['bdd'] = "ewo_blog";
        } elseif ($i == "forum_vf") {
            $conf['serveur'] = "mysql";
            $conf['user'] = "root";
            $conf['pass'] = "root";
            $conf['bdd'] = "ewo_forum";
        }
        return $conf;
    }
}
