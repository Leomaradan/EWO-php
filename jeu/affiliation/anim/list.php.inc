<?php

/**
 *
 * @author Benjamin Herbomez <benjamin.herbomez@gmail.com>
 */

namespace jeu\affiliation;

$sql = AffiliationDAO::getInstance();
$i = 0;
$j = 5;

echo '

    <h2>Liste des affiliés</h2>
    <table>
        <tr>';

foreach ($sql->getAffiList($_GET['mat']) as $perso) {
    if ($i % $j == 0) {
        echo '<tr>';
    }
    echo '<td style="border-right:0;"><img src="',SERVER_URL,'/images/',icone_persos($perso->id),'" alt="icon perso"/></td>
    <td  style="border-left:0;">
    <a href="',SERVER_URL,'/persos/event/?id=',$perso->id,'">',$perso->nom,'</a>
    (<a href="',SERVER_URL,'/messagerie/index.php?id=',$_GET['mat'],'&dest=',$perso->id,'">',$perso->id,'</a>)</td>';
    if ($i % $j == $j - 1) {
        echo '</tr>';
    }
    ++$i;
}
if ($i % $j == 0) {
    echo '</tr>';
}
echo '</table>';
