<?php

namespace persos\eventManager\formatter;

include_once('formatter.php');
class Sprint extends Formatter
{
    private $backg = 'background-color:#FFFFFF;';

    public function printPublic(&$bdd)
    {
        return 'pousse un petit <b>Sprint</b>';
    }

    public function printPrivate(&$bdd)
    {
        $private = parent::getEvent()->infos->getPrivateInfos();
        return 'Vos gains: ' . $private['xp'] . ' XP';
    }
    public function getBackground()
    {
        return '#ACDCCC';
    }
}
