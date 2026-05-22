<?php

//-- Fonction de surveillance

function surveillance($id_perso, $message)
{
    $admin_id = $_SESSION['utilisateur']['id'];
    mysqli_query($conn, "INSERT INTO logs_admin (perso_id, admin_id, message, date) VALUES ('$id_perso', '$admin_id', '$message', CURRENT_TIMESTAMP())") or die(mysqli_error($conn));
}
