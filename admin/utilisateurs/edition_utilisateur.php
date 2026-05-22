<?php

require_once __DIR__ . '/../../conf/master.php';
/*-- Connexion basic requise --*/
ControleAcces('admin', 1);
/*-----------------------------*/

//-- Paramètres de connexion à la base de données
bdd_connect('ewo');

$id_utilisateur = mysqli_real_escape_string($conn, $_POST['id_utilisateur']);

$nom = mysqli_real_escape_string($conn, $_POST['nom']);
$mail = mysqli_real_escape_string($conn, $_POST['mail']);
$jabberid = mysqli_real_escape_string($conn, $_POST['jabberid']);

if (isset($_POST['droit1']) && $_POST['droit1'] == 1) {
    $droit1 = mysqli_real_escape_string($conn, $_POST['droit1']);
} else {
    $droit1 = 0;
}

if (isset($_POST['droit2']) && $_POST['droit2'] == 1) {
    $droit2 = mysqli_real_escape_string($conn, $_POST['droit2']);
} else {
    $droit2 = 0;
}

if (isset($_POST['droit3']) && $_POST['droit3'] == 1) {
    $droit3 = mysqli_real_escape_string($conn, $_POST['droit3']);
} else {
    $droit3 = 0;
}

if (isset($_POST['droit4']) && $_POST['droit4'] == 1) {
    $droit4 = mysqli_real_escape_string($conn, $_POST['droit4']);
} else {
    $droit4 = 0;
}

$droits = $droit1 . $droit2 . $droit3 . $droit4;

$options = mysqli_real_escape_string($conn, $_POST['options']);

//------- Requête de mise à jour -----
if (isset($_POST['nom'])) {
    mysqli_query($conn, "UPDATE utilisateurs 
					SET nom = '$nom', 
						email ='$mail', 
						droits = '$droits', 
						options = '$options' 
					WHERE id = '$id_utilisateur'
				") or die(mysqli_error($conn));
}
//---------------------------------------

//mysqli_close();

echo "<script language='javascript' type='text/javascript' >document.location='" . $_SESSION['temps']['page'] . "'</script>";
exit;
