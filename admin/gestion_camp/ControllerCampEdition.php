<?php
$root_url = "./../..";
//-- Header --
include($root_url . "/conf/master.php");
/*-- Connexion at ou admin requise --*/
ControleAcces('admin', 1);
/*-----------------------------*/

//-- Paramètres de connexion à la base de données
$ewo = bdd_connect('ewo');


// Déclaration de la variable temporaire d'erreur
$_SESSION['temp']['erreurs'] = "";

// Mise sous variables des données récupérées
if (!isset($_POST['creer_camp'])) {
    $id_camp = mysqli_real_escape_string($ewo, $_POST['id_camp']);
}
$camp_a_creer = mysqli_real_escape_string($ewo, $_POST['camp_a_creer']);
$description_du_camp = mysqli_real_escape_string($ewo, $_POST['description_du_camp']);
$id_carte = mysqli_real_escape_string($ewo, $_POST['id_carte']);


// Cas d'une édition de camp
if (isset($_POST['editCamp'])) {
    $requete_edition = mysqli_query($conn, "UPDATE `camps` SET `carte_id` = '$id_carte',`nom` = '$camp_a_creer',`description` = '$description_du_camp'  WHERE `camps`.`id` = '$id_camp'; ");

    if ($requete_edition == false) {
        $msg_error = "Echec de la maj.";
    } else {
        $msg_error = "maj r&eacute;ussi.";
    }
    $_SESSION['temp']['erreurs'] = $msg_error;

    ?>
    <script language="javascript" type="text/javascript" >document.location="index.php?page=gestion_camp&edit_camp=<?php echo $id_camp; ?>";</script>
    <?php
}

// Cas d'une création de camp
if (isset($_POST['creer_camp'])) {
    // On vérifie que le camp n'est pas déjà créé
    $verif_camp_existe = mysqli_query($conn, "SELECT nom FROM `camps` WHERE nom = '$camp_a_creer'");
    if (mysqli_fetch_row($verif_camp_existe)) {
        $msg_error = "Ce nom de camp semble déjà exister dans la base. Vérifiez et/ou recommencez.";

        $_SESSION['temp']['erreurs'] = $msg_error;
        ?>
        <script language="javascript" type="text/javascript" >document.location="index.php?page=gestion_camp"</script>
        <?php
    } else {
        $requete_creation = mysqli_query($conn, "INSERT INTO `camps` ( `id` , `carte_id` , `nom` , `description` ) VALUES('','$id_carte','$camp_a_creer','$description_du_camp')");

        if ($requete_creation == false) {
            $msg_error = "Echec lors de la cr&eacute;ation";
        } else {
            $msg_error = "Cr&eacute;ation r&eacute;ussie.";
        }
        $_SESSION['temp']['erreurs'] = $msg_error;

        ?>
        <script language="javascript" type="text/javascript" >document.location="index.php?page=gestion_camp"</script>
        <?php
    }
}

// Cas d'une suppression
if (isset($_GET['suppr_camp'])) {
    $suppr_camp = $_GET['suppr_camp'];

    $requette_suppression = mysqli_query($conn, "DELETE FROM `camps` WHERE `camps`.`id` = $suppr_camp;");

    if ($requette_suppression == false) {
        $msg_error = "Echec lors de la suppression";
    } else {
        $msg_error = "Suppression r&eacute;ussie.";
    }
    $_SESSION['temp']['erreurs'] = $msg_error;

    ?>
    <script language="javascript" type="text/javascript" >document.location="index.php?page=gestion_camp"</script>
    <?php
}
