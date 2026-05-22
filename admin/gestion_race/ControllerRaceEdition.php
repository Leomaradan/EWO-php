<?php

session_start();
//-- Header --
$root_url = "./../..";
include($root_url . "/conf/master.php");
/*-- Connexion at ou admin requise --*/
ControleAcces('admin', 1);
/*-----------------------------*/

// Param�tres de connexion � la base de donn�es
$ewo = bdd_connect('ewo');
// D�claration de la variable temporaire d'erreur
$_SESSION['temp']['erreurs'] = "";
// Mise sous variables des donn�es r�cup�r�es
if (isset($_POST['id_race'])) {
    $id_race = mysqli_real_escape_string($conn, $_POST['id_race']);
}
if (isset($_POST['race_a_creer'])) {
    $race_a_creer = mysqli_real_escape_string($conn, $_POST['race_a_creer']);
}
if (isset($_POST['description_de_la_race'])) {
    $description_de_la_race = mysqli_real_escape_string($conn, $_POST['description_de_la_race']);
}
if (isset($_POST['id_camp'])) {
    $id_camp = mysqli_real_escape_string($conn, $_POST['id_camp']);
}
if (isset($_POST['couleur'])) {
    $couleur = mysqli_real_escape_string($conn, $_POST['couleur']);
}
if (isset($_POST['type'])) {
    $type = mysqli_real_escape_string($conn, $_POST['type']);
} else {
    $type = 3;
}

// Cas d'une �dition de race
if (isset($_POST['editRace'])) {
    $requete_edition = mysqli_query($conn, "UPDATE races SET type = $type, camp_id='$id_camp', nom='$race_a_creer', description='$description_de_la_race', color='$couleur' WHERE race_id= '$id_race' AND grade_id='-2'");
    $requete_edition = mysqli_query($conn, "UPDATE races SET type = $type, camp_id='$id_camp', description='$description_de_la_race', color='$couleur' WHERE race_id= '$id_race' AND grade_id!='-2'");
    $requete_edition = mysqli_query($conn, "UPDATE races SET type = $type, camp_id='$id_camp', nom='Tricheur', description='$description_de_la_race', color='#E90086' WHERE race_id= '$id_race' AND grade_id='-1'");

    if ($requete_edition == false) {
        $msg_error = "Echec de la maj.";
    } else {
        $msg_error = "maj r&eacute;ussi.";
    }
    $_SESSION['temp']['erreurs'] = $msg_error;


    echo '<script language="javascript" type="text/javascript" >document.location="index.php?page=gestion_race&edit_race=' . $id_race . '"</script>';
}

// Cas d'une cr�ation de race
if (isset($_POST['creer_race'])) {
// On v�rifie que la race n'est pas d�j� cr��e
    $verif_race_existe = mysqli_query($conn, "SELECT nom FROM races WHERE nom='$race_a_creer'") or die(mysqli_error($conn));
    if (mysqli_fetch_row($verif_race_existe)) {
        $msg_error = "Ce nom de race semble d�j� exister dans la base. V�rifier et/ou recommencer.";

        $_SESSION['temp']['erreurs'] = $msg_error;
        echo '<script language="javascript" type="text/javascript" >document.location="index.php?page=gestion_race"</script>';
    } else {
        $requete_creation = mysqli_query($conn, "SELECT MAX(race_id) FROM races") or die(mysqli_error($conn));
        $reponse = mysql_fetch_array($requete_creation);
        $id_race = $reponse[0] + 1;
        for ($inc = -2; $inc <= 5; $inc++) {
            $requete_creation = mysqli_query($conn, "INSERT INTO races (id, race_id, grade_id, camp_id, nom, description, color, type) VALUES('', '$id_race', '$inc','$id_camp', '$race_a_creer', '$description_de_la_race', '$couleur', '$type')") or die(mysqli_error($conn));
        }
        $requete_creation = mysqli_query($conn, "UPDATE races SET camp_id='$id_camp', nom='Tricheur', description='$description_de_la_race', color='#E90086' WHERE race_id= '$id_race' AND grade_id='-1'") or die(mysqli_error($conn));

        if ($requete_creation == false) {
            $msg_error = "Echec lors de la cr&eacute;ation";
        } else {
            $msg_error = "Cr&eacute;ation r&eacute;ussie.";
        }
        $_SESSION['temp']['erreurs'] = $msg_error;

        echo '<script language="javascript" type="text/javascript" >document.location="index.php?page=gestion_race"</script>';
    }
}

// Cas d'une suppression
if (isset($_GET['suppr_race'])) {
    $suppr_race = mysqli_real_escape_string($conn, $_GET['suppr_race']);

    $requette_suppression = mysqli_query($conn, "DELETE FROM `races` WHERE `races`.`race_id`='$suppr_race'") or die(mysqli_error($conn));

    if ($requette_suppression == false) {
        $msg_error = "Echec lors de la suppression";
    } else {
        $msg_error = "Suppression r&eacute;ussie.";
    }
    $_SESSION['temp']['erreurs'] = $msg_error;

    echo '<script language="javascript" type="text/javascript" >document.location="index.php?page=gestion_race"</script>';
}
