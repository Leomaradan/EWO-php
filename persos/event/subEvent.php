<?php

use persos\eventManager\EventFormatter as EventFormatter;

require __DIR__ . '/../../conf/master.php';

/*-- Connexion requise --*/
if (ControleAcces('utilisateur', 0) == false) {
    echo "null";
    exit;
} else {
    if (isset($_GET['key']) && $_GET['key'] != '' && isset($_GET['mat']) && is_numeric($_GET['mat'])) {
        $mat = $_GET['mat'];
        $key = urldecode($_GET['key']);

        $bdd = bdd_connect('ewo');
        $events = EventFormatter::getSubEvents($bdd, $key, $mat);
        $subevents = array();
        foreach ($events as $event) {
            $format = $event->getType();
            $subevents['bg'][] = $format->getBackground();
            $subevents['ct'][] = EventFormatter::printEvent($bdd, $event, $format, $event->getID());
        }

        mysqli_close($bdd);
        header('Cache-Control: no-cache, must-revalidate');
        header('Content-type: application/json');
        echo json_encode($subevents);
    }
}
