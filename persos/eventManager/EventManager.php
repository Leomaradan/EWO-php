<?php

/* Auteur: Nybbas
 * Date: 08.04.2010
 * Classe de gestion pour la création d'evenements
 */

namespace persos\eventManager;

class EventManager
{
    private $debug = false;
    private $bdd = null;
    private $events = array();
    private $date = null;

    public function __construct($debug = false)
    {
        $this->debug = $debug;
        $this->date = date('Y-m-d H:i:s');
        $this->bdd = bdd_connect('ewo');
        if (!$this->bdd) {
            throw new Exception('Instanciation du gestionnaire sans base de donnees');
        }
    }

    public function __destruct()
    {
        $this->commit();
        //mysqli_close($this->bdd);
        unset($this->bdd);
    }

    //inscrit tous les events dans la base
    private function commit()
    {
        $sql = '';
        foreach ($this->events as $event) {
            if ($this->debug) {
                echo 'SQL = ' . $event->sql($this->bdd) . '<br/>';
                $event->setID($event->getSrc() + 10);
            } else {
                $result = mysqli_query($conn, $event->sql($this->bdd), $this->bdd);
                // id courant de l'event
                $last_id = mysql_insert_id($this->bdd);
                if ($event->getMaster() == null) {
                    mysqli_query($conn, "UPDATE evenements SET id_event = $last_id WHERE id = $last_id", $this->bdd);
                }
                $event->setID($last_id);
            }
        }
        unset($this->events);
    }

    public function createEvent($name = 'basic')
    {

        $ref = new \persos\eventManager\event($this->date, $name);

        $this->events[] = $ref;

        return $ref;
    }
    public function addToCV($perso_id, $mat_vic, $nom_vic, $type = 0, $plan = 1)
    {
        if (is_numeric($perso_id) && is_numeric($mat_vic) && is_numeric($plan)) {
            switch ($type) {
                case 'sort':
                    $type = 1;
                    break;
                default:    //attaque par defaut
                    $type = 0;
                    break;
            }

            $sql            = "SELECT nom FROM cartes WHERE id = $plan";
            $result         = mysqli_query($conn, $sql, $this->bdd) or die(mysqli_error($conn));
            $plan_nom       = mysql_fetch_array($result, MYSQL_NUM);
            mysql_free_result($result);


            $nom_vic = mysqli_real_escape_string($conn, htmlentities($nom_vic, ENT_QUOTES, 'UTF-8'), $this->bdd);
            $plan = mysqli_real_escape_string($conn, htmlentities($plan, ENT_QUOTES, 'UTF-8'), $this->bdd);
            $sql = "INSERT INTO `ewo`.`morgue` (`id`, `id_perso`, `nom_perso`, `race_perso`, `nom_race_perso`, `grade_perso`, `date`, `type`, `mat_victime`, `nom_victime`, `race_victime`, `nom_race_victime`, `grade_victime`, `plan_victime`)
			VALUES (NULL, $perso_id, '', 0, null, 0, '" . $this->date . "', $type, $mat_vic, '$nom_vic', 0, null, 0, '$plan_nom[0]')";
            if ($this->debug) {
                echo 'SQL = ' . $sql . '<br/>';
            } else {
                $result = mysqli_query($conn, $sql, $this->bdd);
            }
            $sql = "UPDATE `morgue`, `persos` tueur, `persos` victime
				SET
				`morgue`.`nom_perso`= tueur.`nom`,
				`morgue`.`race_perso`= tueur.`race_id`,
                                `morgue`.`nom_race_perso`= tueur.`nom_race`,
				`morgue`.`grade_perso`= tueur.`grade_id`,
				`morgue`.`race_victime`= victime.`race_id`,
                                `morgue`.`nom_race_victime`= victime.`nom_race`,
				`morgue`.`grade_victime`= victime.`grade_id`
				WHERE `morgue`.`mat_victime`=victime.`id` AND
				`morgue`.`id_perso`=tueur.`id` AND
				`morgue`.`date` = '" . $this->date . "'";
            mysqli_query($conn, $sql, $this->bdd);
        }
    }
}
