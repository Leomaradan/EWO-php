<?php

namespace jeu\carte;

use conf\ConnecteurDAO as ConnecteurDAO;

class Carte
{
    private $_id;
    private $_nom;
    private $_date;

    public $conn;

    private $_x_min;
    private $_x_max;
    private $_y_min;
    private $_y_max;

    private $_ratio_hor;
    private $_ratio_ver;
    private $_taille_hor;
    private $_taille_ver;

    private $_persos = array();
    private $_boucliers = array();
    private $_portes = array();
    private $_viseurs = array();

    private $_popup = array();

    private $_couleurs = array();

    public function __construct($id, ConnecteurDAO $conn, $ratio_horizontale, $ratio_verticale = null)
    {
        if (!isset($ratio_verticale)) {
            $ratio_verticale = $ratio_horizontale;
        }

        $info = $conn->selectInfosCarte($id);
        $this->conn = $conn;

        $this->_x_min = $info['visible_x_min'];
        $this->_x_max = $info['visible_x_max'];
        $this->_y_min = $info['visible_y_min'];
        $this->_y_max = $info['visible_y_max'];

        $this->_ratio_hor = $ratio_horizontale;
        $this->_ratio_ver = $ratio_verticale;

        $this->_taille_hor = ($this->_x_max - $this->_x_min) * $this->_ratio_hor;
        $this->_taille_ver = ($this->_y_max - $this->_y_min) * $this->_ratio_ver;

        $this->_id = $id;
        $this->_nom = $info['nom'];
        $this->_date = time();

        $this->_couleurs['base'] = 'noir';
        $this->_couleurs['races'][1] = 'humain';
        $this->_couleurs['races'][2] = 'paria';
        $this->_couleurs['races'][3] = 'ange';
        $this->_couleurs['races'][4] = 'demon';
    }

    public function fond($fond = 'fond_terre', $img = null)
    {
        if (isset($img)) {
            return SVG::image(0, 0, $this->_taille_ver, $this->_taille_hor, $img);
        }
        return SVG::rectangle(0, 0, $this->_taille_ver, $this->_taille_hor, array('class' => $fond));
    }

    public function header()
    {
        header("Content-type: image/svg+xml");
    }

    public function start()
    {
        return SVG::Header($this->_nom, $this->_taille_hor, $this->_taille_ver, $this->_date);
    }

    public function footer()
    {
        return SVG::Footer();
    }

    public function coordX($x)
    {
        return (($x - 1 - $this->_x_min)) * $this->_ratio_hor;
    }

    public function coordY($y)
    {
        return (($this->_y_max - $this->_y_min) - ($y - $this->_y_min)) * $this->_ratio_ver;
    }

    public function axeHorizontale($position)
    {
        $retour = SVG::rectangle(0, $this->coordY($position) - round($this->_ratio_ver / 2), 1, $this->_taille_hor, array('class' => 'axe'));
        $retour .= SVG::texte($this->coordX($this->_x_min) + 15, $this->coordY($position + 2), 'Y=' . $position);
        $retour .= SVG::texte($this->coordX($this->_x_max) - 40, $this->coordY($position + 2), 'Y=' . $position);
        return $retour;
    }

    public function axeVerticale($position)
    {
        $retour = SVG::rectangle($this->coordX($position) + round($this->_ratio_hor / 2), 0, $this->_taille_ver, 1, array('class' => 'axe'));
        $retour .= SVG::texte($this->coordX($position + 2), $this->coordY($this->_y_min) - 5, 'X=' . $position);
        $retour .= SVG::texte($this->coordX($position + 2), $this->coordY($this->_y_max) + 20, 'X=' . $position);
        return $retour;
    }

    public function boucliers()
    {
        $boucliers = $this->conn->selectBoucliersFromDamier($this->_id, $this->_x_min, $this->_x_max, $this->_y_min, $this->_y_max);

        foreach ($boucliers as $bouclier) {
            $this->addBouclier($bouclier['pos_x'], $bouclier['pos_y'], $bouclier['type_id'], $bouclier['id'], $bouclier['nom']);
        }
    }

    public function portes()
    {
        $portes = $this->conn->selectPortesFromDamier($this->_id, $this->_x_min, $this->_x_max, $this->_y_min, $this->_y_max);

        foreach ($portes as $porte) {
            $this->addPorte($porte['pos_x'], $porte['pos_y'], $porte['id'], $porte['nom']);
        }
    }

    public function persos()
    {
        $persos = $this->conn->selectPersosFromDamier($this->_id, $this->_x_min, $this->_x_max, $this->_y_min, $this->_y_max);

        foreach ($persos as $perso) {
            $camp = $perso['camp_id'];

            if (isset($this->_couleurs['races'][$camp])) {
                $couleur = $this->_couleurs['races'][$camp];
            } else {
                $couleur = $this->_couleurs['base'];
            }
            $this->addPerso($perso['pos_x'], $perso['pos_y'], $couleur, $perso['grade_id'], $perso['perso_id']);
        }
    }

    public function viseurs($persos)
    {
        $nb_perso =  $persos['inc'];

        for ($inc = 1; $inc <= $nb_perso; $inc++) {
            $mat = $persos['id'][$inc];
            if (isset($this->_persos[$mat])) {
                $x = $this->_persos[$mat]['x'];
                $y = $this->_persos[$mat]['y'];
                $this->addViseur($x, $y, $persos['nom'][$inc]);
            }
        }
    }

