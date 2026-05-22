<?php

require_once __DIR__ . '/../conf/master.php';

/*-- Connexion basic requise --*/
ControleAcces('utilisateur', 1);
/*-----------------------------*/

if ((isset($_POST['background'])) and (isset($_POST['id_perso']))) {
    $background = mysqli_real_escape_string($conn, $_POST['background']);
    $id_perso = mysqli_real_escape_string($conn, $_POST['id_perso']);
    $utilisateur_id = $_SESSION['utilisateur']['id'];

    if (id_utilisateur($id_perso, $utilisateur_id) != false) {
        mysqli_query($conn, "UPDATE persos SET background = '$background' WHERE utilisateur_id = '$utilisateur_id' AND id = '$id_perso'");
        $titre = "Modification de votre personnage";
        $text = "Votre background a bien été mis à jour.";
        $lien = "../persos/editer_perso.php?id=" . $id_perso . "";
        gestion_erreur($titre, $text, $lien);
    } else {
        $titre = "Modification de votre personnage";
        $text = "Votre message n'a pu etre mis à jour, ce personnage ne vous appartient pas'.";
        $lien = "/";
        gestion_erreur($titre, $text, $lien);
    }
} else {
    $titre = "Modification de votre personnage";
    $text = "Vous n'êtes pas autorisé à effectuer cette action.";
    $lien = "../persos/editer_perso.php?id=" . $id_perso . "";
    gestion_erreur($titre, $text, $lien);
}
