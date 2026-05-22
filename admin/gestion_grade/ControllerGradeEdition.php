<?php

session_start();
$root_url = "./../..";
//-- Header --
include($root_url . "/conf/master.php");
/*-- Connexion at ou admin requise --*/
ControleAcces('admin', 1);
/*-----------------------------*/

// Param�tres de connexion � la base de donn�es
$ewo_bdd = bdd_connect('ewo');
// D�claration de la variable temporaire d'erreur
$_SESSION['temp']['erreurs'] = "";
// Mise sous variables des donn�es r�cup�r�es
if (!isset($_GET['suppr_grade'])) {
    $grade_a_creer = mysqli_real_escape_string($ewo_bdd, $_POST['grade_a_creer']);
    $description_du_grade = mysqli_real_escape_string($ewo_bdd, $_POST['description_du_grade']);
    $id_camp = mysqli_real_escape_string($ewo_bdd, $_POST['id_camp']);
    $color = mysqli_real_escape_string($ewo_bdd, $_POST['couleur']);
    $new_grade_id = mysqli_real_escape_string($ewo_bdd, $_POST['new_grade_id']);
    $new_race_id = mysqli_real_escape_string($ewo_bdd, $_POST['new_race_id']);
}

// Cas d'une �dition de grade
if (isset($_POST['editGrade'])) {
    $id_grade = mysqli_real_escape_string($ewo_bdd, $_POST['id_grade']);
    $id_race  = mysqli_real_escape_string($ewo_bdd, $_POST['id_race']);
    $requete_edition = mysqli_query($ewo_bdd, "UPDATE `races` 
										SET `camp_id` = '$id_camp',
											`nom` = '$grade_a_creer',
											`race_id` = '$new_race_id',
											`description` = '$description_du_grade', 
											`grade_id` = '$new_grade_id',
											`color`= '$color'
										WHERE `races`.`grade_id` = '$id_grade' AND `races`.`race_id` = '$id_race'; 
									");

    if ($requete_edition == false) {
        $msg_error = "Echec de la maj.";
    } else {
        $msg_error = "maj r&eacute;ussi.";
    }
    $_SESSION['temp']['erreurs'] = $msg_error;


    echo '<script language="javascript" type="text/javascript" >document.location="gestion_grade.php";</script>';
}

// Cas d'une cr�ation de grade
if (isset($_POST['creer_grade'])) {
// On v�rifie que le grade n'est pas d�j� cr��
    $verif_grade_existe = mysqli_query($ewo_bdd, "SELECT nom FROM `races` WHERE nom = '$grade_a_creer'");
    if (mysqli_fetch_row($verif_grade_existe)) {
        $msg_error = "Ce nom de grade semble d�j� exister dans la base. V�rifier et/ou recommencer.";

        $_SESSION['temp']['erreurs'] = $msg_error;
        echo '<script language="javascript" type="text/javascript" >document.location=="gestion_grade.php"</script>';
    } else {
        $requete_creation = mysqli_query($ewo_bdd, "INSERT INTO `races` ( `id`, `race_id`, `grade_id`, `color`, `camp_id` , `nom` , `description`) 
												VALUES('', '$new_race_id', '$new_grade_id', '$color', '$id_camp', '$grade_a_creer', '$description_du_grade')
										") or die(mysqli_error($ewo_bdd));

        if ($requete_creation == false) {
            $msg_error = "Echec lors de la cr&eacute;ation";
        } else {
            $msg_error = "Cr&eacute;ation r&eacute;ussie.";
        }
        $_SESSION['temp']['erreurs'] = $msg_error;

        echo '<script language="javascript" type="text/javascript" >document.location="gestion_grade.php"</script>' ;
    }
}

// Cas d'une suppression
if (isset($_GET['suppr_grade'])) {
    $suppr_grade = $_GET['suppr_grade'];
    $suppr_race = $_GET['race_id'];

    $requette_suppression = mysqli_query($ewo_bdd, "DELETE FROM `races` WHERE `races`.`grade_id` = '$suppr_grade' AND `races`.`race_id` = '$suppr_race'") or die(mysqli_error($ewo_bdd));

    if ($requette_suppression == false) {
        $msg_error = "Echec lors de la suppression";
    } else {
        $msg_error = "Suppression r&eacute;ussie.";
    }
    $_SESSION['temp']['erreurs'] = $msg_error;

    echo '<script language="javascript" type="text/javascript" >document.location="gestion_grade.php"</script>' ;
}
