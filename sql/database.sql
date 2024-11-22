-- phpMyAdmin SQL Dump
-- version 5.2.1deb1
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost:3306
-- Généré le : ven. 22 nov. 2024 à 13:56
-- Version du serveur : 10.11.6-MariaDB-0+deb12u1
-- Version de PHP : 8.2.24

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
  `email` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `Account`
--

INSERT INTO `Account` (`id`, `username`, `password`, `email`) VALUES
(8, 'testMage', '$2y$10$PuPm0zJzOoATRPqiSVIOq.03CbtDndO8qKA1sJGJ.h0DbxzRXKO32', 'test.mage@gmail.com'),
(9, 'testGuerrier', '$2y$10$qebjKEVsM7aKzGzAFo7ppOaAq70kyDP79IvPEoW5qy6YD17M6pOBq', 'test.guerrier@gmail.com'),
(10, 'testVoleur', '$2y$10$sa0n72kjQH.fVdGaqrJM2ujHMZ4HUDFTH.unsuYSNFBgEDqVYWEVm', 'test.voleur@gmail.com'),
(11, 'testSuppri', '$2y$10$Rx82nvEl1O5XFjtTl2/NJ.XTA0sP4G70.9iKKeBxvxKMuQkebQ8Fa', 'test.suppr@gmail.com');

-- --------------------------------------------------------

--
-- Structure de la table `Armor`
--

