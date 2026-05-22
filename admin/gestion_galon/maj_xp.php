<?php

//-- Header --
$root_url = "./../..";
include($root_url . "/template/header_new.php");
//------------

/*-- Connexion basic requise --*/
if (Controle('admin') != true) {
    echo "<script language='javascript' type='text/javascript' >document.location='./../'</script>";
    exit;
}
/*-----------------------------*/

if ((isset($_POST['icone_id'])) and (isset($_POST['px']))) {
    $xp = $_POST['px'];
    $xp_max = $_POST['px_max'];
    $icone_id = $_POST['icone_id'];

    mysqli_query($conn, "UPDATE icone_galons SET xp_min = '$xp', xp_max = '$xp_max' WHERE id = '$icone_id'");

    echo "<script language='javascript' type='text/javascript' >document.location='" . $_SERVER['HTTP_REFERER'] . "'</script>";
    exit;
} else {
        echo "<h2>Modfication de l'xp du perso</h2><p align='center'>Vous n'etes pas autoriser a effectuer cette action.</p><p align='center'>[<a href='" . $_SERVER['HTTP_REFERER'] . "'>Retour</a>]</p>";
//-- Footer --
    include($root_url . "/template/footer_new.php");
//------------
}
