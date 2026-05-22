<?php

namespace persos\eventManager;

class Tools
{
    protected static function checkPrivate($mat)
    {
        $persos = (isset($_SESSION['persos']['id'])) ? $_SESSION['persos']['id'] : array();
        if (isset($persos[0])) {
            unset($persos[0]);
        }
        if (in_array($mat, $persos)) {
            $_SESSION['persos']['priv_id'] = $_SESSION['persos']['id'][array_search($mat, $persos)];
            return true;
        } else {
            return false;
        }
    }

    protected static function chkSrc($src, $dst)
    {
        if (isset($_SESSION['persos']['current_id']) && $_SESSION['persos']['current_id'] == $src) {
            return true;
        } elseif (isset($_SESSION['persos']['current_id']) && $_SESSION['persos']['current_id'] == $dst) {
            return false;
        } elseif (isset($_SESSION['persos']['priv_id']) && $_SESSION['persos']['priv_id'] == $src) {
            return true;
        } elseif (isset($_SESSION['persos']['priv_id']) && $_SESSION['persos']['priv_id'] == $dst) {
            return false;
        } else {
            return null;
        }
    }
}
