<?php

namespace persos\eventManager\formatter;

include_once('formatter.php');
class Vacances extends Formatter
{
    private $backg = 'background-color:#FFFFFF;';

    public function printPublic(&$bdd)
    {
        switch (parent::getEvent()->getState()) {
            case '1':
                return 's\'appr&ecirc;te &agrave; partir en Vacances';
            break;
            case '2':
                return 'est parti(e) en Vacances';
            break;
            case '3':
                return 'est revenu(e) de Vacances';
            break;
            default:
                return '';
        }
    }

    public function printPrivate(&$bdd)
    {
        if (parent::getEvent()->getState() == '3') {
            $private = parent::getEvent()->infos->getPrivateInfos();
            return 'Vos gains: ' . $private['xp'] . ' XP';
        } else {
            return '';
        }
    }
    public function getBackground()
    {
        return '#ACDCCC';
    }
}
