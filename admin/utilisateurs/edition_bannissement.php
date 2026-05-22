<?php

require_once __DIR__ . '/../../conf/master.php';
//-- Paramètres de connexion à la base de données
$conn = bdd_connect('ewo');
/*-- Connexion basic requise --*/
ControleAcces('admin', 1);
/*-----------------------------*/
if (!empty($_POST['ban_fin'])) {
//--------Gestion du bannissement ------

    $ban_date = time();
    $ban_fin = strtotime(mysqli_real_escape_string($conn, $_POST['ban_fin']));
    $ban_motif = mysqli_real_escape_string($conn, $_POST['ban_motif']);
    $id_utilisateur = mysqli_real_escape_string($conn, $_POST['id_utilisateur']);

    if (isset($_POST['ban_check']) && $_POST['ban_check'] == 1) {
        if (isset($_POST['ban_existe']) && $_POST['ban_existe'] == 'existe') {
            mysqli_query($conn, "UPDATE utilisateurs_ban SET date = '$ban_date', date_fin = '$ban_fin', motif = '$ban_motif' WHERE utilisateur_id = '$id_utilisateur'") or die(mysqli_error($conn));
        } else {
            mysqli_query($conn, "INSERT INTO utilisateurs_ban(utilisateur_id, date, date_fin, motif, statut) VALUES ('$id_utilisateur', '$ban_date','$ban_fin','$ban_motif','')") or die(mysqli_error($conn));
        }
    } elseif (!isset($_POST['ban_check']) && $_POST['ban_check'] != 1) {
        mysqli_query($conn, "DELETE FROM utilisateurs_ban WHERE utilisateur_id='$id_utilisateur'") or die(mysqli_error($conn));
    }
//---------------------------------------


//--------Gestion du bannissement pour le forum ------
/*
mysqli_close();

mysql_connect($_FSERVEUR,$_FUSER,$_FPASS);
mysql_select_db($_FBDD);

while($perso_id['id']){
    if (isset($_POST['ban_check']) && $_POST['ban_check'] == 1){
        if (isset($_POST['ban_existe']) && $_POST['ban_existe'] == 'existe'){
            //-- Update ban
            mysqli_query($conn, "UPDATE phpbb_banlist SET ban_start ='$ban_date', ban_end = '$ban_fin', ban_reason = '$ban_motif', ban_give_reason = '$ban_motif'") or die (mysqli_error($conn));
        }else{
            //-- Insert ban
            mysqli_query($conn, "INSERT INTO phpbb_banlist(`ban_id`, `ban_userid`, `ban_ip`, `ban_email`, `ban_start`, `ban_end`, `ban_exclude`, `ban_reason`, `ban_give_reason`) VALUES (NULL, '$perso_id['id']', '', '', '$ban_date', '$ban_fin', '0', '$ban_motif', '$ban_motif')") or die (mysqli_error($conn));
        }
    }elseif(!isset($_POST['ban_check']) && $_POST['ban_check'] != 1){
        //-- Delete ban
        mysqli_query($conn, "DELETE FROM phpbb_banlist  WHERE ban_userid = '$perso_id['id']'") or die (mysqli_error($conn));
    }
}

*/
//---------------------------------------

    mysqli_close();
    echo "<script language='javascript' type='text/javascript' >document.location='" . $_SESSION['temps']['page'] . "'</script>";
    exit;
} else {
    echo "<script language='javascript' type='text/javascript' >document.location='" . $_SESSION['temps']['page'] . "'</script>";
    exit;
}