CREATE TABLE `Armor` (
  `item_id` int(11) NOT NULL,
  `defense` int(11) NOT NULL,
  `weight` int(11) NOT NULL,
  `slot` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `Armor`
--

INSERT INTO `Armor` (`item_id`, `defense`, `weight`, `slot`) VALUES
(4, 4, 25, 'body'),
(5, 3, 15, 'body'),
(6, 2, 10, 'head'),
(13, 3, 5, 'head'),
(14, 5, 15, 'body'),
(15, 4, 8, 'legs'),
(16, 2, 2, 'hands'),
(19, 2, 3, 'head'),
(20, 1, 4, 'body'),
(21, 2, 2, 'hands'),
(24, 1, 1, 'head'),
(25, 2, 3, 'body'),
(26, 2, 2, 'legs');

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
-- Structure de la table `Categorie`
--

CREATE TABLE `Categorie` (
  `id_categorie` int(3) NOT NULL,
  `nom` varchar(20) NOT NULL,
  `qte_effet` int(3) NOT NULL,
  `description` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `Chapter`
--

CREATE TABLE `Chapter` (
  `id` int(11) NOT NULL,
  `content` text NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `treasure_id` int(11) DEFAULT NULL,
  `titre` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `Chapter`
--

INSERT INTO `Chapter` (`id`, `content`, `image`, `treasure_id`, `titre`) VALUES
(1, 'Le ciel est lourd ce soir sur le village du Val Perdu, dissimulé entre les montagnes. La petite taverne, dernier refuge avant l\'immense forêt, est étrangement calme quand le bourgmestre s\'approche de vous. Homme d\'apparence usée par les années et les soucis, il vous adresse un regard désespéré. \"Ma fille… elle a disparu dans la forêt. Personne n\'a osé la chercher… sauf vous, peut-être ? On raconte qu\'un sorcier vit dans un château en ruines, caché au cœur des bois. Depuis des mois, des jeunes filles disparaissent… J\'ai besoin de vous pour la retrouver.\" Vous sentez le poids de la mission qui s\'annonce, et un frisson parcourt votre échine. Bientôt, la forêt s\'ouvre devant vous, sombre et menaçante. La quête commence.', NULL, NULL, 'Introduction'),
(2, 'Vous franchissez la lisière des arbres, la pénombre de la forêt avalant le sentier devant vous. Un vent froid glisse entre les troncs, et le bruissement des feuilles ressemble à un murmure menaçant. Deux chemins s’offrent à vous : l’un sinueux, bordé de vieux arbres noueux ; l’autre droit mais envahi par des ronces épaisses.', NULL, NULL, 'L\'orée de la forêt'),
(3, 'Votre choix vous mène devant un vieux chêne aux branches tordues, grouillant de corbeaux noirs qui vous observent en silence. À vos pieds, des traces de pas légers, probablement récents, mènent plus loin dans les bois. Soudain, un bruit de pas feutrés se fait entendre. Vous ressentez la présence d’un prédateur.', NULL, NULL, 'L\'arbre aux corbeaux'),
(4, 'Le calme de la forêt est soudain brisé par un grognement. Surgissant des buissons, un énorme sanglier, au pelage épais et aux yeux injectés de sang, se dirige vers vous. Sa rage est palpable, et il semble prêt à en découdre.', NULL, NULL, 'Le sanglier enragé'),
(5, 'Tandis que vous progressez, une voix humaine s’élève, interrompant le silence de la forêt. Vous tombez sur un vieux paysan, accroupi près de champignons aux couleurs vives. Il sursaute en vous voyant, puis se détend, vous souriant tristement.', NULL, NULL, 'Rencontre avec le paysan'),
(6, 'À mesure que vous avancez, un bruissement attire votre attention. Une silhouette sombre s’élance soudainement devant vous : un loup noir aux yeux perçants. Son poil est hérissé et sa gueule laisse entrevoir des crocs acérés. Vous sentez son regard fixé sur vous, prêt à bondir.', NULL, NULL, 'Le loup noir'),
(7, 'Après votre rencontre, vous atteignez une clairière étrange, entourée de pierres dressées, comme un ancien autel oublié par le temps. Une légère brume rampe au sol, et les ombres des pierres semblent danser sous la lueur de la lune.', NULL, NULL, 'La clairière aux pierres anciennes'),
(8, 'Essoufflé mais déterminé, vous arrivez près d’un petit ruisseau qui serpente au milieu des arbres. Le chant de l’eau vous apaise quelque peu, mais des murmures étranges semblent émaner de la rive. Vous apercevez des inscriptions anciennes gravées dans une pierre moussue.', NULL, NULL, 'Les murmures du ruisseau'),
(9, 'La forêt se disperse enfin, et devant vous se dresse une colline escarpée. Au sommet, le château en ruines projette une ombre menaçante sous le clair de lune. Les murs effrités et les tours en partie effondrées ajoutent à la sinistre réputation du lieu. Vous sentez que la véritable aventure commence ici.', NULL, NULL, 'Au pied du château'),
(10, 'Le monde se dérobe sous vos pieds, et une obscurité profonde vous enveloppe, glaciale et insondable. Vous ne sentez plus le poids de votre équipement, ni la morsure de la douleur. Juste un vide infini, vous aspirant lentement dans les ténèbres. Une lueur douce apparaît au loin, vacillante comme une flamme fragile dans l’obscurité.', NULL, NULL, 'La lumière au bout du néant');

-- --------------------------------------------------------

--
-- Structure de la table `Chapter_Treasure`
--

CREATE TABLE `Chapter_Treasure` (
  `id` int(11) NOT NULL,
  `chapter_id` int(11) DEFAULT NULL,
  `item_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `Class`
--

CREATE TABLE `Class` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `description` text DEFAULT NULL,
  `base_pv` int(11) NOT NULL,
  `base_mana` int(11) NOT NULL,
  `strength` int(11) NOT NULL,
  `initiative` int(11) NOT NULL,
  `max_items` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `Class`
--

INSERT INTO `Class` (`id`, `name`, `description`, `base_pv`, `base_mana`, `strength`, `initiative`, `max_items`) VALUES
(1, 'Guerrier', 'Un combattant puissant avec une force brute.', 30, 0, 10, 5, 8),
(2, 'Mage', 'Un lanceur de sorts avec une grande puissance magique.', 15, 30, 3, 4, 6),
(3, 'Voleur', 'Un maître de la furtivité et des attaques rapides.', 15, 15, 5, 8, 7);

-- --------------------------------------------------------

--
-- Structure de la table `Codex`
--

CREATE TABLE `Codex` (
  `item_id` int(11) NOT NULL,
  `family` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `Codex`
--

INSERT INTO `Codex` (`item_id`, `family`) VALUES
(36, 'Umbrae'),
(37, 'Thanatos'),
(38, 'Carnifex'),
(39, 'Obsidianus'),
(40, 'Inferna'),
(41, 'Venenum'),
(42, 'Noctis'),
(43, 'Fulgoris'),
(44, 'Mortis'),
(45, 'Arcanum'),
(46, 'Malachior'),
(47, 'Venator'),
(48, 'Tenebris'),
(49, 'Lugdor'),
(50, 'Ferox');

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
-- Déchargement des données de la table `Consumable`
--

INSERT INTO `Consumable` (`item_id`, `effect_type`, `heal_amount`, `mana_amount`, `attack_buff`, `defense_buff`, `duration`) VALUES
(7, 'heal', 5, NULL, NULL, NULL, NULL),
(8, 'mana', NULL, 3, NULL, NULL, NULL),
(9, 'buff', NULL, NULL, 5, NULL, 10),
(18, 'buff', NULL, NULL, 10, NULL, 10),
(23, 'mana', NULL, 30, NULL, NULL, NULL),
(28, 'buff', NULL, NULL, NULL, NULL, 5);

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
  `event_type` enum('exploration','combat','dungeon','npc_interaction','treasure','puzzle','death') NOT NULL,
  `description` text DEFAULT NULL,
  `related_monster_id` int(11) DEFAULT NULL,
  `related_treasure_id` int(11) DEFAULT NULL,
  `related_puzzle` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `Event`
--

INSERT INTO `Event` (`id`, `chapter_id`, `event_type`, `description`, `related_monster_id`, `related_treasure_id`, `related_puzzle`) VALUES
(101, 6, 'combat', 'Un Loup Noir vous attaque dans une clairière sombre.', 1, NULL, NULL),
(102, 4, 'combat', 'Un Sanglier Enragé surgit des buissons et charge !', 2, NULL, NULL),
(103, 10, 'death', 'La mort vous emporte', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `Hero`
--

CREATE TABLE `Hero` (
  `id` int(11) NOT NULL,
  `lastname` varchar(50) NOT NULL,
  `class_id` int(11) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `biography` text DEFAULT NULL,
  `pv` int(11) NOT NULL,
  `mana` int(11) NOT NULL,
  `strength` int(11) NOT NULL,
  `initiative` int(11) NOT NULL,
  `armor` varchar(50) DEFAULT NULL,
  `xp` int(11) NOT NULL DEFAULT 0,
  `current_level` int(11) DEFAULT 1,
  `poids_max` double NOT NULL DEFAULT 100,
  `nb_items_max` int(11) NOT NULL DEFAULT 20,
  `firstname` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `Hero`
--

INSERT INTO `Hero` (`id`, `lastname`, `class_id`, `image`, `biography`, `pv`, `mana`, `strength`, `initiative`, `armor`, `xp`, `current_level`, `poids_max`, `nb_items_max`, `firstname`) VALUES
(8, 'Caria', 2, NULL, 'Grande mage de la lune', 15, 30, 3, 4, NULL, 0, 1, 100, 20, 'Rennala'),
(10, 'l\'Affranchie', 3, NULL, '', 15, 15, 5, 8, NULL, 0, 1, 100, 20, 'Pat');

--
-- Déclencheurs `Hero`
--
DELIMITER $$
CREATE TRIGGER `after_hero_creation` AFTER INSERT ON `Hero` FOR EACH ROW BEGIN
    IF NEW.class_id = 1 THEN
        -- Guerrier : arme principale et secondaire par défaut
        INSERT INTO Hero_Weapons (hero_id, primary_weapon_id, secondary_weapon_id)
        VALUES (NEW.id, 2, 34);

        -- Ajout des objets dans l'inventaire
        INSERT INTO Inventory (hero_id, item_id) VALUES 
            (NEW.id, 13), 
            (NEW.id, 14), 
            (NEW.id, 15), 
            (NEW.id, 16), 
            (NEW.id, 17), 
            (NEW.id, 34);

        -- Ajout des armures associées
        INSERT INTO Hero_Armor (hero_id, helmet_id, armor_id, greaves_id) VALUES 
            (NEW.id, 13, 14, 15);
        
    ELSEIF NEW.class_id = 2 THEN
        -- Magicien : arme principale et secondaire par défaut
        INSERT INTO Hero_Weapons (hero_id, primary_weapon_id, secondary_weapon_id)
        VALUES (NEW.id, 22, 35);

        -- Ajout des objets dans l'inventaire
        INSERT INTO Inventory (hero_id, item_id) VALUES 
            (NEW.id, 19), 
            (NEW.id, 20), 
            (NEW.id, 21), 
            (NEW.id, 22), 
            (NEW.id, 23), 
            (NEW.id, 35),
            (NEW.id, 40),
            (NEW.id, 45);

        -- Ajout des armures associées
        INSERT INTO Hero_Armor (hero_id, helmet_id, armor_id, greaves_id) VALUES 
            (NEW.id, 19, 20, NULL);
        
    ELSEIF NEW.class_id = 3 THEN
        -- Voleur : arme principale et secondaire par défaut
        INSERT INTO Hero_Weapons (hero_id, primary_weapon_id, secondary_weapon_id)
        VALUES (NEW.id, 3, 35);

        -- Ajout des objets dans l'inventaire
        INSERT INTO Inventory (hero_id, item_id) VALUES 
            (NEW.id, 24), 
            (NEW.id, 25), 
            (NEW.id, 26), 
            (NEW.id, 27), 
            (NEW.id, 28), 
            (NEW.id, 35),
            (NEW.id, 42);

        -- Ajout des armures associées
        INSERT INTO Hero_Armor (hero_id, helmet_id, armor_id, greaves_id) VALUES 
            (NEW.id, 24, 25, 26);
        
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
  `greaves_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `Hero_Armor`
--

INSERT INTO `Hero_Armor` (`hero_id`, `helmet_id`, `armor_id`, `greaves_id`) VALUES
(8, 19, 20, NULL),
(10, 24, 25, 26);

-- --------------------------------------------------------

--
-- Structure de la table `Hero_Updates`
--

CREATE TABLE `Hero_Updates` (
  `hero_id` int(11) NOT NULL,
  `primary_weapon_id` int(11) DEFAULT NULL,
  `secondary_weapon_id` int(11) DEFAULT NULL
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

--
-- Déchargement des données de la table `Hero_Weapons`
--

INSERT INTO `Hero_Weapons` (`hero_id`, `primary_weapon_id`, `secondary_weapon_id`) VALUES
(8, 22, 35),
(10, 3, 35);

-- --------------------------------------------------------

--
-- Structure de la table `Inventory`
--

CREATE TABLE `Inventory` (
  `id` int(11) NOT NULL,
  `hero_id` int(11) DEFAULT NULL,
  `item_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `Inventory`
--

INSERT INTO `Inventory` (`id`, `hero_id`, `item_id`) VALUES
(74, 8, 19),
(75, 8, 20),
(76, 8, 21),
(77, 8, 22),
(78, 8, 23),
(79, 8, 35),
(80, 8, 40),
(81, 8, 45),
(98, 8, 32),
(99, 8, 30),
(100, 8, 31),
(101, 8, 31),
(102, 10, 24),
(103, 10, 25),
(104, 10, 26),
(105, 10, 27),
(106, 10, 28),
(107, 10, 35),
(108, 10, 42),
(109, 10, 33),
(110, 10, 31),
(111, 10, 31),
(112, 10, 30),
(113, 10, 31),
(114, 10, 31),
(115, 10, 30),
(116, 10, 33),
(117, 10, 33),
(118, 10, 31),
(119, 10, 31);

-- --------------------------------------------------------

--
-- Structure de la table `Items`
--

CREATE TABLE `Items` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `description` text DEFAULT NULL,
  `unite_inv` int(11) DEFAULT NULL,
  `poids` int(11) DEFAULT NULL,
  `item_type` enum('weapon','armor','consumable','miscellaneous','codex') NOT NULL,
  `gold_value` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `Items`
--

INSERT INTO `Items` (`id`, `name`, `description`, `unite_inv`, `poids`, `item_type`, `gold_value`) VALUES
(1, 'Épée longue', 'Une épée forgée pour le combat rapproché.', 3, 10, 'weapon', 50),
(2, 'Hache de bataille', 'Une hache lourde capable de briser des armures.', 4, 15, 'weapon', 75),
(3, 'Dague en acier noir', 'Une dague rapide et mortelle, idéale pour les assassins.', 1, 5, 'weapon', 30),
(4, 'Armure de plaques', 'Une armure complète offrant une protection maximale.', 6, 30, 'armor', 150),
(5, 'Cuirasse renforcée', 'Une armure de cuir renforcé avec du métal.', 4, 20, 'armor', 80),
(6, 'Casque à cornes', 'Un casque intimidant avec des cornes massives.', 2, 10, 'armor', 40),
(7, 'Potion de soins', 'Régénère 5 points de vie.', 1, 1, 'consumable', 25),
(8, 'Potion de mana', 'Restaure 3 points de mana.', 1, 1, 'consumable', 20),
(9, 'Poudre de force', 'Augmente la force pendant 10 minutes.', 1, 2, 'consumable', 35),
(10, 'Amulette maudite', 'Une amulette obscure qui porte malheur à son porteur.', 1, 1, 'miscellaneous', 10),
(11, 'Parchemin ancien', 'Un parchemin contenant des runes illisibles.', 1, 1, 'miscellaneous', 15),
(12, 'Pierre magique', 'Une pierre mystérieuse pulsant d\'une faible lumière.', 1, 1, 'miscellaneous', 50),
(13, 'Casque Guerrier', 'Un casque solide offrant une bonne protection.', 1, 2, 'armor', 40),
(14, 'Armure Guerrier', 'Une armure lourde offrant une protection maximale.', 6, 25, 'armor', 120),
(15, 'Jambiers Guerrier', 'Protection pour les jambes des guerriers.', 2, 5, 'armor', 60),
(16, 'Gants Guerrier', 'Des gants renforcés pour une meilleure prise.', 1, 2, 'armor', 30),
(17, 'Épée de guerre', 'Une épée lourde et puissante.', 3, 15, 'weapon', 150),
(18, 'Potion de force', 'Augmente la force pendant 10 minutes.', 1, 1, 'consumable', 50),
(19, 'Chapeau de magicien', 'Chapeau pointu offrant une résistance magique.', 1, 2, 'armor', 35),
(20, 'Robe de magicien', 'Robe magique légère.', 6, 25, 'armor', 80),
(21, 'Gants de mage', 'Gants amplifiant les pouvoirs magiques.', 1, 2, 'armor', 40),
(22, 'Bâton magique', 'Un bâton qui canalise la magie.', 2, 5, 'weapon', 100),
(23, 'Potion de régénération de mana', 'Restaure 30 points de mana.', 1, 1, 'consumable', 45),
(24, 'Masque de voleur', 'Masque léger pour dissimuler son identité.', 1, 2, 'armor', 25),
(25, 'Robe de voleur', 'Robe légère pour agilité et discrétion.', 1, 3, 'armor', 50),
(26, 'Jambiers de voleur', 'Jambiers légers pour une meilleure mobilité.', 2, 5, 'armor', 30),
(27, 'Dagues de voleur', 'Deux petites dagues pour des attaques rapides.', 1, 3, 'weapon', 70),
(28, 'Potion de furtivité', 'Rend invisible temporairement.', 1, 1, 'consumable', 60),
(29, 'Grimoire magique', 'Un livre ancien contenant des sorts et des connaissances magiques.', 3, 10, 'miscellaneous', 150),
(30, 'Fourrure de loup', 'Une fourrure sombre et dense, utile pour les vêtements.', 1, 2, 'miscellaneous', 10),
(31, 'Croc de loup', 'Un croc acéré, parfait pour les artisans ou comme trophée.', 1, 2, 'miscellaneous', 5),
(32, 'Peau de sanglier', 'Une peau épaisse, idéale pour renforcer une armure.', 1, 1, 'miscellaneous', 15),
(33, 'Défense de sanglier', 'Une grande défense, très recherchée par les collectionneurs.', 1, 3, 'miscellaneous', 20),
(34, 'Bouclier', 'Un bouclier de base', 1, 2, 'weapon', 100),
(35, 'Dague', 'Une dague de base', 1, 1, 'weapon', 50),
(36, 'Codex Umbrae', 'Un ancien grimoire contenant des secrets liés à la magie des ombres et de la peur.', 1, 3, 'codex', 200),
(37, 'Codex Thanatos', 'Un codex noir qui explore les arcanes de la nécromancie et de la manipulation des âmes.', 1, 4, 'codex', 250),
(38, 'Codex Carnifex', 'Un livre de rituels sanguinaires et de pouvoirs tirés de la douleur et du sacrifice.', 1, 5, 'codex', 300),
(39, 'Codex Obsidianus', 'Un codex mystérieux lié aux cristaux maudits et aux pièges dimensionnels.', 1, 3, 'codex', 220),
(40, 'Codex Inferna', 'Un grimoire ancien dédié aux flammes et à la destruction totale.', 1, 4, 'codex', 350),
(41, 'Codex Venenum', 'Un ouvrage de sciences sombres, enseignant la manipulation des poisons et des maladies.', 1, 3, 'codex', 180),
(42, 'Codex Noctis', 'Un codex astral, détaillant la magie des étoiles et des entités cosmiques des abysses.', 1, 5, 'codex', 400),
(43, 'Codex Fulgoris', 'Un grimoire rendant maître des tempêtes et de la foudre dévastatrice.', 1, 4, 'codex', 275),
(44, 'Codex Mortis', 'Un codex qui explore la magie des cadavres et des rituels morbides.', 1, 4, 'codex', 250),
(45, 'Codex Arcanum', 'Un livre des connaissances interdites et des secrets ancestraux liés aux dimensions perdues.', 1, 3, 'codex', 350),
(46, 'Codex Malachior', 'Un codex permettant de manipuler les esprits et de contrôler les âmes.', 1, 3, 'codex', 230),
(47, 'Codex Venator', 'Un grimoire traitant de la chasse magique, des malédictions et des pièges magiques.', 1, 4, 'codex', 200),
(48, 'Codex Tenebris', 'Un ouvrage d’ombres et de rituels puissants, nécessitant des sacrifices.', 1, 5, 'codex', 280),
(49, 'Codex Lugdor', 'Un livre dédié à l’invocation des anciens dieux oubliés et des rituels cosmiques.', 1, 6, 'codex', 500),
(50, 'Codex Ferox', 'Un codex qui enseigne la transformation en créatures sauvages et l’invocation de bêtes infernales.', 1, 4, 'codex', 300);

-- --------------------------------------------------------

--
-- Structure de la table `Level`
--

CREATE TABLE `Level` (
  `id` int(11) NOT NULL,
  `class_id` int(11) DEFAULT NULL,
  `level` int(11) NOT NULL,
  `required_xp` int(11) NOT NULL,
  `pv_bonus` int(11) NOT NULL,
  `mana_bonus` int(11) NOT NULL,
  `strength_bonus` int(11) NOT NULL,
  `initiative_bonus` int(11) NOT NULL
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

--
-- Déchargement des données de la table `Links`
--

INSERT INTO `Links` (`id`, `chapter_id`, `next_chapter_id`, `description`) VALUES
(3, 1, 2, 'Le bourgmestre vous indique le sentier. Soyez prudents, la forêt cache des dangers.'),
(4, 2, 3, 'Le vent vous guide vers un sentier sinueux.'),
(5, 2, 4, 'Un cri d\'animal résonne alors que vous avancez à travers les ronces.'),
(24, 3, 5, 'Vous croisez un vieux paysan qui vous avertit des créatures de la forêt.'),
(25, 3, 6, 'Vous ignorez les bruits et continuez, jusqu\'à rencontrer un loup noir.'),
(26, 4, 7, 'Après avoir vaincu le sanglier, vous découvrez une clairière entourée de pierres anciennes.'),
(27, 4, 10, 'Le sanglier vous terrasse et vous vous retrouvez dans l’obscurité, où un mystère vous attend.'),
(28, 5, 7, 'Le paysan vous avertit, mais vous continuez et arrivez dans une clairière entourée de pierres.'),
(29, 6, 7, 'Après le combat avec le loup, vous atteignez une clairière brumeuse avec des pierres dressées.'),
(30, 7, 8, 'Dans la clairière, vous apercevez un ruisseau paisible et des murmures étranges.'),
(31, 7, 9, 'Vous avancez vers le château en ruines, l’ombre du mal vous attend.'),
(33, 8, 9, 'Vous ignorez les murmures et vous approchez du château, toujours plus près du mystère.'),
(34, 9, 10, 'Le château en ruines cache un mal ancien prêt à surgir.'),
(35, 10, 1, 'L’obscurité vous engloutit, vous guidant vers une lumière qui pourrait vous coûter cher.'),
(36, 6, 7, NULL);

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

--
-- Déchargement des données de la table `Loot`
--

INSERT INTO `Loot` (`id`, `item_id`, `quantity`, `id_monster`, `probability`) VALUES
(1, 30, 1, 1, 60),
(2, 31, 2, 1, 40),
(3, 33, 1, 2, 75),
(4, 32, 1, 2, 25);

-- --------------------------------------------------------

--
-- Structure de la table `Miscellaneous`
--

CREATE TABLE `Miscellaneous` (
  `item_id` int(11) NOT NULL,
  `special_property` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `Miscellaneous`
--

INSERT INTO `Miscellaneous` (`item_id`, `special_property`) VALUES
(10, 'Apporte malchance au porteur.'),
(11, 'Peut être utilisé pour résoudre des énigmes.'),
(12, 'Permet de détecter des passages secrets.'),
(29, 'Magie ancienne'),
(30, NULL),
(31, NULL),
(32, NULL),
(33, NULL);

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
  `attack` text DEFAULT NULL,
  `xp` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `Monster`
--

INSERT INTO `Monster` (`id`, `name`, `pv`, `mana`, `initiative`, `strength`, `attack`, `xp`) VALUES
(1, 'Loup Noir', 15, 0, 6, 10, 'Morsure vicieuse', 50),
(2, 'Sanglier Enragé', 5, 0, 4, 13, 'Charge brutale', 70);

-- --------------------------------------------------------

--
-- Structure de la table `Quest`
--

CREATE TABLE `Quest` (
  `id` int(11) NOT NULL,
  `hero_id` int(11) DEFAULT NULL,
  `chapter_id` int(11) DEFAULT NULL
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
-- Déchargement des données de la table `Spell`
--

INSERT INTO `Spell` (`id`, `codex_id`, `name`, `effect`, `mana_cost`, `level_required`, `effect_function`) VALUES
(1, 36, 'Obscuritas Noctis', 'Plonge l\'ennemi dans une nuit noire éternelle, réduisant sa perception et ses attaques pendant 3 tours.', 25, 5, 'reduce_attack(5, 3); reduce_perception(10, 3)'),
(2, 36, 'Cloak of Despair', 'Entoure l\'ennemi d\'un voile de désespoir, réduisant son moral et sa résistance pendant 2 tours.', 30, 6, 'reduce_morale(5, 2); reduce_resistance(5, 2)'),
(3, 36, 'Nightmare Weaver', 'Crée une illusion dévastatrice qui fait vivre les plus grandes peurs de la cible, la paralysant brièvement pendant 1 tour.', 35, 8, 'paralyze(1)'),
(4, 37, 'Soul Reaver', 'Extraire l\'âme d\'un ennemi pour ajouter temporairement de la mana à l\'utilisateur pendant 1 tour.', 30, 6, 'gain_mana(20, 1)'),
(5, 37, 'Necrotic Drain', 'Drainer la vie des ennemis autour, leur infligeant des dégâts tout en soignant l\'utilisateur pendant 2 tours.', 40, 8, 'drain_health(20, 2); heal_user(10, 2)'),
(6, 37, 'Death\'s Embrace', 'Invoque une étreinte spectrale qui immobilise la cible et l\'empêche d\'utiliser ses capacités pendant 2 tours.', 50, 10, 'immobilize(2); disable_abilities(2)'),
(7, 38, 'Bloodrend Sacrifice', 'L\'utilisateur sacrifice une partie de sa vie pour infliger de puissants dégâts physiques à un ennemi.', 30, 8, 'sacrifice_health(30); deal_physical_damage(50)'),
(8, 38, 'Sanguine Fury', 'Augmente temporairement la force physique de l\'utilisateur en échange de sa santé pendant 2 tours.', 40, 10, 'increase_attack(15, 2); sacrifice_health(20)'),
(9, 38, 'Crimson Chain', 'Utilise le sang de la cible pour créer une chaîne magique qui l\'empêche de se déplacer pendant 1 tour.', 35, 9, 'bind_target(1)'),
(10, 39, 'Crystal Prison', 'Piège un ennemi dans un cristal maudit, l\'empêchant de bouger pendant 2 tours.', 30, 6, 'immobilize(2)'),
(11, 39, 'Dark Obsidian', 'Invoque une attaque de cristaux sombres qui frappe tous les ennemis dans la zone d\'effet.', 35, 8, 'area_damage(40)'),
(12, 39, 'Soulstone Convergence', 'Rassemble l\'âme d\'un ennemi tué dans un cristal pour que l\'utilisateur puisse l\'utiliser plus tard pour renforcer ses pouvoirs.', 50, 12, 'soul_recovery()'),
(13, 40, 'Infernal Burst', 'Inflige de lourds dégâts de feu sur une zone ciblée, brûlant tous les ennemis à l\'intérieur pendant 1 tour.', 35, 7, 'area_damage(50, 1)'),
(14, 40, 'Flamecloak', 'Entoure l\'utilisateur d\'une flamme protectrice qui inflige des dégâts à quiconque l\'attaque au corps à corps pendant 3 tours.', 25, 5, 'flame_protection(3)'),
(15, 40, 'Fireball', 'Projette une boule de feu qui explose en infligeant des dégâts massifs à une cible.', 40, 9, 'deal_damage(80)'),
(16, 41, 'Wind Rush', 'Accélère l\'utilisateur, augmentant sa vitesse de déplacement pendant 3 tours.', 20, 4, 'increase_speed(15, 3)'),
(17, 41, 'Cyclone Strike', 'Crée un vent violent qui projette les ennemis dans la zone, les déséquilibrant pendant 1 tour.', 30, 6, 'knock_back(5, 1)'),
(18, 41, 'Tempest Fury', 'Invoque une tempête dévastatrice qui frappe tous les ennemis dans une large zone pendant 1 tour.', 45, 10, 'area_damage(70, 1)'),
(19, 42, 'Healing Light', 'Soigne un allié en concentrant la lumière divine sur lui pendant 1 tour.', 25, 5, 'heal_target(30, 1)'),
(20, 42, 'Blinding Radiance', 'Émet une explosion de lumière qui aveugle les ennemis dans la zone pendant 2 tours.', 30, 7, 'blind_target(2)'),
(21, 42, 'Luminous Shield', 'Crée un bouclier lumineux qui réduit les dégâts physiques reçus par un allié pendant 3 tours.', 35, 8, 'shield_target(20, 3)'),
(22, 43, 'Shadow Curse', 'Lance une malédiction qui affaiblit les ennemis, réduisant leur vitesse et leur attaque pendant 2 tours.', 30, 6, 'reduce_attack(5, 2); reduce_speed(5, 2)'),
(23, 43, 'Void Blast', 'Lance une décharge d\'énergie ténébreuse qui inflige de lourds dégâts magiques pendant 1 tour.', 40, 8, 'deal_damage(60)'),
(24, 43, 'Dark Binding', 'Enchaîne un ennemi dans des chaînes ténébreuses, le ralentissant et l\'immobilisant partiellement pendant 2 tours.', 35, 7, 'bind_target(1, 2); slow_target(3, 2)'),
(25, 44, 'Poison Touch', 'Envenime les ennemis au contact, infligeant des dégâts continus pendant 2 tours.', 20, 4, 'poison_effect(10, 2)'),
(26, 44, 'Toxic Cloud', 'Crée une nuée toxique qui inflige des dégâts sur la durée aux ennemis dans la zone pendant 2 tours.', 35, 7, 'area_damage(10, 2)'),
(27, 44, 'Venomous Strike', 'Inflige un coup empoisonné, paralysant l\'ennemi et réduisant ses capacités de mouvement pendant 2 tours.', 30, 6, 'paralyze(2); reduce_speed(4, 2)'),
(28, 45, 'Arcane Blast', 'Lance une vague d\'énergie magique qui frappe tous les ennemis dans la zone pendant 1 tour.', 30, 6, 'area_damage(30, 1)'),
(29, 45, 'Mana Shield', 'Crée un bouclier magique qui protège l\'utilisateur en absorbant une partie des dégâts pendant 3 tours.', 40, 8, 'mana_shield(20, 3)'),
(30, 45, 'Mana Surge', 'Augmente temporairement la quantité de mana disponible de l\'utilisateur pendant 2 tours.', 35, 7, 'increase_mana(30, 2)'),
(31, 46, 'Flame Burst', 'Crée une explosion de flammes qui inflige des dégâts dans une petite zone pendant 1 tour.', 25, 5, 'area_damage(20, 1)'),
(32, 46, 'Fire Wave', 'Projette une vague de feu, infligeant des dégâts à tous les ennemis dans sa trajectoire pendant 1 tour.', 35, 8, 'area_damage(40, 1)'),
(33, 46, 'Inferno', 'Provoque un gigantesque incendie dans une large zone, brûlant tous les ennemis dedans pendant 2 tours.', 50, 12, 'area_damage(60, 2)'),
(34, 47, 'Gust of Wind', 'Crée une bourrasque qui repousse les ennemis et déséquilibre ceux qui sont proches pendant 1 tour.', 25, 5, 'knock_back(5, 1)'),
(35, 47, 'Stormcall', 'Invoque une tempête violente qui frappe tous les ennemis avec des éclairs pendant 2 tours.', 40, 8, 'area_damage(50, 2)'),
(36, 47, 'Whirlwind', 'Crée un tourbillon qui attire et endommage tous les ennemis dans sa zone d\'effet pendant 2 tours.', 45, 10, 'area_damage(30, 2); pull_enemies(2)'),
(37, 48, 'Gravity Well', 'Crée une zone de gravité intense qui ralentit et attire tous les ennemis au centre pendant 2 tours.', 30, 7, 'slow_target(5, 2); pull_enemies(2)'),
(38, 48, 'Space Rift', 'Ouvre une distorsion spatiale qui fait apparaître des éclats d\'énergie, infligeant des dégâts à tous ceux qui se trouvent à proximité pendant 1 tour.', 40, 9, 'area_damage(40, 1)'),
(39, 48, 'Time Slow', 'Ralentit le temps dans une zone pour toutes les cibles à l\'intérieur, réduisant leur vitesse d\'attaque et de déplacement pendant 2 tours.', 35, 8, 'slow_target(5, 2); reduce_attack(5, 2)'),
(40, 49, 'Sacred Flame', 'Invoque une flamme sacrée qui soigne les alliés et inflige des dégâts aux ennemis pendant 2 tours.', 30, 6, 'heal_allies(30, 2); deal_damage(20, 2)'),
(41, 49, 'Divine Shield', 'Crée un bouclier divin qui protège l\'utilisateur ou un allié des dégâts magiques et physiques pendant 3 tours.', 40, 8, 'shield_target(50, 3)'),
(42, 49, 'Light of Aether', 'Invoque une lumière pure qui restaure la mana des alliés à proximité pendant 2 tours.', 35, 7, 'restore_mana(20, 2)');

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
  `porter` int(11) NOT NULL,
  `weight` int(11) NOT NULL,
  `damage_bonus` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'Bonus to damage (max 6)',
  `defense_bonus` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'Bonus to defense (max 6)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `Weapon`
--

INSERT INTO `Weapon` (`item_id`, `porter`, `weight`, `damage_bonus`, `defense_bonus`) VALUES
(1, 1, 15, 4, 1),
(2, 1, 20, 5, 0),
(3, 1, 5, 2, 0),
(17, 1, 12, 6, 2),
(22, 5, 6, 1, 4),
(27, 1, 3, 4, 1),
(34, 1, 5, 0, 5),
(35, 1, 1, 1, 0);

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
-- Index pour la table `Armor`
--
ALTER TABLE `Armor`
  ADD PRIMARY KEY (`item_id`);

--
-- Index pour la table `Categorie`
--
ALTER TABLE `Categorie`
  ADD PRIMARY KEY (`id_categorie`);

--
-- Index pour la table `Chapter`
--
ALTER TABLE `Chapter`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_chapter_treasure` (`treasure_id`);

--
-- Index pour la table `Chapter_Treasure`
--
ALTER TABLE `Chapter_Treasure`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_chapter_treasure_chapter` (`chapter_id`),
  ADD KEY `fk_chapter_treasure_item` (`item_id`);

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
  ADD KEY `related_treasure_id` (`related_treasure_id`);

--
-- Index pour la table `Hero`
--
ALTER TABLE `Hero`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_hero_class` (`class_id`);

--
-- Index pour la table `Hero_Armor`
--
ALTER TABLE `Hero_Armor`
  ADD PRIMARY KEY (`hero_id`),
  ADD KEY `helmet_id` (`helmet_id`),
  ADD KEY `armor_id` (`armor_id`),
  ADD KEY `greaves_id` (`greaves_id`);

--
-- Index pour la table `Hero_Updates`
--
ALTER TABLE `Hero_Updates`
  ADD PRIMARY KEY (`hero_id`);

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
  ADD KEY `fk_inventory_hero` (`hero_id`),
  ADD KEY `fk_inventory_item` (`item_id`);

--
-- Index pour la table `Items`
--
ALTER TABLE `Items`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `Level`
--
ALTER TABLE `Level`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_level_class` (`class_id`);

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
-- Index pour la table `Quest`
--
ALTER TABLE `Quest`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_quest_hero` (`hero_id`),
  ADD KEY `fk_quest_chapter` (`chapter_id`);

--
-- Index pour la table `Spell`
--
ALTER TABLE `Spell`
  ADD PRIMARY KEY (`id`),
  ADD KEY `codex_id` (`codex_id`);

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
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `Account`
--
ALTER TABLE `Account`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT pour la table `Categorie`
--
ALTER TABLE `Categorie`
  MODIFY `id_categorie` int(3) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `Chapter`
--
ALTER TABLE `Chapter`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT pour la table `Class`
--
ALTER TABLE `Class`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT pour la table `Hero`
--
ALTER TABLE `Hero`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT pour la table `Inventory`
--
ALTER TABLE `Inventory`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=120;

--
-- AUTO_INCREMENT pour la table `Level`
--
ALTER TABLE `Level`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `Links`
--
ALTER TABLE `Links`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT pour la table `Quest`
--
ALTER TABLE `Quest`
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
-- Contraintes pour la table `Armor`
--
ALTER TABLE `Armor`
  ADD CONSTRAINT `fk_armor` FOREIGN KEY (`item_id`) REFERENCES `Items` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `Chapter`
--
ALTER TABLE `Chapter`
  ADD CONSTRAINT `fk_chapter_treasure` FOREIGN KEY (`treasure_id`) REFERENCES `Treasure` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Contraintes pour la table `Chapter_Treasure`
--
ALTER TABLE `Chapter_Treasure`
  ADD CONSTRAINT `fk_chapter_treasure_chapter` FOREIGN KEY (`chapter_id`) REFERENCES `Chapter` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_chapter_treasure_item` FOREIGN KEY (`item_id`) REFERENCES `Items` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

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
  ADD CONSTRAINT `Event_ibfk_3` FOREIGN KEY (`related_treasure_id`) REFERENCES `Treasure` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Contraintes pour la table `Hero`
--
ALTER TABLE `Hero`
  ADD CONSTRAINT `Hero_ibfk_1` FOREIGN KEY (`id`) REFERENCES `Account` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `Hero_Armor`
--
ALTER TABLE `Hero_Armor`
  ADD CONSTRAINT `Hero_Armor_ibfk_1` FOREIGN KEY (`hero_id`) REFERENCES `Hero` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Hero_Armor_ibfk_2` FOREIGN KEY (`helmet_id`) REFERENCES `Items` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `Hero_Armor_ibfk_3` FOREIGN KEY (`armor_id`) REFERENCES `Items` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `Hero_Armor_ibfk_4` FOREIGN KEY (`greaves_id`) REFERENCES `Items` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Contraintes pour la table `Hero_Weapons`
--
ALTER TABLE `Hero_Weapons`
  ADD CONSTRAINT `Hero_Weapons_ibfk_1` FOREIGN KEY (`hero_id`) REFERENCES `Hero` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `Inventory`
--
ALTER TABLE `Inventory`
  ADD CONSTRAINT `fk_inventory_hero` FOREIGN KEY (`hero_id`) REFERENCES `Hero` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_inventory_item` FOREIGN KEY (`item_id`) REFERENCES `Items` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `Level`
--
ALTER TABLE `Level`
  ADD CONSTRAINT `fk_level_class` FOREIGN KEY (`class_id`) REFERENCES `Class` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

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
-- Contraintes pour la table `Miscellaneous`
--
ALTER TABLE `Miscellaneous`
  ADD CONSTRAINT `Miscellaneous_ibfk_1` FOREIGN KEY (`item_id`) REFERENCES `Items` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `Quest`
--
ALTER TABLE `Quest`
  ADD CONSTRAINT `fk_quest_chapter` FOREIGN KEY (`chapter_id`) REFERENCES `Chapter` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_quest_hero` FOREIGN KEY (`hero_id`) REFERENCES `Hero` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `Spell`
--
ALTER TABLE `Spell`
  ADD CONSTRAINT `Spell_ibfk_1` FOREIGN KEY (`codex_id`) REFERENCES `Codex` (`item_id`) ON DELETE CASCADE ON UPDATE CASCADE;

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
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
