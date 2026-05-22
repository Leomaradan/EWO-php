<?php

namespace persos;

use conf\ConnecteurDAO as ConnecteurDAO;

class PersosDAO extends ConnecteurDAO
{
    public function selectPersoById($id)
    {
        $this->selectData(array(array('operation' => '=', 'variable' => 'persos.id', 'value' => $id)));
        return $this->fetchAssoc();
    }

    public function selectPersoByName($name)
    {
        $this->selectData(array(array('operation' => 'LIKE', 'variable' => 'persos.nom', 'value' => $name)));
        return $this->fetchAssoc();
    }

    private function selectData($array = null)
    {
        $bind = array();
        $sql = "SELECT persos.id AS id_personnage, persos.nom AS nom_perso, races.color AS couleur, races.nom AS nom_race   
		FROM persos 
		INNER JOIN races 
		ON persos.race_id = races.id WHERE 1=1";
        if ($array) {
            foreach ($array as $ligne) {
                $id = md5($ligne['variable']);
                $sql .= ' AND ' . $ligne['variable'] . ' ' . $ligne['operation'] . ' :' . $id;
                $bind[$id] = $ligne['value'];
            }
        }

        $this->prepare($sql);
        $this->executePreparedStatement(null, $bind);
    }
}
