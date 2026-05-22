-- phpMyAdmin SQL Dump
-- version 3.5.0
-- http://www.phpmyadmin.net
--
-- Client: localhost
-- Généré le: Mar 19 Mars 2013 à 13:01
-- Version du serveur: 5.5.23-log
-- Version de PHP: 5.3.10

SET FOREIGN_KEY_CHECKS=0;
SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT=0;
START TRANSACTION;
SET time_zone = "+00:00";

--
-- Base de données: `ewo`
--

-- --------------------------------------------------------

--
-- Structure de la table `action`
--

DROP TABLE IF EXISTS `action`;
CREATE TABLE IF NOT EXISTS `action` (
  `id` mediumint(9) NOT NULL AUTO_INCREMENT,
  `nom` mediumtext COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `cout` int(11) NOT NULL DEFAULT '1' COMMENT 'cout en PA de l''action',
  `cercle_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'cercle auquel est lié cette action defaut = 0',
  `niv` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'niveau de magie requis pour accéder à  cette action',
  `race` tinytext COLLATE utf8_unicode_ci NOT NULL COMMENT 'race pouvant realiser cette action. 1000 pour les humains, 0100 pour les parias, 1100 pour humain et paria etc ...',
  `grade` smallint(6) NOT NULL DEFAULT '-2',
  `galon` smallint(6) NOT NULL DEFAULT '0',
  `zone` mediumint(9) NOT NULL COMMENT 'taille de la zone d''effet autour de la cible. -1 si egale à la vision du lanceur.',
  `cible` tinyint(3) NOT NULL DEFAULT '1' COMMENT 'Prise en compte de la cible ou non. (permet de déplacer une zone sur une cible autre que le lanceur)',
  `lanceur` tinyint(3) NOT NULL DEFAULT '1' COMMENT 'Prise en compte du lanceur ou non.',
  `id_effet` mediumtext COLLATE utf8_unicode_ci NOT NULL COMMENT '(lanceur_id_effet1),..,(lanceur_id_effetn):(cible_id_effet1),..,(cible_id_effetk)',
  `type_cible` mediumtext COLLATE utf8_unicode_ci NOT NULL COMMENT 'allie, ennemi, both,choix, none',
  `type_action` varchar(12) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IX_Action_CercleId` (`cercle_id`),
  KEY `IX_Action_Niveau` (`niv`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=160 ;

-- --------------------------------------------------------

--
-- Structure de la table `api_key`
--

DROP TABLE IF EXISTS `api_key`;
CREATE TABLE IF NOT EXISTS `api_key` (
  `utilisateur_id` int(10) unsigned NOT NULL,
  `nom` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `cle` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `niveau` enum('public','private','full') COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`utilisateur_id`,`nom`),
  UNIQUE KEY `UU_ApiKey_Cle` (`cle`),
  KEY `FK_ApiKey_Utilisateurs` (`utilisateur_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `at_log`
--

DROP TABLE IF EXISTS `at_log`;
CREATE TABLE IF NOT EXISTS `at_log` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `compte` int(11) NOT NULL,
  `date` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='table générique de log' AUTO_INCREMENT=5542 ;

-- --------------------------------------------------------

--
-- Structure de la table `at_log_at`
--

DROP TABLE IF EXISTS `at_log_at`;
CREATE TABLE IF NOT EXISTS `at_log_at` (
  `id` bigint(20) unsigned NOT NULL,
  `action` int(11) NOT NULL,
  `message` char(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `at_log_connexion`
--

DROP TABLE IF EXISTS `at_log_connexion`;
CREATE TABLE IF NOT EXISTS `at_log_connexion` (
  `id` int(11) NOT NULL,
  `IP` char(15) COLLATE utf8_unicode_ci NOT NULL,
  `cookieId` int(10) unsigned NOT NULL,
  `navigateur` int(10) unsigned NOT NULL,
  KEY `id` (`id`),
  KEY `navigateur` (`navigateur`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `at_log_inter_geo`
--

DROP TABLE IF EXISTS `at_log_inter_geo`;
CREATE TABLE IF NOT EXISTS `at_log_inter_geo` (
  `id` bigint(20) unsigned NOT NULL,
  `id_perso1` int(10) unsigned NOT NULL,
  `x1` int(11) NOT NULL,
  `y1` int(11) NOT NULL,
  `id_perso2` int(10) unsigned NOT NULL,
  `x2` int(11) NOT NULL,
  `y2` int(11) NOT NULL,
  `carte_id` tinyint(3) unsigned NOT NULL,
  `ref` bigint(20) unsigned DEFAULT NULL,
  `lvl` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `perso1` (`id_perso1`),
  KEY `perso2` (`id_perso2`),
  KEY `ref` (`ref`),
  KEY `carte_id` (`carte_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `at_members`
--

DROP TABLE IF EXISTS `at_members`;
CREATE TABLE IF NOT EXISTS `at_members` (
  `id` int(10) unsigned NOT NULL,
  `lvl` int(10) unsigned NOT NULL,
  UNIQUE KEY `couple` (`id`,`lvl`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `at_navigateur`
--

DROP TABLE IF EXISTS `at_navigateur`;
CREATE TABLE IF NOT EXISTS `at_navigateur` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `descr` text COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=112 ;

-- --------------------------------------------------------

--
-- Structure de la table `at_punish`
--

DROP TABLE IF EXISTS `at_punish`;
CREATE TABLE IF NOT EXISTS `at_punish` (
  `id` int(10) unsigned NOT NULL,
  `lvl` tinyint(3) unsigned NOT NULL,
  `at` int(10) unsigned NOT NULL,
  `date` datetime NOT NULL,
  PRIMARY KEY (`id`,`lvl`),
  UNIQUE KEY `trio` (`id`,`lvl`,`at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `background`
--

DROP TABLE IF EXISTS `background`;
CREATE TABLE IF NOT EXISTS `background` (
  `perso_id` int(10) unsigned NOT NULL,
  `classe_rp` tinyint(4) NOT NULL,
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `historique` text COLLATE utf8_unicode_ci NOT NULL,
  `avis_ange` text COLLATE utf8_unicode_ci NOT NULL,
  `avis_demon` text COLLATE utf8_unicode_ci NOT NULL,
  `avis_humain` text COLLATE utf8_unicode_ci NOT NULL,
  `classe_visible` tinyint(1) NOT NULL,
  PRIMARY KEY (`perso_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `background_classes`
--

DROP TABLE IF EXISTS `background_classes`;
CREATE TABLE IF NOT EXISTS `background_classes` (
  `id` tinyint(3) NOT NULL,
  `camps` tinyint(3) NOT NULL,
  `groupe` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `nom` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`,`camps`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `bals`
--

DROP TABLE IF EXISTS `bals`;
CREATE TABLE IF NOT EXISTS `bals` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `perso_src_id` int(10) unsigned DEFAULT NULL,
  `perso_dest_id` int(10) unsigned DEFAULT NULL,
  `corps_id` bigint(20) unsigned NOT NULL,
  `flag_lu` tinyint(1) NOT NULL DEFAULT '0',
  `flag_envoye` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `flag_archive` tinyint(1) NOT NULL,
  `flag_favori` tinyint(1) NOT NULL DEFAULT '0',
  `nom_liste` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_Bals_Corps` (`corps_id`),
  KEY `FK_Bals_Expediteur` (`perso_src_id`),
  KEY `FK_Bals_Destinataire` (`perso_dest_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Destinataires des BAL' AUTO_INCREMENT=2682 ;

-- --------------------------------------------------------

--
-- Structure de la table `bals_corps`
--

DROP TABLE IF EXISTS `bals_corps`;
CREATE TABLE IF NOT EXISTS `bals_corps` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `titre` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `corps` mediumtext COLLATE utf8_unicode_ci NOT NULL,
  `liste_mats` mediumtext CHARACTER SET latin1 NOT NULL,
  `liste` varchar(30) CHARACTER SET latin1 DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IX_BalsCorps_Date` (`date`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Corps des BAL' AUTO_INCREMENT=464 ;

-- --------------------------------------------------------

--
-- Structure de la table `bals_listes`
--

DROP TABLE IF EXISTS `bals_listes`;
CREATE TABLE IF NOT EXISTS `bals_listes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `libelle` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `ouverture` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0 = fermée / 1 = ouverte',
  `type` enum('public','prive','aura') COLLATE utf8_unicode_ci NOT NULL,
  `camp` tinyint(3) unsigned DEFAULT NULL COMMENT 'Camps correspondant à cette liste',
  `owner` int(10) unsigned DEFAULT NULL COMMENT 'propriétaire de la liste, lui seul peut la modifier',
  `liste` mediumtext COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_BalsListes_Camp` (`camp`),
  KEY `FK_BalsListes_Persos` (`owner`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `bals_listeview`
--
DROP VIEW IF EXISTS `bals_listeview`;
CREATE TABLE IF NOT EXISTS `bals_listeview` (
`id` int(10) unsigned
,`libelle` varchar(50)
,`ouverture` tinyint(1)
,`type` enum('public','prive','aura')
,`camp` tinyint(3) unsigned
,`owner` int(10) unsigned
,`liste` mediumtext
,`grade` smallint(6)
,`pos_x` int(11)
,`pos_y` int(11)
,`carte` tinyint(3) unsigned
);
-- --------------------------------------------------------

--
-- Structure de la table `bals_send`
--

DROP TABLE IF EXISTS `bals_send`;
CREATE TABLE IF NOT EXISTS `bals_send` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `perso_src_id` int(10) unsigned DEFAULT '0' COMMENT 'perso source de la bal',
  `perso_dest_id` mediumtext COLLATE utf8_unicode_ci NOT NULL COMMENT 'perso destinataire de la bal',
  `titre` varchar(60) COLLATE utf8_unicode_ci NOT NULL,
  `corps` mediumtext COLLATE utf8_unicode_ci NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `flag_lu` tinyint(1) NOT NULL,
  `flag_exp` varchar(10) COLLATE utf8_unicode_ci NOT NULL COMMENT 'qui envoie le mail, anim, admin, joueur',
  `flag_fav` varchar(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `liste_bal` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_BalsSend_Persos` (`perso_src_id`),
  KEY `IX_BalsSend_Date` (`date`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=456 ;

-- --------------------------------------------------------

--
-- Structure de la table `blocks`
--

DROP TABLE IF EXISTS `blocks`;
CREATE TABLE IF NOT EXISTS `blocks` (
  `unique_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `perso_id` int(10) unsigned NOT NULL,
  `block_id` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `column_id` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `order_id` smallint(6) NOT NULL DEFAULT '0',
  `visible` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'permet de rendre visible ou non un block',
  PRIMARY KEY (`unique_id`),
  UNIQUE KEY `UU_Blocks_PersoId_BlockId` (`perso_id`,`block_id`),
  KEY `FK_Block_Persos` (`perso_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `camps`
--

DROP TABLE IF EXISTS `camps`;
CREATE TABLE IF NOT EXISTS `camps` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Identifiant du camp',
  `carte_id` tinyint(3) unsigned NOT NULL COMMENT 'Identifiant du plan ou ce camp respawn',
  `nom` varchar(10) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Nom du camp',
  `description` mediumtext COLLATE utf8_unicode_ci NOT NULL COMMENT 'Texte de description du camp',
  PRIMARY KEY (`id`),
  KEY `FK_Camps_Carte` (`carte_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=7 ;

-- --------------------------------------------------------

--
-- Structure de la table `caracs`
--

DROP TABLE IF EXISTS `caracs`;
CREATE TABLE IF NOT EXISTS `caracs` (
  `perso_id` int(10) unsigned NOT NULL COMMENT 'Identifiant du personnage',
  `px` mediumint(9) NOT NULL DEFAULT '0' COMMENT 'Exp',
  `pi` mediumint(9) NOT NULL DEFAULT '0' COMMENT 'Points d''investissement du perso',
  `pv` mediumint(9) NOT NULL DEFAULT '0' COMMENT 'PVs actuels du perso',
  `niv_pv` smallint(5) unsigned NOT NULL DEFAULT '0',
  `recup_pv` smallint(6) NOT NULL DEFAULT '0',
  `malus_def` smallint(6) NOT NULL DEFAULT '0',
  `niv_recup_pv` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `niv` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'niveau de magie',
  `cercle` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `mouv` mediumint(9) NOT NULL DEFAULT '0',
  `niv_mouv` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `pa` float NOT NULL DEFAULT '0',
  `pa_dec` tinyint(4) NOT NULL DEFAULT '0',
  `niv_pa` smallint(5) unsigned NOT NULL DEFAULT '0',
  `des_attaque` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `maj_des` tinyint(1) NOT NULL DEFAULT '0',
  `maj_esq_mag` tinyint(4) NOT NULL DEFAULT '0',
  `niv_des` smallint(5) unsigned NOT NULL DEFAULT '0',
  `force` mediumint(9) NOT NULL DEFAULT '1',
  `niv_force` smallint(5) unsigned NOT NULL DEFAULT '0',
  `perception` mediumint(9) NOT NULL DEFAULT '1',
  `niv_perception` smallint(5) unsigned NOT NULL DEFAULT '0',
  `res_mag` mediumint(9) NOT NULL DEFAULT '0',
  `esq_mag` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`perso_id`),
  KEY `IX_Caracs_Px` (`px`),
  KEY `IX_Caracs_Pv` (`pv`),
  KEY `IX_Caracs_MalusDef` (`malus_def`),
  KEY `IX_Caracs_NivDes` (`niv_des`),
  KEY `IX_Caracs_DesAttaque` (`des_attaque`),
  KEY `IX_Caracs_ResMag` (`res_mag`),
  KEY `IX_Caracs_EsqMag` (`esq_mag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `caracs_alter`
--

DROP TABLE IF EXISTS `caracs_alter`;
CREATE TABLE IF NOT EXISTS `caracs_alter` (
  `perso_id` int(10) unsigned NOT NULL,
  `alter_pa` mediumint(8) NOT NULL DEFAULT '0',
  `alter_pv` mediumint(9) NOT NULL DEFAULT '0',
  `alter_mouv` mediumint(8) NOT NULL DEFAULT '0',
  `alter_def` mediumint(8) NOT NULL DEFAULT '0',
  `alter_att` mediumint(8) NOT NULL DEFAULT '0',
  `alter_recup_pv` mediumint(8) NOT NULL DEFAULT '0',
  `alter_force` mediumint(8) NOT NULL DEFAULT '0',
  `alter_perception` mediumint(8) NOT NULL DEFAULT '0',
  `nb_desaffil` mediumint(8) NOT NULL DEFAULT '0',
  `alter_niv_mag` mediumint(8) NOT NULL DEFAULT '0',
  `alter_effet` int(11) NOT NULL DEFAULT '0',
  `alter_res_mag` int(11) NOT NULL DEFAULT '0',
  `alter_esq_mag` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`perso_id`),
  KEY `IX_CaracsAlter_ResMag` (`alter_res_mag`),
  KEY `IX_CaracsAlter_EsqMag` (`alter_esq_mag`),
  KEY `IX_CaracsAlter_Def` (`alter_def`),
  KEY `IX_CaracsAlter_Att` (`alter_att`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `caracs_alter_affi`
--

DROP TABLE IF EXISTS `caracs_alter_affi`;
CREATE TABLE IF NOT EXISTS `caracs_alter_affi` (
  `perso_id` int(10) unsigned NOT NULL,
  `alter_pa` mediumint(8) NOT NULL,
  `alter_pv` mediumint(9) NOT NULL,
  `alter_mouv` mediumint(8) NOT NULL,
  `alter_def` mediumint(8) NOT NULL,
  `alter_att` mediumint(8) NOT NULL,
  `alter_recup_pv` mediumint(8) NOT NULL,
  `alter_force` mediumint(8) NOT NULL,
  `alter_perception` mediumint(8) NOT NULL,
  `nb_desaffil` mediumint(8) NOT NULL,
  `alter_niv_mag` mediumint(8) NOT NULL,
  `alter_effet` int(11) NOT NULL DEFAULT '0',
  `alter_res_mag` int(11) NOT NULL DEFAULT '0',
  `alter_esq_mag` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`perso_id`),
  KEY `IX_CaracsAlter_ResMag` (`alter_res_mag`),
  KEY `IX_CaracsAlter_EsqMag` (`alter_esq_mag`),
  KEY `IX_CaracsAlter_Def` (`alter_def`),
  KEY `IX_CaracsAlter_Att` (`alter_att`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `caracs_alter_artefact`
--

DROP TABLE IF EXISTS `caracs_alter_artefact`;
CREATE TABLE IF NOT EXISTS `caracs_alter_artefact` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `case_artefact_id` int(11) NOT NULL,
  `alter_pa` mediumint(9) NOT NULL,
  `alter_pv` mediumint(9) NOT NULL,
  `alter_mouv` mediumint(9) NOT NULL,
  `alter_def` mediumint(9) NOT NULL,
  `alter_att` mediumint(9) NOT NULL,
  `alter_recup_pv` mediumint(9) NOT NULL,
  `alter_force` mediumint(9) NOT NULL,
  `alter_perception` mediumint(9) NOT NULL,
  `alter_niv_mag` mediumint(9) NOT NULL DEFAULT '0',
  `immunite` mediumint(9) NOT NULL,
  `alter_effet` int(11) NOT NULL DEFAULT '0',
  `alter_res_mag` int(11) NOT NULL DEFAULT '0',
  `alter_esq_mag` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `case_artefact_id` (`case_artefact_id`),
  KEY `IX_CaracsAlterArtefact_Def` (`alter_def`),
  KEY `IX_CaracsAlterArtefact_Att` (`alter_att`),
  KEY `IX_CaracsAlterArtefact_ResMag` (`alter_res_mag`),
  KEY `IX_CaracsAlterArtefact_EsqMag` (`alter_esq_mag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `caracs_alter_camp`
--

DROP TABLE IF EXISTS `caracs_alter_camp`;
CREATE TABLE IF NOT EXISTS `caracs_alter_camp` (
  `camp_id` tinyint(3) unsigned NOT NULL,
  `alter_pa` mediumint(8) NOT NULL,
  `alter_pv` mediumint(9) NOT NULL,
  `alter_mouv` mediumint(8) NOT NULL,
  `alter_def` mediumint(8) NOT NULL,
  `alter_att` mediumint(8) NOT NULL,
  `alter_recup_pv` mediumint(8) NOT NULL,
  `alter_force` mediumint(8) NOT NULL,
  `alter_perception` mediumint(8) NOT NULL,
  `alter_niv_mag` mediumint(8) NOT NULL,
  `alter_effet` int(11) NOT NULL DEFAULT '0',
  `alter_res_mag` int(11) NOT NULL DEFAULT '0',
  `alter_esq_mag` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`camp_id`),
  KEY `IX_CaracsAlterCamp_Att` (`alter_att`),
  KEY `IX_CaracsAlterCamp_Def` (`alter_def`),
  KEY `IX_CaracsAlterCamp_EsqMag` (`alter_esq_mag`),
  KEY `IX_CaracsAlterCamp_ResMag` (`alter_res_mag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `caracs_alter_ext`
--

DROP TABLE IF EXISTS `caracs_alter_ext`;
CREATE TABLE IF NOT EXISTS `caracs_alter_ext` (
  `grade_id` smallint(8) NOT NULL,
  `cout_pv` int(11) NOT NULL,
  `alter_pa_min` smallint(8) NOT NULL,
  `alter_pa_max` smallint(8) NOT NULL,
  `alter_mouv_min` smallint(8) NOT NULL,
  `alter_mouv_max` smallint(8) NOT NULL,
  `alter_def_min` smallint(8) NOT NULL,
  `alter_def_max` smallint(8) NOT NULL,
  `alter_att_min` smallint(8) NOT NULL,
  `alter_att_max` smallint(8) NOT NULL,
  `alter_recup_pv_min` smallint(8) NOT NULL,
  `alter_recup_pv_max` smallint(8) NOT NULL,
  `alter_force_min` smallint(8) NOT NULL,
  `alter_force_max` smallint(8) NOT NULL,
  `alter_perception_min` smallint(8) NOT NULL,
  `alter_perception_max` smallint(8) NOT NULL,
  `alter_niv_mag_min` smallint(8) NOT NULL,
  `alter_niv_mag_max` smallint(8) NOT NULL,
  PRIMARY KEY (`grade_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `caracs_alter_mag`
--

DROP TABLE IF EXISTS `caracs_alter_mag`;
CREATE TABLE IF NOT EXISTS `caracs_alter_mag` (
  `unique_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `perso_id` int(10) unsigned NOT NULL,
  `alter_pa` mediumint(9) NOT NULL DEFAULT '0',
  `alter_pv` mediumint(9) NOT NULL DEFAULT '0',
  `alter_mouv` mediumint(9) NOT NULL DEFAULT '0',
  `alter_def` mediumint(9) NOT NULL DEFAULT '0',
  `alter_att` mediumint(9) NOT NULL DEFAULT '0',
  `alter_recup_pv` mediumint(9) NOT NULL DEFAULT '0',
  `alter_force` mediumint(9) NOT NULL DEFAULT '0',
  `alter_perception` mediumint(9) NOT NULL DEFAULT '0',
  `alter_niv_mag` mediumint(9) NOT NULL DEFAULT '0',
  `alter_effet` mediumint(9) NOT NULL DEFAULT '0',
  `immunite` smallint(6) NOT NULL DEFAULT '0',
  `alter_res_mag` int(11) NOT NULL DEFAULT '0',
  `alter_esq_mag` int(11) NOT NULL DEFAULT '0',
  `alter_res_phy` int(11) NOT NULL DEFAULT '0',
  `nb_tour` tinyint(3) NOT NULL DEFAULT '1',
  `cassable` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `dissipe_mort` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`unique_id`),
  KEY `IX_CaracsAlterMagie_Def` (`alter_def`),
  KEY `IX_CaracsAlterMagie_Att` (`alter_att`),
  KEY `IX_CaracsAlterMagie_ResMag` (`alter_res_mag`),
  KEY `IX_CaracsAlterMagie_EsqMag` (`alter_esq_mag`),
  KEY `IX_CaracsAlterMagie_Perso` (`perso_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=144 ;

-- --------------------------------------------------------

--
-- Structure de la table `caracs_alter_plan`
--

DROP TABLE IF EXISTS `caracs_alter_plan`;
CREATE TABLE IF NOT EXISTS `caracs_alter_plan` (
  `perso_id` int(10) unsigned NOT NULL,
  `alter_pa` int(11) NOT NULL,
  `alter_pv` int(11) NOT NULL,
  `alter_mouv` int(11) NOT NULL,
  `alter_def` int(11) NOT NULL,
  `alter_att` int(11) NOT NULL,
  `alter_recup_pv` int(11) NOT NULL,
  `alter_force` int(11) NOT NULL,
  `alter_perception` int(11) NOT NULL,
  `alter_niv_mag` int(11) NOT NULL,
  `alter_effet` int(11) NOT NULL DEFAULT '0',
  `alter_res_mag` int(11) NOT NULL DEFAULT '0',
  `alter_esq_mag` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`perso_id`),
  KEY `IX_CaracsAlterPlan_Def` (`alter_def`),
  KEY `IX_CaracsAlterPlan_Att` (`alter_att`),
  KEY `IX_CaracsAlterPlan_ResMag` (`alter_res_mag`),
  KEY `IX_CaracsAlterPlan_EsqMag` (`alter_esq_mag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `cartes`
--

DROP TABLE IF EXISTS `cartes`;
CREATE TABLE IF NOT EXISTS `cartes` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Identifiant du plan',
  `nom` varchar(45) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Nom de ce plan',
  `description` mediumtext COLLATE utf8_unicode_ci NOT NULL COMMENT 'Description du plan',
  `circ` char(2) COLLATE utf8_unicode_ci NOT NULL DEFAULT '00' COMMENT 'Defini la circularité du plan. Le premier bit en X le second en Y. 1 = circulaire.',
  `infini` char(4) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0000' COMMENT 'Defini si un côté est infini ou non. Les deux premières valeurs en X, les deux dernières en Y. Première valeur en X pour les valeures négatives de X, vaut 1 si infini.',
  `x_min` mediumint(6) NOT NULL DEFAULT '-10',
  `y_min` mediumint(6) NOT NULL DEFAULT '-10',
  `x_max` mediumint(9) NOT NULL DEFAULT '10',
  `y_max` mediumint(9) NOT NULL DEFAULT '10',
  `visible_x_min` mediumint(6) NOT NULL COMMENT 'Debut carte visible en X',
  `visible_x_max` mediumint(6) NOT NULL COMMENT 'Fin carte visible en X',
  `visible_y_min` mediumint(6) NOT NULL COMMENT 'Debut carte visible en Y',
  `visible_y_max` mediumint(6) NOT NULL COMMENT 'Fin carte visible en X',
  `dla` float NOT NULL DEFAULT '23' COMMENT 'en heures',
  `nom_decors` varchar(40) COLLATE utf8_unicode_ci DEFAULT NULL,
  `decors_defaut` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=255 ;

-- --------------------------------------------------------

--
-- Structure de la table `case_artefact`
--

DROP TABLE IF EXISTS `case_artefact`;
CREATE TABLE IF NOT EXISTS `case_artefact` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `description` mediumtext COLLATE utf8_unicode_ci NOT NULL,
  `image` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `pv_max` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `rarete` varchar(3) COLLATE utf8_unicode_ci NOT NULL COMMENT 'en %, 1 rare, 100 courant',
  `cout` varchar(15) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0' COMMENT 'cout de l''objet en po',
  `poid` varchar(5) COLLATE utf8_unicode_ci NOT NULL COMMENT 'poid de l''objet en kilo',
  `categorie_id` mediumint(8) NOT NULL,
  `consom` varchar(1) COLLATE utf8_unicode_ci NOT NULL COMMENT '0 : ni consomable ni activable,1 : activable,2 : activ� en permanence,3 : consomable,4 : en cours de consomation',
  PRIMARY KEY (`id`),
  KEY `FK_CaseArtefact_CategorieArtefact` (`categorie_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=17 ;

-- --------------------------------------------------------

--
-- Structure de la table `case_objet_complexe`
--

DROP TABLE IF EXISTS `case_objet_complexe`;
CREATE TABLE IF NOT EXISTS `case_objet_complexe` (
  `id` mediumint(9) NOT NULL AUTO_INCREMENT,
  `nom` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `description` mediumtext COLLATE utf8_unicode_ci NOT NULL,
  `pv_max` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `bloquant` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1:bloquant',
  `reparable` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Défini si un objet complexe est réparable ou non. Par défaut il ne l''est pas.',
  `images` varchar(250) COLLATE utf8_unicode_ci NOT NULL COMMENT 'nom s',
  `taille_x` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `taille_y` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `categorie_id` mediumint(8) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_CaseObjetComplexe_CategorieObjetComplexe` (`categorie_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=10 ;

-- --------------------------------------------------------

--
-- Structure de la table `case_objet_simple`
--

DROP TABLE IF EXISTS `case_objet_simple`;
CREATE TABLE IF NOT EXISTS `case_objet_simple` (
  `id` mediumint(9) NOT NULL AUTO_INCREMENT,
  `nom` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `description` mediumtext COLLATE utf8_unicode_ci NOT NULL,
  `bloquant` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1:bloquant,0:non',
  `pv_max` varchar(30) COLLATE utf8_unicode_ci NOT NULL COMMENT 'pv maximum de l''objet',
  `poid` varchar(15) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `image` varchar(250) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'defaut' COMMENT 'nom de l''image',
  `categorie_id` mediumint(8) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_CaseObjetSimple_CategorieObjetSimple` (`categorie_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=40 ;

-- --------------------------------------------------------

--
-- Structure de la table `case_terrain`
--

DROP TABLE IF EXISTS `case_terrain`;
CREATE TABLE IF NOT EXISTS `case_terrain` (
  `id` mediumint(9) unsigned NOT NULL AUTO_INCREMENT,
  `nom` varchar(250) COLLATE utf8_unicode_ci NOT NULL COMMENT 'nom du type de terrain',
  `image` varchar(250) COLLATE utf8_unicode_ci NOT NULL COMMENT 'nom de l''image',
  `couleur` varchar(20) COLLATE utf8_unicode_ci NOT NULL COMMENT 'couleur Hexa',
  `mouv` smallint(6) NOT NULL COMMENT 'nb de mouv',
  `categorie_id` mediumint(8) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_CaseTerrain_CategorieTerrain` (`categorie_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=18 ;

-- --------------------------------------------------------

--
-- Structure de la table `categorie_artefact`
--

DROP TABLE IF EXISTS `categorie_artefact`;
CREATE TABLE IF NOT EXISTS `categorie_artefact` (
  `id` mediumint(8) NOT NULL AUTO_INCREMENT,
  `nom` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `description` tinytext COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=5 ;

-- --------------------------------------------------------

--
-- Structure de la table `categorie_objet_complexe`
--

DROP TABLE IF EXISTS `categorie_objet_complexe`;
CREATE TABLE IF NOT EXISTS `categorie_objet_complexe` (
  `id` mediumint(8) NOT NULL AUTO_INCREMENT,
  `nom` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `description` tinytext COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=4 ;

-- --------------------------------------------------------

--
-- Structure de la table `categorie_objet_simple`
--

DROP TABLE IF EXISTS `categorie_objet_simple`;
CREATE TABLE IF NOT EXISTS `categorie_objet_simple` (
  `id` mediumint(8) NOT NULL AUTO_INCREMENT,
  `nom` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `description` tinytext COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=9 ;

-- --------------------------------------------------------

--
-- Structure de la table `categorie_terrain`
--

DROP TABLE IF EXISTS `categorie_terrain`;
CREATE TABLE IF NOT EXISTS `categorie_terrain` (
  `id` mediumint(8) NOT NULL AUTO_INCREMENT,
  `nom` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `description` tinytext COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=8 ;

-- --------------------------------------------------------

--
-- Structure de la table `classement`
--

DROP TABLE IF EXISTS `classement`;
CREATE TABLE IF NOT EXISTS `classement` (
  `date` date NOT NULL,
  `mat` int(11) NOT NULL,
  `pseudo` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `race` smallint(6) NOT NULL,
  `camp` int(11) NOT NULL,
  `type` int(11) NOT NULL,
  `grade` tinyint(4) NOT NULL,
  `galon` tinyint(4) NOT NULL,
  `xp` mediumint(9) NOT NULL,
  `meurtre` smallint(6) NOT NULL,
  `mort` smallint(6) NOT NULL,
  `joueur` int(10) unsigned NOT NULL,
  `nom_race` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`date`,`mat`),
  KEY `classement_cache_xp` (`xp`),
  KEY `classement_cache_mort` (`meurtre`),
  KEY `classement_cache_meurtre` (`mort`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Table d''archivage du classement';

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `classement_view`
--
DROP VIEW IF EXISTS `classement_view`;
CREATE TABLE IF NOT EXISTS `classement_view` (
`date` date
,`id` int(10) unsigned
,`nom` varchar(64)
,`race` int(10) unsigned
,`camp` tinyint(3) unsigned
,`type` int(11)
,`grade` smallint(6)
,`galon` smallint(6)
,`px` mediumint(9)
,`tueur` bigint(21)
,`mort` bigint(21)
,`joueur` int(10) unsigned
,`nom_race` varchar(100)
);
-- --------------------------------------------------------

--
-- Structure de la table `classes`
--

DROP TABLE IF EXISTS `classes`;
CREATE TABLE IF NOT EXISTS `classes` (
  `Id` varchar(2) NOT NULL,
  `Camps` tinyint(3) unsigned NOT NULL,
  `Position` tinyint(1) NOT NULL,
  `Titre` varchar(40) NOT NULL,
  `Sub` varchar(50) NOT NULL,
  `Description` varchar(250) NOT NULL DEFAULT '',
  PRIMARY KEY (`Id`,`Camps`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `damier_artefact`
--

DROP TABLE IF EXISTS `damier_artefact`;
CREATE TABLE IF NOT EXISTS `damier_artefact` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `icone_artefact_id` mediumint(9) NOT NULL,
  `pos_x` int(11) NOT NULL,
  `pos_y` int(11) NOT NULL,
  `pv` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `carte_id` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UU_DamierArtefact_PosX_PosY_CarteId` (`pos_x`,`pos_y`,`carte_id`),
  KEY `FK_DamierArtefact_Carte` (`carte_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `damier_bouclier`
--

DROP TABLE IF EXISTS `damier_bouclier`;
CREATE TABLE IF NOT EXISTS `damier_bouclier` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(250) COLLATE utf8_unicode_ci NOT NULL COMMENT 'nom du bouclier',
  `nom_image` varchar(32) COLLATE utf8_unicode_ci NOT NULL COMMENT 'nom de l''image du bouclier',
  `description` mediumtext COLLATE utf8_unicode_ci NOT NULL COMMENT 'rp  du bouclier',
  `pos_x` int(11) NOT NULL,
  `pos_y` int(11) NOT NULL,
  `type_id` tinyint(4) NOT NULL COMMENT 'Niveau du bouclier généré',
  `objet_lie` int(11) NOT NULL,
  `carte_id` tinyint(3) unsigned NOT NULL COMMENT 'plan ou se trouve  le bouclier',
  `pv` varchar(30) COLLATE utf8_unicode_ci NOT NULL COMMENT 'pv en cours',
  `pv_max` varchar(30) COLLATE utf8_unicode_ci NOT NULL COMMENT 'pv maximum  du bouclier',
  `deplacer` varchar(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0' COMMENT '0: non 1:oui',
  `statut` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1:ouvert, 0:ferm',
  PRIMARY KEY (`id`),
  KEY `FK_DamierBouclier_Carte` (`carte_id`),
  KEY `FK_DamierBouclier_DamierObjetComplexe` (`objet_lie`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `damier_objet_complexe`
--

DROP TABLE IF EXISTS `damier_objet_complexe`;
CREATE TABLE IF NOT EXISTS `damier_objet_complexe` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `case_objet_complexe_id` mediumint(9) NOT NULL,
  `pos_x` int(11) NOT NULL,
  `pos_x_max` int(11) NOT NULL,
  `pos_y` int(11) NOT NULL,
  `pos_y_max` int(11) NOT NULL,
  `pv` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `carte_id` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_DamierObjetComplexe_CaseObjetComplexe` (`case_objet_complexe_id`),
  KEY `FK_DamierObjetComplexe_Carte` (`carte_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `damier_objet_simple`
--

DROP TABLE IF EXISTS `damier_objet_simple`;
CREATE TABLE IF NOT EXISTS `damier_objet_simple` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `case_objet_simple_id` mediumint(9) NOT NULL,
  `pos_x` int(11) NOT NULL,
  `pos_y` int(11) NOT NULL,
  `pv` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `carte_id` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_DamierObjetSimple_Carte` (`carte_id`),
  KEY `FK_DamierObjetSimple_CaseObjetSimple` (`case_objet_simple_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `damier_persos`
--

DROP TABLE IF EXISTS `damier_persos`;
CREATE TABLE IF NOT EXISTS `damier_persos` (
  `carte_id` tinyint(3) unsigned NOT NULL COMMENT 'identifiant de la carte',
  `pos_x` int(11) NOT NULL COMMENT 'position x sur le damier',
  `pos_y` int(11) NOT NULL COMMENT 'position y sur le damier',
  `perso_id` int(10) unsigned NOT NULL COMMENT 'id du personnage',
  PRIMARY KEY (`carte_id`,`pos_x`,`pos_y`),
  KEY `FK_DamierPersos_Persos` (`perso_id`),
  KEY `FK_DamierPersos_Carte` (`carte_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `damier_porte`
--

DROP TABLE IF EXISTS `damier_porte`;
CREATE TABLE IF NOT EXISTS `damier_porte` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(250) COLLATE utf8_unicode_ci NOT NULL COMMENT 'nom de la porte',
  `nom_image` varchar(32) COLLATE utf8_unicode_ci NOT NULL COMMENT 'nom de l''image de la porte',
  `description` mediumtext COLLATE utf8_unicode_ci NOT NULL COMMENT 'rp de la porte',
  `pos_x` int(11) NOT NULL,
  `pos_y` int(11) NOT NULL,
  `porte_liee_id` int(11) DEFAULT NULL,
  `objet_lie` int(11) NOT NULL,
  `spawn_id` int(11) NOT NULL COMMENT 'la ou la porte mene',
  `carte_id` tinyint(3) unsigned NOT NULL COMMENT 'plan ou se trouve la porte',
  `pv` varchar(30) COLLATE utf8_unicode_ci NOT NULL COMMENT 'pv en cours',
  `pv_max` varchar(30) COLLATE utf8_unicode_ci NOT NULL COMMENT 'pv maximum de la porte',
  `statut` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1:ouvert, 0:fermé',
  PRIMARY KEY (`id`),
  KEY `FK_DamierPorte_Carte` (`carte_id`),
  KEY `FK_DamierPorte_DamierSpawn` (`spawn_id`),
  KEY `FK_DamierPorte_PorteLiee` (`porte_liee_id`),
  KEY `FK_DamierPorte_DamierObjetComplexe` (`objet_lie`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=4 ;

-- --------------------------------------------------------

--
-- Structure de la table `damier_spawn`
--

DROP TABLE IF EXISTS `damier_spawn`;
CREATE TABLE IF NOT EXISTS `damier_spawn` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `pos_x` int(11) NOT NULL,
  `pos_y` int(11) NOT NULL,
  `pos_max_x` int(11) NOT NULL,
  `pos_max_y` int(11) NOT NULL,
  `carte_id` tinyint(3) unsigned NOT NULL,
  `primaire` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `FK_DamierSpawn_Carte` (`carte_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `damier_terrain`
--

DROP TABLE IF EXISTS `damier_terrain`;
CREATE TABLE IF NOT EXISTS `damier_terrain` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `carte_id` tinyint(3) unsigned NOT NULL COMMENT 'identifiant de la carte',
  `terrain_id` mediumint(9) unsigned NOT NULL COMMENT 'id du terrain avec images',
  `pos_x` int(11) NOT NULL,
  `pos_y` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_DamierTerrain_CaseTerrain` (`terrain_id`),
  KEY `FK_DamierTerrain_Carte` (`carte_id`),
  KEY `IX_DamierTerrain_PosX` (`pos_x`),
  KEY `IX_DamierTerrain_PosY` (`pos_y`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `effet`
--

DROP TABLE IF EXISTS `effet`;
CREATE TABLE IF NOT EXISTS `effet` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type_effet` varchar(32) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Element sur lequel porte l''effet : PV, PA, PM; ou objet s''il s''agit de ramasser.',
  `effet` varchar(32) COLLATE utf8_unicode_ci NOT NULL COMMENT 'valeur de l''effet, negatif s''il s''agit d''un retrait de carac, positif s''il s''agit d''un ajout, nul si prise en compte d''une carac du lanceur.',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UU_Effet_Type_Valeur` (`type_effet`,`effet`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=227 ;

-- --------------------------------------------------------

--
-- Structure de la table `emails`
--

DROP TABLE IF EXISTS `emails`;
CREATE TABLE IF NOT EXISTS `emails` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `hash_id` varchar(32) NOT NULL,
  `date_send` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `to_email` text NOT NULL,
  `title` text NOT NULL,
  `message` text NOT NULL,
  `headers` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=226 ;

-- --------------------------------------------------------

--
-- Structure de la table `evenement`
--

DROP TABLE IF EXISTS `evenement`;
CREATE TABLE IF NOT EXISTS `evenement` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Identifiant de l''evenement',
  `evenement_type_id` tinyint(3) unsigned NOT NULL COMMENT 'Identifiant du type d''evenement',
  `perso_id` int(10) unsigned NOT NULL COMMENT 'Identifiant du personnage',
  `second_id` int(11) NOT NULL,
  `second_type` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `date` datetime NOT NULL COMMENT 'Date de l''evenement',
  `champs` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT 'variable de l''évenements sous la forme : champ0,champ1,champ2',
  PRIMARY KEY (`id`),
  KEY `perso_id` (`perso_id`),
  KEY `type_evenement_id` (`evenement_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `evenements`
--

DROP TABLE IF EXISTS `evenements`;
CREATE TABLE IF NOT EXISTS `evenements` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_perso_source` int(10) unsigned NOT NULL,
  `type_source` tinyint(1) NOT NULL DEFAULT '0',
  `id_perso_desti` int(10) unsigned DEFAULT NULL,
  `type_desti` tinyint(1) DEFAULT '0',
  `id_event` int(10) unsigned DEFAULT NULL,
  `date_ev` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `type_ev` varchar(10) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'basic',
  `public_data` varchar(70) COLLATE utf8_unicode_ci DEFAULT NULL,
  `private_data` varchar(70) COLLATE utf8_unicode_ci DEFAULT NULL,
  `result` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `id_src` (`id_perso_source`),
  KEY `id_dst` (`id_perso_desti`),
  KEY `id_ev` (`id_event`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=4663 ;

-- --------------------------------------------------------

--
-- Structure de la table `evenements_texte`
--

DROP TABLE IF EXISTS `evenements_texte`;
CREATE TABLE IF NOT EXISTS `evenements_texte` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `texte` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `texte` (`texte`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=2 ;

-- --------------------------------------------------------

--
-- Structure de la table `evenement_type`
--

DROP TABLE IF EXISTS `evenement_type`;
CREATE TABLE IF NOT EXISTS `evenement_type` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Identifiant du type d''evenement',
  `type` enum('mouvement','attaque','esquive','sort','esquive_magique','sprint','suicide','entrainement','transaction','mort','meurtre','grade_up','grade_down','faction_in','faction_out','faction_eject','perso') COLLATE utf8_unicode_ci NOT NULL COMMENT 'si le champ est noté ''perso'' il faut afficher le champs champs de la table evenement sans traitement.',
  `motif` text COLLATE utf8_unicode_ci NOT NULL COMMENT 'Motif du texte a trou, champs vide par [champ0]',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `factions`
--

DROP TABLE IF EXISTS `factions`;
CREATE TABLE IF NOT EXISTS `factions` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Identifiant de la faction',
  `nom` varchar(64) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Nom de la faction',
  `race` tinyint(3) unsigned NOT NULL COMMENT 'correspond au camp',
  `description` mediumtext COLLATE utf8_unicode_ci NOT NULL COMMENT 'Description de la faction',
  `type` smallint(6) NOT NULL DEFAULT '0',
  `alignement` int(10) unsigned NOT NULL,
  `type_nom` mediumtext COLLATE utf8_unicode_ci NOT NULL,
  `creation_date` datetime NOT NULL COMMENT 'Date de creation de la faction',
  `site_url` tinytext COLLATE utf8_unicode_ci COMMENT 'URL du site de la faction si il y a lieu',
  `logo_url` tinytext COLLATE utf8_unicode_ci COMMENT 'Image du logo de la faction',
  `nature` enum('LEGION','ORDRE') COLLATE utf8_unicode_ci NOT NULL,
  `link1` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `link2` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `link3` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `link4` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `link5` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_Factions_Camps` (`race`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=2 ;

-- --------------------------------------------------------

--
-- Structure de la table `faction_alignement`
--

DROP TABLE IF EXISTS `faction_alignement`;
CREATE TABLE IF NOT EXISTS `faction_alignement` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `label` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=6 ;

-- --------------------------------------------------------

--
-- Structure de la table `faction_grades`
--

DROP TABLE IF EXISTS `faction_grades`;
CREATE TABLE IF NOT EXISTS `faction_grades` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Identifiant du grade',
  `grade_id` mediumint(9) NOT NULL COMMENT 'Identifiant du grade',
  `faction_id` mediumint(8) unsigned NOT NULL COMMENT 'Identifiant de la faction',
  `nom` varchar(42) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Nom du grade dans cette faction',
  `description` mediumtext COLLATE utf8_unicode_ci COMMENT 'Description de ce grade au sein de cette faction',
  `droits` varchar(8) COLLATE utf8_unicode_ci NOT NULL DEFAULT '00000001' COMMENT 'Droit de ce grade dans la faction',
  PRIMARY KEY (`id`),
  KEY `FK_FactionGrade_Factions` (`faction_id`),
  KEY `IX_FactionGrades_GradeId` (`grade_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=5 ;

-- --------------------------------------------------------

--
-- Structure de la table `faction_membres`
--

DROP TABLE IF EXISTS `faction_membres`;
CREATE TABLE IF NOT EXISTS `faction_membres` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Identification du membre',
  `perso_id` int(10) unsigned NOT NULL COMMENT 'Identifiant du personnage',
  `faction_id` mediumint(8) unsigned NOT NULL COMMENT 'Identifiant de la faction',
  `faction_grade_id` mediumint(8) unsigned DEFAULT NULL COMMENT 'Identifiant du grade de faction',
  PRIMARY KEY (`id`),
  KEY `FK_FactionMembres_Persos` (`perso_id`),
  KEY `FK_FactionMembres_Factions` (`faction_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=5 ;

-- --------------------------------------------------------

--
-- Structure de la table `faction_types`
--

DROP TABLE IF EXISTS `faction_types`;
CREATE TABLE IF NOT EXISTS `faction_types` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nom` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=6 ;

-- --------------------------------------------------------

--
-- Structure de la table `grimoire`
--

DROP TABLE IF EXISTS `grimoire`;
CREATE TABLE IF NOT EXISTS `grimoire` (
  `id_perso` int(10) unsigned NOT NULL,
  `id_sort` mediumint(9) NOT NULL,
  PRIMARY KEY (`id_perso`,`id_sort`),
  KEY `FK_Grimoire_Persos` (`id_perso`),
  KEY `FK_Grimoire_Action` (`id_sort`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `icone_galons`
--

DROP TABLE IF EXISTS `icone_galons`;
CREATE TABLE IF NOT EXISTS `icone_galons` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Identifiant du galon',
  `grade_id` int(11) NOT NULL,
  `icone_url` tinytext COLLATE utf8_unicode_ci NOT NULL COMMENT 'URL du galon autiliser',
  KEY `id` (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=20 ;

-- --------------------------------------------------------

--
-- Structure de la table `icone_persos`
--

DROP TABLE IF EXISTS `icone_persos`;
CREATE TABLE IF NOT EXISTS `icone_persos` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Identifiant de l''icone',
  `camp_id` int(10) unsigned NOT NULL COMMENT 'Identifiant du camp',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '3',
  `grade_id` int(11) NOT NULL,
  `sexe_id` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `xp_min` mediumint(9) NOT NULL COMMENT 'Niveau d''xp a partir duquel s''applique cet icone',
  `xp_max` mediumint(9) NOT NULL,
  `icone_url` tinytext COLLATE utf8_unicode_ci NOT NULL COMMENT 'URL de l''icone à  utiliser',
  KEY `id` (`id`),
  KEY `camp_id` (`camp_id`),
  KEY `FK_IconePersos_Sexe` (`sexe_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=158 ;

-- --------------------------------------------------------

--
-- Structure de la table `inventaire`
--

DROP TABLE IF EXISTS `inventaire`;
CREATE TABLE IF NOT EXISTS `inventaire` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `perso_id` int(10) unsigned NOT NULL,
  `case_artefact_id` int(11) NOT NULL,
  `statut` enum('actif','inactif') COLLATE utf8_unicode_ci NOT NULL,
  `pv` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `consom` varchar(1) COLLATE utf8_unicode_ci NOT NULL COMMENT '0 : ni consomable ni activable,1 : activable,2 : activ� en permanence,3 : consomable,4 : en cours de consomation',
  PRIMARY KEY (`id`),
  KEY `FK_Inventaires_Persos` (`perso_id`),
  KEY `FK_Inventaires_CaseArtefact` (`case_artefact_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=2 ;

-- --------------------------------------------------------

--
-- Structure de la table `invitations`
--

DROP TABLE IF EXISTS `invitations`;
CREATE TABLE IF NOT EXISTS `invitations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `numero` char(255) COLLATE utf8_unicode_ci NOT NULL,
  `date` date NOT NULL,
  `distribue` varchar(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `numero` (`numero`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `logs_admin`
--

DROP TABLE IF EXISTS `logs_admin`;
CREATE TABLE IF NOT EXISTS `logs_admin` (
  `perso_id` int(11) NOT NULL COMMENT 'id du personnage modifi�/consult�',
  `admin_id` int(11) NOT NULL COMMENT 'id de l''admin/anim/at',
  `message` text COLLATE utf8_unicode_ci NOT NULL COMMENT 'message de ce qui � �t� fait.',
  `date` datetime NOT NULL,
  KEY `IX_LogsAdmin_Perso` (`perso_id`),
  KEY `IX_LogsAdmin_AdminId` (`admin_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `medailles`
--

DROP TABLE IF EXISTS `medailles`;
CREATE TABLE IF NOT EXISTS `medailles` (
  `id_perso` int(10) unsigned NOT NULL,
  `id_medaille` smallint(5) unsigned NOT NULL,
  `nombre` smallint(5) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id_perso`,`id_medaille`),
  KEY `FK_Medailles_Persos` (`id_perso`),
  KEY `FK_Medailles_MedaillesListe` (`id_medaille`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `medailles_liste`
--

DROP TABLE IF EXISTS `medailles_liste`;
CREATE TABLE IF NOT EXISTS `medailles_liste` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `nom` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `niveau` tinyint(3) unsigned NOT NULL COMMENT '1 = platine, 2 = or 3 = argent 4 = bronze 5 = chocolat',
  `priorite` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT 'la priorite d''affichage pour un même niveau de médaille',
  `image` varchar(30) COLLATE utf8_unicode_ci NOT NULL COMMENT 'indique une image à afficher',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=10 ;

-- --------------------------------------------------------

--
-- Structure de la table `morgue`
--

DROP TABLE IF EXISTS `morgue`;
CREATE TABLE IF NOT EXISTS `morgue` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_perso` int(10) unsigned NOT NULL,
  `nom_perso` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `race_perso` int(10) unsigned NOT NULL,
  `nom_race_perso` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `grade_perso` int(10) unsigned NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `mat_victime` int(10) unsigned NOT NULL,
  `nom_victime` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `race_victime` int(10) unsigned NOT NULL,
  `nom_race_victime` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `grade_victime` int(10) unsigned NOT NULL,
  `plan_victime` varchar(15) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'Terre',
  PRIMARY KEY (`id`),
  KEY `id_perso` (`id_perso`),
  KEY `id_victime` (`mat_victime`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=45 ;

-- --------------------------------------------------------

--
-- Structure de la table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
CREATE TABLE IF NOT EXISTS `notifications` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `utilisateur_id` int(10) unsigned NOT NULL,
  `text` text COLLATE utf8_unicode_ci NOT NULL COMMENT 'nom exp, mat exp, mat perso receveur ( soit un de nos persos )',
  `lien` text COLLATE utf8_unicode_ci NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `flag_lu` tinyint(1) NOT NULL DEFAULT '0',
  `type` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_Notifications_Utilisateurs` (`utilisateur_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `persos`
--

DROP TABLE IF EXISTS `persos`;
CREATE TABLE IF NOT EXISTS `persos` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Identifiant du personnage',
  `background` mediumtext COLLATE utf8_unicode_ci NOT NULL,
  `description_affil` mediumtext COLLATE utf8_unicode_ci NOT NULL,
  `classe` tinyint(3) unsigned DEFAULT NULL COMMENT '10ène = Ordre, unité = Caveau',
  `utilisateur_id` int(10) unsigned NOT NULL COMMENT 'Identifiant de l''utilisateur',
  `nb_suicide` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'nombre de suicide du perso',
  `race_id` int(10) unsigned NOT NULL COMMENT 'Identifiant de la race',
  `superieur_id` int(10) unsigned DEFAULT NULL COMMENT 'Personnage a qui ce personnage est affilié',
  `grade_id` smallint(6) NOT NULL COMMENT 'Identifiant du grade',
  `faction_id` mediumint(8) NOT NULL DEFAULT '0',
  `nom` varchar(64) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Le nom du personnage',
  `titre` varchar(250) COLLATE utf8_unicode_ci DEFAULT NULL,
  `creation_date` datetime NOT NULL COMMENT 'Date de creation du personnage',
  `date_tour` datetime NOT NULL COMMENT 'date du prochain tour',
  `date_esquivemagique` datetime NOT NULL,
  `avatar_url` tinytext COLLATE utf8_unicode_ci COMMENT 'URL de l''avatar de ce personnage',
  `icone_id` smallint(5) DEFAULT NULL COMMENT 'id de l''icone personnalisée du perso, si jamais il y a',
  `galon_id` smallint(6) NOT NULL DEFAULT '0' COMMENT 'id du galon assigne au perso',
  `alter_spawn` smallint(6) NOT NULL DEFAULT '0',
  `options` varchar(8) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0000000' COMMENT 'signature, possede un pet, vois les pets, option reception bal, html ou txt',
  `mdj` text COLLATE utf8_unicode_ci COMMENT 'message du jour du personnage',
  `signature` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `sexe` tinyint(1) unsigned DEFAULT NULL,
  `pewo` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'monnaie',
  `nom_race` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Si non-null, remplace le nom de la race du jeu',
  `pnj` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '0 = pj, 1 = pnj',
  `mortel` tinyint(2) NOT NULL DEFAULT '0' COMMENT '0 = immortel, 1 = mortel en vie, -1 = mortel décédé, 2 = mortel en attente de la première incarnation',
  PRIMARY KEY (`id`),
  UNIQUE KEY `NAME` (`nom`),
  KEY `IX_Persos_GradeId` (`grade_id`),
  KEY `IX_Persos_GalonId` (`galon_id`),
  KEY `FK_Persos_SuperieurId` (`superieur_id`),
  KEY `FK_Persos_UtilisateurId` (`utilisateur_id`),
  KEY `FK_Persos_RacesId` (`race_id`),
  KEY `FK_Persos_Sexe` (`sexe`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=359 ;

-- --------------------------------------------------------

--
-- Structure de la table `persos_familier`
--

DROP TABLE IF EXISTS `persos_familier`;
CREATE TABLE IF NOT EXISTS `persos_familier` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `persos_id` int(10) unsigned NOT NULL,
  `nom` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `image` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `options` varchar(8) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_PersosFamilier_Persos` (`persos_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Possession d''un familier' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `persos_ia`
--

DROP TABLE IF EXISTS `persos_ia`;
CREATE TABLE IF NOT EXISTS `persos_ia` (
  `id` int(10) unsigned NOT NULL COMMENT 'matricule',
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'prochain tour',
  `dna` text NOT NULL COMMENT 'ADN du pnj',
  `type` varchar(32) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `persos_mdj`
--

DROP TABLE IF EXISTS `persos_mdj`;
CREATE TABLE IF NOT EXISTS `persos_mdj` (
  `id` int(8) unsigned NOT NULL COMMENT 'timestamp / 119 (1m59s)',
  `perso_id` int(10) unsigned NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `message` varchar(250) NOT NULL,
  PRIMARY KEY (`id`,`perso_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Messages du jours style Twitter';

-- --------------------------------------------------------

--
-- Structure de la table `races`
--

DROP TABLE IF EXISTS `races`;
CREATE TABLE IF NOT EXISTS `races` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `race_id` tinyint(3) unsigned NOT NULL,
  `grade_id` int(11) DEFAULT NULL COMMENT 'Identifiant du camp',
  `camp_id` tinyint(3) unsigned NOT NULL,
  `type` int(11) NOT NULL DEFAULT '3' COMMENT 'Type de jeu, 3 ou 7 cases, 0 pour parias',
  `nom` varchar(64) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Nom de la race',
  `description` mediumtext COLLATE utf8_unicode_ci NOT NULL COMMENT 'Description de la race',
  `color` varchar(7) COLLATE utf8_unicode_ci NOT NULL COMMENT 'couleur de la race',
  PRIMARY KEY (`id`),
  KEY `IX_Races_RaceId` (`race_id`),
  KEY `IX_Races_GradeId` (`grade_id`),
  KEY `FK_Races_Camps` (`camp_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=105 ;

-- --------------------------------------------------------

--
-- Structure de la table `record`
--

DROP TABLE IF EXISTS `record`;
CREATE TABLE IF NOT EXISTS `record` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` mediumtext COLLATE utf8_unicode_ci NOT NULL,
  `perso_id` int(10) unsigned NOT NULL,
  `valeur` mediumtext COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_Record_Persos` (`perso_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='records realise par les joueurs d ewo' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `repertoire`
--

DROP TABLE IF EXISTS `repertoire`;
CREATE TABLE IF NOT EXISTS `repertoire` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `perso_id` int(10) unsigned NOT NULL,
  `contact_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UU_Repertoire_PersoContact` (`perso_id`,`contact_id`),
  KEY `FK_Repertoire_Contact` (`contact_id`),
  KEY `FK_Repertoire_Persos` (`perso_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=4 ;

-- --------------------------------------------------------

--
-- Structure de la table `sexe`
--

DROP TABLE IF EXISTS `sexe`;
CREATE TABLE IF NOT EXISTS `sexe` (
  `id` tinyint(1) unsigned NOT NULL AUTO_INCREMENT,
  `sexe` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `admin` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=6 ;

-- --------------------------------------------------------

--
-- Structure de la table `stat_popvivante`
--

DROP TABLE IF EXISTS `stat_popvivante`;
CREATE TABLE IF NOT EXISTS `stat_popvivante` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` int(11) DEFAULT NULL,
  `nb_joueur_total` int(11) DEFAULT NULL,
  `ange_g0_terre` int(11) DEFAULT NULL,
  `ange_g0_enfer` int(11) DEFAULT NULL,
  `ange_g0_paradis` int(11) DEFAULT NULL,
  `ange_g1_terre` int(11) DEFAULT NULL,
  `ange_g1_enfer` int(11) DEFAULT NULL,
  `ange_g1_paradis` int(11) DEFAULT NULL,
  `ange_g2_terre` int(11) DEFAULT NULL,
  `ange_g2_enfer` int(11) DEFAULT NULL,
  `ange_g2_paradis` int(11) DEFAULT NULL,
  `ange_g3_terre` int(11) DEFAULT NULL,
  `ange_g3_enfer` int(11) DEFAULT NULL,
  `ange_g3_paradis` int(11) DEFAULT NULL,
  `ange_g4_terre` int(11) DEFAULT NULL,
  `ange_g4_enfer` int(11) DEFAULT NULL,
  `ange_g4_paradis` int(11) DEFAULT NULL,
  `ange_g5_terre` int(11) DEFAULT NULL,
  `ange_g5_enfer` int(11) DEFAULT NULL,
  `ange_g5_paradis` int(11) DEFAULT NULL,
  `ange_total` int(11) DEFAULT NULL,
  `demon_g0_terre` int(11) DEFAULT NULL,
  `demon_g0_enfer` int(11) DEFAULT NULL,
  `demon_g0_paradis` int(11) DEFAULT NULL,
  `demon_g1_terre` int(11) DEFAULT NULL,
  `demon_g1_enfer` int(11) DEFAULT NULL,
  `demon_g1_paradis` int(11) DEFAULT NULL,
  `demon_g2_terre` int(11) DEFAULT NULL,
  `demon_g2_enfer` int(11) DEFAULT NULL,
  `demon_g2_paradis` int(11) DEFAULT NULL,
  `demon_g3_terre` int(11) DEFAULT NULL,
  `demon_g3_enfer` int(11) DEFAULT NULL,
  `demon_g3_paradis` int(11) DEFAULT NULL,
  `demon_g4_terre` int(11) DEFAULT NULL,
  `demon_g4_enfer` int(11) DEFAULT NULL,
  `demon_g4_paradis` int(11) DEFAULT NULL,
  `demon_g5_terre` int(11) DEFAULT NULL,
  `demon_g5_enfer` int(11) DEFAULT NULL,
  `demon_g5_paradis` int(11) DEFAULT NULL,
  `demon_total` int(11) DEFAULT NULL,
  `humain_g0_terre` int(11) DEFAULT NULL,
  `humain_g0_enfer` int(11) DEFAULT NULL,
  `humain_g0_paradis` int(11) DEFAULT NULL,
  `humain_g1_terre` int(11) DEFAULT NULL,
  `humain_g1_enfer` int(11) DEFAULT NULL,
  `humain_g1_paradis` int(11) DEFAULT NULL,
  `humain_g2_terre` int(11) DEFAULT NULL,
  `humain_g2_enfer` int(11) DEFAULT NULL,
  `humain_g2_paradis` int(11) DEFAULT NULL,
  `humain_g3_terre` int(11) DEFAULT NULL,
  `humain_g3_enfer` int(11) DEFAULT NULL,
  `humain_g3_paradis` int(11) DEFAULT NULL,
  `humain_g4_terre` int(11) DEFAULT NULL,
  `humain_g4_enfer` int(11) DEFAULT NULL,
  `humain_g4_paradis` int(11) DEFAULT NULL,
  `humain_g5_terre` int(11) DEFAULT NULL,
  `humain_g5_enfer` int(11) DEFAULT NULL,
  `humain_g5_paradis` int(11) DEFAULT NULL,
  `humain_total` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IX_Statistiques_Date` (`date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `utilisateurs`
--

DROP TABLE IF EXISTS `utilisateurs`;
CREATE TABLE IF NOT EXISTS `utilisateurs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Identifiant de l''utilisateur',
  `nom` varchar(64) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Nom (ou pseudo) de l''utilisateur',
  `email` tinytext COLLATE utf8_unicode_ci NOT NULL COMMENT 'Adresse email de l''utilisateur',
  `passwd` char(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Le hash sha1 (ou md5) du mot de pass de l''utilisateur',
  `passwd_forum` char(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT 'password hash pour l''interface avec le forum phpbb3',
  `date_enregistrement` datetime NOT NULL COMMENT 'Date d''enregistrement de l''utilisateur',
  `droits` varchar(8) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0' COMMENT 'Les droits de l''utilisateur',
  `options` tinyint(4) DEFAULT '0' COMMENT 'Les options de l''utilisateur',
  `codevalidation` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT 'code de validation du compte.',
  `session_id` char(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'session_id unique pour la gestion des APIs',
  `bals_speed` float NOT NULL DEFAULT '0.5',
  `template` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  `icones_pack` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `grille` tinyint(1) NOT NULL DEFAULT '0',
  `rose` tinyint(1) NOT NULL DEFAULT '1',
  `redirection` tinyint(1) NOT NULL DEFAULT '1',
  `mail_rp` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'L''utilisateur reçoit les mails "RP"',
  `mail_event` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'l''utilisateur reçoit les mails d''événements',
  `mail_bal` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'L''utilisateur reçoit les BAL par mail',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UU_Utilisateurs_Nom` (`nom`),
  UNIQUE KEY `UU_Utilisateurs_Email` (`email`(50)),
  KEY `IX_Utilisateurs_Passwd` (`passwd`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=104 ;

-- --------------------------------------------------------

--
-- Structure de la table `utilisateurs_ban`
--

DROP TABLE IF EXISTS `utilisateurs_ban`;
CREATE TABLE IF NOT EXISTS `utilisateurs_ban` (
  `utilisateur_id` int(10) unsigned NOT NULL,
  `date` int(11) NOT NULL,
  `date_fin` int(11) NOT NULL,
  `motif` text COLLATE utf8_unicode_ci NOT NULL,
  `statut` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`utilisateur_id`,`date`),
  KEY `FK_UtilisateursBan_Utilisateurs` (`utilisateur_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `utilisateurs_ticket`
--

DROP TABLE IF EXISTS `utilisateurs_ticket`;
CREATE TABLE IF NOT EXISTS `utilisateurs_ticket` (
  `utilisateur_id` int(10) unsigned NOT NULL,
  `ticket` varchar(32) COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT 'Ticket de connection pour l''autologin',
  `expiration` datetime NOT NULL,
  PRIMARY KEY (`utilisateur_id`,`ticket`),
  KEY `IX_UtilisateurTicket_Id` (`utilisateur_id`),
  KEY `IX_UtilisateurTicket_Ticket` (`ticket`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `utilisateurs_vacances`
--

DROP TABLE IF EXISTS `utilisateurs_vacances`;
CREATE TABLE IF NOT EXISTS `utilisateurs_vacances` (
  `utilisateur_id` int(10) unsigned NOT NULL,
  `date_demande` datetime NOT NULL,
  `date_depart` datetime NOT NULL,
  `date_retour` datetime NOT NULL,
  `traite` enum('0','1') COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`utilisateur_id`,`date_demande`),
  KEY `FK_UtilisateursVacances_Utilisateurs` (`utilisateur_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `wait_affil`
--

DROP TABLE IF EXISTS `wait_affil`;
CREATE TABLE IF NOT EXISTS `wait_affil` (
  `superieur` int(10) unsigned NOT NULL,
  `vassal` int(10) unsigned NOT NULL,
  `vassal_id` mediumint(8) unsigned NOT NULL,
  PRIMARY KEY (`superieur`,`vassal`),
  KEY `FK_WaitAffil_Superieur` (`superieur`),
  KEY `FK_WaitAffil_Vassal` (`vassal`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `wait_faction`
--

DROP TABLE IF EXISTS `wait_faction`;
CREATE TABLE IF NOT EXISTS `wait_faction` (
  `perso_id` int(10) unsigned NOT NULL,
  `faction_id` mediumint(8) unsigned NOT NULL,
  `demandeur` bit(1) NOT NULL DEFAULT b'0' COMMENT 'Vaut 1 si l''utilisateur est le demandeur, 0 si c''est la faction',
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `utilisateur_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_WaitFaction_Persos` (`perso_id`),
  KEY `FK_WaitFaction_Factions` (`faction_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=7 ;

-- --------------------------------------------------------

--
-- Structure de la vue `bals_listeview`
--
DROP TABLE IF EXISTS `bals_listeview`;

CREATE VIEW `bals_listeview` AS select `bals_listes`.`id` AS `id`,`bals_listes`.`libelle` AS `libelle`,`bals_listes`.`ouverture` AS `ouverture`,`bals_listes`.`type` AS `type`,`bals_listes`.`camp` AS `camp`,`bals_listes`.`owner` AS `owner`,`bals_listes`.`liste` AS `liste`,`persos`.`grade_id` AS `grade`,`damier_persos`.`pos_x` AS `pos_x`,`damier_persos`.`pos_y` AS `pos_y`,`damier_persos`.`carte_id` AS `carte` from ((`bals_listes` left join `persos` on((`persos`.`id` = `bals_listes`.`owner`))) left join `damier_persos` on((`damier_persos`.`perso_id` = `persos`.`id`)));

-- --------------------------------------------------------

--
-- Structure de la vue `classement_view`
--
DROP TABLE IF EXISTS `classement_view`;

CREATE VIEW `classement_view` AS select curdate() AS `date`,`persos`.`id` AS `id`,`persos`.`nom` AS `nom`,`persos`.`race_id` AS `race`,`races`.`camp_id` AS `camp`,`races`.`type` AS `type`,`persos`.`grade_id` AS `grade`,`persos`.`galon_id` AS `galon`,`caracs`.`px` AS `px`,(select count(0) AS `COUNT( * )` from `morgue` where (`morgue`.`id_perso` = `persos`.`id`)) AS `tueur`,(select count(0) AS `COUNT( * )` from `morgue` where (`morgue`.`mat_victime` = `persos`.`id`)) AS `mort`,`persos`.`utilisateur_id` AS `joueur`,`persos`.`nom_race` AS `nom_race` from ((`persos` join `caracs` on((`caracs`.`perso_id` = `persos`.`id`))) join `races` on(((`races`.`race_id` = `persos`.`race_id`) and (`races`.`grade_id` = 0)))) where (`races`.`camp_id` < 5) group by `persos`.`id` order by `persos`.`id`;

--
-- Contraintes pour les tables exportées
--

--
-- Contraintes pour la table `api_key`
--
ALTER TABLE `api_key`
  ADD CONSTRAINT `api_key_ibfk_1` FOREIGN KEY (`utilisateur_id`) REFERENCES `utilisateurs` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `at_log_at`
--
ALTER TABLE `at_log_at`
  ADD CONSTRAINT `at_log_at_ibfk_1` FOREIGN KEY (`id`) REFERENCES `at_log` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `at_log_connexion`
--
ALTER TABLE `at_log_connexion`
  ADD CONSTRAINT `at_log_connexion_ibfk_1` FOREIGN KEY (`navigateur`) REFERENCES `at_navigateur` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `at_log_inter_geo`
--
ALTER TABLE `at_log_inter_geo`
  ADD CONSTRAINT `at_log_inter_geo_ibfk_1` FOREIGN KEY (`id`) REFERENCES `at_log` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `at_log_inter_geo_ibfk_2` FOREIGN KEY (`id_perso1`) REFERENCES `persos` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `at_log_inter_geo_ibfk_3` FOREIGN KEY (`id_perso2`) REFERENCES `persos` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `at_log_inter_geo_ibfk_4` FOREIGN KEY (`ref`) REFERENCES `at_log_inter_geo` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `at_log_inter_geo_ibfk_5` FOREIGN KEY (`carte_id`) REFERENCES `cartes` (`id`);

--
-- Contraintes pour la table `at_members`
--
ALTER TABLE `at_members`
  ADD CONSTRAINT `at_members_ibfk_1` FOREIGN KEY (`id`) REFERENCES `utilisateurs` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `bals`
--
ALTER TABLE `bals`
  ADD CONSTRAINT `bals_ibfk_1` FOREIGN KEY (`corps_id`) REFERENCES `bals_corps` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `bals_ibfk_2` FOREIGN KEY (`perso_src_id`) REFERENCES `persos` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `bals_ibfk_3` FOREIGN KEY (`perso_dest_id`) REFERENCES `persos` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Contraintes pour la table `bals_listes`
--
ALTER TABLE `bals_listes`
  ADD CONSTRAINT `bals_listes_ibfk_1` FOREIGN KEY (`camp`) REFERENCES `camps` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `bals_listes_ibfk_2` FOREIGN KEY (`owner`) REFERENCES `persos` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Contraintes pour la table `bals_send`
--
ALTER TABLE `bals_send`
  ADD CONSTRAINT `bals_send_ibfk_1` FOREIGN KEY (`perso_src_id`) REFERENCES `persos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `blocks`
--
ALTER TABLE `blocks`
  ADD CONSTRAINT `blocks_ibfk_1` FOREIGN KEY (`perso_id`) REFERENCES `persos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `camps`
--
ALTER TABLE `camps`
  ADD CONSTRAINT `camps_ibfk_1` FOREIGN KEY (`carte_id`) REFERENCES `cartes` (`id`) ON UPDATE CASCADE;

--
-- Contraintes pour la table `caracs`
--
ALTER TABLE `caracs`
  ADD CONSTRAINT `caracs_ibfk_1` FOREIGN KEY (`perso_id`) REFERENCES `persos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `caracs_alter`
--
ALTER TABLE `caracs_alter`
  ADD CONSTRAINT `caracs_alter_ibfk_1` FOREIGN KEY (`perso_id`) REFERENCES `persos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `caracs_alter_affi`
--
ALTER TABLE `caracs_alter_affi`
  ADD CONSTRAINT `caracs_alter_affi_ibfk_1` FOREIGN KEY (`perso_id`) REFERENCES `persos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `caracs_alter_artefact`
--
ALTER TABLE `caracs_alter_artefact`
  ADD CONSTRAINT `caracs_alter_artefact_ibfk_1` FOREIGN KEY (`case_artefact_id`) REFERENCES `case_artefact` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `caracs_alter_camp`
--
ALTER TABLE `caracs_alter_camp`
  ADD CONSTRAINT `caracs_alter_camp_ibfk_1` FOREIGN KEY (`camp_id`) REFERENCES `races` (`race_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `caracs_alter_mag`
--
ALTER TABLE `caracs_alter_mag`
  ADD CONSTRAINT `caracs_alter_mag_ibfk_1` FOREIGN KEY (`perso_id`) REFERENCES `persos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `case_artefact`
--
ALTER TABLE `case_artefact`
  ADD CONSTRAINT `case_artefact_ibfk_1` FOREIGN KEY (`categorie_id`) REFERENCES `categorie_artefact` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `case_objet_complexe`
--
ALTER TABLE `case_objet_complexe`
  ADD CONSTRAINT `case_objet_complexe_ibfk_1` FOREIGN KEY (`categorie_id`) REFERENCES `categorie_objet_complexe` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `case_objet_simple`
--
ALTER TABLE `case_objet_simple`
  ADD CONSTRAINT `case_objet_simple_ibfk_1` FOREIGN KEY (`categorie_id`) REFERENCES `categorie_objet_simple` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `case_terrain`
--
ALTER TABLE `case_terrain`
  ADD CONSTRAINT `case_terrain_ibfk_1` FOREIGN KEY (`categorie_id`) REFERENCES `categorie_terrain` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `damier_artefact`
--
ALTER TABLE `damier_artefact`
  ADD CONSTRAINT `damier_artefact_ibfk_1` FOREIGN KEY (`carte_id`) REFERENCES `cartes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `damier_bouclier`
--
ALTER TABLE `damier_bouclier`
  ADD CONSTRAINT `damier_bouclier_ibfk_1` FOREIGN KEY (`carte_id`) REFERENCES `cartes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `damier_bouclier_ibfk_2` FOREIGN KEY (`objet_lie`) REFERENCES `damier_objet_complexe` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `damier_objet_complexe`
--
ALTER TABLE `damier_objet_complexe`
  ADD CONSTRAINT `damier_objet_complexe_ibfk_1` FOREIGN KEY (`carte_id`) REFERENCES `cartes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `damier_objet_complexe_ibfk_2` FOREIGN KEY (`case_objet_complexe_id`) REFERENCES `case_objet_complexe` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `damier_spawn`
--
ALTER TABLE `damier_spawn`
  ADD CONSTRAINT `damier_spawn_ibfk_1` FOREIGN KEY (`carte_id`) REFERENCES `cartes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `damier_terrain`
--
ALTER TABLE `damier_terrain`
  ADD CONSTRAINT `damier_terrain_ibfk_1` FOREIGN KEY (`carte_id`) REFERENCES `cartes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `damier_terrain_ibfk_2` FOREIGN KEY (`terrain_id`) REFERENCES `case_terrain` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `factions`
--
ALTER TABLE `factions`
  ADD CONSTRAINT `factions_ibfk_1` FOREIGN KEY (`race`) REFERENCES `camps` (`id`) ON UPDATE CASCADE;

--
-- Contraintes pour la table `grimoire`
--
ALTER TABLE `grimoire`
  ADD CONSTRAINT `grimoire_ibfk_1` FOREIGN KEY (`id_perso`) REFERENCES `persos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `grimoire_ibfk_2` FOREIGN KEY (`id_sort`) REFERENCES `action` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `icone_persos`
--
ALTER TABLE `icone_persos`
  ADD CONSTRAINT `icone_persos_ibfk_1` FOREIGN KEY (`sexe_id`) REFERENCES `sexe` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `inventaire`
--
ALTER TABLE `inventaire`
  ADD CONSTRAINT `inventaire_ibfk_1` FOREIGN KEY (`perso_id`) REFERENCES `persos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `inventaire_ibfk_2` FOREIGN KEY (`case_artefact_id`) REFERENCES `case_artefact` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `medailles`
--
ALTER TABLE `medailles`
  ADD CONSTRAINT `medailles_ibfk_1` FOREIGN KEY (`id_perso`) REFERENCES `persos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `medailles_ibfk_2` FOREIGN KEY (`id_medaille`) REFERENCES `medailles_liste` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `notifications`
--
ALTER TABLE `notifications`
  ADD CONSTRAINT `notifications_ibfk_1` FOREIGN KEY (`utilisateur_id`) REFERENCES `utilisateurs` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `persos`
--
ALTER TABLE `persos`
  ADD CONSTRAINT `persos_ibfk_2` FOREIGN KEY (`utilisateur_id`) REFERENCES `utilisateurs` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `persos_ibfk_5` FOREIGN KEY (`superieur_id`) REFERENCES `persos` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `persos_ibfk_6` FOREIGN KEY (`sexe`) REFERENCES `sexe` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Contraintes pour la table `persos_familier`
--
ALTER TABLE `persos_familier`
  ADD CONSTRAINT `persos_familier_ibfk_1` FOREIGN KEY (`persos_id`) REFERENCES `persos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `races`
--
ALTER TABLE `races`
  ADD CONSTRAINT `races_ibfk_1` FOREIGN KEY (`camp_id`) REFERENCES `camps` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `record`
--
ALTER TABLE `record`
  ADD CONSTRAINT `record_ibfk_1` FOREIGN KEY (`perso_id`) REFERENCES `persos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `repertoire`
--
ALTER TABLE `repertoire`
  ADD CONSTRAINT `repertoire_ibfk_1` FOREIGN KEY (`perso_id`) REFERENCES `persos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `repertoire_ibfk_2` FOREIGN KEY (`contact_id`) REFERENCES `persos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `utilisateurs_ban`
--
ALTER TABLE `utilisateurs_ban`
  ADD CONSTRAINT `utilisateurs_ban_ibfk_1` FOREIGN KEY (`utilisateur_id`) REFERENCES `utilisateurs` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `utilisateurs_ticket`
--
ALTER TABLE `utilisateurs_ticket`
  ADD CONSTRAINT `utilisateurs_ticket_ibfk_1` FOREIGN KEY (`utilisateur_id`) REFERENCES `utilisateurs` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `utilisateurs_vacances`
--
ALTER TABLE `utilisateurs_vacances`
  ADD CONSTRAINT `utilisateurs_vacances_ibfk_1` FOREIGN KEY (`utilisateur_id`) REFERENCES `utilisateurs` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `wait_affil`
--
ALTER TABLE `wait_affil`
  ADD CONSTRAINT `wait_affil_ibfk_1` FOREIGN KEY (`superieur`) REFERENCES `persos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `wait_affil_ibfk_2` FOREIGN KEY (`vassal`) REFERENCES `persos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `wait_faction`
--
ALTER TABLE `wait_faction`
  ADD CONSTRAINT `wait_faction_ibfk_1` FOREIGN KEY (`faction_id`) REFERENCES `factions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `wait_faction_ibfk_2` FOREIGN KEY (`perso_id`) REFERENCES `persos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;


--
-- Contenu de la table `action`
--

INSERT IGNORE INTO `action` (`id`, `nom`, `description`, `cout`, `cercle_id`, `niv`, `race`, `grade`, `galon`, `zone`, `cible`, `lanceur`, `id_effet`, `type_cible`, `type_action`) VALUES
(1, 'Attaquer', 'Attaque un personnage', 1, 0, 0, '1111', -2, 0, 0, 1, 0, '0:1', 'both', 'attaque'),
(2, 'Sentrainer', 'Entrainement', 1, 0, 0, '1111', -2, 0, 0, 1, 1, '0:1', 'both', 'entrainement'),
(3, 'Réparation', 'Action de réparation d''objets', 1, 0, 0, '1111', -2, 0, 0, 1, 0, '0:1', 'both', 'reparation'),
(4, 'Sprint', 'Utiliser ses PA restant pour les transformer en mouv.', 0, 0, 0, '1111', -2, 0, 0, 0, 1, '2:0', 'allie', 'sprint'),
(5, 'Suicide', 'Exercer une vengeance personnelle.', 0, 0, 0, '1111', -2, 0, 0, 0, 1, '3:0', 'allie', 'suicide'),
(6, 'Hymne National||Chants Céleste|Vocifération Démoniaque', '[Annulé] +2 Atk sur 1 cible', 1, 0, 0, '0000', -2, 0, 0, 1, 1, '0:169', 'choix', 'sort'),
(7, 'Pensées Familiales||Pensées Pieuses|Pensées lubriques', '[Annulé] +2 en défense sur 1 cible', 1, 0, 0, '0000', -2, 0, 0, 1, 1, '0:170', 'choix', 'sort'),
(8, 'Bière||Eau de vie|Orangina rouge', '+ 5 PV sur 1 cible', 1, 0, 0, '1011', -2, 0, 0, 1, 1, '0:221', 'choix', 'sort'),
(9, 'Flammèche', '-40 PV sur 1 cible', 2, 1, 1, '0011', -2, 0, 0, 0, 0, '0:13', 'choix', 'sort'),
(10, 'Brasier', '-30 PV -1 DEF sur la perception', 2, 1, 1, '0011', -2, 0, -2, 0, 0, '0:194,8', 'choix', 'sort'),
(11, 'Flammiche', '-24 PV sur 1 cible', 1, 1, 2, '0011', -2, 0, 0, 0, 0, '0:153', 'choix', 'sort'),
(12, 'Boule de feu', '-18 PV -1 DEF sur la perception', 1, 1, 2, '0011', -2, 0, -2, 0, 0, '0:154,194', 'choix', 'sort'),
(13, 'Frénésie', '+4 ATK +10% Recup''PV +10% Force -2 DEF sur 1 cible', 2, 1, 2, '0011', -2, 0, 0, 0, 0, '0:171,20,25,195', 'choix', 'sort'),
(14, 'Légion enragée', '+3 ATK +10% Recup''PV +10% Force -2 DEF sur la perception', 2, 1, 3, '0011', -2, 0, -2, 0, 1, '0:171,175,25,196', 'choix', 'sort'),
(15, '||Sceau de Célestia|Sceau de Ciféris', '+70 PV -8 DEF sur 1 cible', 2, 1, 3, '0011', -2, 0, 0, 0, 1, '0:155,176', 'choix', 'sort'),
(16, 'Canicule', '-1% PV -15% Récup''PV -4 DEF sur 1 cible', 2, 1, 3, '0011', -2, 0, 0, 0, 0, '0:172,29,30', 'choix', 'sort'),
(17, '||Sceau de Selvaria|Sceau de Kazuya', '+100 PV + 10% Recup''PV -10 DEF sur la perception', 3, 1, 4, '0011', -2, 0, -2, 0, 1, '0:177,25,33', 'choix', 'sort'),
(18, 'Fournaise', '-15 PV -25% Récup''PV -4 DEF sur la perception', 2, 1, 4, '0011', -2, 0, -2, 0, 0, '0:172,157,18', 'choix', 'sort'),
(19, '||Annulé Colère de Selvaria|Annulé Colère de Kazuya', '[Annulé] -150 PV -8 DEF sur 1 cible', 3, 1, 4, '0000', -2, 0, 0, 0, 0, '0:176,41', 'choix', 'sort'),
(20, 'Fourneau des Abysses', '-25 PV -35% Récup''PV -5 DEF sur la perception', 3, 1, 5, '0011', -2, 0, -2, 0, 0, '0:197,160,64', 'choix', 'sort'),
(21, '||Colère de Selvaria|Colère du Tyran', '-130 PV -7 DEF sur la perception', 4, 1, 5, '0011', -2, 0, -2, 0, 0, '0:200,199', 'choix', 'sort'),
(22, 'Désenvoûtement', 'Annule les effets de TechnoMagie précédents sur 1 cible', 1, 1, 5, '0011', -2, 0, 0, 1, 1, '0:0', 'choix', 'sort'),
(23, 'Neige', '-40 PV sur 1 cible', 2, 2, 1, '0011', -2, 0, 0, 0, 0, '0:13', 'choix', 'sort'),
(24, 'Glacier', '-30 PV -1 ATK sur la perception', 2, 2, 1, '0011', -2, 0, -2, 0, 0, '0:198,8', 'choix', 'sort'),
(25, 'Gel', '-24 PV sur 1 cible', 1, 2, 2, '1011', -2, 0, 0, 0, 0, '0:153', 'choix', 'sort'),
(26, 'Boule de neige', '-18 PV -1 ATK sur la perception', 1, 2, 2, '0011', -2, 0, -2, 0, 0, '0:198,154', 'choix', 'sort'),
(27, 'Frénésie', '+4 ATK +10% Recup''PV +10% Force -2 DEF sur 1 cible', 2, 2, 2, '0011', -2, 0, 0, 0, 1, '0:171,175,25,195', 'choix', 'sort'),
(28, 'Légion enragée', '+3 ATK +10% Recup''PV +10% Force -2 DEF sur la perception', 2, 2, 3, '0011', -2, 0, -2, 0, 1, '0:171,175,25,196', 'choix', 'sort'),
(29, '||Sceau de Célestia|Sceau de Ciféris', '+70 PV -8 DEF sur 1 cible', 2, 2, 3, '0011', -2, 0, 0, 0, 1, '0:176,155', 'choix', 'sort'),
(30, 'Vent glacial', '-1% PV -15% Récup''PV -4 DEF sur 1 cible', 2, 2, 3, '0011', -2, 0, 0, 0, 0, '0:172,29,30', 'choix', 'sort'),
(31, '||Sceau de Selvaria|Sceau de Kazuya', '+100 PV + 10% Recup''PV -10 DEF sur la perception', 3, 2, 4, '0011', -2, 0, -2, 0, 1, '0:177,25,33', 'choix', 'sort'),
(32, 'Blizzard', '-15 PV -25% Récup''PV -4 DEF sur la perception', 2, 2, 4, '0011', -2, 0, -2, 0, 0, '0:172,157,18', 'choix', 'sort'),
(33, '||Annulé  Colère de Selvaria|Annulé  Colère de Kazuya', '[Annulé] -150 PV -8 DEF sur 1 cible', 3, 2, 4, '0000', -2, 0, 0, 0, 0, '0:176,41', 'choix', 'sort'),
(34, 'Zéro absolu', '-25 PV -35% Récup''PV -5 DEF sur la perception', 3, 2, 5, '0011', -2, 0, -2, 0, 0, '0:197,160,64', 'choix', 'sort'),
(35, '||Colère de l''Impératrice|Colère de Kazuya', '-130 PV -7 DEF sur la perception', 4, 2, 5, '0011', -2, 0, -2, 0, 0, '0:199,200', 'choix', 'sort'),
(36, 'Désenvoûtement', 'Annule les effets de TechnoMagie précédents sur 1 cible', 1, 2, 5, '0011', -2, 0, 0, 1, 1, '0:0', 'choix', 'sort'),
(37, 'Brouillard', '-30% Perception sur la perception', 2, 5, 1, '0011', -2, 0, -2, 0, 0, '0:49', 'choix', 'sort'),
(38, 'Armure en mousse', '-2 DEF -10PV sur 1 cible', 1, 5, 1, '0011', -2, 0, 0, 0, 0, '0:36,171', 'choix', 'sort'),
(39, 'Arme de guimauve', '-2 ATK -10PV sur 1 cible', 1, 5, 1, '0011', -2, 0, 0, 0, 0, '0:36,179', 'choix', 'sort'),
(40, 'Engourdissement', '-10% Force -10PV sur 1 cible', 1, 5, 1, '0011', -2, 0, 0, 0, 0, '0:51,36', 'choix', 'sort'),
(41, 'Voile opaque', '-25% Perception sur 1 cible', 1, 5, 2, '0011', -2, 0, 0, 0, 0, '0:54', 'choix', 'sort'),
(42, 'Armure d''engelures', '-3 DEF -20 PV sur la perception', 2, 5, 2, '0011', -2, 0, -2, 0, 0, '0:201,16', 'choix', 'sort'),
(43, 'Glissement de terrain', '-10% Mouv -10PV sur 1 cible', 2, 5, 2, '0011', -2, 0, 0, 0, 0, '0:55,36', 'choix', 'sort'),
(44, 'Petit canard en plastique jaune', '-3 ATK -20 PV sur la perception', 2, 5, 2, '0011', -2, 0, -2, 0, 0, '0:202,16', 'choix', 'sort'),
(45, 'Courbatures', '-20% Force -20PV sur la perception', 2, 5, 2, '0011', -2, 0, -2, 0, 0, '0:59,16', 'choix', 'sort'),
(46, 'Fatigue', '-1PA +5XP sur 1 cible', 2, 5, 3, '0011', -2, 0, 0, 0, 0, '0:163,61', 'choix', 'sort'),
(47, 'Tremblement de terre', '-20% Mouv -30PV sur la perception', 3, 5, 3, '0011', -2, 0, -2, 0, 0, '0:62,8', 'choix', 'sort'),
(48, 'Nécromancie', '[Pas encore fonctionnel] Pour ramener des alliés plus très frais (voir Guide du Jeu)', 3, 5, 3, '0011', -2, 0, 0, 0, 0, '63,64:63,64,63,64,97', 'none', 'sort'),
(49, 'Désenvoûtement', 'Annule les effets de TechnoMagie précédents sur 1 cible', 1, 5, 3, '0011', -2, 0, 0, 1, 1, '0:0', 'choix', 'sort'),
(50, 'Epuisement', '-2PA +10XP sur 1 cible', 3, 5, 4, '0011', -2, 0, 0, 0, 0, '0:66,162', 'choix', 'sort'),
(51, 'Moquerie', '-30% Effet -40PV sur 1 cible', 2, 5, 4, '0011', -2, 0, 0, 0, 0, '0:67,13', 'choix', 'sort'),
(52, 'Infection', 'S''applique sur le dernier agresseur du mage : -4 DEF -30PV', 2, 5, 4, '0011', -2, 0, 0, 0, 0, '0:172,8', 'none', 'sort'),
(53, 'Brûlure de fluide', 'Retire 1 Fluide à son porteur s''il en possède (voir Guide du Jeu)', 2, 5, 5, '0011', -2, 0, 0, 0, 0, '0:83', 'choix', 'sort'),
(54, 'Dimension de la flexibilité', '-5 ATK -30% Force -30 PV sur la perception', 3, 5, 5, '0011', -2, 0, -2, 0, 0, '0:203,8,69', 'choix', 'sort'),
(55, 'Chaos', '-70% Perception -12 DEF -30% Recup''PV +12 ATK +30% Force +10% Mouv sur la perception', 4, 5, 5, '0011', -2, 0, -2, 0, 0, '0:74,178,71,72,184,39', 'choix', 'sort'),
(56, 'Feinte de mouvement', 'Rajoute un (?) mouv dans les évènements publics du mage.', 1, 3, 1, '0011', -2, 0, 0, 0, 1, '76:0', 'allie', 'sort'),
(57, 'Permutation', 'Le mage permute de place avec un personnage de son camp', 1, 3, 1, '0011', -2, 0, 0, 1, 0, '0:84', 'allie', 'sort'),
(58, 'Immunité au terrain', 'Tous les déplacements de la cible lui coûte qu''1 point de mouvement, quelque soit le type de terrain.', 1, 3, 1, '0011', -2, 0, 0, 0, 1, '0:82', 'allie', 'sort'),
(59, 'Retard', 'Retarde de 30 minutes la DLA d''un personnage de son camp (22h =&gt; 22h30)', 1, 3, 1, '0011', -2, 0, 0, 0, 1, '0:77', 'allie', 'sort'),
(60, 'Jouvence', '+15% Récup''PV +10% Mouv sur 1 cible', 2, 3, 2, '0011', -2, 0, 0, 0, 1, '0:71,80', 'choix', 'sort'),
(61, 'Sénescence', '-15% Récup''PV -10% Mouv sur 1 cible', 2, 3, 2, '0011', -2, 0, 0, 0, 1, '0:55,29', 'choix', 'sort'),
(62, 'Impatience', 'Avance d''une heure la DLA du mage (22h00 =&gt; 21h00)', 1, 3, 2, '0011', -2, 0, 0, 0, 1, '0:81', 'allie', 'sort'),
(63, 'Favoritisme', 'Le mage permute 2 personnages de son camp', 1, 3, 2, '0011', -2, 0, 0, 2, 0, '0:84', 'allie', 'sort'),
(64, 'Home Sweet Home', 'Le mage téléporte un personnage de son camp dans son plan.', 1, 3, 3, '0011', -2, 0, 0, 0, 1, '0:85', 'allie', 'sort'),
(65, 'Téléportation balbutiante', 'Le mage (se) téléporte dans la moitié de sa perception.', 1, 3, 3, '0011', -2, 0, -1, 0, 2, '86:0', 'none', 'sort'),
(66, 'Raccourci temporel', 'Avance de 30 minutes la DLA d''un personnage de son camp ( 22h00 =&gt; 21h30 )', 1, 3, 3, '0011', -2, 0, 0, 1, 1, '0:87', 'allie', 'sort'),
(67, 'Encouragement', '+25% Mouv sur 1 cible', 1, 3, 4, '0011', -2, 0, 0, 0, 1, '0:89', 'choix', 'sort'),
(68, 'Ralentissement du temps', '-25% Mouv sur 1 cible', 1, 3, 4, '0011', -2, 0, 0, 0, 0, '0:91', 'choix', 'sort'),
(69, 'Téléportation maitrisée', 'Le mage se téléporte dans sa perception.', 1, 3, 4, '0011', -2, 0, -2, 0, 2, '86:0', 'none', 'sort'),
(70, 'Porte à porte', '[Pas fonctionnel] Le mage téléporte un personnage de son camp vers une porte de son camp.', 1, 3, 4, '0011', -2, 0, -3, 0, 1, '0:86', 'allie', 'sort'),
(71, 'Retour dans le passé', 'Fait revenir la cible sur sa dernière case.', 2, 3, 5, '0011', -2, 0, 0, 1, 1, '0:92', 'choix', 'sort'),
(72, 'Temps Mort', '-2 PA +10XP +2h sur la DLA sur 1 cible', 3, 3, 5, '0011', -2, 0, 0, 1, 0, '0:93,162,66', 'choix', 'sort'),
(73, 'Echange dangereux', 'Le mage permute sa place avec un ennemi.', 3, 3, 5, '0011', -2, 0, 0, 1, 0, '0:84', 'choix', 'sort'),
(74, 'Ultime Téléportation', '[Temporairement désactivé !] Le mage se téléporte où il veut sur Althian.', 2, 3, 5, '0011', -2, 0, -3, 0, 0, '0:0', 'none', 'sort'),
(75, 'Fin des Temps', '+1 PA +50% Force +10 ATK -30% Récup''PV -10 DEF sur la perception', 4, 3, 5, '0011', -2, 0, -2, 0, 0, '0:177,39,181,95,96', 'choix', 'sort'),
(76, 'Désenvoûtement', 'Annule les effets de TechnoMagie précédents sur 1 cible', 1, 3, 5, '0011', -2, 0, 0, 1, 1, '0:0', 'choix', 'sort'),
(87, 'Désenvoûtement', 'Annule les effets de TechnoMagie précédents sur 1 cible', 1, 4, 3, '0011', -2, 0, 0, 1, 1, '0:0', 'choix', 'sort'),
(90, 'Fuite', '+30% Mouv -80PV', 2, 6, 1, '0100', -2, 0, 0, 0, 1, '116,117:0', 'allie', 'sort'),
(91, 'Reincarnum', '[Pas encore fonctionnel] Ramener des alliés plus très frais (voir Guide du Jeu)', 3, 4, 5, '0011', -2, 0, -1, 0, 1, '0:97', 'allie', 'sort'),
(92, 'Parole de Lui Sait Faire', '+50% effets sur la perception', 3, 4, 5, '0011', -2, 0, -2, 0, 0, '0:189', 'choix', 'sort'),
(93, '||Marteau qui fait pouic|Peluche qui fait groumpf', 'Pouic! Groupf! Apwal ! (Ah non, pas ici)', 1, 5, 5, '0000', 5, 0, 0, 1, 0, '0:36,118,119', 'both', 'sort'),
(94, 'Saut de puce', '[Temporairement désactivé !] Téléportation aléatoire dans la perception du mage', 1, 6, 1, '0100', -2, 0, -1, 1, 1, '0:0', 'none', 'sort'),
(95, 'Aspiration de vélocité', '20% des mouvs de la cible est retiré et donné au mage.', 1, 6, 1, '0100', -2, 0, 0, 1, 0, '0:120', 'choix', 'sort'),
(96, 'Aspiration de régénération', '50% de la Récup''PV de la cible est retiré et donné au mage.', 1, 6, 1, '0100', -2, 0, 0, 1, 0, '0:121', 'choix', 'sort'),
(97, 'Aspiration de force', '50% de la force de la cible est retiré et donné au mage.', 1, 6, 2, '0100', -2, 0, 0, 1, 0, '0:122', 'choix', 'sort'),
(98, 'Aspiration obscurantiste', '20% de la perception de la cible est retiré et donné au mage.', 1, 6, 2, '0100', -2, 0, 0, 1, 0, '0:123', 'choix', 'sort'),
(99, 'Aspiration de dextérité', '20% du potentiel offensif de la cible est retiré et donné au mage.', 1, 6, 2, '0100', -2, 0, 0, 1, 0, '0:124', 'choix', 'sort'),
(100, 'Transfert de vélocité', '20% des mouvs max du mage sont retirés à la cible au bénéfice du mage.', 1, 6, 3, '0100', -2, 0, 0, 0, 1, '0:125', 'choix', 'sort'),
(101, 'Transfert de force', '30% de la force max du mage est retiré à la cible au bénéfice du mage.', 1, 6, 3, '0100', -2, 0, 0, 0, 1, '0:126', 'choix', 'sort'),
(102, 'Transfert obscurantiste', '30% de la perception du mage est retiré à la cible au bénéfice du mage.', 1, 6, 3, '0100', -2, 0, 0, 0, 1, '0:127', 'choix', 'sort'),
(103, 'Transfert de dextérité', '20% du potentiel offensif du mage est retiré à la cible au bénéfice du mage.', 1, 6, 3, '0100', -2, 0, 0, 0, 1, '0:128', 'choix', 'sort'),
(104, 'Aspiration de vitalité', '50PV +5% PV de la cible sont retirés et donnés au mage.', 2, 6, 4, '0100', -2, 0, 0, 0, 1, '0:129,130', 'choix', 'sort'),
(105, 'Aspiration de défensive', '20% du potentiel défensif de la cible est retiré et donné au mage.', 1, 6, 4, '0100', -2, 0, 0, 0, 1, '0:131', 'choix', 'sort'),
(106, 'Aspiration d''action', '1 PA de la cible est retiré et donné au mage.', 2, 6, 4, '0100', -2, 0, 0, 0, 1, '0:132,163', 'choix', 'sort'),
(107, 'Désenvoûtement', 'Annule les effets de TechnoMagie précédents sur 1 cible', 1, 6, 4, '0100', -2, 0, 0, 1, 1, '0:0', 'choix', 'sort'),
(108, 'Transfert de vitalité', '50PV +5% du mage sont retirés à la cible au bénéfice du mage.', 2, 6, 5, '0100', -2, 0, 0, 0, 1, '0:133,134', 'choix', 'sort'),
(109, 'Transfert défensif', '20% du potentiel défensif max du mage est retiré à la cible et donné au bénéfice du mage.', 1, 6, 5, '0100', -2, 0, 0, 0, 1, '0:135', 'choix', 'sort'),
(110, 'Reincarnum désespéré', '[Pas encore fonctionnel] Pour ramener des "alliés" plus très frais (voir Guide du Jeu)', 2, 6, 5, '0100', -2, 0, -1, 0, 1, '0:97', 'allie', 'sort'),
(111, '1ers secours', '+20 PV sur 1 cible', 2, 7, 1, '1000', -2, 0, 0, 0, 1, '0:104', 'choix', 'sort'),
(112, 'Centre d''opération chirurgicale', '+15 PV sur la perception', 2, 7, 1, '1000', -2, 0, -2, 0, 0, '0:107', 'choix', 'sort'),
(113, 'Fusil à glue', '-2 ATK  et -15 PV sur 1 cible', 1, 7, 1, '1000', -2, 0, 0, 0, 0, '0:18,179', 'choix', 'sort'),
(114, 'Canon à glue', '-1 ATK et -10 PV sur la perception', 1, 7, 1, '1000', -2, 0, -2, 0, 0, '0:36,198', 'choix', 'sort'),
(115, 'Veste de kevlar', '+2 DEF sur 1 cible', 1, 7, 1, '1000', -2, 0, 0, 0, 1, '0:170', 'choix', 'sort'),
(116, 'Régiment de kevlar', '+1 DEF +5 PV sur la perception', 1, 7, 1, '1000', -2, 0, -2, 0, 0, '0:205,221', 'choix', 'sort'),
(117, 'Coma artificiel', '+15 % Regen sur 1 cible', 1, 7, 1, '1000', -2, 0, 0, 0, 1, '0:222', 'choix', 'sort'),
(118, 'Caisson de régénération', '+10 % Regen sur la perception', 1, 7, 1, '1000', -2, 0, -2, 0, 0, '0:21', 'choix', 'sort'),
(119, 'Taser', '-2 DEF -15PV sur 1 cible', 1, 7, 2, '1000', -2, 0, 0, 0, 1, '0:171,18', 'choix', 'sort'),
(120, 'Filet électrifié', '-1 DEF -10PV sur la perception', 1, 7, 2, '1000', -2, 0, -2, 0, 0, '0:194,36', 'choix', 'sort'),
(121, 'Anabolisants', '+2 ATK +5 PV sur 1 cible', 1, 7, 2, '1000', -2, 0, 0, 0, 1, '0:169,221', 'choix', 'sort'),
(122, 'Ration d''amphétamines', '+1 ATK +5 PV sur la perception', 1, 7, 2, '1000', -2, 0, -2, 0, 0, '0:206,221', 'choix', 'sort'),
(123, 'Mauvaise came', '-10% Regen - 20% Force sur 1 cible', 1, 7, 2, '1000', -2, 0, 0, 0, 1, '0:212,59', 'choix', 'sort'),
(124, 'Roquette tranquillisante', '-5% Regen - 15% Force sur la perception', 1, 7, 2, '1000', -2, 0, -2, 0, 0, '0:211,142', 'choix', 'sort'),
(125, 'Grenade aveuglante', '-25% Perception sur 1 cible', 1, 7, 3, '1000', -2, 0, 0, 0, 1, '0:54', 'choix', 'sort'),
(126, 'Fusée aveuglante', '-30% Perception et -20 PV sur la perception', 2, 7, 3, '1000', -2, 0, -2, 0, 0, '0:49,16', 'choix', 'sort'),
(127, 'Jet-pack', '+15% Mouv sur 1 cible', 1, 7, 3, '1000', -2, 0, 0, 0, 1, '0:207', 'choix', 'sort'),
(128, 'Promo sur les Jet-pack', '+10% Mouv sur la perception', 2, 7, 3, '1000', -2, 0, -2, 0, 0, '0:71', 'choix', 'sort'),
(129, 'Permutation', 'Le technicien permute de place avec un personnage de son camp.', 1, 7, 3, '1000', -2, 0, 0, 1, 0, '0:84', 'allie', 'sort'),
(130, 'Désenvoûtement', 'Annule les effets de TechnoMagie précédents sur 1 cible', 1, 7, 3, '1000', -2, 0, 0, 0, 1, '0:0', 'choix', 'sort'),
(131, 'Grenade paralysante', '-10% Mouv -20PV sur 1 cible', 2, 7, 4, '1000', -2, 0, 0, 0, 0, '0:55,16', 'choix', 'sort'),
(132, 'Fusée paralysante', '-20% Mouv -30PV sur la perception', 3, 7, 4, '1000', -2, 0, -2, 0, 0, '0:62,8', 'choix', 'sort'),
(133, 'Grenade', '-30 PV et -2 DEF sur 1 cible', 1, 7, 4, '1000', -2, 0, 0, 0, 1, '0:8,171', 'choix', 'sort'),
(134, 'Grenade à fragmentation', '-50 PV -4 DEF sur la perception', 2, 7, 4, '1000', -2, 0, -2, 0, 0, '0:143,172', 'choix', 'sort'),
(135, 'Sur-Humain', '+20% Force sur la perception', 3, 7, 5, '1000', -2, 0, -2, 0, 0, '0:216', 'choix', 'sort'),
(136, '[Désactivé] Transhumain', '4 PA + 1PA -50 PV -15 XP sur tout Althian !\r\nSur le lanceur ⇒ -50% PV -20 Def\r\n', 4, 7, 5, '0000', -2, 0, -3, 0, 0, '224,225:224,225,143,144,96', 'choix', 'sort'),
(137, '[Désactivé ] Armée de clones', 'Ramène des "alliés" plus très frais (voir Guide du Jeu)', 3, 7, 5, '0000', -2, 0, -1, 1, 1, '0:97', 'none', 'sort'),
(138, 'Sur-armement', '+1 PA +50% Force +5 ATK -30% Récup''PV -5 DEF -10 XP sur la perception', 4, 7, 5, '1000', -2, 0, -2, 0, 0, '0:197,39,208,95,96,145', 'choix', 'sort'),
(139, '/!\\ Canon nucléaire /!\\', '-120 PV -6 DEF sur tout Althian et sans distinction de cibles !', 4, 7, 5, '1000', -2, 0, -3, 0, 1, '0:209,174,35', 'both', 'sort'),
(140, 'Aura de protection', '+10% DEF sur zone réduite', 2, 0, 0, '0000', 3, 2, -1, 0, 1, '0:5', 'allie', 'aura'),
(141, 'RAZ effroyable', '3 PA, Annule les effets de T-M précédents sur la perception', 3, 5, 5, '0011', -2, 0, 2, 0, 0, '0:0', 'choix', 'sort'),
(142, 'RAZ bienveillante', '3 PA, Annule les effets de T-M précédents sur la perception', 3, 4, 5, '0011', -2, 0, 2, 0, 0, '0:0', 'choix', 'sort'),
(143, 'Clairvoyance', '+20 % de Perception sur la perception', 2, 4, 1, '0011', -2, 0, 2, 0, 0, '0:213', 'choix', 'sort'),
(144, 'Armure du guérisseur', '+2 DEF +10 PV sur une cible', 1, 4, 1, '0011', -2, 0, 0, 1, 1, '0:170,6', 'choix', 'sort'),
(145, 'Aura du forgeron', '+2 ATK +10 PV sur une cible', 1, 4, 1, '0011', -2, 0, 0, 1, 1, '0:169,6', 'choix', 'sort'),
(146, 'Coup de fouet', '+10% Force +10 PV sur une cible', 1, 4, 1, '0011', -2, 0, 0, 1, 1, '0:20,6', 'choix', 'sort'),
(147, 'Illumination', '+15% de Perception sur une cible', 1, 4, 2, '0011', -2, 0, 0, 1, 1, '0:214', 'choix', 'sort'),
(148, 'Promesses politiques', '+3 DEF +20 PV sur la perception', 2, 4, 2, '0011', -2, 0, -2, 0, 0, '0:104,215', 'choix', 'sort'),
(149, 'Remodelage de la réalité', '+10% Mouv +10 PV sur une cible', 2, 4, 2, '0011', -2, 0, 0, 1, 1, '0:71,6', 'choix', 'sort'),
(150, '||Ferveur d''Angélios|Ferveur de Démonial', '+3 ATK +20 PV sur la perception', 2, 4, 2, '0011', -2, 0, -2, 0, 0, '0:196,104', 'choix', 'sort'),
(151, 'Echauffement', '+20% Force +20 PV sur la perception', 2, 4, 2, '0011', -2, 0, -2, 0, 0, '0:216,104', 'choix', 'sort'),
(152, '[Désactivé] Eveil', '2 PA +1PA -50 PV -5XP sur une cible\r\nSur le lanceur => -50% PV -20 Def', 2, 4, 3, '0000', -2, 0, 0, 1, 1, '224,225:224,225,96,150,217', 'choix', 'sort'),
(153, 'Aplanissement du relief', '+20% Mouv +30 PV sur la perception', 3, 4, 3, '0011', -2, 0, -2, 0, 0, '0:100,168', 'choix', 'sort'),
(154, '[Désactivé] Sublimation', '3 PA +2PA -50 PV -10XP sur une cible\r\nSur le lanceur ⇒ -50% PV -20 Def\r\n', 3, 4, 4, '0000', -2, 0, 0, 1, 1, '224,225:224,225,193,143,145', 'choix', 'sort'),
(155, 'Motivation', '+30% Effet +40 PV sur une cible', 2, 4, 4, '0011', -2, 0, 0, 1, 1, '0:98,218', 'choix', 'sort'),
(156, 'Dévouement', '35% des PV du Mage sont donnés à la cible', 3, 4, 4, '0011', -2, 0, 0, 1, 0, '0:210', 'both', 'sort'),
(157, 'Félicité', '+50% Perception +10 DEF +20% Récup''PV -10 ATK -30% Force -10% Mouv sur la perception', 4, 4, 5, '0011', -2, 0, -2, 0, 0, '0:55,69,180,219,5,220', 'choix', 'sort'),
(158, 'Test', 'Test', 1, 3, 5, '1111', -2, 0, -2, 1, 1, '0:0', 'both', 'sort'),
(159, '�APWAL', '', 1, 0, 5, '0000', -2, 0, 0, 1, 1, '0:226', 'both', 'sort');

--
-- Contenu de la table `camps`
--

INSERT IGNORE INTO `camps` (`id`, `carte_id`, `nom`, `description`) VALUES
(1, 1, 'Humain', 'Humain'),
(2, 1, 'Paria', 'Paria'),
(3, 3, 'Ange', 'Ange'),
(4, 2, 'Demon', 'Demon'),
(5, 1, 'Autre', 'Autre'),
(6, 1, 'Légendes', 'Regroupement des légendes');

--
-- Contenu de la table `cartes`
--

INSERT IGNORE INTO `cartes` (`id`, `nom`, `description`, `circ`, `infini`, `x_min`, `y_min`, `x_max`, `y_max`, `visible_x_min`, `visible_x_max`, `visible_y_min`, `visible_y_max`, `dla`, `nom_decors`, `decors_defaut`) VALUES
(1, 'Althian', 'Plan de la Terre', '11', '0000', -30, -30, 30, 30, -30, 30, -30, 30, 47, 'prevf2', 'eau'),
(2, 'Ciferis', 'Plan des enfers', '10', '0010', -50, -100, 50, 0, -50, 50, -100, 0, 23, NULL, 'enfer'),
(3, 'Celestia', 'Plan du paradis', '10', '0001', -50, 0, 50, 100, -50, 50, 0, 100, 23, NULL, 'paradis'),
(4, 'Prison', 'Prison pour les tricheurs', '00', '0000', -10, -10, 10, 10, -10, 10, -10, 10, 23, NULL, NULL),
(5, '8eme enfer', 'Dernier etage des enfers', '00', '0000', -50, -50, 50, 50, -25, 25, -25, 25, -5, NULL, NULL),
(6, '9ème Paradis', 'Résidence secondaire de Dix-Yeux', '11', '0000', -10, -10, 10, 10, 0, 0, 0, 0, 0.005, NULL, NULL),
(255, 'Espace-Temps', 'L''Espace-Temps est le lieu de passage des mages du même nom, lors de la téléportation', '00', '0000', -100000, -100000, 100000, 100000, 0, 0, 0, 0, 23, NULL, NULL);

--
-- Contenu de la table `case_artefact`
--

INSERT IGNORE INTO `case_artefact` (`id`, `nom`, `description`, `image`, `pv_max`, `rarete`, `cout`, `poid`, `categorie_id`, `consom`) VALUES
(1, 'Essence', 'Essence obtenue en tuant des ail&eacute;s.', 'decors/artefacts/broad_sword.gif', '100', '50', '10', '1', 2, '1'),
(2, 'Orbe Ang&eacute;lique', 'Orbe d''essence obtenue en tuant un Archange. L''artefact bouillonne de puissance, mais il est inutilisable en l''&eacute;tat...', 'decors/artefacts/broad_sword.gif', '10', '1', '1500', '11', 1, '1'),
(3, 'Orbe D&eacute;moniaque', 'Orbe d''essence obtenue en tuant un Seigneur D&eacute;mon. L''artefact bouillonne de puissance, mais il est inutilisable en l''&eacute;tat...', 'decors/artefacts/broad_sword.gif', '10', '1', '32767', '12', 1, '1'),
(4, 'Ep&eacute;e', 'Une &eacute;p&eacute;e forg&eacute;e dans le 7eme enfer !', 'decors/artefacts/broad_sword.gif', '9999', '50', '1500', '15', 3, '1'),
(5, 'Dague', 'Dague rouill&eacute;e sans aucune utilit&eacute;', 'decors/artefacts/broad_sword.gif', '20', '100', '5', '5', 3, '1'),
(6, 'Dague', 'Dagounette, pour le style', 'decors/artefacts/dague.gif', '45', '100', '10', '1', 3, '1'),
(7, 'Couteau de lancer', 'Minable petit couteau rouill&eacute;', 'decors/artefacts/dague.gif', '45', '100', '10', '1', 4, '2'),
(8, 'Dynamite', 'Booomm !!', 'decors/artefacts/dague.gif', '1', '50', '150', '0.2', 2, '1'),
(9, 'Check', 'Booomm !!', 'decors/artefacts/dague.gif', '1', '50', '150', '0.2', 2, '1'),
(10, 'Cookie de Kazuya', 'Délicieux biscuit au chocolat offert en récompense à Squig par le Seigneur des Enfers.', 'decors/artefacts/broad_sword.gif', '-1', '1', '666', '0,1', 4, '0'),
(11, 'Boîte d''allumettes', 'Boîte de base avec des allumettes classique. Pratique pour faire du feu de base... et pour massacrer des Humains !', 'decors/artefacts/broad_sword.gif', '-1', '100', '1', '0,1', 4, '0'),
(12, 'Bouteille entamée de Deyron', 'Seule bouteille non vidée par la Légende Démoniaque Deyron. Laissée derrière durant ses vacances au Paradis.', 'decors/artefacts/broad_sword.gif', '-1', '1', '666', '0,1', 4, '0'),
(13, 'Caisse de Bière "Belzebuth" modifiée', 'Une caisse de bière contenant des bouteilles de Belzebuth ... vide. Sur la caisse est dessinée une tête avec des cornes, sous laquelle se trouve une légende : Eckarlion', 'decors/objets/caisse00.png', '50', '50', '0', '0', 0, '0'),
(14, 'Coeur de Dev', 'Le coeur d''un dev, allez savoir lequel ...', 'decors/artefacts/coeur.png', '999999', '1', '1', '0', 1, '0'),
(15, 'Boxer en dentelle blanc', 'Boxer laissé par Céri en paiement de sa commande dans le Bouiboui de Ein', 'decors/artefacts/resize.png', '1', '1', '0', '0', 1, '0'),
(16, 'Nours', 'Nours, ancien bisounours berzerk devenu peluche inanimée', 'decors/artefacts/Fluffycase.jpg', '1', '1', '0', '0', 1, '0');

--
-- Contenu de la table `case_objet_complexe`
--

INSERT IGNORE INTO `case_objet_complexe` (`id`, `nom`, `description`, `pv_max`, `bloquant`, `reparable`, `images`, `taille_x`, `taille_y`, `categorie_id`) VALUES
(1, 'Immeuble', 'Immeuble simple', '5000', 1, 1, 'decors/objets_complexe/Immeuble_2x2', '2', '2', 1),
(2, 'Abysses', 'Abysses infranchissables', '-1', 1, 0, 'Abysses', '400', '1000000', 3),
(3, 'Décors  Porte Paradis', 'Décors des portes du paradis', '-1', 0, 0, 'decors/objets_complexe/DPorteParadis', '7', '7', 0),
(4, 'Décors Porte Enfer', 'Décors de la porte des enfers', '-1', 0, 0, 'decors/objets_complexe/DPorteEnfer', '7', '7', 0),
(5, 'Décors bouclier T1', 'Décors du bouclier de taille 1', '-1', 0, 0, 'decors/objets_complexe/DBouclier_1', '10', '10', 0),
(6, 'Décors bouclier T2', 'Décors du bouclier de taille 2', '-1', 0, 0, 'decors/objets_complexe/DBouclier_2', '19', '19', 0),
(7, 'Décors bouclier T3', 'Décors du bouclier de taille 3', '-1', 0, 0, 'decors/objets_complexe/DBouclier_3', '30', '30', 0),
(8, 'Décors bouclier T4', 'Décors du bouclier de taille 4', '-1', 0, 0, 'decors/objets_complexe/DBouclier_4', '39', '39', 0),
(9, 'Panneau de station', 'Sur la panneau vous pouvez lire l''inscription suivante : "Au diablotin égaré, station de ski"', '-1', 1, 0, 'decors/objets_complexe/panneau', '1', '2', 0);

--
-- Contenu de la table `case_objet_simple`
--

INSERT IGNORE INTO `case_objet_simple` (`id`, `nom`, `description`, `bloquant`, `pv_max`, `poid`, `image`, `categorie_id`) VALUES
(1, 'Caisse', 'Caisse sans doute videll', 1, '10', '0', 'decors/objets/caisse00.png', 1),
(2, 'Arbre', 'Arbre des bois !', 1, '500', '0', 'decors/objets/arbre.gif', 1),
(3, 'Escargot', '', 1, '50', '0', 'decors/objets/escargot.png', 3),
(4, 'Plot chantier', '', 1, '50', '1', 'decors/objets/plot.png', 4),
(5, 'Billet', 'Liasse de billet', 1, '50', '0', 'decors/objets/billet.png', 5),
(6, 'Faux billets', 'Liasse de faux billet vulgairement imprimmé sur du papier recyclé', 1, '55000', '0', 'decors/objets/billet.png', 5),
(7, 'Liasse de 10', 'Liasse de 10 billets', 1, '5500', '0.1', 'decors/objets/billet.png', 1),
(8, 'Caise dynamite', 'Pas touche ça explose !!!', 1, '45', '10', 'decors/objets/caisse00.png', 1),
(9, 'Caisse de Bière "Belzebuth" modifiée', 'Une caisse de bière contenant des bouteilles de Belzebuth ... vide. Sur la caisse est dessinée une tête avec des cornes, sous laquelle se trouve une légende : Eckarlion', 1, '50', '0', 'decors/objets/caisse00.png', 1),
(10, 'Cactus', 'Cactus', 1, '50', '0', 'decors/objets/cactus1.png', 8),
(11, 'Cactus', 'Cactus', 1, '50', '0', 'decors/objets/cactus2.png', 8),
(12, 'Plante', 'Plante', 0, '1', '0', 'decors/objets/fleurs1.png', 8),
(13, 'Plante', 'Plante', 0, '1', '0', 'decors/objets/fleurs2.png', 8),
(14, 'Plante', 'Plante', 0, '1', '0', 'decors/objets/fleurs3.png', 8),
(15, 'Plante', 'Plante', 0, '1', '0', 'decors/objets/fleurs4.png', 8),
(16, 'Plante', 'Plante', 0, '1', '0', 'decors/objets/fleurs5.png', 8),
(17, 'Plante', 'Plante', 0, '1', '0', 'decors/objets/fleurs6.png', 8),
(18, 'Plante', 'Plante', 0, '1', '0', 'decors/objets/herbe1.png', 8),
(19, 'Plante', 'Plante', 0, '1', '0', 'decors/objets/herbe2.png', 8),
(20, 'Plante', 'Plante', 0, '1', '0', 'decors/objets/herbe3.png', 8),
(21, 'Plante', 'Plante', 0, '1', '0', 'decors/objets/herbe4.png', 8),
(22, 'Plante', 'Plante', 0, '1', '0', 'decors/objets/herbe5.png', 8),
(23, 'Plante', 'Plante', 0, '1', '0', 'decors/objets/herbe6.png', 8),
(24, 'Neige', 'Neige', 0, '1', '0', 'decors/objets/neige1.png', 1),
(25, 'Plante', 'Plante', 0, '1', '0', 'decors/objets/neige2.png', 8),
(26, 'Plante', 'Plante', 0, '1', '0', 'decors/objets/neige3.png', 8),
(27, 'Plante', 'Plante', 0, '1', '0', 'decors/objets/neige4.png', 8),
(28, 'Plante', 'Plante', 0, '1', '0', 'decors/objets/neige5.png', 8),
(29, 'Souche', 'Souche', 1, '100', '0', 'decors/objets/neige6.png', 8),
(30, 'Roche', 'Roche', 0, '1', '0', 'decors/objets/roche1.png', 7),
(31, 'Roche', 'Roche', 0, '1', '0', 'decors/objets/roche2.png', 7),
(32, 'Roche', 'Roche', 0, '1', '0', 'decors/objets/roche3.png', 7),
(33, 'Roche', 'Roche', 1, '200', '0', 'decors/objets/roche4.png', 7),
(34, 'Souche', 'Souche', 1, '100', '0', 'decors/objets/souche1.png', 8),
(35, 'Souche', 'Souche', 1, '100', '0', 'decors/objets/souche2.png', 8),
(36, 'Souche', 'Souche', 1, '100', '0', 'decors/objets/souche3.png', 8),
(37, 'Nénuphare', 'Nénuphare', 0, '2', '0', 'decors/objets/nenuphare1.png', 8),
(38, 'Nénuphare', 'Nénuphare', 0, '2', '0', 'decors/objets/nenuphare1.png', 8),
(39, 'Hatsukoi', 'Statue de Hatukoi', 1, '-1', '0', 'persos/perso/hatsu.png', 1);

--
-- Contenu de la table `case_terrain`
--

INSERT IGNORE INTO `case_terrain` (`id`, `nom`, `image`, `couleur`, `mouv`, `categorie_id`) VALUES
(17, 'Eau', 'decors/motifs/pattern_water.jpg', '73A9FA', 1, 4);

--
-- Contenu de la table `categorie_artefact`
--

INSERT IGNORE INTO `categorie_artefact` (`id`, `nom`, `description`) VALUES
(1, 'Orbe', 'Toutes les orbes du jeux'),
(2, 'Essence', 'Type d''essence'),
(3, 'Epée', 'Toutes les épées'),
(4, 'Armes de poing', 'Fusil a manche court');

--
-- Contenu de la table `categorie_objet_complexe`
--

INSERT IGNORE INTO `categorie_objet_complexe` (`id`, `nom`, `description`) VALUES
(1, 'Vehicule', 'Tout type de vehicule'),
(2, 'Immeuble', 'Tous type d''immeuble'),
(3, 'Abysses', 'Abysses infranchissables');

--
-- Contenu de la table `categorie_objet_simple`
--

INSERT IGNORE INTO `categorie_objet_simple` (`id`, `nom`, `description`) VALUES
(1, 'Caisses', 'Les différentes caisse'),
(2, 'Mur', 'Les différents type de mur'),
(3, 'Animaux', ''),
(4, 'Chantier', ''),
(5, 'Argent', 'Tout type de monaie'),
(7, 'Rocher', 'Rocher de toutes sorte'),
(8, 'Flore', 'Les plantes');

--
-- Contenu de la table `categorie_terrain`
--

INSERT IGNORE INTO `categorie_terrain` (`id`, `nom`, `description`) VALUES
(1, 'Herbe', 'Toutes les différentes composition d''herbe du damier'),
(2, 'Beton', 'Les différents type de beton'),
(3, 'Epée', 'Les différentes routes'),
(4, 'Eau', 'Case d''eau'),
(5, 'Plancher', 'PLancher'),
(6, 'Sable', 'Tout sur le sable'),
(7, 'Terre', 'Terre');

--
-- Contenu de la table `classes`
--

INSERT IGNORE INTO `classes` (`Id`, `Camps`, `Position`, `Titre`, `Sub`, `Description`) VALUES
('11', 1, 1, 'Confrérie des Unionistes', '1ere Maison: Les Fédéralistes', 'Croient en l''unité des hommes sous l''égide d''une fédération de pays.'),
('11', 3, 1, 'L''Ordre de Cristal', '1er Ciel: Les Tempérés', 'Celui qui se ballade les mains dans les poches, mais qui fait son taf...'),
('11', 4, 1, 'L''Ordre des Envieux', '2ème Caveau: Les Luxurieux', 'Démons des plaisirs charnels, ils n''hésitent pas à faire usage de leur corps et d''autres talents divers pour obtenir ce qu''ils veulent.'),
('12', 1, 2, 'Confrérie des Unionistes', '2ème Maison: Les Absolutistes', 'Croient en l''union sous une seule et unique bannière commune imposée par un dirigeant unique.'),
('12', 3, 2, 'L''Ordre de Cristal', '3ème Ciel: Les Adorateurs', 'Celui qui croit profondément en ce qu''il fait, en bien ou en mal. La race Céleste est toute puissante.'),
('12', 4, 2, 'L''Ordre des Envieux', '3ème Caveau: Les Gourmands', 'Ils aiment les plaisirs de manière excessive et n''hésitent pas à outrepasser toutes les limites pour satisfaire leur moindre envie.'),
('13', 1, 3, 'Confrérie des Unionistes', '3ème Maison: Les Militaristes', 'Pensent que seule l''armée et la force peuvent unir l''humanité.'),
('13', 3, 3, 'L''Ordre de Cristal', '7ème Ciel: Les Possessifs', 'A moi ! A moi ! Mon précieuuux'),
('13', 4, 3, 'L''Ordre des Envieux', '4ème Caveau: Les Avares', 'Égoïstes, ils refusent catégoriquement de se séparer de n''importe quoi leur appartenant. Ou ne leur appartenant pas...'),
('21', 1, 4, 'Confrérie des Nationalistes', '1ere Maison: Les Intégristes', 'Pour eux, l''utilisation de la TeK'' ou de la religion est vraie et gage d''avenir pour l''Humanité.'),
('21', 3, 4, 'L''Ordre de Lumière', '2ème Ciel: Les Illuminati', 'Celui qui cherche la vérité. Mais on peut aussi traduire cela par "les illuminés", soit ceux qui ne savent pas ce qu''ils font.'),
('21', 4, 4, 'L''Ordre des Indus', '1er Caveau: Le Limbe', 'Il paraît que c''est le genre de démons qui n''est pas démoniaque. Mais ce n''est que ce que l''on voudrait bien nous faire croire...'),
('22', 1, 5, 'Confrérie des Nationalistes', '2ème Maison: Les Loyalistes', 'Ceux-là préféreront mourir que d''abandonner leur patrie.'),
('22', 3, 5, 'L''Ordre de Lumière', '5ème Ciel: Les Guerriers éclairés', 'Celui qui se bat pour l''honneur et l''intégrité, de sa race ou de lui-même ? A chacun son interprétation...'),
('22', 4, 5, 'L''Ordre des Indus', '8ème Caveau: Les Fraudeurs', 'Rois de l''arnaque, ils vendent des assurances vie aux immortels, et détournent des tonneaux de bière. Il faut se méfier des Fraudeurs.'),
('23', 1, 6, 'Confrérie des Nationalistes', '3ème Maison: Les Alliés', 'Aux grands maux, les grands moyens. Ceux-ci sauront s''allier pour défaire l''ennemi juré.'),
('23', 3, 6, 'L''Ordre de Lumière', '8ème Ciel: Les Hérauts de Célestia', 'Celui qui bourrine pour la gloire du Très-Haut, ou pas, mais il bourrine pour de la gloire.'),
('23', 4, 6, 'L''Ordre des Indus', '9ème Caveau: Les Traîtres', 'Ils n''hésitent pas à frapper dans le dos et désirent plus que tout devenir calife à la place du Calife. It''s not good.'),
('31', 1, 7, 'Confrérie des Indépendants', '1ère Maison: Les Pacifistes', 'La guerre, ce n''est pas leur truc, à eux. Encore que, parfois, pour imposer la paix, il faut savoir... eh bien. Pacifier.'),
('31', 3, 7, 'L''Ordre des Ombres', '4ème Ciel: Les Avisés', 'Celui qui cherche la vérité et la Justice, enfin, les siennes, souvent.'),
('31', 4, 7, 'L''Ordre des Ardents', '5ème Caveau: Les Colériques', 'Ils ont le sang chaud, s''énervent à la moindre contrariété, et agissent souvent sous les coups de leurs émotions..'),
('32', 1, 8, 'Confrérie des Indépendants', '2ème Maison: Les Neutres', 'Ceux-ci s''en foutent. En tous cas, c''est ce qu''ils disent.'),
('32', 3, 8, 'L''Ordre des Ombres', '6ème Ciel: Les Manipulateurs', 'Celui qui est prêt à tout pour arriver à ses fins. Oui, ça y compris. Mais à chacun sa méthode...'),
('32', 4, 8, 'L''Ordre des Ardents', '6ème Caveau: Les Hérétiques', 'Tout ce qui n''est pas permis les attire en général. Ils haïssent par dessus tout les Anges et la religion qu''ils inculquent aux humains.'),
('33', 1, 9, 'Confrérie des Indépendants', '3ème Maison: Les Barbares', 'La violence est solution à tous problèmes pour les barbares. Même si certains d''entre eux sont parfaitement civilisés.'),
('33', 3, 9, 'L''Ordre des Ombres', '9ème Ciel: Les Cruels', 'Celui qui fait souffrir pour son propre plaisir, parfois pour celui des autres. Mais souvent pour le sien.'),
('33', 4, 9, 'L''Ordre des Ardents', '7ème Caveau: Les Violents', 'Ils frappent d''abord, et posent les questions ensuite. Quand ils posent des questions.');

--
-- Contenu de la table `effet`
--

INSERT IGNORE INTO `effet` (`id`, `type_effet`, `effet`) VALUES
(198, 'alter_att', '-1'),
(180, 'alter_att', '-10'),
(50, 'alter_att', '-10%'),
(136, 'alter_att', '-15%'),
(179, 'alter_att', '-2'),
(57, 'alter_att', '-20'),
(58, 'alter_att', '-20%'),
(202, 'alter_att', '-3'),
(70, 'alter_att', '-30%'),
(182, 'alter_att', '-4'),
(111, 'alter_att', '-40%'),
(203, 'alter_att', '-5'),
(43, 'alter_att', '-5%'),
(190, 'alter_att', '-6'),
(183, 'alter_att', '-8'),
(206, 'alter_att', '1'),
(181, 'alter_att', '10'),
(4, 'alter_att', '10%'),
(184, 'alter_att', '12'),
(22, 'alter_att', '15%'),
(169, 'alter_att', '2'),
(141, 'alter_att', '20%'),
(196, 'alter_att', '3'),
(73, 'alter_att', '30%'),
(195, 'alter_att', '4'),
(208, 'alter_att', '5'),
(166, 'alter_att', '5%'),
(173, 'alter_att', '6'),
(192, 'alter_att', '8'),
(194, 'alter_def', '-1'),
(177, 'alter_def', '-10'),
(19, 'alter_def', '-10%'),
(178, 'alter_def', '-12'),
(23, 'alter_def', '-15%'),
(171, 'alter_def', '-2'),
(224, 'alter_def', '-20'),
(27, 'alter_def', '-20%'),
(159, 'alter_def', '-25%'),
(201, 'alter_def', '-3'),
(9, 'alter_def', '-30'),
(68, 'alter_def', '-30%'),
(172, 'alter_def', '-4'),
(197, 'alter_def', '-5'),
(14, 'alter_def', '-5%'),
(31, 'alter_def', '-50%'),
(174, 'alter_def', '-6'),
(199, 'alter_def', '-7'),
(176, 'alter_def', '-8'),
(205, 'alter_def', '1'),
(185, 'alter_def', '10'),
(5, 'alter_def', '10%'),
(137, 'alter_def', '15%'),
(170, 'alter_def', '2'),
(187, 'alter_def', '20'),
(101, 'alter_def', '25%'),
(215, 'alter_def', '3'),
(186, 'alter_def', '4'),
(112, 'alter_def', '40%'),
(204, 'alter_def', '5'),
(167, 'alter_def', '5%'),
(191, 'alter_def', '6'),
(67, 'alter_effet', '-30'),
(188, 'alter_effet', '15'),
(114, 'alter_effet', '20'),
(218, 'alter_effet', '30%'),
(189, 'alter_effet', '50'),
(51, 'alter_force', '-10%'),
(142, 'alter_force', '-15%'),
(59, 'alter_force', '-20%'),
(69, 'alter_force', '-30%'),
(175, 'alter_force', '10'),
(20, 'alter_force', '10%'),
(216, 'alter_force', '20%'),
(72, 'alter_force', '30%'),
(95, 'alter_force', '50%'),
(55, 'alter_mouv', '-10%'),
(148, 'alter_mouv', '-100%'),
(118, 'alter_mouv', '-2'),
(62, 'alter_mouv', '-20%'),
(91, 'alter_mouv', '-25%'),
(108, 'alter_mouv', '-30%'),
(151, 'alter_mouv', '-50%'),
(149, 'alter_mouv', '-75%'),
(71, 'alter_mouv', '10%'),
(207, 'alter_mouv', '15%'),
(168, 'alter_mouv', '20%'),
(89, 'alter_mouv', '25%'),
(116, 'alter_mouv', '30%'),
(61, 'alter_pa', '-1'),
(66, 'alter_pa', '-2'),
(96, 'alter_pa', '1'),
(193, 'alter_pa', '2'),
(119, 'alter_perception', '-1'),
(54, 'alter_perception', '-25%'),
(49, 'alter_perception', '-30%'),
(74, 'alter_perception', '-70%'),
(214, 'alter_perception', '15%'),
(213, 'alter_perception', '20%'),
(220, 'alter_perception', '50%'),
(140, 'alter_pv', '-10'),
(139, 'alter_pv', '-15'),
(158, 'alter_pv', '-150'),
(161, 'alter_pv', '-25'),
(152, 'alter_pv', '-35'),
(150, 'alter_pv', '-50'),
(226, 'alter_pv', '10%'),
(212, 'alter_recup_pv', '-10'),
(29, 'alter_recup_pv', '-15'),
(35, 'alter_recup_pv', '-20'),
(157, 'alter_recup_pv', '-25'),
(39, 'alter_recup_pv', '-30'),
(160, 'alter_recup_pv', '-35'),
(211, 'alter_recup_pv', '-5'),
(25, 'alter_recup_pv', '10'),
(21, 'alter_recup_pv', '10%'),
(80, 'alter_recup_pv', '15'),
(222, 'alter_recup_pv', '15%'),
(138, 'alter_recup_pv', '20'),
(219, 'alter_recup_pv', '20%'),
(46, 'alter_res_mag', '-10'),
(45, 'alter_res_mag', '-15'),
(44, 'alter_res_mag', '-20'),
(90, 'alter_res_mag', '-25'),
(42, 'alter_res_mag', '-30'),
(146, 'alter_res_mag', '-30%'),
(38, 'alter_res_mag', '-40'),
(40, 'alter_res_mag', '-50'),
(52, 'alter_res_mag', '-8'),
(99, 'alter_res_mag', '10'),
(78, 'alter_res_mag', '15'),
(47, 'alter_res_mag', '20'),
(88, 'alter_res_mag', '25'),
(105, 'alter_res_mag', '5'),
(48, 'alter_res_mag', '50'),
(102, 'alter_res_mag', '8'),
(17, 'alter_res_phy', '-10'),
(15, 'alter_res_phy', '-15'),
(10, 'alter_res_phy', '-20'),
(12, 'alter_res_phy', '-30'),
(7, 'alter_res_phy', '-40'),
(34, 'alter_res_phy', '-50'),
(53, 'alter_res_phy', '-8'),
(56, 'alter_res_phy', '0'),
(24, 'alter_res_phy', '10'),
(79, 'alter_res_phy', '15'),
(26, 'alter_res_phy', '20'),
(110, 'alter_res_phy', '25'),
(147, 'alter_res_phy', '30%'),
(106, 'alter_res_phy', '5'),
(32, 'alter_res_phy', '50'),
(103, 'alter_res_phy', '8'),
(124, 'aspire_att', '20%'),
(131, 'aspire_def', '20%'),
(122, 'aspire_force', '50%'),
(120, 'aspire_mouv', '20%'),
(132, 'aspire_pa', '1'),
(123, 'aspire_perception', '20%'),
(129, 'aspire_pv', '5%'),
(130, 'aspire_pv', '50'),
(121, 'aspire_recup_pv', '50%'),
(83, 'brulessence', '0'),
(87, 'dla', '-30'),
(81, 'dla', '-60'),
(93, 'dla', '120'),
(77, 'dla', '30'),
(76, 'event_mouv', '1'),
(85, 'home', '0'),
(82, 'immunite', '0'),
(94, 'permutation', ''),
(84, 'permutation', '0'),
(30, 'pv', '-1%'),
(36, 'pv', '-10'),
(223, 'pv', '-100'),
(209, 'pv', '-120'),
(200, 'pv', '-130'),
(18, 'pv', '-15'),
(41, 'pv', '-150'),
(154, 'pv', '-18'),
(16, 'pv', '-20'),
(153, 'pv', '-24'),
(64, 'pv', '-25'),
(63, 'pv', '-25%'),
(8, 'pv', '-30'),
(75, 'pv', '-35'),
(13, 'pv', '-40'),
(11, 'pv', '-5%'),
(143, 'pv', '-50'),
(225, 'pv', '-50%'),
(117, 'pv', '-80'),
(1, 'pv', '0'),
(6, 'pv', '10'),
(33, 'pv', '100'),
(156, 'pv', '140'),
(107, 'pv', '15'),
(115, 'pv', '150'),
(165, 'pv', '18'),
(104, 'pv', '20'),
(164, 'pv', '25'),
(100, 'pv', '30'),
(98, 'pv', '40'),
(221, 'pv', '5'),
(28, 'pv', '50'),
(155, 'pv', '70'),
(109, 'pv', '80'),
(97, 'reincarnum', '0'),
(92, 'retour', '1'),
(2, 'sprint', '1'),
(3, 'suicide', '1'),
(86, 'teleportation', '0'),
(128, 'trans_att', '30%'),
(135, 'trans_def', '20%'),
(126, 'trans_force', '30%'),
(125, 'trans_mouv', '20%'),
(127, 'trans_perception', '30%'),
(113, 'trans_pv', '-35%'),
(210, 'trans_pv', '35%'),
(133, 'trans_pv', '5%'),
(134, 'trans_pv', '50'),
(145, 'xp', '-10'),
(144, 'xp', '-15'),
(217, 'xp', '-5'),
(162, 'xp', '10'),
(60, 'xp', '4'),
(163, 'xp', '5'),
(65, 'xp', '8');

--
-- Contenu de la table `icone_galons`
--

INSERT IGNORE INTO `icone_galons` (`id`, `grade_id`, `icone_url`) VALUES
(1, 1, 'galons/grade1/galon1.png'),
(2, 1, 'galons/grade1/galon2.png'),
(3, 1, 'galons/grade1/galon3.png'),
(4, 2, 'galons/grade2/galon1.png'),
(5, 2, 'galons/grade2/galon2.png'),
(6, 2, 'galons/grade2/galon3.png'),
(7, 2, 'galons/grade2/galon4.png'),
(8, 3, 'galons/grade3/galon1.png'),
(9, 3, 'galons/grade3/galon2.png'),
(10, 3, 'galons/grade3/galon3.png'),
(11, 3, 'galons/grade3/galon4.png'),
(12, 4, 'galons/grade4/galon1.png'),
(13, 4, 'galons/grade4/galon2.png'),
(14, 4, 'galons/grade4/galon3.png'),
(15, 4, 'galons/grade4/galon4.png'),
(16, 5, 'galons/grade5/galon1.png'),
(17, 5, 'galons/grade5/galon2.png'),
(18, 5, 'galons/grade5/galon3.png'),
(19, 5, 'galons/grade5/galon4.png');

--
-- Contenu de la table `icone_persos`
--

INSERT IGNORE INTO `icone_persos` (`id`, `camp_id`, `type`, `grade_id`, `sexe_id`, `xp_min`, `xp_max`, `icone_url`) VALUES
(1, 1, 3, -3, 1, -99999, 250, 'persos/humain_t3/Hero0.gif'),
(2, 1, 3, -3, 1, 249, 500, 'persos/humain_t3/Hero1.gif'),
(3, 1, 3, -3, 1, 499, 1000, 'persos/humain_t3/Hero2.gif'),
(4, 1, 3, -3, 1, 999, 2000, 'persos/humain_t3/Hero3.gif'),
(5, 1, 3, -3, 1, 1999, 3000, 'persos/humain_t3/Hero4.gif'),
(6, 1, 3, -3, 1, 2999, 4000, 'persos/humain_t3/Hero5.gif'),
(7, 1, 3, -3, 1, 3999, 5500, 'persos/humain_t3/Hero6.gif'),
(8, 1, 3, -3, 1, 5499, 7000, 'persos/humain_t3/Hero7.gif'),
(9, 1, 3, -3, 1, 6999, 8500, 'persos/humain_t3/Hero8.gif'),
(10, 1, 3, -3, 1, 8499, 999999, 'persos/humain_t3/Hero9.gif'),
(11, 1, 3, 4, 1, -99999, 999999, 'persos/humain_t3/HeroG4.gif'),
(12, 1, 3, 5, 1, -99999, 999999, 'persos/humain_t3/HeroG5.gif'),
(13, 1, 3, -3, 2, -99999, 250, 'persos/humain_t3/Heroine0.gif'),
(14, 1, 3, -3, 2, 249, 500, 'persos/humain_t3/Heroine1.gif'),
(15, 1, 3, -3, 2, 499, 1000, 'persos/humain_t3/Heroine2.gif'),
(16, 1, 3, -3, 2, 999, 2000, 'persos/humain_t3/Heroine3.gif'),
(17, 1, 3, -3, 2, 1999, 3000, 'persos/humain_t3/Heroine4.gif'),
(18, 1, 3, -3, 2, 2999, 4000, 'persos/humain_t3/Heroine5.gif'),
(19, 1, 3, -3, 2, 3999, 5500, 'persos/humain_t3/Heroine6.gif'),
(20, 1, 3, -3, 2, 5499, 7000, 'persos/humain_t3/Heroine7.gif'),
(21, 1, 3, -3, 2, 6999, 8500, 'persos/humain_t3/Heroine8.gif'),
(22, 1, 3, -3, 2, 8499, 999999, 'persos/humain_t3/Heroine9.gif'),
(23, 1, 3, 4, 2, -99999, 999999, 'persos/humain_t3/HeroineG4.gif'),
(24, 1, 3, 5, 2, -99999, 999999, 'persos/humain_t3/HeroineG5.gif'),
(25, 1, 4, -3, 1, -99999, 250, 'persos/humain_t4/Humain0.gif'),
(26, 1, 4, -3, 1, 249, 500, 'persos/humain_t4/Humain1.gif'),
(27, 1, 4, -3, 1, 499, 1000, 'persos/humain_t4/Humain2.gif'),
(28, 1, 4, -3, 1, 999, 2000, 'persos/humain_t4/Humain3.gif'),
(29, 1, 4, -3, 1, 1999, 3000, 'persos/humain_t4/Humain4.gif'),
(30, 1, 4, -3, 1, 2999, 4000, 'persos/humain_t4/Humain5.gif'),
(31, 1, 4, -3, 1, 3999, 5500, 'persos/humain_t4/Humain6.gif'),
(32, 1, 4, -3, 1, 5499, 7000, 'persos/humain_t4/Humain7.gif'),
(33, 1, 4, -3, 1, 6999, 8500, 'persos/humain_t4/Humain8.gif'),
(34, 1, 4, -3, 1, 8499, 999999, 'persos/humain_t4/Humain9.gif'),
(35, 1, 4, 4, 1, -99999, 999999, 'persos/humain_t4/HumainG4.gif'),
(36, 1, 4, 5, 1, -99999, 999999, 'persos/humain_t4/HumainG5.gif'),
(37, 1, 4, -3, 2, -99999, 250, 'persos/humain_t4/Humaine0.gif'),
(38, 1, 4, -3, 2, 249, 500, 'persos/humain_t4/Humaine1.gif'),
(39, 1, 4, -3, 2, 499, 1000, 'persos/humain_t4/Humaine2.gif'),
(40, 1, 4, -3, 2, 999, 2000, 'persos/humain_t4/Humaine3.gif'),
(41, 1, 4, -3, 2, 1999, 3000, 'persos/humain_t4/Humaine4.gif'),
(42, 1, 4, -3, 2, 2999, 4000, 'persos/humain_t4/Humaine5.gif'),
(43, 1, 4, -3, 2, 3999, 5500, 'persos/humain_t4/Humaine6.gif'),
(44, 1, 4, -3, 2, 5499, 7000, 'persos/humain_t4/Humaine7.gif'),
(45, 1, 4, -3, 2, 6999, 8500, 'persos/humain_t4/Humaine8.gif'),
(46, 1, 4, -3, 2, 8499, 999999, 'persos/humain_t4/Humaine9.gif'),
(47, 1, 4, 4, 2, -99999, 999999, 'persos/humain_t4/HumaineG4.gif'),
(48, 1, 4, 5, 2, -99999, 999999, 'persos/humain_t4/HumaineG5.gif'),
(49, 2, 3, -3, 1, -99999, 999999, 'persos/paria/paria.gif'),
(50, 2, 3, -3, 2, -99999, 999999, 'persos/paria/pariate.gif'),
(51, 2, 4, -3, 1, -99999, 999999, 'persos/paria/paria.gif'),
(52, 2, 4, -3, 2, -99999, 999999, 'persos/paria/pariate.gif'),
(53, 3, 3, -3, 1, -99999, 250, 'persos/ange_t3/Angem0.gif'),
(54, 3, 3, -3, 1, 249, 500, 'persos/ange_t3/Angem1.gif'),
(55, 3, 3, -3, 1, 499, 1000, 'persos/ange_t3/Angem2.gif'),
(56, 3, 3, -3, 1, 999, 2000, 'persos/ange_t3/Angem3.gif'),
(57, 3, 3, -3, 1, 1999, 3000, 'persos/ange_t3/Angem4.gif'),
(58, 3, 3, -3, 1, 2999, 4000, 'persos/ange_t3/Angem5.gif'),
(59, 3, 3, -3, 1, 3999, 5500, 'persos/ange_t3/Angem6.gif'),
(60, 3, 3, -3, 1, 5499, 7000, 'persos/ange_t3/Angem7.gif'),
(61, 3, 3, -3, 1, 6999, 8500, 'persos/ange_t3/Angem8.gif'),
(62, 3, 3, -3, 1, 8499, 999999, 'persos/ange_t3/Angem9.gif'),
(63, 3, 3, 4, 1, -99999, 999999, 'persos/ange_t3/AngemG4.gif'),
(64, 3, 3, 5, 1, -99999, 999999, 'persos/ange_t3/AngemG5.gif'),
(65, 3, 3, -3, 2, -99999, 250, 'persos/ange_t3/Angef0.gif'),
(66, 3, 3, -3, 2, 249, 500, 'persos/ange_t3/Angef1.gif'),
(67, 3, 3, -3, 2, 499, 1000, 'persos/ange_t3/Angef2.gif'),
(68, 3, 3, -3, 2, 999, 2000, 'persos/ange_t3/Angef3.gif'),
(69, 3, 3, -3, 2, 1999, 3000, 'persos/ange_t3/Angef4.gif'),
(70, 3, 3, -3, 2, 2999, 4000, 'persos/ange_t3/Angef5.gif'),
(71, 3, 3, -3, 2, 3999, 5500, 'persos/ange_t3/Angef6.gif'),
(72, 3, 3, -3, 2, 5499, 7000, 'persos/ange_t3/Angef7.gif'),
(73, 3, 3, -3, 2, 6999, 8500, 'persos/ange_t3/Angef8.gif'),
(74, 3, 3, -3, 2, 8499, 999999, 'persos/ange_t3/Angef9.gif'),
(75, 3, 3, 4, 2, -99999, 999999, 'persos/ange_t3/AngefG4.gif'),
(76, 3, 3, 5, 2, -99999, 999999, 'persos/ange_t3/AngefG5.gif'),
(77, 3, 4, -3, 1, -99999, 250, 'persos/ange_t4/Cherubin0.gif'),
(78, 3, 4, -3, 1, 249, 500, 'persos/ange_t4/Cherubin1.gif'),
(79, 3, 4, -3, 1, 499, 1000, 'persos/ange_t4/Cherubin2.gif'),
(80, 3, 4, -3, 1, 999, 2000, 'persos/ange_t4/Cherubin3.gif'),
(81, 3, 4, -3, 1, 1999, 3000, 'persos/ange_t4/Cherubin4.gif'),
(82, 3, 4, -3, 1, 2999, 4000, 'persos/ange_t4/Cherubin5.gif'),
(83, 3, 4, -3, 1, 3999, 5500, 'persos/ange_t4/Cherubin6.gif'),
(84, 3, 4, -3, 1, 5499, 7000, 'persos/ange_t4/Cherubin7.gif'),
(85, 3, 4, -3, 1, 6999, 8500, 'persos/ange_t4/Cherubin8.gif'),
(86, 3, 4, -3, 1, 8499, 999999, 'persos/ange_t4/Cherubin9.gif'),
(87, 3, 4, 4, 1, -99999, 999999, 'persos/ange_t4/CherubinG4.gif'),
(88, 3, 4, 5, 1, -99999, 999999, 'persos/ange_t4/CherubinG5.gif'),
(89, 3, 4, -3, 2, -99999, 250, 'persos/ange_t4/Cherubine0.gif'),
(90, 3, 4, -3, 2, 249, 500, 'persos/ange_t4/Cherubine1.gif'),
(91, 3, 4, -3, 2, 499, 1000, 'persos/ange_t4/Cherubine2.gif'),
(92, 3, 4, -3, 2, 999, 2000, 'persos/ange_t4/Cherubine3.gif'),
(93, 3, 4, -3, 2, 1999, 3000, 'persos/ange_t4/Cherubine4.gif'),
(94, 3, 4, -3, 2, 2999, 4000, 'persos/ange_t4/Cherubine5.gif'),
(95, 3, 4, -3, 2, 3999, 5500, 'persos/ange_t4/Cherubine6.gif'),
(96, 3, 4, -3, 2, 5499, 7000, 'persos/ange_t4/Cherubine7.gif'),
(97, 3, 4, -3, 2, 6999, 8500, 'persos/ange_t4/Cherubine8.gif'),
(98, 3, 4, -3, 2, 8499, 999999, 'persos/ange_t4/Cherubine9.gif'),
(99, 3, 4, 4, 2, -99999, 999999, 'persos/ange_t4/CherubineG4.gif'),
(100, 3, 4, 5, 2, -99999, 999999, 'persos/ange_t4/CherubineG5.gif'),
(101, 4, 3, -3, 1, -99999, 250, 'persos/demon_t3/Demon0.gif'),
(102, 4, 3, -3, 1, 249, 500, 'persos/demon_t3/Demon1.gif'),
(103, 4, 3, -3, 1, 499, 1000, 'persos/demon_t3/Demon2.gif'),
(104, 4, 3, -3, 1, 999, 2000, 'persos/demon_t3/Demon3.gif'),
(105, 4, 3, -3, 1, 1999, 3000, 'persos/demon_t3/Demon4.gif'),
(106, 4, 3, -3, 1, 2999, 4000, 'persos/demon_t3/Demon5.gif'),
(107, 4, 3, -3, 1, 3999, 5500, 'persos/demon_t3/Demon6.gif'),
(108, 4, 3, -3, 1, 5499, 7000, 'persos/demon_t3/Demon7.gif'),
(109, 4, 3, -3, 1, 6999, 8500, 'persos/demon_t3/Demon8.gif'),
(110, 4, 3, -3, 1, 8499, 999999, 'persos/demon_t3/Demon9.gif'),
(111, 4, 3, 4, 1, -99999, 999999, 'persos/demon_t3/DemonG4.gif'),
(112, 4, 3, 5, 1, -99999, 999999, 'persos/demon_t3/DemonG5.gif'),
(113, 4, 3, -3, 2, -99999, 250, 'persos/demon_t3/Sucube0.gif'),
(114, 4, 3, -3, 2, 249, 500, 'persos/demon_t3/Sucube1.gif'),
(115, 4, 3, -3, 2, 499, 1000, 'persos/demon_t3/Sucube2.gif'),
(116, 4, 3, -3, 2, 999, 2000, 'persos/demon_t3/Sucube3.gif'),
(117, 4, 3, -3, 2, 1999, 3000, 'persos/demon_t3/Sucube4.gif'),
(118, 4, 3, -3, 2, 2999, 4000, 'persos/demon_t3/Sucube5.gif'),
(119, 4, 3, -3, 2, 3999, 5500, 'persos/demon_t3/Sucube6.gif'),
(120, 4, 3, -3, 2, 5499, 7000, 'persos/demon_t3/Sucube7.gif'),
(121, 4, 3, -3, 2, 6999, 8500, 'persos/demon_t3/Sucube8.gif'),
(122, 4, 3, -3, 2, 8499, 999999, 'persos/demon_t3/Sucube9.gif'),
(123, 4, 3, 4, 2, -99999, 999999, 'persos/demon_t3/SucubeG4.gif'),
(124, 4, 3, 5, 2, -99999, 999999, 'persos/demon_t3/SucubeG5.gif'),
(125, 4, 4, -3, 1, -99999, 250, 'persos/demon_t4/Diablotin0.gif'),
(126, 4, 4, -3, 1, 249, 500, 'persos/demon_t4/Diablotin1.gif'),
(127, 4, 4, -3, 1, 499, 1000, 'persos/demon_t4/Diablotin2.gif'),
(128, 4, 4, -3, 1, 999, 2000, 'persos/demon_t4/Diablotin3.gif'),
(129, 4, 4, -3, 1, 1999, 3000, 'persos/demon_t4/Diablotin4.gif'),
(130, 4, 4, -3, 1, 2999, 4000, 'persos/demon_t4/Diablotin5.gif'),
(131, 4, 4, -3, 1, 3999, 5500, 'persos/demon_t4/Diablotin6.gif'),
(132, 4, 4, -3, 1, 5499, 7000, 'persos/demon_t4/Diablotin7.gif'),
(133, 4, 4, -3, 1, 6999, 8500, 'persos/demon_t4/Diablotin8.gif'),
(134, 4, 4, -3, 1, 8499, 999999, 'persos/demon_t4/Diablotin9.gif'),
(135, 4, 4, 4, 1, -99999, 999999, 'persos/demon_t4/DiablotinG4.gif'),
(136, 4, 4, 5, 1, -99999, 999999, 'persos/demon_t4/DiablotinG5.gif'),
(137, 4, 4, -3, 2, -99999, 250, 'persos/demon_t4/Diablotine0.gif'),
(138, 4, 4, -3, 2, 249, 500, 'persos/demon_t4/Diablotine1.gif'),
(139, 4, 4, -3, 2, 499, 1000, 'persos/demon_t4/Diablotine2.gif'),
(140, 4, 4, -3, 2, 999, 2000, 'persos/demon_t4/Diablotine3.gif'),
(141, 4, 4, -3, 2, 1999, 3000, 'persos/demon_t4/Diablotine4.gif'),
(142, 4, 4, -3, 2, 2999, 4000, 'persos/demon_t4/Diablotine5.gif'),
(143, 4, 4, -3, 2, 3999, 5500, 'persos/demon_t4/Diablotine6.gif'),
(144, 4, 4, -3, 2, 5499, 7000, 'persos/demon_t4/Diablotine7.gif'),
(145, 4, 4, -3, 2, 6999, 8500, 'persos/demon_t4/Diablotine8.gif'),
(146, 4, 4, -3, 2, 8499, 999999, 'persos/demon_t4/Diablotine9.gif'),
(147, 4, 4, 4, 2, -99999, 999999, 'persos/demon_t4/DiablotineG4.gif'),
(148, 4, 4, 5, 2, -99999, 999999, 'persos/demon_t4/DiablotineG5.gif'),
(149, 0, 3, 5, 1, 0, 0, 'persos/perso/selvaria.gif'),
(150, 0, 3, 5, 1, 0, 0, 'persos/perso/kazuya.gif'),
(151, 0, 3, 5, 1, 0, 0, 'persos/perso/dieu.gif'),
(152, 5, 3, -3, 1, -9999, 99999, 'persos/perso/derange.gif'),
(153, 0, 3, 0, 1, -1000, 99999, 'persos/perso/splinter.png'),
(154, 0, 3, 0, 1, -1000, 999999, 'persos/perso/leonardo.png'),
(155, 0, 3, 0, 1, -1000, 99999, 'persos/perso/michelangelo.png'),
(156, 0, 3, 0, 1, -1000, 999999, 'persos/perso/donatello.png'),
(157, 0, 3, 5, 1, 0, 0, 'persos/perso/deyron.gif');

--
-- Contenu de la table `medailles_liste`
--

INSERT IGNORE INTO `medailles_liste` (`id`, `nom`, `description`, `niveau`, `priorite`, `image`) VALUES
(1, 'G4', 'A atteint le grade 4', 1, 1, 'g4'),
(2, 'G5', 'A atteint le grade 5', 1, 8, 'g5'),
(3, 'Très-Haut', 'Est ou à été(e) Très-Haut(e)', 1, 10, 'th'),
(4, 'Tyran', 'Est ou à été(e) Tyran(ne)', 1, 10, 'tyran'),
(5, 'Terreur des neiges', 'A tué(e) le Bonhomme Hiver', 2, 1, 'tueur_hiver'),
(6, 'Fondeur de bonhomme', 'A fait fondre le Bonhomme Hiver', 3, 1, 'fondeur_hiver'),
(7, 'Calife à la place du Calife', 'A tué(e) un G5 de son propre camps', 2, 1, 'calife'),
(8, 'Survivant', 'A activé(e) en ayant moins de 5 pv', 4, 1, 'survivant'),
(9, 'Régicide', 'A tué(e) un G5 ennemis', 2, 1, 'regicide');

--
-- Contenu de la table `races`
--

INSERT IGNORE INTO `races` (`id`, `race_id`, `grade_id`, `camp_id`, `type`, `nom`, `description`, `color`) VALUES
(1, 1, -2, 1, 4, 'Humanité', 'Grade servant au nom de la race', '#638D19'),
(2, 1, -1, 1, 4, 'Tricheur', 'Humain, de simple homme', '#E90086'),
(3, 1, 0, 1, 4, 'Humain', 'Humain, de simple homme', '#638D19'),
(4, 1, 1, 1, 4, 'Humain', 'Humain, de simple homme', '#638D19'),
(5, 1, 2, 1, 4, 'Humain', 'Humain, de simple homme', '#638D19'),
(6, 1, 3, 1, 4, 'Humain', 'Humain, de simple homme', '#638D19'),
(7, 1, 4, 1, 4, 'Roi Humain', 'Leur Chef.', '#638D19'),
(8, 1, 5, 1, 4, 'Empereur Humain', 'Dieu vivant ... mais toujours humain.', '#638D19'),
(9, 2, -2, 2, 3, 'Parias', 'Grade servant au nom de la race', '#55108A'),
(10, 2, -1, 2, 3, 'Tricheur', 'Grade servant au nom de la race', '#E90086'),
(11, 2, 0, 2, 3, 'Paria', 'Grade servant au nom de la race', '#55108A'),
(12, 2, 1, 2, 3, 'Paria', 'Grade servant au nom de la race', '#55108A'),
(13, 2, 2, 2, 3, 'Paria', 'Grade servant au nom de la race', '#55108A'),
(14, 2, 3, 2, 3, 'Paria', 'Grade servant au nom de la race', '#55108A'),
(15, 2, 4, 2, 3, 'Paria', 'Grade servant au nom de la race', '#55108A'),
(16, 2, 5, 2, 3, 'Paria', 'Grade servant au nom de la race', '#55108A'),
(17, 3, -2, 3, 3, 'Ange', 'Grade servant au nom de la race', '#7AD4F4'),
(18, 3, -1, 3, 3, 'Tricheur', 'Race angelique, les plus beaux !', '#E90086'),
(19, 3, 0, 3, 3, 'Serviteur', 'Race angelique, les plus beaux !', '#7AD4F4'),
(20, 3, 1, 3, 3, 'Angelot', 'Race angelique, les plus beaux !', '#7AD4F4'),
(21, 3, 2, 3, 3, 'Ange Mineur', 'Race angelique, les plus beaux !', '#7AD4F4'),
(22, 3, 3, 3, 3, 'Ange Majeur', 'Race angelique, les plus beaux !', '#7AD4F4'),
(23, 3, 4, 3, 3, 'Puissance Angélique', 'Un gros poulet.', '#7AD4F4'),
(24, 3, 5, 3, 3, 'Archange', 'Un très gros poulet.', '#7AD4F4'),
(25, 4, -2, 4, 3, 'Démon', 'Grade servant au nom de la race', '#9F213C'),
(26, 4, -1, 4, 3, 'Tricheur', 'Les plus laid !', '#E90086'),
(27, 4, 0, 4, 3, 'Familier', 'Les plus laid !', '#9F213C'),
(28, 4, 1, 4, 3, 'Diablotin', '', '#9F213C'),
(29, 4, 2, 4, 3, 'Démon Mineur', '', '#9F213C'),
(30, 4, 3, 4, 3, 'Démon Majeur', '', '#9F213C'),
(31, 4, 4, 4, 3, 'Puissance Démoniaque', 'Une petite merguez, mais qui pique fort.', '#9F213C'),
(32, 4, 5, 4, 3, 'Seigneur Démon', 'Une grosse merguez.', '#9F213C'),
(49, 7, -2, 4, 4, 'Diablotins', '', '#9F213C'),
(50, 7, -1, 4, 4, 'Tricheur', '', '#E90086'),
(51, 7, 0, 4, 4, 'Diablotins', '', '#9F213C'),
(52, 7, 1, 4, 4, 'Diablotins', '', '#9F213C'),
(53, 7, 2, 4, 4, 'Diablotins', '', '#9F213C'),
(54, 7, 3, 4, 4, 'Diablotins', '', '#9F213C'),
(55, 7, 4, 4, 4, 'Diablotins', '', '#9F213C'),
(56, 7, 5, 4, 4, 'Diablotins', '', '#9F213C'),
(57, 8, -2, 3, 4, 'Chérubins', '', '#7AD4F4'),
(58, 8, -1, 3, 4, 'Tricheur', '', '#E90086'),
(59, 8, 0, 3, 4, 'Chérubins', '', '#7AD4F4'),
(60, 8, 1, 3, 4, 'Chérubins', '', '#7AD4F4'),
(61, 8, 2, 3, 4, 'Chérubins', '', '#7AD4F4'),
(62, 8, 3, 3, 4, 'Chérubins', '', '#7AD4F4'),
(63, 8, 4, 3, 4, 'Chérubins', '', '#7AD4F4'),
(64, 8, 5, 3, 4, 'Chérubins', '', '#7AD4F4'),
(65, 9, -2, 1, 3, 'Héros de l''humanité', '', '#638D19'),
(66, 9, -1, 1, 3, 'Tricheur', '', '#E90086'),
(67, 9, 0, 1, 3, 'Héros', '', '#638D19'),
(68, 9, 1, 1, 3, 'Héros', '', '#638D19'),
(69, 9, 2, 1, 3, 'Héros', '', '#638D19'),
(70, 9, 3, 1, 3, 'Héros', '', '#638D19'),
(71, 9, 4, 1, 3, 'Héros', '', '#638D19'),
(72, 9, 5, 1, 3, 'Héros', '', '#638D19'),
(73, 10, -2, 6, 3, 'Légende', '', '#638D19'),
(74, 10, -1, 6, 3, 'Tricheur', '', '#E90086'),
(75, 10, 0, 6, 3, 'Légende', '', '#638D19'),
(76, 10, 1, 6, 3, 'Légende', '', '#638D19'),
(77, 10, 2, 6, 3, 'Légende', '', '#638D19'),
(78, 10, 3, 6, 3, 'Légende', '', '#638D19'),
(79, 10, 4, 6, 3, 'Légende', '', '#638D19'),
(80, 10, 5, 6, 3, 'Légende', '', '#638D19'),
(81, 11, -2, 2, 4, 'Mini paria', 'Paria version minimoi', '#55108A'),
(82, 11, -1, 2, 4, 'Tricheur', 'Paria version minimoi', '#E90086'),
(83, 11, 0, 2, 4, 'Mini paria', 'Paria version minimoi', '#55108A'),
(84, 11, 1, 2, 4, 'Mini paria', 'Paria version minimoi', '#55108A'),
(85, 11, 2, 2, 4, 'Mini paria', 'Paria version minimoi', '#55108A'),
(86, 11, 3, 2, 4, 'Mini paria', 'Paria version minimoi', '#55108A'),
(87, 11, 4, 2, 4, 'Mini paria', 'Paria version minimoi', '#55108A'),
(88, 11, 5, 2, 4, 'Mini paria', 'Paria version minimoi', '#55108A'),
(89, 12, -2, 5, 3, 'Testeurs', 'Cases de testeurs', '#000000'),
(90, 12, -1, 5, 3, 'Tricheur', 'Cases de testeurs', '#E90086'),
(91, 12, 0, 5, 3, 'Testeurs', 'Cases de testeurs', '#000000'),
(92, 12, 1, 5, 3, 'Testeurs', 'Cases de testeurs', '#000000'),
(93, 12, 2, 5, 3, 'Testeurs', 'Cases de testeurs', '#000000'),
(94, 12, 3, 5, 3, 'Testeurs', 'Cases de testeurs', '#000000'),
(95, 12, 4, 5, 3, 'Testeurs', 'Cases de testeurs', '#000000'),
(96, 12, 5, 5, 3, 'Testeurs', 'Cases de testeurs', '#000000'),
(99, 1, -3, 1, 4, 'Traitre', 'À mort !', '#638D19'),
(100, 9, -3, 1, 3, 'Traitre', 'À mort !', '#638D19'),
(101, 3, -3, 3, 3, 'Traitre', 'À mort !', '#7AD4F4'),
(102, 8, -3, 3, 4, 'Traitre', 'À mort !', '#7AD4F4'),
(103, 4, -3, 4, 3, 'Traitre', 'À mort !', '#9F213C'),
(104, 7, -3, 4, 4, 'Traitre', 'À mort !', '#9F213C');

--
-- Contenu de la table `sexe`
--

INSERT IGNORE INTO `sexe` (`id`, `sexe`, `admin`) VALUES
(1, 'Masculin', 0),
(2, 'Féminin', 0),
(3, 'Autre', 0),
(4, 'Oui', 1),
(5, 'Non', 1);
SET FOREIGN_KEY_CHECKS=1;
COMMIT;
