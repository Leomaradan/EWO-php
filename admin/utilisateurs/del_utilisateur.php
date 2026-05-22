<?php

require_once __DIR__ . '/../../conf/master.php';
/*-- Connexion at ou admin requise --*/
ControleAcces('admin', 1);
/*-----------------------------*/

if ((!empty($_POST['id_utilisateur'])) && ($_POST['supprimer'] == "supp")) {
//-- Paramètres de connexion à la base de données
    bdd_connect('ewo');
    $id_utilisateur = mysqli_real_escape_string($conn, $_POST['id_utilisateur']);
//-- Liste des ID des personnages
    $sql = "SELECT id FROM persos WHERE utilisateur_id = '$id_utilisateur'";
    $resultat = mysqli_query($conn, $sql) or die(mysqli_error($conn));
    while ($persos = mysql_fetch_array($resultat)) {
    //-- Supression dans : REPERTOIRE > perso_id, contact_id
            mysqli_query($conn, "DELETE FROM repertoire WHERE perso_id = '" . $persos['id'] . "'") or die(mysqli_error($conn));
        mysqli_query($conn, "DELETE FROM repertoire WHERE contact_id = '" . $persos['id'] . "'") or die(mysqli_error($conn));

        //-- Supression dans : PERSOS > id
            mysqli_query($conn, "DELETE FROM persos WHERE id = '" . $persos['id'] . "'") or die(mysqli_error($conn));

        //-- Supression dans : LOGS_ADMIN > perso_id
            mysqli_query($conn, "DELETE FROM logs_admin WHERE perso_id = '" . $persos['id'] . "'") or die(mysqli_error($conn));

        //-- Supression dans : INVENTAIRE > perso_id
            mysqli_query($conn, "DELETE FROM inventaire WHERE perso_id = '" . $persos['id'] . "'") or die(mysqli_error($conn));

        //-- Supression dans : FACTION_MEMBRES > perso_id
        mysqli_query($conn, "DELETE FROM faction_membres WHERE perso_id = '" . $persos['id'] . "'") or die(mysqli_error($conn));

        //-- Supression dans : EVENEMENT > perso_id
        mysqli_query($conn, "DELETE FROM evenement WHERE perso_id = '" . $persos['id'] . "'") or die(mysqli_error($conn));

        //-- Supression dans : DAMIER_PERSOS > perso_id
        mysqli_query($conn, "DELETE FROM damier_persos WHERE perso_id = '" . $persos['id'] . "'") or die(mysqli_error($conn));

        //-- Supression dans : CARACS_ALTER_PLAN > perso_id
        mysqli_query($conn, "DELETE FROM caracs_alter_plan WHERE perso_id = '" . $persos['id'] . "'") or die(mysqli_error($conn));

        //-- Supression dans : CARACS_ALTER_MAG > perso_id
        mysqli_query($conn, "DELETE FROM caracs_alter_mag WHERE perso_id = '" . $persos['id'] . "'") or die(mysqli_error($conn));

        //-- Supression dans : CARACS_ALTER > perso_id
        mysqli_query($conn, "DELETE FROM caracs_alter WHERE perso_id = '" . $persos['id'] . "'") or die(mysqli_error($conn));

        //-- Supression dans : CARACS > perso_id
        mysqli_query($conn, "DELETE FROM caracs  WHERE perso_id = '" . $persos['id'] . "'") or die(mysqli_error($conn));

        //-- Supression dans : BALS > perso_src_id
        mysqli_query($conn, "DELETE FROM bals WHERE perso_src_id = '" . $persos['id'] . "'") or die(mysqli_error($conn));
    }

    //---- SUPPRESSION DES DONNEES UTILISATEUR

//-- Suppression dans : UTILISATEUR > id et UTILISATEUR_BAN > utilisateur_id
    mysqli_query($conn, "DELETE FROM utilisateurs WHERE id='$id_utilisateur'") or die(mysqli_error($conn));
    mysqli_query($conn, "DELETE FROM utilisateurs_ban WHERE utilisateur_id='$id_utilisateur'") or die(mysqli_error($conn));
//-- Supression dans : LOGS > utilisateur_id
    mysqli_query($conn, "DELETE FROM logs WHERE utilisateur_id = '$id_utilisateur'") or die(mysqli_error($conn));

    mysqli_close();
        $titre = "Suppression";
    $text = "Suppression total de l'utilisateur et de ses personnages effectué'.";
    $lien = "./../..";
    gestion_erreur($titre, $text, $lien);
}
