<?php

/**
 * Logger de connexion
 *
 * Cette classe a pour but de réaliser le log des connexions au jeu
 * @author Herbomez Benjamin <benjamin.herbomez@gmail.com>
 * @version 1.0
 * @package antitriche
 */

namespace at;

use conf\ConnecteurDAO;

    require_once('Logger.php.inc');



class ConnexionLogger extends Logger
{
    public function __construct()
    {
    }

    /*
         * action   : action réalisée (voir les defines en haut)
        * message  : message (système de parsage des messages, voir le wiki pour plus d'info)
      * id       : id du peros qui subit l'aciton
     */
    public function log($user)
    {

        $conn   = ConnecteurDAO::getInstance();
        $last   = parent::log($user);
        $nav    = addslashes($_SERVER['HTTP_USER_AGENT']);
        $sql    = '
				SELECT id
				FROM  `at_navigateur`
				WHERE descr="' . $nav . '";
			';
        $search = $conn->query($sql);
        if (!($data = $conn->fetch($search, \PDO::FETCH_OBJ))) {
        //On insère
                $sql = '
						INSERT INTO `at_navigateur` (descr)
						VALUES("' . $nav . '");
					';
            $conn->exec($sql);
            $idNav = $conn->lastId();
        } else {
            $idNav = $data->id;
        }

        if (isset($_COOKIE['ewo_a_c_i'])) {
            $c = $_COOKIE['ewo_a_c_i'];
        } else {
            $sql = '
					SELECT cookieId
					FROM `at_log_connexion`
					ORDER BY cookieId DESC
					LIMIT 0,1';
            if ($search = $conn->query($sql)) {
                if ($data = $conn->fetch($search)) {
                    $c = $data->cookieId + 1;
                } else {
                    $c = 0;
                }
            } else {
                $c = 0;
            }
        }



        setcookie('ewo_a_c_i', $c, time() + 31536000) or die('error');
//On enouvelle pour un an

        //$sql    = 'INSERT INTO `at_log_connexion` (id,IP,cookieId,navigateur) VALUES(' . $last . ',\'' . $_SERVER["REMOTE_ADDR"] . '\',' . $c . ',' . $idNav . ');';
        $sql    = 'INSERT INTO `at_log_connexion` (id,IP,cookieId,navigateur) VALUES(:id,:ip,:cookieId,:navigateur)';
        $conn->prepare($sql);
        $conn->executePreparedStatement(null, array(
            ":id" => $last,
            ":ip" => $_SERVER["REMOTE_ADDR"],
            ":cookieId" => $c,
            ":navigateur" => $idNav
        ));
    }
}
