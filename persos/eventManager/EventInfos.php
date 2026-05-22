<?php

namespace persos\eventManager;

class EventInfos
{
    private $private = array();
    private $public = array();

    public function __construct($public, $private)
    {
        if (isset($public) && $public != null) {
            $tmp = unseritab($public);
            if (!is_array($tmp)) {
                $this->public = array();
            } else {
                $this->public = $tmp;
            }
        }

        if (isset($private) && $private != null) {
            $tmp = unseritab($private);
            if (!is_array($tmp)) {
                $this->private = array();
            } else {
                $this->private = $tmp;
            }
        }
    }

    public function addPrivateInfo($key, $value)
    {
        $this->private[$key] = $value;
    }

    public function addPublicInfo($key, $value)
    {
        $this->public[$key] = $value;
    }

    public function getPublicInfos()
    {
        return $this->public;
    }

    public function getPrivateInfos()
    {
        return $this->private;
    }

    public function sql($bdd)
    {
        return "'" . mysqli_real_escape_string($conn, seritab($this->public, $bdd), $bdd) . "','" . mysqli_real_escape_string($conn, seritab($this->private, $bdd), $bdd) . "'";
    }
}
