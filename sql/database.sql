-- phpMyAdmin SQL Dump
-- version 5.2.1deb1
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost:3306
-- Généré le : ven. 27 déc. 2024 à 22:09
-- Version du serveur : 10.11.6-MariaDB-0+deb12u1
-- Version de PHP : 8.2.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `dx06_bd`
--

-- --------------------------------------------------------

--
-- Structure de la table `Account`
--

CREATE TABLE `Account` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(100) NOT NULL,
  `is_admin` tinyint(1) NOT NULL DEFAULT 0,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `Account_Hero`
--

CREATE TABLE `Account_Hero` (
  `account_id` int(11) NOT NULL,
  `hero_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `Armor`
--

CREATE TABLE `Armor` (
  `item_id` int(11) NOT NULL,
  `defense` int(11) NOT NULL,
  `slot` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déclencheurs `Armor`
--
DELIMITER $$
CREATE TRIGGER `check_armor_uniqueness_before_insert` BEFORE INSERT ON `Armor` FOR EACH ROW BEGIN
    DECLARE item_count INT;

    -- Vérifier si l'item_id existe dans Weapon
    SELECT COUNT(*) INTO item_count FROM Weapon WHERE item_id = NEW.item_id;
    IF item_count > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'L''item_id existe déjà dans Weapon, il ne peut pas être dans Armor.';
    END IF;

    -- Vérifier si l'item_id existe dans Consumable
    SELECT COUNT(*) INTO item_count FROM Consumable WHERE item_id = NEW.item_id;
    IF item_count > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'L''item_id existe déjà dans Consumable, il ne peut pas être dans Armor.';
    END IF;

    -- Vérifier si l'item_id existe dans Miscellaneous
    SELECT COUNT(*) INTO item_count FROM Miscellaneous WHERE item_id = NEW.item_id;
    IF item_count > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'L''item_id existe déjà dans Miscellaneous, il ne peut pas être dans Armor.';
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `ChangeOST`
--

CREATE TABLE `ChangeOST` (
  `chapter_id` int(11) NOT NULL,
  `ost_normal` text NOT NULL,
  `fight_ost` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `Chapter`
--

CREATE TABLE `Chapter` (
  `id` int(11) NOT NULL,
  `content` text NOT NULL,
  `titre` varchar(64) NOT NULL,
  `id_item_taken` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `Chapter_Treasure`
--

CREATE TABLE `Chapter_Treasure` (
  `id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL DEFAULT 1,
  `condition` int(1) NOT NULL CHECK (`condition` between 1 and 6)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `Class`
--

CREATE TABLE `Class` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `description` text DEFAULT NULL,
  `imageName` text DEFAULT NULL,
  `base_pv` int(11) NOT NULL,
  `base_mana` int(11) NOT NULL,
  `strength` int(11) NOT NULL,
  `initiative` int(11) NOT NULL,
  `domination` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `Codex`
--

CREATE TABLE `Codex` (
  `item_id` int(11) NOT NULL,
  `family` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déclencheurs `Codex`
--
DELIMITER $$
CREATE TRIGGER `check_codex_uniqueness_before_insert` BEFORE INSERT ON `Codex` FOR EACH ROW BEGIN
    DECLARE item_count INT;

    -- Vérifier si l'item_id existe déjà dans Weapon
    SELECT COUNT(*) INTO item_count FROM Weapon WHERE item_id = NEW.item_id;
    IF item_count > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'L''item_id existe déjà dans Weapon, il ne peut pas être dans Codex.';
    END IF;

    -- Vérifier si l'item_id existe déjà dans Armor
    SELECT COUNT(*) INTO item_count FROM Armor WHERE item_id = NEW.item_id;
    IF item_count > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'L''item_id existe déjà dans Armor, il ne peut pas être dans Codex.';
    END IF;

    -- Vérifier si l'item_id existe déjà dans Consumable
    SELECT COUNT(*) INTO item_count FROM Consumable WHERE item_id = NEW.item_id;
    IF item_count > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'L''item_id existe déjà dans Consumable, il ne peut pas être dans Codex.';
    END IF;

    -- Vérifier si l'item_id existe déjà dans Miscellaneous
    SELECT COUNT(*) INTO item_count FROM Miscellaneous WHERE item_id = NEW.item_id;
    IF item_count > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'L''item_id existe déjà dans Miscellaneous, il ne peut pas être dans Codex.';
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `Consumable`
--

CREATE TABLE `Consumable` (
  `item_id` int(11) NOT NULL,
  `effect_type` enum('heal','mana','buff') NOT NULL,
  `heal_amount` int(11) DEFAULT NULL,
  `mana_amount` int(11) DEFAULT NULL,
  `attack_buff` int(11) DEFAULT NULL,
  `defense_buff` int(11) DEFAULT NULL,
  `duration` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déclencheurs `Consumable`
--
DELIMITER $$
CREATE TRIGGER `check_consumable_uniqueness_before_insert` BEFORE INSERT ON `Consumable` FOR EACH ROW BEGIN
    DECLARE item_count INT;

    -- Vérifier si l'item_id existe dans Weapon
    SELECT COUNT(*) INTO item_count FROM Weapon WHERE item_id = NEW.item_id;
    IF item_count > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'L''item_id existe déjà dans Weapon, il ne peut pas être dans Consumable.';
    END IF;

    -- Vérifier si l'item_id existe dans Armor
    SELECT COUNT(*) INTO item_count FROM Armor WHERE item_id = NEW.item_id;
    IF item_count > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'L''item_id existe déjà dans Armor, il ne peut pas être dans Consumable.';
    END IF;

    -- Vérifier si l'item_id existe dans Miscellaneous
    SELECT COUNT(*) INTO item_count FROM Miscellaneous WHERE item_id = NEW.item_id;
    IF item_count > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'L''item_id existe déjà dans Miscellaneous, il ne peut pas être dans Consumable.';
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `Event`
--

CREATE TABLE `Event` (
  `id` int(11) NOT NULL,
  `chapter_id` int(11) NOT NULL,
  `event_type` enum('exploration','combat','npc_interaction','treasure','death','merchent','healing') NOT NULL,
  `description` text DEFAULT NULL,
  `related_monster_id` int(11) DEFAULT NULL,
  `related_treasure_id` int(11) DEFAULT NULL,
  `related_npc_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `Hero`
--

CREATE TABLE `Hero` (
  `id` int(11) NOT NULL,
  `lastname` varchar(50) NOT NULL,
  `firstname` varchar(50) DEFAULT NULL,
  `biography` text DEFAULT NULL,
  `class_id` int(11) DEFAULT NULL,
  `race_id` int(11) NOT NULL,
  `talent_id` int(11) DEFAULT NULL,
  `xp` int(11) NOT NULL DEFAULT 0,
  `current_level` int(11) DEFAULT 1,
  `pv_max` int(11) NOT NULL,
  `mana_max` int(11) NOT NULL,
  `strength` int(11) NOT NULL,
  `initiative` int(11) NOT NULL,
  `domination` int(11) NOT NULL,
  `madness` int(11) NOT NULL DEFAULT 0,
  `poids_max` double NOT NULL DEFAULT 100,
  `nb_items_max` int(11) NOT NULL DEFAULT 20,
  `gold` float NOT NULL DEFAULT 1000
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déclencheurs `Hero`
--
DELIMITER $$
CREATE TRIGGER `after_hero_creation` AFTER INSERT ON `Hero` FOR EACH ROW BEGIN
    IF NEW.class_id = 1 THEN
        -- Guerrier
        INSERT INTO Hero_Weapons (hero_id, primary_weapon_id, secondary_weapon_id)
        VALUES (NEW.id, 2, 34);

        -- Ajout des objets dans l'inventaire
        INSERT INTO Inventory (hero_id, item_id, quantity) VALUES
            (NEW.id, 13, 1),
            (NEW.id, 14, 1),
            (NEW.id, 15, 1),
            (NEW.id, 16, 1),
            (NEW.id, 17, 1),
            (NEW.id, 34, 1);

        -- Ajout des armures associées
        INSERT INTO Hero_Armor (hero_id, helmet_id, armor_id, greaves_id, gloves_id) VALUES 
            (NEW.id, 13, 14, 15, 16);
        
    ELSEIF NEW.class_id = 2 THEN
        -- Magicien
        INSERT INTO Hero_Weapons (hero_id, primary_weapon_id, secondary_weapon_id)
        VALUES (NEW.id, 22, 35);

        -- Ajout des objets dans l'inventaire
        INSERT INTO Inventory (hero_id, item_id, quantity) VALUES
            (NEW.id, 19, 1),
            (NEW.id, 20, 1),
            (NEW.id, 21, 1),
            (NEW.id, 22, 1),
            (NEW.id, 23, 1),
            (NEW.id, 35, 1),
            (NEW.id, 40, 1),
            (NEW.id, 45, 1);

        -- Ajout des armures associées
        INSERT INTO Hero_Armor (hero_id, helmet_id, armor_id, gloves_id) VALUES 
            (NEW.id, 19, 20, 21);
        
    ELSEIF NEW.class_id = 3 THEN
        -- Voleur
        INSERT INTO Hero_Weapons (hero_id, primary_weapon_id, secondary_weapon_id)
        VALUES (NEW.id, 3, 35);

        -- Ajout des objets dans l'inventaire
        INSERT INTO Inventory (hero_id, item_id, quantity) VALUES
            (NEW.id, 24, 1),
            (NEW.id, 25, 1),
            (NEW.id, 26, 1),
            (NEW.id, 27, 1),
            (NEW.id, 28, 1),
            (NEW.id, 35, 1),
            (NEW.id, 42, 1);
	
        -- Ajout des armures associées
        INSERT INTO Hero_Armor (hero_id, helmet_id, armor_id, gloves_id) VALUES 
            (NEW.id, 24, 25, 26);
    ELSEIF NEW.class_id = 5 THEN
    -- Inquisiteur
    INSERT INTO Hero_Weapons (hero_id, primary_weapon_id, secondary_weapon_id)
    VALUES (NEW.id, 56, 57);

    -- Ajout des objets dans l'inventaire
    INSERT INTO Inventory (hero_id, item_id, quantity) VALUES
        (NEW.id, 56, 1),
        (NEW.id, 57, 1),
        (NEW.id, 58, 1),
        (NEW.id, 59, 1),
        (NEW.id, 60, 1),
        (NEW.id, 61, 1),
        (NEW.id, 49, 1);

    -- Ajout des armures associées
    INSERT INTO Hero_Armor (hero_id, helmet_id, armor_id, greaves_id, gloves_id) VALUES 
        (NEW.id, 58, 59, 60, 61);
        

	ELSEIF NEW.class_id = 6 THEN
    	-- Necromencien        
        INSERT INTO Hero_Weapons (hero_id, primary_weapon_id, secondary_weapon_id)
        VALUES (NEW.id, 54, 55);
        INSERT INTO Inventory(hero_id, item_id, quantity) VALUES
            (NEW.id, 37, 1),
            (NEW.id, 51, 1),
            (NEW.id, 52, 1),
            (NEW.id, 54, 1),
            (NEW.id, 55, 1),
            (NEW.id, 53, 1);
            
        INSERT INTO Hero_Armor(hero_id, helmet_id, armor_id, gloves_id) VALUES 
            (NEW.id, 51, 52, 53);
    ELSEIF NEW.class_id = 7 THEN
        -- Chasseur des Ombres
        INSERT INTO Hero_Weapons (hero_id, primary_weapon_id, secondary_weapon_id)
        VALUES (NEW.id, 66, 67);
        -- Ajout des objets dans l'inventaire
        INSERT INTO Inventory (hero_id, item_id, quantity) VALUES
            (NEW.id, 62, 1),
            (NEW.id, 63, 1),
            (NEW.id, 64, 1),
            (NEW.id, 65, 1),
            (NEW.id, 66, 1),
            (NEW.id, 67, 1);
            
        -- Ajout des armures associées
        INSERT INTO Hero_Armor (hero_id, helmet_id, armor_id, greaves_id, gloves_id) VALUES
            (NEW.id, 62, 63, 64, 65);
    ELSEIF NEW.class_id = 8 THEN
        -- Acolytes des Cendres
        INSERT INTO Hero_Weapons (hero_id, primary_weapon_id, secondary_weapon_id)
        VALUES (NEW.id, 72, 73);
        -- Ajout des objets dans l'inventaire
        INSERT INTO Inventory (hero_id, item_id, quantity) VALUES
            (NEW.id, 68, 1),
            (NEW.id, 69, 1),
            (NEW.id, 70, 1),
            (NEW.id, 71, 1),
            (NEW.id, 72, 1),
            (NEW.id, 73, 1),
            (NEW.id, 40, 1);
        -- Ajout des armures associées
        INSERT INTO Hero_Armor (hero_id, helmet_id, armor_id, greaves_id, gloves_id) VALUES
            (NEW.id, 68, 69, 70, 71);
    ELSEIF NEW.class_id = 9 THEN
        -- Druide des Profondeurs
        INSERT INTO Hero_Weapons (hero_id, primary_weapon_id, secondary_weapon_id)
        VALUES (NEW.id, 78, 79);
        -- Ajout des objets dans l'inventaire
        INSERT INTO Inventory (hero_id, item_id, quantity) VALUES
            (NEW.id, 74, 1),
            (NEW.id, 75, 1),
            (NEW.id, 76, 1),
            (NEW.id, 77, 1),
            (NEW.id, 78, 1),
            (NEW.id, 79, 1),
            (NEW.id, 50, 1);
        -- Ajout des armures associées
        INSERT INTO Hero_Armor (hero_id, helmet_id, armor_id, greaves_id, gloves_id) VALUES
            (NEW.id, 74, 75, 76, 77);
    ELSEIF NEW.class_id = 10 THEN
        -- Sanglier des Ténèbres
        INSERT INTO Hero_Weapons (hero_id, primary_weapon_id, secondary_weapon_id)
        VALUES (NEW.id, 84, 85);
        -- Ajout des objets dans l'inventaire
        INSERT INTO Inventory (hero_id, item_id, quantity) VALUES
            (NEW.id, 80, 1),
            (NEW.id, 81, 1),
            (NEW.id, 82, 1),
            (NEW.id, 83, 1),
            (NEW.id, 84, 1),
            (NEW.id, 85, 1);
        -- Ajout des armures associées
        INSERT INTO Hero_Armor (hero_id, helmet_id, armor_id, greaves_id, gloves_id) VALUES
            (NEW.id, 80, 81, 82, 83);
        	
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `Hero_Armor`
--

CREATE TABLE `Hero_Armor` (
  `hero_id` int(11) NOT NULL,
  `helmet_id` int(11) DEFAULT NULL,
  `armor_id` int(11) DEFAULT NULL,
  `greaves_id` int(11) DEFAULT NULL,
  `gloves_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `Hero_Story`
--

CREATE TABLE `Hero_Story` (
  `id` int(11) NOT NULL,
  `hero_id` int(11) NOT NULL,
  `pv` int(11) NOT NULL,
  `mana` int(11) NOT NULL,
  `chapter` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `Hero_Weapons`
--

CREATE TABLE `Hero_Weapons` (
  `hero_id` int(11) NOT NULL,
  `primary_weapon_id` int(11) DEFAULT NULL,
  `secondary_weapon_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `Inventory`
--

CREATE TABLE `Inventory` (
  `id` int(11) NOT NULL,
  `hero_id` int(11) DEFAULT NULL,
  `item_id` int(11) DEFAULT NULL,
  `quantity` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `Items`
--

CREATE TABLE `Items` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `description` text DEFAULT NULL,
  `item_type` enum('weapon','armor','consumable','miscellaneous','codex','key object') NOT NULL,
  `gold_value` int(11) NOT NULL DEFAULT 0,
  `imageName` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `Level`
--

CREATE TABLE `Level` (
  `level` int(99) NOT NULL,
  `required_xp` int(99) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `LevelBonus`
--

CREATE TABLE `LevelBonus` (
  `id` int(11) NOT NULL,
  `class_id` int(11) NOT NULL,
  `pv_bonus` int(11) NOT NULL,
  `mana_bonus` int(11) NOT NULL,
  `strength_bonus` int(11) NOT NULL,
  `initiative_bonus` int(11) NOT NULL,
  `domination_bonus` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `Links`
--

CREATE TABLE `Links` (
  `id` int(11) NOT NULL,
  `chapter_id` int(11) DEFAULT NULL,
  `next_chapter_id` int(11) DEFAULT NULL,
  `description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `Loot`
--

CREATE TABLE `Loot` (
  `id` int(11) NOT NULL,
  `item_id` int(11) DEFAULT NULL,
  `quantity` int(11) NOT NULL,
  `id_monster` int(11) NOT NULL,
  `probability` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `Merchant`
--

CREATE TABLE `Merchant` (
  `npc_id` int(11) NOT NULL,
  `gold` int(11) NOT NULL DEFAULT 0,
  `trickery_level` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `MerchantStock`
--

CREATE TABLE `MerchantStock` (
  `merchant_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `stock` int(11) NOT NULL DEFAULT 0,
  `price` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `Merchant_Racisme`
--

CREATE TABLE `Merchant_Racisme` (
  `npc_id` int(11) NOT NULL,
  `race_id` int(11) NOT NULL,
  `refus_vente_achat` tinyint(1) NOT NULL DEFAULT 0,
  `multiplicateur` decimal(5,2) NOT NULL DEFAULT 1.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `Miscellaneous`
--

CREATE TABLE `Miscellaneous` (
  `item_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déclencheurs `Miscellaneous`
--
DELIMITER $$
CREATE TRIGGER `check_miscellaneous_uniqueness_before_insert` BEFORE INSERT ON `Miscellaneous` FOR EACH ROW BEGIN
    DECLARE item_count INT;

    -- Vérifier si l'item_id existe dans Weapon
    SELECT COUNT(*) INTO item_count FROM Weapon WHERE item_id = NEW.item_id;
    IF item_count > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'L''item_id existe déjà dans Weapon, il ne peut pas être dans Miscellaneous.';
    END IF;

    -- Vérifier si l'item_id existe dans Armor
    SELECT COUNT(*) INTO item_count FROM Armor WHERE item_id = NEW.item_id;
    IF item_count > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'L''item_id existe déjà dans Armor, il ne peut pas être dans Miscellaneous.';
    END IF;

    -- Vérifier si l'item_id existe dans Consumable
    SELECT COUNT(*) INTO item_count FROM Consumable WHERE item_id = NEW.item_id;
    IF item_count > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'L''item_id existe déjà dans Consumable, il ne peut pas être dans Miscellaneous.';
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `Monster`
--

CREATE TABLE `Monster` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `pv` int(11) NOT NULL,
  `mana` int(11) DEFAULT NULL,
  `initiative` int(11) NOT NULL,
  `strength` int(11) NOT NULL,
  `xp` int(11) NOT NULL,
  `ost` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `Monster_Attack`
--

CREATE TABLE `Monster_Attack` (
  `id` int(11) NOT NULL,
  `monster_id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `effect` text DEFAULT NULL,
  `effect_function` varchar(255) DEFAULT NULL,
  `mana_cost` int(11) DEFAULT 0,
  `is_physical` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `NPC`
--

CREATE TABLE `NPC` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `OST` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `NPC_Dialogue`
--

CREATE TABLE `NPC_Dialogue` (
  `id_npc` int(11) NOT NULL,
  `id_dialogue` int(11) NOT NULL,
  `choix` text NOT NULL,
  `reponse` text NOT NULL,
  `condition` int(11) DEFAULT NULL,
  `is_end` tinyint(1) DEFAULT NULL,
  `chapter` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `NPC_FirstSentence`
--

CREATE TABLE `NPC_FirstSentence` (
  `npc_id` int(11) DEFAULT NULL,
  `chapter_id` int(11) NOT NULL,
  `INTRO_SENTENCE` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `PlayerDeaths`
--

CREATE TABLE `PlayerDeaths` (
  `id` int(11) NOT NULL,
  `player_id` int(11) NOT NULL,
  `chapter_id` int(11) NOT NULL,
  `death_count` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déclencheurs `PlayerDeaths`
--
DELIMITER $$
CREATE TRIGGER `after_death_record` AFTER INSERT ON `PlayerDeaths` FOR EACH ROW BEGIN
  UPDATE PlayerStats
  SET total_deaths = total_deaths + NEW.death_count
  WHERE player_id = NEW.player_id;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `PlayerKills`
--

CREATE TABLE `PlayerKills` (
  `id` int(11) NOT NULL,
  `player_id` int(11) NOT NULL,
  `monster_id` int(11) NOT NULL,
  `kill_count` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `PlayerSessions`
--

CREATE TABLE `PlayerSessions` (
  `id` int(11) NOT NULL,
  `player_id` int(11) NOT NULL,
  `session_start` datetime NOT NULL,
  `session_end` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `PlayerStats`
--

CREATE TABLE `PlayerStats` (
  `player_id` int(11) NOT NULL,
  `total_deaths` int(11) NOT NULL DEFAULT 0,
  `max_chapter` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `Race`
--

CREATE TABLE `Race` (
  `id` int(11) NOT NULL,
  `name` varchar(64) NOT NULL,
  `description` varchar(999) NOT NULL,
  `question` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `Racisme`
--

CREATE TABLE `Racisme` (
  `npc_id` int(11) NOT NULL,
  `race_id` int(11) NOT NULL,
  `colère` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `Spell`
--

CREATE TABLE `Spell` (
  `id` int(11) NOT NULL,
  `codex_id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `effect` text DEFAULT NULL,
  `mana_cost` int(11) DEFAULT 0,
  `level_required` int(11) DEFAULT 1,
  `effect_function` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déclencheurs `Spell`
--
DELIMITER $$
CREATE TRIGGER `check_spell_codex_before_insert` BEFORE INSERT ON `Spell` FOR EACH ROW BEGIN
    DECLARE codex_count INT;

    -- Vérifier si le `codex_id` existe dans la table `Codex` avec `item_id`
    SELECT COUNT(*) INTO codex_count FROM Codex WHERE item_id = NEW.codex_id;
    IF codex_count = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Le codex_id fourni n''existe pas dans la table Codex.';
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `Talent`
--

CREATE TABLE `Talent` (
  `id` int(11) NOT NULL,
  `name` text DEFAULT NULL,
  `description` text DEFAULT NULL,
  `type` text NOT NULL DEFAULT 'talent',
  `curse_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `Talent_Race`
--

CREATE TABLE `Talent_Race` (
  `race_id` int(11) DEFAULT NULL,
  `talent_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `Treasure`
--

CREATE TABLE `Treasure` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `item_id` int(11) DEFAULT NULL,
  `quantity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `Weapon`
--

CREATE TABLE `Weapon` (
  `item_id` int(11) NOT NULL,
  `damage_bonus` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'Bonus to damage (max 6)',
  `defense_bonus` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'Bonus to defense (max 6)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déclencheurs `Weapon`
--
DELIMITER $$
CREATE TRIGGER `check_weapon_uniqueness_before_insert` BEFORE INSERT ON `Weapon` FOR EACH ROW BEGIN
    DECLARE item_count INT;

    -- Vérifier si l'item_id existe dans Armor
    SELECT COUNT(*) INTO item_count FROM Armor WHERE item_id = NEW.item_id;
    IF item_count > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'L''item_id existe déjà dans Armor, il ne peut pas être dans Weapon.';
    END IF;

    -- Vérifier si l'item_id existe dans Consumable
    SELECT COUNT(*) INTO item_count FROM Consumable WHERE item_id = NEW.item_id;
    IF item_count > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'L''item_id existe déjà dans Consumable, il ne peut pas être dans Weapon.';
    END IF;

    -- Vérifier si l'item_id existe dans Miscellaneous
    SELECT COUNT(*) INTO item_count FROM Miscellaneous WHERE item_id = NEW.item_id;
    IF item_count > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'L''item_id existe déjà dans Miscellaneous, il ne peut pas être dans Weapon.';
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `WeaponEffect`
--

CREATE TABLE `WeaponEffect` (
  `weapon_id` int(11) NOT NULL,
  `effect_function` varchar(50) NOT NULL COMMENT 'Type of effect'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `Account`
--
ALTER TABLE `Account`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_username` (`username`),
  ADD UNIQUE KEY `uq_email` (`email`);

--
-- Index pour la table `Account_Hero`
--
ALTER TABLE `Account_Hero`
  ADD PRIMARY KEY (`account_id`,`hero_id`),
  ADD KEY `fk_hero_id` (`hero_id`);

--
-- Index pour la table `Armor`
--
ALTER TABLE `Armor`
  ADD PRIMARY KEY (`item_id`);

--
-- Index pour la table `ChangeOST`
--
ALTER TABLE `ChangeOST`
  ADD PRIMARY KEY (`chapter_id`);

--
-- Index pour la table `Chapter`
--
ALTER TABLE `Chapter`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `Chapter_Treasure`
--
ALTER TABLE `Chapter_Treasure`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Chapter_Treasure_ibfk_1` (`item_id`);

--
-- Index pour la table `Class`
--
ALTER TABLE `Class`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `Codex`
--
ALTER TABLE `Codex`
  ADD PRIMARY KEY (`item_id`);

--
-- Index pour la table `Consumable`
--
ALTER TABLE `Consumable`
  ADD PRIMARY KEY (`item_id`);

--
-- Index pour la table `Event`
--
ALTER TABLE `Event`
  ADD PRIMARY KEY (`id`),
  ADD KEY `chapter_id` (`chapter_id`),
  ADD KEY `related_monster_id` (`related_monster_id`),
  ADD KEY `fk_event_related_npc` (`related_npc_id`),
  ADD KEY `related_treasure_id` (`related_treasure_id`);

--
-- Index pour la table `Hero`
--
ALTER TABLE `Hero`
  ADD PRIMARY KEY (`id`),
  ADD KEY `race_id` (`race_id`),
  ADD KEY `class_id` (`class_id`),
  ADD KEY `Heri_ibfk_4` (`talent_id`);

--
-- Index pour la table `Hero_Armor`
--
ALTER TABLE `Hero_Armor`
  ADD PRIMARY KEY (`hero_id`),
  ADD KEY `helmet_id` (`helmet_id`),
  ADD KEY `armor_id` (`armor_id`),
  ADD KEY `greaves_id` (`greaves_id`),
  ADD KEY `gloves_id` (`gloves_id`);

--
-- Index pour la table `Hero_Story`
--
ALTER TABLE `Hero_Story`
  ADD PRIMARY KEY (`id`),
  ADD KEY `hero_id` (`hero_id`);

--
-- Index pour la table `Hero_Weapons`
--
ALTER TABLE `Hero_Weapons`
  ADD PRIMARY KEY (`hero_id`),
  ADD KEY `primary_weapon_id` (`primary_weapon_id`),
  ADD KEY `secondary_weapon_id` (`secondary_weapon_id`);

--
-- Index pour la table `Inventory`
--
ALTER TABLE `Inventory`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_inventory_item` (`item_id`),
  ADD KEY `hero_id` (`hero_id`);

--
-- Index pour la table `Items`
--
ALTER TABLE `Items`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `Level`
--
ALTER TABLE `Level`
  ADD PRIMARY KEY (`level`);

--
-- Index pour la table `LevelBonus`
--
ALTER TABLE `LevelBonus`
  ADD PRIMARY KEY (`id`),
  ADD KEY `class_id` (`class_id`);

--
-- Index pour la table `Links`
--
ALTER TABLE `Links`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_links_chapter` (`chapter_id`),
  ADD KEY `fk_links_next_chapter` (`next_chapter_id`);

--
-- Index pour la table `Loot`
--
ALTER TABLE `Loot`
  ADD PRIMARY KEY (`id`),
  ADD KEY `item_id` (`item_id`);

--
-- Index pour la table `Merchant`
--
ALTER TABLE `Merchant`
  ADD PRIMARY KEY (`npc_id`);

--
-- Index pour la table `MerchantStock`
--
ALTER TABLE `MerchantStock`
  ADD PRIMARY KEY (`merchant_id`,`item_id`),
  ADD KEY `item_id` (`item_id`),
  ADD KEY `merchant_id` (`merchant_id`);

--
-- Index pour la table `Merchant_Racisme`
--
ALTER TABLE `Merchant_Racisme`
  ADD PRIMARY KEY (`npc_id`,`race_id`),
  ADD KEY `race_id` (`race_id`);

--
-- Index pour la table `Miscellaneous`
--
ALTER TABLE `Miscellaneous`
  ADD PRIMARY KEY (`item_id`);

--
-- Index pour la table `Monster`
--
ALTER TABLE `Monster`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `Monster_Attack`
--
ALTER TABLE `Monster_Attack`
  ADD PRIMARY KEY (`id`),
  ADD KEY `monster_id` (`monster_id`);

--
-- Index pour la table `NPC`
--
ALTER TABLE `NPC`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `NPC_Dialogue`
--
ALTER TABLE `NPC_Dialogue`
  ADD PRIMARY KEY (`id_npc`,`id_dialogue`,`chapter`),
  ADD KEY `chapter` (`chapter`);

--
-- Index pour la table `NPC_FirstSentence`
--
ALTER TABLE `NPC_FirstSentence`
  ADD KEY `chapter_id` (`chapter_id`),
  ADD KEY `npc_id` (`npc_id`);

--
-- Index pour la table `PlayerDeaths`
--
ALTER TABLE `PlayerDeaths`
  ADD PRIMARY KEY (`id`),
  ADD KEY `player_id` (`player_id`),
  ADD KEY `chapter_id` (`chapter_id`);

--
-- Index pour la table `PlayerKills`
--
ALTER TABLE `PlayerKills`
  ADD PRIMARY KEY (`id`),
  ADD KEY `player_id` (`player_id`),
  ADD KEY `monster_id` (`monster_id`);

--
-- Index pour la table `PlayerSessions`
--
ALTER TABLE `PlayerSessions`
  ADD PRIMARY KEY (`id`,`player_id`),
  ADD KEY `player_id` (`player_id`);

--
-- Index pour la table `PlayerStats`
--
ALTER TABLE `PlayerStats`
  ADD PRIMARY KEY (`player_id`);

--
-- Index pour la table `Race`
--
ALTER TABLE `Race`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `Racisme`
--
ALTER TABLE `Racisme`
  ADD PRIMARY KEY (`npc_id`,`race_id`),
  ADD KEY `race_id` (`race_id`);

--
-- Index pour la table `Spell`
--
ALTER TABLE `Spell`
  ADD PRIMARY KEY (`id`),
  ADD KEY `codex_id` (`codex_id`);

--
-- Index pour la table `Talent`
--
ALTER TABLE `Talent`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_curse_id` (`curse_id`);

--
-- Index pour la table `Talent_Race`
--
ALTER TABLE `Talent_Race`
  ADD KEY `race_id` (`race_id`),
  ADD KEY `talent_id` (`talent_id`);

--
-- Index pour la table `Treasure`
--
ALTER TABLE `Treasure`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_treasure_item` (`item_id`);

--
-- Index pour la table `Weapon`
--
ALTER TABLE `Weapon`
  ADD PRIMARY KEY (`item_id`);

--
-- Index pour la table `WeaponEffect`
--
ALTER TABLE `WeaponEffect`
  ADD KEY `fk_weapon` (`weapon_id`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `Account`
--
ALTER TABLE `Account`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `Chapter`
--
ALTER TABLE `Chapter`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `Chapter_Treasure`
--
ALTER TABLE `Chapter_Treasure`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `Class`
--
ALTER TABLE `Class`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `Event`
--
ALTER TABLE `Event`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `Hero`
--
ALTER TABLE `Hero`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `Hero_Story`
--
ALTER TABLE `Hero_Story`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `Inventory`
--
ALTER TABLE `Inventory`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `Items`
--
ALTER TABLE `Items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `LevelBonus`
--
ALTER TABLE `LevelBonus`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `Links`
--
ALTER TABLE `Links`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `Monster_Attack`
--
ALTER TABLE `Monster_Attack`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `NPC`
--
ALTER TABLE `NPC`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `PlayerDeaths`
--
ALTER TABLE `PlayerDeaths`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `PlayerKills`
--
ALTER TABLE `PlayerKills`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `PlayerSessions`
--
ALTER TABLE `PlayerSessions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `Talent`
--
ALTER TABLE `Talent`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `Treasure`
--
ALTER TABLE `Treasure`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `Account_Hero`
--
ALTER TABLE `Account_Hero`
  ADD CONSTRAINT `fk_account_id` FOREIGN KEY (`account_id`) REFERENCES `Account` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_hero_id` FOREIGN KEY (`hero_id`) REFERENCES `Hero` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `Armor`
--
ALTER TABLE `Armor`
  ADD CONSTRAINT `fk_armor` FOREIGN KEY (`item_id`) REFERENCES `Items` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `ChangeOST`
--
ALTER TABLE `ChangeOST`
  ADD CONSTRAINT `fk_chapter_id` FOREIGN KEY (`chapter_id`) REFERENCES `Chapter` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `Chapter_Treasure`
--
ALTER TABLE `Chapter_Treasure`
  ADD CONSTRAINT `Chapter_Treasure_ibfk_1` FOREIGN KEY (`item_id`) REFERENCES `Items` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `Codex`
--
ALTER TABLE `Codex`
  ADD CONSTRAINT `fk_codex` FOREIGN KEY (`item_id`) REFERENCES `Items` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `Consumable`
--
ALTER TABLE `Consumable`
  ADD CONSTRAINT `Consumable_ibfk_1` FOREIGN KEY (`item_id`) REFERENCES `Items` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `Event`
--
ALTER TABLE `Event`
  ADD CONSTRAINT `Event_ibfk_1` FOREIGN KEY (`chapter_id`) REFERENCES `Chapter` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Event_ibfk_2` FOREIGN KEY (`related_monster_id`) REFERENCES `Monster` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `Event_ibfk_3` FOREIGN KEY (`related_treasure_id`) REFERENCES `Chapter_Treasure` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_event_related_npc` FOREIGN KEY (`related_npc_id`) REFERENCES `NPC` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Contraintes pour la table `Hero`
--
ALTER TABLE `Hero`
  ADD CONSTRAINT `Heri_ibfk_4` FOREIGN KEY (`talent_id`) REFERENCES `Talent` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Hero_ibfk_2` FOREIGN KEY (`race_id`) REFERENCES `Race` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Hero_ibfk_3` FOREIGN KEY (`class_id`) REFERENCES `Class` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `Hero_Armor`
--
ALTER TABLE `Hero_Armor`
  ADD CONSTRAINT `Hero_Armor_ibfk_1` FOREIGN KEY (`hero_id`) REFERENCES `Hero` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Hero_Armor_ibfk_2` FOREIGN KEY (`helmet_id`) REFERENCES `Items` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `Hero_Armor_ibfk_3` FOREIGN KEY (`armor_id`) REFERENCES `Items` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `Hero_Armor_ibfk_4` FOREIGN KEY (`greaves_id`) REFERENCES `Items` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `Hero_Armor_ibfk_5` FOREIGN KEY (`gloves_id`) REFERENCES `Items` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Contraintes pour la table `Hero_Story`
--
ALTER TABLE `Hero_Story`
  ADD CONSTRAINT `Hero_Story_ibfk_1` FOREIGN KEY (`hero_id`) REFERENCES `Hero` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `Hero_Weapons`
--
ALTER TABLE `Hero_Weapons`
  ADD CONSTRAINT `Hero_Weapons_ibfk_1` FOREIGN KEY (`hero_id`) REFERENCES `Hero` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Hero_Weapons_ibfk_2` FOREIGN KEY (`primary_weapon_id`) REFERENCES `Items` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Hero_Weapons_ibfk_3` FOREIGN KEY (`secondary_weapon_id`) REFERENCES `Items` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `Inventory`
--
ALTER TABLE `Inventory`
  ADD CONSTRAINT `Inventory_ibfk_1` FOREIGN KEY (`hero_id`) REFERENCES `Hero` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_inventory_item` FOREIGN KEY (`item_id`) REFERENCES `Items` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `LevelBonus`
--
ALTER TABLE `LevelBonus`
  ADD CONSTRAINT `LevelBonus_ibfk_1` FOREIGN KEY (`class_id`) REFERENCES `Class` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `Links`
--
ALTER TABLE `Links`
  ADD CONSTRAINT `fk_links_chapter` FOREIGN KEY (`chapter_id`) REFERENCES `Chapter` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_links_next_chapter` FOREIGN KEY (`next_chapter_id`) REFERENCES `Chapter` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `Loot`
--
ALTER TABLE `Loot`
  ADD CONSTRAINT `Loot_ibfk_1` FOREIGN KEY (`item_id`) REFERENCES `Items` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `Merchant`
--
ALTER TABLE `Merchant`
  ADD CONSTRAINT `Merchant_ibfk_1` FOREIGN KEY (`npc_id`) REFERENCES `NPC` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `MerchantStock`
--
ALTER TABLE `MerchantStock`
  ADD CONSTRAINT `MerchantStock_ibfk_1` FOREIGN KEY (`item_id`) REFERENCES `Items` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `MerchantStock_ibfk_2` FOREIGN KEY (`merchant_id`) REFERENCES `Merchant` (`npc_id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `Merchant_Racisme`
--
ALTER TABLE `Merchant_Racisme`
  ADD CONSTRAINT `Merchant_Racisme_ibfk_1` FOREIGN KEY (`npc_id`) REFERENCES `NPC` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `Merchant_Racisme_ibfk_2` FOREIGN KEY (`race_id`) REFERENCES `Race` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `Miscellaneous`
--
ALTER TABLE `Miscellaneous`
  ADD CONSTRAINT `Miscellaneous_ibfk_1` FOREIGN KEY (`item_id`) REFERENCES `Items` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `Monster_Attack`
--
ALTER TABLE `Monster_Attack`
  ADD CONSTRAINT `Monster_Attack_ibfk_1` FOREIGN KEY (`monster_id`) REFERENCES `Monster` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `NPC_Dialogue`
--
ALTER TABLE `NPC_Dialogue`
  ADD CONSTRAINT `NPC_Dialogue_ibfk_1` FOREIGN KEY (`id_npc`) REFERENCES `NPC` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `NPC_Dialogue_ibfk_2` FOREIGN KEY (`chapter`) REFERENCES `Chapter` (`id`);

--
-- Contraintes pour la table `NPC_FirstSentence`
--
ALTER TABLE `NPC_FirstSentence`
  ADD CONSTRAINT `NPC_FirstSentence_ibfk_1` FOREIGN KEY (`chapter_id`) REFERENCES `Chapter` (`id`),
  ADD CONSTRAINT `NPC_FirstSentence_ibfk_2` FOREIGN KEY (`npc_id`) REFERENCES `NPC` (`id`);

--
-- Contraintes pour la table `PlayerDeaths`
--
ALTER TABLE `PlayerDeaths`
  ADD CONSTRAINT `PlayerDeaths_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `Hero` (`id`),
  ADD CONSTRAINT `PlayerDeaths_ibfk_2` FOREIGN KEY (`chapter_id`) REFERENCES `Chapter` (`id`);

--
-- Contraintes pour la table `PlayerKills`
--
ALTER TABLE `PlayerKills`
  ADD CONSTRAINT `PlayerKills_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `Hero` (`id`),
  ADD CONSTRAINT `PlayerKills_ibfk_2` FOREIGN KEY (`monster_id`) REFERENCES `Monster` (`id`);

--
-- Contraintes pour la table `PlayerSessions`
--
ALTER TABLE `PlayerSessions`
  ADD CONSTRAINT `PlayerSessions_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `Account` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `PlayerStats`
--
ALTER TABLE `PlayerStats`
  ADD CONSTRAINT `PlayerStats_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `Hero` (`id`);

--
-- Contraintes pour la table `Racisme`
--
ALTER TABLE `Racisme`
  ADD CONSTRAINT `Racisme_ibfk_1` FOREIGN KEY (`npc_id`) REFERENCES `NPC` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `Racisme_ibfk_2` FOREIGN KEY (`race_id`) REFERENCES `Race` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `Spell`
--
ALTER TABLE `Spell`
  ADD CONSTRAINT `Spell_ibfk_1` FOREIGN KEY (`codex_id`) REFERENCES `Codex` (`item_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `Talent`
--
ALTER TABLE `Talent`
  ADD CONSTRAINT `fk_curse_id` FOREIGN KEY (`curse_id`) REFERENCES `Talent` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Contraintes pour la table `Talent_Race`
--
ALTER TABLE `Talent_Race`
  ADD CONSTRAINT `Talent_Race_ibfk_1` FOREIGN KEY (`race_id`) REFERENCES `Race` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Talent_Race_ibfk_2` FOREIGN KEY (`talent_id`) REFERENCES `Talent` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `Treasure`
--
ALTER TABLE `Treasure`
  ADD CONSTRAINT `fk_treasure_item` FOREIGN KEY (`item_id`) REFERENCES `Items` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `Weapon`
--
ALTER TABLE `Weapon`
  ADD CONSTRAINT `Weapon_ibfk_1` FOREIGN KEY (`item_id`) REFERENCES `Items` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `WeaponEffect`
--
ALTER TABLE `WeaponEffect`
  ADD CONSTRAINT `fk_weapon` FOREIGN KEY (`weapon_id`) REFERENCES `Weapon` (`item_id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
