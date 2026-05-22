<?php

namespace persos\eventManager\formatter;

include_once('formatter.php');

class Suicide extends Formatter
{
    public function printPublic(&$bdd)
    {
        if (parent::getEvent()->getState()) {
            return 's\'est <b>suicid&eacute;(e)</b>';
        } else {
            return 'a lamentablement <u>rat&eacute;</u> son <b>Suicide</b>';
        }
    }
    public function printPrivate(&$bdd)
    {
        if (parent::getEvent()->getState()) {
            $private = parent::getEvent()->infos->getPrivateInfos();
            $nb = ($private['nb'] == 1) ? '&egrave;re' : '&egrave;me';
            return $private['nb'] . '<span style="vertical-align:super;">' . $nb . '</span> fois<br/>XP perdu: ' . $private['xpA'];
        } else {
            return '';
        }
    }
    public function getBackground()
    {
        return '#FF8888';
    }
}