    public function compile()
    {

        $retour = '';
        $camp = null;

        // Persos
        foreach ($this->_persos as $id => $perso) {
            if ($camp && $camp != $perso['camp']) {
                $retour .= '</g><g class="' . $perso['camp'] . '">';
            } elseif (!$camp) {
                $retour .= '<g class="' . $perso['camp'] . '">';
            }
            $camp = $perso['camp'];
            $retour .= $this->printPerso($id, true);
            //$retour .= '</g>';
        }
        if ($retour != '') {
            $retour .= '</g>';
        }

        // Boucliers
        $retour .= '<g class="bouclier">';
        foreach ($this->_boucliers as $id => $bouclier) {
            $retour .= $this->printBouclier($id);
        }
        $retour .= '</g>';

        // Portes
        $retour .= '<g class="porte">';
        foreach ($this->_portes as $id => $porte) {
            $retour .= $this->printPorte($id);
        }
        $retour .= '</g>';

        // Viseurs
        $retour .= '<g class="viseurs">';
        foreach ($this->_viseurs as $id => $viseur) {
            $retour .= $this->printViseur($id);
        }
        $retour .= '</g>';

        // Popups
        $retour .= '<g class="noir">';
        foreach ($this->_popup as $popup) {
            $retour .= $this->printPopup($popup);
        }
        $retour .= '</g>';

        return $retour;
    }

    public function addViseur($x, $y, $info)
    {
        $this->_viseurs[] = array(
            'x' => $x,
            'y' => $y,
            'nom' => $info
        );
        //echo "$x $y $info";
    }

    public function printViseur($id)
    {
        $viseur = $this->_viseurs[$id];

        /*$max_width = $this->_ratio_ver*0.7;
        $max_height = $this->_ratio_hor*0.7;
        $max_circ = max(min($this->_ratio_ver*5, 20),3);*/

        $res = SVG::ligne(
            $this->coord_x($viseur['x'] + 0.5) - 15,
            $this->coord_y($viseur['y'] - 0.5),
            $this->coord_x($viseur['x'] + 0.5) + 15,
            $this->coord_y($viseur['y'] - 0.5)
        );

        $res .= SVG::ligne(
            $this->coord_x($viseur['x'] + 0.5),
            $this->coord_y($viseur['y'] - 0.5) - 15,
            $this->coord_x($viseur['x'] + 0.5),
            $this->coord_y($viseur['y'] - 0.5) + 15
        );

        $res .= SVG::cercle($this->coord_x($viseur['x'] + 0.5), $this->coord_y($viseur['y'] - 0.5), 20, array('id' => md5($viseur['nom'])));

        if (($this->coord_y($viseur['y'] - 0.5) - 20) < 3) {
            $this->_popup[] = array($this->coord_x($viseur['x'] + 0.5), $this->coord_y($viseur['y'] - 0.5) + 30, md5($viseur['nom']), $viseur['nom']);
        } else {
            $this->_popup[] = array($this->coord_x($viseur['x'] + 0.5), $this->coord_y($viseur['y'] - 0.5) - 20, md5($viseur['nom']), $viseur['nom']);
        }

        return $res;
    }

    public function printPopup($popup)
    {
        return SVG::popup($popup[0], $popup[1], $popup[2], $popup[3]);
    }

    public function addPerso($x, $y, $camp, $grade, $id)
    {
        $this->_persos[$id] = array(
            'x' => $x,
            'y' => $y,
            'grade' => $grade,
            'camp' => $camp
        );
    }

    private function printPerso($id)
    {
        $perso = $this->_persos[$id];

        return SVG::rectangle($this->coord_x($perso['x']), $this->coord_y($perso['y']), $this->_ratio_ver, $this->_ratio_hor, array('class' => 'g' . $perso['grade'], 'id' => 'perso_' . $perso['x'] . '_' . $perso['y']));
    }

    public function addBouclier($x, $y, $taille, $id, $nom)
    {
        $this->_boucliers[$id] = array(
            'x' => $x,
            'y' => $y,
            'taille' => $taille,
            'nom' => $nom
        );
    }

    public function printBouclier($id)
    {
        $bouclier = $this->_boucliers[$id];

        $this->_popup[] = array($this->coord_x($bouclier['x'] + 0.5), $this->coord_y($bouclier['y'] - 0.5) - 35, 'bouclier_' . $id, 'Bouclier');

        return SVG::rectangle(
            $this->coord_x($bouclier['x']),
            $this->coord_y($bouclier['y']),
            $this->_ratio_ver * $bouclier['taille'],
            $this->_ratio_hor * $bouclier['taille'],
            //array('class' => 'bouclier', 'id' => 'bouclier_'.$id, 'onmouseover' => 'affiche_bouclier(this)'));
                                array('class' => 'bouclier', 'id' => 'bouclier_' . $id)
        );
    }

    public function addPorte($x, $y, $id, $nom)
    {
        $this->_portes[$id] = array(
            'x' => $x,
            'y' => $y,
            'nom' => $nom
        );
    }

    public function printPorte($id)
    {
        $porte = $this->_portes[$id];

        $this->_popup[] = array($this->coord_x($porte['x'] + 0.5), $this->coord_y($porte['y'] - 0.5) - 20, 'porte_' . $id, 'Porte');

        return SVG::rectangle(
            $this->coord_x($porte['x']),
            $this->coord_y($porte['y']),
            $this->_ratio_ver * 4,
            $this->_ratio_hor * 4,
            array('class' => 'porte', 'id' => 'porte_' . $id)
        );
    }

    public function serializer()
    {
        $this->conn = null;
        return serialize($this);
    }

    public static function deserializer($data, $conn)
    {
        $carte = unserialize($data);
        $carte->conn = $conn;
        return $carte;
    }
}
