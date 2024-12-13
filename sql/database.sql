-- phpMyAdmin SQL Dump
-- version 5.2.1deb1
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost:3306
-- Généré le : ven. 13 déc. 2024 à 06:30
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
  `email` varchar(100) NOT NULL,
  `is_admin` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `Account`
--

INSERT INTO `Account` (`id`, `username`, `password`, `email`, `is_admin`) VALUES
(15, 'Admin', '$2y$10$fsdb1N03Tyk7FeMlXZ1s0e5t24wvE23LsiGNHaWdJM7olJpBUtQSe', 'admin@admin.admin', 1),
(21, 'testGuerrier', '$2y$10$3VfJgXzTu.DPr98Yj4YvieUy52fSnj57vCjjJNbyG4h2VkgXYyq0G', 'testguerrier@gmail.com', 0),
(23, 'testVoleur', '$2y$10$0T6HhqthfqBCFe1dtdpPOeunj/cqo/K9qPh.PvWtvEC9DC6g5UvKe', 'testVoleur@gmail.com', 0),
(24, 'testMage', '$2y$10$hAaLcojhrwJ5gNLKRFbQF.zadrdIvUznGPP5yG.YMsm4d7D8PACpO', 'testMage@gmail.com', 0),
(26, 'testInquisiteur', '$2y$10$0T/MjmCnYrJMGPiYMYjYDupt8ZSPswT8XtgELFm9EbLjhJGYwnBIm', 'testInq@gmail.com', 0),
(27, 'testNecromencien', '$2y$10$8pHcOAuOlKKgRbJ2shvyT.bQ6XSjYH2bnb6V5bcIgxN1Kj9q1F.ci', 'testNecro@gmail.com', 0),
(28, 'testShadowHunter', '$2y$10$16fkefnLCHV/Y7kOgULJk.kjBE3SVchFHEgSniBz10WJUdTzhGt/a', 'test@gmail.com', 0),
(29, 'testAcolyte', '$2y$10$au2TGskxD3UT8ZLKJPqi0ufskh.IU.iZKs3eEV6VWX0L2X3UFChtS', 'testA@gmail.com', 0),
(30, 'testDruide', '$2y$10$gs8OMeot2YKVE7Xoj8rs3.c80vkGUPNulqMGSNxRFPJS9v/xNeMNK', 'testD@gmail.com', 0),
(31, 'testAbysseTief', '$2y$10$WKtDjpR6VC64HsubP19NfeP1qrfsRo8PF57Xdc1avUygRUMWtKs6q', 'testAbysse@gmail.com', 0),
(32, 'tber', '$2y$10$UoC0qe7m8f6t0.q9kNDLDO7OJIK7o6HRDjD4c1iyE/svswPHQrFZ.', 'tber.nouza@raspberry.py', 0),
(33, 'test', '$2y$10$kdc5xiLmRlmqImC9SpdBKeSbpnOzhgGEAttNAEk7A.nv4ialnvkW6', 'test@unicaen.fr', 0),
(37, 'testLevel', '$2y$10$Mkw36vL0DHCN2W/v2SO2wexpmR3QDdJhrCiCuQ27.0i57miRLDj3u', 'testL@gmail.com', 0),
(38, 'testDeath', '$2y$10$/8rot7tCA6n/xxiJFplXsu/QM/hLXxWIX8n7Rn3R/4ZepsHaZZB6G', 'testDeath@gmail.com', 0),
(39, 'testBiographie', '$2y$10$vD7u5.rfcdn1DmL6OvUj..THT5s4lFDK9FsGnMPEiooq2F9q5jxHW', 'testB@gmail.com', 0);

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
(4, 3, 8, 'body'),
(5, 3, 6, 'body'),
(6, 2, 4, 'head'),
(13, 3, 5, 'head'),
(14, 3, 6, 'body'),
(15, 2, 8, 'legs'),
(16, 2, 2, 'hands'),
(19, 0, 3, 'head'),
(20, 1, 4, 'body'),
(21, 0, 2, 'hands'),
(24, 1, 1, 'head'),
(25, 1, 3, 'body'),
(26, 1, 2, 'legs'),
(51, 0, 2, 'head'),
(52, 2, 4, 'body'),
(53, 0, 1, 'hands'),
(56, 15, 5, 'head'),
(57, 25, 15, 'body'),
(58, 20, 10, 'legs'),
(59, 10, 3, 'hands'),
(62, 2, 4, 'heads'),
(63, 6, 12, 'body'),
(64, 4, 7, 'legs'),
(65, 1, 2, 'hands'),
(68, 3, 6, 'heads'),
(69, 8, 18, 'body'),
(70, 6, 12, 'legs'),
(71, 2, 5, 'hands'),
(74, 4, 6, 'heads'),
(75, 9, 20, 'body'),
(76, 5, 10, 'legs'),
(77, 3, 4, 'hands'),
(80, 5, 8, 'heads'),
(81, 10, 25, 'body'),
(82, 7, 15, 'legs'),
(83, 4, 6, 'hands');

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
-- Structure de la table `Chapter`
--

CREATE TABLE `Chapter` (
  `id` int(11) NOT NULL,
  `content` text NOT NULL,
  `titre` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `Chapter`
--

INSERT INTO `Chapter` (`id`, `content`, `titre`) VALUES
(1, 'Le ciel est lourd ce soir sur le village du Val Perdu, dissimulé entre les montagnes. La petite taverne, dernier refuge avant l\'immense forêt, est étrangement calme quand le bourgmestre s\'approche de vous. Homme d\'apparence usée par les années et les soucis, il vous adresse un regard désespéré. \"Ma fille… elle a disparu dans la forêt. Personne n\'a osé la chercher… sauf vous, peut-être ? On raconte qu\'un sorcier vit dans un château en ruines, caché au cœur des bois. Depuis des mois, des jeunes filles disparaissent… J\'ai besoin de vous pour la retrouver.\" Vous sentez le poids de la mission qui s\'annonce, et un frisson parcourt votre échine. Bientôt, la forêt s\'ouvre devant vous, sombre et menaçante. La quête commence.', 'Introduction'),
(2, 'Vous franchissez la lisière des arbres, la pénombre de la forêt avalant le sentier devant vous. Un vent froid glisse entre les troncs, et le bruissement des feuilles ressemble à un murmure menaçant. Deux chemins s’offrent à vous : l’un sinueux, bordé de vieux arbres noueux ; l’autre droit mais envahi par des ronces épaisses. Soudain, vous entendez un cris d\'animal.', 'L\'orée de la forêt'),
(3, 'Votre choix vous mène devant un vieux chêne aux branches tordues, grouillant de corbeaux noirs qui vous observent en silence. À vos pieds, des traces de pas légers, probablement récents, mènent plus loin dans les bois. Soudain, un bruit de pas feutrés se fait entendre. Vous ressentez la présence d’un prédateur.', 'L\'arbre aux corbeaux'),
(4, 'Le calme de la forêt est soudain brisé par un grognement. Surgissant des buissons, un énorme sanglier, au pelage épais et aux yeux injectés de sang, se dirige vers vous. Sa rage est palpable, et il semble prêt à en découdre.', 'Le sanglier enragé'),
(5, 'Tandis que vous progressez, une voix humaine s’élève, interrompant le silence de la forêt. Vous tombez sur un vieux paysan, accroupi près de champignons aux couleurs vives. Il sursaute en vous voyant, puis se détend, vous souriant tristement.', 'Rencontre avec le paysan'),
(6, 'À mesure que vous avancez, un bruissement attire votre attention. Une silhouette sombre s’élance soudainement devant vous : un loup noir aux yeux perçants. Son poil est hérissé et sa gueule laisse entrevoir des crocs acérés. Vous sentez son regard fixé sur vous, prêt à bondir.', 'Le loup noir'),
(7, 'Après votre rencontre, vous atteignez une clairière étrange, entourée de pierres dressées, comme un ancien autel oublié par le temps. Une légère brume rampe au sol, et les ombres des pierres semblent danser sous la lueur de la lune.', 'La clairière aux pierres anciennes'),
(8, 'Essoufflé mais déterminé, vous arrivez près d’un petit ruisseau qui serpente au milieu des arbres. Le chant de l’eau vous apaise quelque peu, mais des murmures étranges semblent émaner de la rive. Vous apercevez des inscriptions anciennes gravées dans une pierre moussue.', 'Les murmures du ruisseau'),
(9, 'La forêt se disperse enfin, et devant vous se dresse une colline escarpée. Au sommet, le château en ruines projette une ombre menaçante sous le clair de lune. Les murs effrités et les tours en partie effondrées ajoutent à la sinistre réputation du lieu. Vous sentez que la véritable aventure commence ici.', 'Au pied du château'),
(10, 'Le monde se dérobe sous vos pieds, et une obscurité profonde vous enveloppe, glaciale et insondable. Vous ne sentez plus le poids de votre équipement, ni la morsure de la douleur. Juste un vide infini, vous aspirant lentement dans les ténèbres. Une lueur douce apparaît au loin, vacillante comme une flamme fragile dans l’obscurité.', 'La lumière au bout du néant'),
(11, 'Vous fuyez à toutes jambes alors que le sanglier grogne derrière vous. Essoufflé, vous trébuchez et vous retrouvez dans une clairière sombre, dominée par un grand arbre mort. Le danger semble s’être éloigné, mais une tension demeure dans l’air.', 'Fuite du sanglier'),
(12, 'Prenant la décision de fuir, vous laissez le loup derrière vous. Vous vous réfugiez près d’un vieux puits abandonné. L’endroit semble calme, le loup semblent avoir perdu votre trace, vous décidez de sortir du puit et de marcher', 'Fuite du loup'),
(13, 'Vous atteignez un étang mystérieux, dont les eaux scintillent sous la lune. Les murmures qui en émanent semblent anciens, porteurs d’une sagesse ou d’un danger oublié.', 'L\'étang des murmures'),
(14, 'Votre fuite vous mène à un sentier ancien, envahi par la végétation. Le chemin semble oublié de tous, mais son tracé vous intrigue et vous pousse à continuer.', 'Le sentier oublié'),
(15, 'Les ombres s\'étendent alors que vous pénétrez dans l\'antre sinistre, une caverne au cœur de la montagne, seul chemin pour le château. La chaleur est accablante et une lumière rougeâtre émane des fissures béantes du sol. Soudain, un rugissement infernal déchire le silence, et un monstre colossale émerge de la lave en fusion. Gor\'huga, la créature de feu et de roche, vous fixe de ses yeux ardents. Son corps est une masse mouvante de lave en fusion, ses membres corrompus par une énergie démoniaque.', 'Dans l\'ombre du diable'),
(16, 'A l\'aube du temps, une entité se tient devant toi ? Qui est-elle ? Que te veux elle ?', '???'),
(17, 'Le Val Perdu, 1500 ans en arrière, est frappé par une calamité. Des Miasmes Corrompus, des créatures spectrales nées de la haine et du désespoir, attaquent sans relâche. Vous vous retrouvez face à l\'une de ces abominations, son corps éthéré et ses griffes tranchantes prêtes à vous déchiqueter. Le combat est inévitable.', 'Le Miasme Corrompu'),
(18, 'Après avoir vaincu le Miasme Corrompu, vous êtes conduit au bourgmestre du village. Un homme imposant, vêtu d\'une cape en laine grossière, vous accueille dans une salle rustique mais chaleureuse. Son visage grave traduit l\'urgence de la situation.', 'Audience avec le bourgmestre'),
(19, 'Vous avez fui face au Miasme Corrompu, mais la menace demeure. Le village est en proie à la panique, et les habitants murmurent à votre passage. \"Ils sont censés être nos sauveurs, et ils ont fui ?\", chuchote un vieillard. Vous réalisez que vous devrez reprendre des forces avant de tenter à nouveau votre chance.', 'Une retraite nécessaire'),
(20, 'Que voulez-vous faire ?', 'Le Val Putride'),
(21, 'Vous entrez dans une forge bruyante et encombrée. Le forgeron vous salue d\'un hochement de tête.', 'La Forge'),
(22, 'Un petit commerce bien achalandé, où divers objets utiles pour votre quête sont en vente.', 'Le Commerce'),
(23, 'Vous trouvez un coin calme où plusieurs villageois sont rassemblés. Ils semblent disposés à discuter avec vous.', 'Rencontre avec les PNJ');

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
  `initiative` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `Class`
--

INSERT INTO `Class` (`id`, `name`, `description`, `base_pv`, `base_mana`, `strength`, `initiative`) VALUES
(1, 'Gladiateur', 'Les Gladiateurs sont des combattants forgés dans les arènes de sang. Ces guerriers ont été réduits à des machines de destruction, leur chair mutilée par les combats incessants, leurs corps porteurs de cicatrices béantes. Leurs sens sont exacerbés par la souffrance et la douleur qu’ils endurent, et leur rage leur confère une puissance presque surnaturelle. Ils se battent avec une brutalité implacable, sacrifiant leur propre corps pour faire tomber l\'ennemi dans un torrent de sang.', 30, 0, 10, 5),
(2, 'Pacteur', 'Les Pacteurs sont des mages qui ont scellé un pacte avec des entités inhumaines pour obtenir des pouvoirs interdits. Leur magie est terriblement corrompue, puisant dans la souffrance et la mort. Leur propre corps porte les marques des rituels maudits qu’ils pratiquent : peau brûlée, yeux écorchés, et organes altérés. Leurs sorts font appel aux forces les plus sombres, manipulant la chair et l’esprit de leurs ennemis, les laissant dans un état de décomposition avant même leur mort.', 15, 30, 3, 4),
(3, 'Faucheur', 'Les Faucheurs sont des voleurs mortels, des assassins d’une rare habileté qui se nourrissent de la douleur et de la terreur qu’ils répandent. Leur approche est rapide et propre, mais leurs victimes se retrouvent souvent dans une agonie prolongée, les corps laissés pourrir lentement. Ces créatures de l\'ombre sont capables de s\'infiltrer dans n\'importe quel endroit, se fondant dans la peur de leurs victimes, et frappant dans les pires moments, en utilisant des instruments qui infligent une douleur insoutenable avant la mort. Leur maîtrise du poison et de la souffrance corporelle les rend redoutables. ', 15, 15, 5, 10),
(5, 'Inquisiteur', 'Les Inquisiteurs sont des chasseurs de sorcières et des exécuteurs impitoyables. Ils sont formés pour traquer et éliminer les hérétiques et les pratiquants de la magie noire. Leur corps est marqué par des tortures physiques et spirituelles, leur permettant d\'endurer des souffrances inouïes. Avec des armes bénites et des sorts d\'exorcisme, ils font face à des ennemis invisibles et des forces surnaturelles, souvent au prix de leur propre âme.', 25, 5, 8, 8),
(6, 'Nécromancien', 'Les Nécromanciens ont pactisé avec la mort pour acquérir le pouvoir de soumettre les morts à leur volonté. Ils invoquent des hordes de squelettes, de zombies et autres créatures macabres pour se battre à leurs côtés. Leurs pouvoirs sont puissants, mais leur utilisation rapide peut les affaiblir ou les corrompre davantage. Ils sont souvent vus comme des parias ou des malédictions vivantes.', 15, 25, 5, 4),
(7, 'Chasseur des Ombres', 'Les Chasseurs des Ombres sont des traqueurs d\'élite, des experts en discrétion et en embuscades. Ils s\'allient avec les créatures des ténèbres, maîtrisant l\'art de se fondre dans les ombres pour frapper sans avertir. Leur agilité et leurs réflexes sont aiguisés à l\'extrême, leur permettant d\'anticiper les mouvements de l\'ennemi et de frapper avec une précision mortelle.', 20, 10, 6, 12),
(8, 'Acolyte des Cendres', 'Les Acolytes des Cendres sont des prêtres fanatiques dévoués à une divinité obscure, celle de la destruction et de la fin des âges. Ils utilisent la douleur et la souffrance comme rituels pour renforcer leur magie. Les Acolytes sont souvent plongés dans une trance mystique où ils sacrifient leur propre chair pour infliger des malédictions ou bénir leurs alliés avec des pouvoirs de résurrection, mais à un coût élevé.', 18, 18, 4, 6),
(9, 'Druide des Profondeurs', 'Les Druidesses des Profondeurs sont des êtres mystérieux, issus des coins les plus obscurs et inexplorés de la nature. Connus pour leur capacité à se transformer en créatures de la forêt, ils manipulent la flore et la faune à des fins sombres, offrant des bénédictions corrompues ou appelant des animaux tordus pour les servir. Ils peuvent aussi appeler les esprits de la forêt, mais à un prix.', 20, 15, 5, 8),
(10, 'Voleur des Abysses', 'Les Voleurs des Abysses sont des mercenaires et voleurs interlopes qui font des affaires avec des entités inhumaines, allant même jusqu\'à voler les âmes des autres. Ils utilisent des armes et des artefacts étranges pour manipuler les forces du mal, se faisant invisibles ou créant des illusions pour tromper leurs ennemis. Leur pouvoir est un mélange d\'habilité et de tromperie, mais il les consomme lentement.', 15, 20, 4, 9);

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
(9, 'buff', NULL, NULL, 2, NULL, 10),
(18, 'buff', NULL, NULL, 5, NULL, 10),
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
  `event_type` enum('exploration','combat','dungeon','npc_interaction','treasure','puzzle','death','healing','merchent') NOT NULL,
  `description` text DEFAULT NULL,
  `related_monster_id` int(11) DEFAULT NULL,
  `related_treasure_id` int(11) DEFAULT NULL,
  `related_puzzle` text DEFAULT NULL,
  `related_npc_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `Event`
--

INSERT INTO `Event` (`id`, `chapter_id`, `event_type`, `description`, `related_monster_id`, `related_treasure_id`, `related_puzzle`, `related_npc_id`) VALUES
(101, 6, 'combat', 'Un Loup Noir vous attaque dans une clairière sombre.', 1, NULL, NULL, NULL),
(102, 4, 'combat', 'Un Sanglier Enragé surgit des buissons et charge !', 2, NULL, NULL, NULL),
(103, 15, 'combat', NULL, 3, NULL, NULL, NULL),
(104, 5, 'npc_interaction', NULL, NULL, NULL, NULL, 1),
(105, 10, 'death', NULL, NULL, NULL, NULL, NULL),
(106, 16, 'npc_interaction', NULL, NULL, NULL, NULL, 2),
(108, 17, 'combat', NULL, 4, NULL, NULL, NULL),
(109, 18, 'npc_interaction', NULL, NULL, NULL, NULL, 3),
(110, 20, 'exploration', 'Le val putride... même dans le passé, c est un village qui ne connait pas la richesse.', NULL, NULL, NULL, NULL),
(111, 22, 'merchent', '\r\n', NULL, NULL, NULL, 4),
(112, 21, 'merchent', NULL, NULL, NULL, NULL, 5);

-- --------------------------------------------------------

--
-- Structure de la table `Hero`
--

CREATE TABLE `Hero` (
  `id` int(11) NOT NULL,
  `lastname` varchar(50) NOT NULL,
  `class_id` int(11) DEFAULT NULL,
  `race_id` int(11) NOT NULL,
  `biography` text DEFAULT NULL,
  `pv_max` int(11) NOT NULL,
  `mana_max` int(11) NOT NULL,
  `strength` int(11) NOT NULL,
  `initiative` int(11) NOT NULL,
  `xp` int(11) NOT NULL DEFAULT 0,
  `current_level` int(11) DEFAULT 1,
  `poids_max` double NOT NULL DEFAULT 100,
  `nb_items_max` int(11) NOT NULL DEFAULT 20,
  `firstname` varchar(50) DEFAULT NULL,
  `gold` float NOT NULL DEFAULT 1000
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `Hero`
--

INSERT INTO `Hero` (`id`, `lastname`, `class_id`, `race_id`, `biography`, `pv_max`, `mana_max`, `strength`, `initiative`, `xp`, `current_level`, `poids_max`, `nb_items_max`, `firstname`, `gold`) VALUES
(21, 'Varek', 1, 1, NULL, 70, 0, 18, 5, 870, 2, 100, 20, 'Sanguine', 820),
(23, 'Elira', 3, 1, NULL, 25, 21, 54, 12, 140, 2, 100, 20, 'Nocturne', 1000),
(24, 'Decroix', 2, 1, NULL, 99999, 99999, 3, 4, 560, 100, 100, 20, 'Reilique', 1000),
(26, 'Inquisiteur', 5, 1, NULL, 43, 7, 10, 9, 0, 2, 100, 20, 'test', 1000),
(27, 'Necromen', 6, 4, NULL, 20, 35, 5, 5, 0, 2, 100, 20, 'Test', 1000),
(28, 'ShadowHunter', 7, 2, NULL, 20, 10, 6, 12, 400, 1, 100, 20, 'test', 1000),
(29, 'Acolyte', 8, 10, NULL, 18, 18, 4, 6, 70, 1, 100, 20, 'test', 1000),
(30, 'druide', 9, 11, NULL, 20, 15, 5, 8, 0, 1, 100, 20, 'test', 1000),
(31, 'Voleur des Abysses', 10, 12, NULL, 15, 20, 4, 9, 70, 1, 100, 20, 'test', 1000),
(38, 'death', 2, 1, NULL, 15, 30, 3, 4, 0, 1, 100, 20, 'test', 1000),
(39, 'Sen', 1, 4, 'Varek est née d\'un rituel du sang des plus sombre, née de la fusion de ces deux frère pour crée l\'être vivant le plus fort', 50, 0, 14, 5, 0, 2, 100, 20, 'Varek', 458);

--
-- Déclencheurs `Hero`
--
DELIMITER $$
CREATE TRIGGER `after_hero_creation` AFTER INSERT ON `Hero` FOR EACH ROW BEGIN
    IF NEW.class_id = 1 THEN
        -- Guerrier
        INSERT INTO Hero_Weapons (hero_id, primary_weapon_id, secondary_weapon_id)
        VALUES (NEW.id, 2, 34);

        -- Ajout des objets dans l'inventaire avec isDeleted = TRUE
        INSERT INTO Inventory (hero_id, item_id, isDeleted, quantity) VALUES
            (NEW.id, 13, TRUE, 1),
            (NEW.id, 14, TRUE, 1),
            (NEW.id, 15, TRUE, 1),
            (NEW.id, 16, TRUE, 1),
            (NEW.id, 17, TRUE, 1),
            (NEW.id, 34, TRUE, 1);

        -- Ajout des armures associées
        INSERT INTO Hero_Armor (hero_id, helmet_id, armor_id, greaves_id, gloves_id) VALUES 
            (NEW.id, 13, 14, 15, 16);
        
    ELSEIF NEW.class_id = 2 THEN
        -- Magicien
        INSERT INTO Hero_Weapons (hero_id, primary_weapon_id, secondary_weapon_id)
        VALUES (NEW.id, 22, 35);

        -- Ajout des objets dans l'inventaire avec isDeleted = TRUE
        INSERT INTO Inventory (hero_id, item_id, isDeleted, quantity) VALUES
            (NEW.id, 19, TRUE, 1),
            (NEW.id, 20, TRUE, 1),
            (NEW.id, 21, TRUE, 1),
            (NEW.id, 22, TRUE, 1),
            (NEW.id, 23, TRUE, 1),
            (NEW.id, 35, TRUE, 1),
            (NEW.id, 40, TRUE, 1),
            (NEW.id, 45, TRUE, 1);

        -- Ajout des armures associées
        INSERT INTO Hero_Armor (hero_id, helmet_id, armor_id, gloves_id) VALUES 
            (NEW.id, 19, 20, 21);
        
    ELSEIF NEW.class_id = 3 THEN
        -- Voleur
        INSERT INTO Hero_Weapons (hero_id, primary_weapon_id, secondary_weapon_id)
        VALUES (NEW.id, 3, 35);

        -- Ajout des objets dans l'inventaire avec isDeleted = TRUE
        INSERT INTO Inventory (hero_id, item_id, isDeleted, quantity) VALUES
            (NEW.id, 24, TRUE, 1),
            (NEW.id, 25, TRUE, 1),
            (NEW.id, 26, TRUE, 1),
            (NEW.id, 27, TRUE, 1),
            (NEW.id, 28, TRUE, 1),
            (NEW.id, 35, TRUE, 1),
            (NEW.id, 42, TRUE, 1);
	
        -- Ajout des armures associées
        INSERT INTO Hero_Armor (hero_id, helmet_id, armor_id, gloves_id) VALUES 
            (NEW.id, 24, 25, 26);
    ELSEIF NEW.class_id = 5 THEN
    -- Inquisiteur
    INSERT INTO Hero_Weapons (hero_id, primary_weapon_id, secondary_weapon_id)
    VALUES (NEW.id, 56, 57);

    -- Ajout des objets dans l'inventaire avec isDeleted = TRUE
    INSERT INTO Inventory (hero_id, item_id, isDeleted, quantity) VALUES
        (NEW.id, 56, TRUE, 1),
        (NEW.id, 57, TRUE, 1),
        (NEW.id, 58, TRUE, 1),
        (NEW.id, 59, TRUE, 1),
        (NEW.id, 60, TRUE, 1),
        (NEW.id, 61, TRUE, 1),
        (NEW.id, 49, TRUE, 1);

    -- Ajout des armures associées
    INSERT INTO Hero_Armor (hero_id, helmet_id, armor_id, greaves_id, gloves_id) VALUES 
        (NEW.id, 58, 59, 60, 61);
        

	ELSEIF NEW.class_id = 6 THEN
    	-- Necromencien        
        INSERT INTO Hero_Weapons (hero_id, primary_weapon_id, secondary_weapon_id)
        VALUES (NEW.id, 54, 55);
        INSERT INTO Inventory(hero_id, item_id, isDeleted, quantity) VALUES
            (NEW.id, 37, TRUE, 1),
            (NEW.id, 51, TRUE, 1),
            (NEW.id, 52, TRUE, 1),
            (NEW.id, 54, TRUE, 1),
            (NEW.id, 55, TRUE, 1),
            (NEW.id, 53, TRUE, 1);
            
        INSERT INTO Hero_Armor(hero_id, helmet_id, armor_id, gloves_id) VALUES 
            (NEW.id, 51, 52, 53);
    ELSEIF NEW.class_id = 7 THEN
        -- Chasseur des Ombres
        INSERT INTO Hero_Weapons (hero_id, primary_weapon_id, secondary_weapon_id)
        VALUES (NEW.id, 66, 67);
        -- Ajout des objets dans l'inventaire avec isDeleted = TRUE
        INSERT INTO Inventory (hero_id, item_id, isDeleted, quantity) VALUES
            (NEW.id, 62, TRUE, 1),
            (NEW.id, 63, TRUE, 1),
            (NEW.id, 64, TRUE, 1),
            (NEW.id, 65, TRUE, 1),
            (NEW.id, 66, TRUE, 1),
            (NEW.id, 67, TRUE, 1);
            
        -- Ajout des armures associées
        INSERT INTO Hero_Armor (hero_id, helmet_id, armor_id, greaves_id, gloves_id) VALUES
            (NEW.id, 62, 63, 64, 65);
    ELSEIF NEW.class_id = 8 THEN
        -- Acolytes des Cendres
        INSERT INTO Hero_Weapons (hero_id, primary_weapon_id, secondary_weapon_id)
        VALUES (NEW.id, 72, 73);
        -- Ajout des objets dans l'inventaire avec isDeleted = TRUE
        INSERT INTO Inventory (hero_id, item_id, isDeleted, quantity) VALUES
            (NEW.id, 68, TRUE, 1),
            (NEW.id, 69, TRUE, 1),
            (NEW.id, 70, TRUE, 1),
            (NEW.id, 71, TRUE, 1),
            (NEW.id, 72, TRUE, 1),
            (NEW.id, 73, TRUE, 1),
            (NEW.id, 40, TRUE, 1);
        -- Ajout des armures associées
        INSERT INTO Hero_Armor (hero_id, helmet_id, armor_id, greaves_id, gloves_id) VALUES
            (NEW.id, 68, 69, 70, 71);
    ELSEIF NEW.class_id = 9 THEN
        -- Druide des Profondeurs
        INSERT INTO Hero_Weapons (hero_id, primary_weapon_id, secondary_weapon_id)
        VALUES (NEW.id, 78, 79);
        -- Ajout des objets dans l'inventaire avec isDeleted = TRUE
        INSERT INTO Inventory (hero_id, item_id, isDeleted, quantity) VALUES
            (NEW.id, 74, TRUE, 1),
            (NEW.id, 75, TRUE, 1),
            (NEW.id, 76, TRUE, 1),
            (NEW.id, 77, TRUE, 1),
            (NEW.id, 78, TRUE, 1),
            (NEW.id, 79, TRUE, 1),
            (NEW.id, 50, TRUE, 1);
        -- Ajout des armures associées
        INSERT INTO Hero_Armor (hero_id, helmet_id, armor_id, greaves_id, gloves_id) VALUES
            (NEW.id, 74, 75, 76, 77);
    ELSEIF NEW.class_id = 10 THEN
        -- Sanglier des Ténèbres
        INSERT INTO Hero_Weapons (hero_id, primary_weapon_id, secondary_weapon_id)
        VALUES (NEW.id, 84, 85);
        -- Ajout des objets dans l'inventaire avec isDeleted = TRUE
        INSERT INTO Inventory (hero_id, item_id, isDeleted, quantity) VALUES
            (NEW.id, 80, TRUE, 1),
            (NEW.id, 81, TRUE, 1),
            (NEW.id, 82, TRUE, 1),
            (NEW.id, 83, TRUE, 1),
            (NEW.id, 84, TRUE, 1),
            (NEW.id, 85, TRUE, 1);
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

--
-- Déchargement des données de la table `Hero_Armor`
--

INSERT INTO `Hero_Armor` (`hero_id`, `helmet_id`, `armor_id`, `greaves_id`, `gloves_id`) VALUES
(21, 13, 14, 15, 16),
(23, 24, 25, NULL, 26),
(24, 19, 20, NULL, 21),
(26, 58, 59, 60, 61),
(27, 51, 52, NULL, 53),
(28, 62, 63, 64, 65),
(29, 68, 69, 70, 71),
(30, 74, 75, 76, 77),
(31, 80, 81, 82, 83),
(38, 19, 20, NULL, 21),
(39, 13, 14, 15, 16);

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

--
-- Déchargement des données de la table `Hero_Story`
--

INSERT INTO `Hero_Story` (`id`, `hero_id`, `pv`, `mana`, `chapter`) VALUES
(72, 27, 20, 35, '17'),
(73, 39, 50, 0, '17'),
(74, 24, 99930, 99604, '15'),
(75, 21, 70, 0, '5');

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
(21, 2, 34),
(23, 3, 35),
(24, 22, 35),
(26, 56, 57),
(27, 54, 55),
(28, 66, 67),
(29, 72, 73),
(30, 78, 79),
(31, 84, 85),
(38, 22, 35),
(39, 2, 34);

-- --------------------------------------------------------

--
-- Structure de la table `Inventory`
--

CREATE TABLE `Inventory` (
  `id` int(11) NOT NULL,
  `hero_id` int(11) DEFAULT NULL,
  `item_id` int(11) DEFAULT NULL,
  `isDeleted` tinyint(1) NOT NULL DEFAULT 0,
  `quantity` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `Inventory`
--

INSERT INTO `Inventory` (`id`, `hero_id`, `item_id`, `isDeleted`, `quantity`) VALUES
(208, 21, 13, 1, 1),
(209, 21, 14, 1, 1),
(210, 21, 15, 1, 1),
(211, 21, 16, 1, 1),
(212, 21, 17, 1, 1),
(213, 21, 34, 1, 1),
(222, 23, 24, 1, 1),
(223, 23, 25, 1, 1),
(224, 23, 26, 1, 1),
(225, 23, 27, 1, 1),
(226, 23, 28, 1, 1),
(227, 23, 35, 1, 1),
(228, 23, 42, 1, 1),
(231, 21, 33, 0, 7),
(232, 24, 19, 1, 1),
(233, 24, 20, 1, 1),
(234, 24, 21, 1, 1),
(235, 24, 22, 1, 1),
(236, 24, 23, 1, 1),
(237, 24, 35, 1, 1),
(238, 24, 40, 1, 1),
(239, 24, 45, 1, 1),
(240, 24, 33, 0, 17),
(241, 24, 32, 0, 7),
(256, 24, 41, 0, 1),
(257, 24, 42, 0, 1),
(258, 24, 43, 0, 1),
(259, 24, 44, 0, 1),
(260, 24, 46, 0, 1),
(261, 24, 47, 0, 1),
(262, 24, 48, 0, 1),
(263, 24, 49, 0, 1),
(264, 24, 50, 0, 1),
(265, 24, 39, 0, 1),
(266, 24, 38, 0, 1),
(267, 24, 37, 0, 1),
(268, 24, 36, 0, 1),
(269, 23, 33, 0, 1),
(304, 26, 56, 1, 1),
(305, 26, 57, 1, 1),
(306, 26, 58, 1, 1),
(307, 26, 59, 1, 1),
(308, 26, 60, 1, 1),
(309, 26, 61, 1, 1),
(310, 26, 49, 1, 1),
(311, 28, 62, 1, 1),
(312, 28, 63, 1, 1),
(313, 28, 64, 1, 1),
(314, 28, 65, 1, 1),
(315, 28, 66, 1, 1),
(316, 28, 67, 1, 1),
(317, 29, 68, 1, 1),
(318, 29, 69, 1, 1),
(319, 29, 70, 1, 1),
(320, 29, 71, 1, 1),
(321, 29, 72, 1, 1),
(322, 29, 73, 1, 1),
(323, 29, 40, 1, 1),
(324, 30, 74, 1, 1),
(325, 30, 75, 1, 1),
(326, 30, 76, 1, 1),
(327, 30, 77, 1, 1),
(328, 30, 78, 1, 1),
(329, 30, 79, 1, 1),
(330, 30, 50, 1, 1),
(331, 31, 80, 1, 1),
(332, 31, 81, 1, 1),
(333, 31, 82, 1, 1),
(334, 31, 83, 1, 1),
(335, 31, 84, 1, 1),
(336, 31, 85, 1, 1),
(339, 21, 86, 0, 2),
(340, 21, 88, 0, 7),
(342, 31, 33, 0, 1),
(353, 21, 32, 0, 2),
(361, 21, 7, 0, 5),
(362, 21, 8, 0, 1),
(364, 26, 87, 0, 1),
(365, 28, 88, 0, 1),
(366, 23, 87, 0, 1),
(367, 23, 86, 0, 1),
(442, 38, 19, 1, 1),
(443, 38, 20, 1, 1),
(444, 38, 21, 1, 1),
(445, 38, 22, 1, 1),
(446, 38, 23, 1, 1),
(447, 38, 35, 1, 1),
(448, 38, 40, 1, 1),
(449, 38, 45, 1, 1),
(456, 27, 37, 1, 1),
(457, 27, 51, 1, 1),
(458, 27, 52, 1, 1),
(459, 27, 54, 1, 1),
(460, 27, 55, 1, 1),
(461, 27, 53, 1, 1),
(462, 27, 88, 0, 3),
(463, 39, 13, 1, 1),
(464, 39, 14, 1, 1),
(465, 39, 15, 1, 1),
(466, 39, 16, 1, 1),
(467, 39, 17, 1, 1),
(468, 39, 34, 1, 1),
(469, 39, 33, 0, 1),
(470, 39, 88, 0, 1),
(471, 39, 7, 0, 5),
(472, 39, 4, 0, 1),
(473, 21, 87, 0, 1);

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
  `gold_value` int(11) NOT NULL DEFAULT 0,
  `imageName` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `Items`
--

INSERT INTO `Items` (`id`, `name`, `description`, `unite_inv`, `poids`, `item_type`, `gold_value`, `imageName`) VALUES
(1, 'Epee longue', 'Une épée forgée pour le combat rapproché.', 3, 10, 'weapon', 50, NULL),
(2, 'Hache de bataille', 'Une hache lourde capable de briser des armures.', 4, 15, 'weapon', 75, NULL),
(3, 'Dague en acier noir', 'Une dague rapide et mortelle, idéale pour les assassins.', 1, 5, 'weapon', 30, NULL),
(4, 'Armure de plaques', 'Une armure complète offrant une protection maximale.', 6, 30, 'armor', 150, NULL),
(5, 'Cuirasse renforcée', 'Une armure de cuir renforcé avec du métal.', 4, 20, 'armor', 80, NULL),
(6, 'Casque à cornes', 'Un casque intimidant avec des cornes massives.', 2, 10, 'armor', 40, NULL),
(7, 'Potion de soins', 'Régénère 5 points de vie.', 1, 1, 'consumable', 25, 'PetitPopoVie'),
(8, 'Potion de mana', 'Restaure 3 points de mana.', 1, 1, 'consumable', 20, 'PetitPopoMana'),
(9, 'Poudre de force', 'Augmente la force pendant 10 minutes.', 1, 2, 'consumable', 35, NULL),
(10, 'Amulette maudite', 'Une amulette obscure qui porte malheur à son porteur.', 1, 1, 'miscellaneous', 10, NULL),
(11, 'Parchemin ancien', 'Un parchemin contenant des runes illisibles.', 1, 1, 'miscellaneous', 15, NULL),
(12, 'Pierre magique', 'Une pierre mystérieuse pulsant d\'une faible lumière.', 1, 1, 'miscellaneous', 50, NULL),
(13, 'Casque Guerrier', 'Un casque solide offrant une bonne protection.', 1, 2, 'armor', 40, 'CasqueG'),
(14, 'Armure Guerrier', 'Une armure lourde offrant une protection maximale.', 6, 25, 'armor', 120, 'ArmureG'),
(15, 'Jambiers Guerrier', 'Protection pour les jambes des guerriers.', 2, 5, 'armor', 60, 'JambiereG'),
(16, 'Gants Guerrier', 'Des gants renforcés pour une meilleure prise.', 1, 2, 'armor', 30, 'GantG'),
(17, 'Épée de guerre', 'Une épée lourde et puissante.', 3, 15, 'weapon', 150, NULL),
(18, 'Potion de force', 'Augmente la force pendant 10 minutes.', 1, 1, 'consumable', 50, NULL),
(19, 'Chapeau de magicien', 'Chapeau pointu offrant une résistance magique.', 1, 2, 'armor', 35, 'ChapeauS'),
(20, 'Robe de magicien', 'Robe magique légère.', 6, 25, 'armor', 80, NULL),
(21, 'Gants de mage', 'Gants amplifiant les pouvoirs magiques.', 1, 2, 'armor', 40, NULL),
(22, 'Bâton magique', 'Un bâton qui canalise la magie.', 2, 5, 'weapon', 100, NULL),
(23, 'Potion de régénération de mana', 'Restaure 30 points de mana.', 1, 1, 'consumable', 45, 'GrossePopoMana'),
(24, 'Masque de voleur', 'Masque léger pour dissimuler son identité.', 1, 2, 'armor', 25, NULL),
(25, 'Cape de voleur', 'Cape légère pour agilité et discrétion.', 1, 3, 'armor', 50, NULL),
(26, 'Jambiers de voleur', 'Jambiers légers pour une meilleure mobilité.', 2, 5, 'armor', 30, 'BotteV'),
(27, 'Dagues de voleur', 'Deux petites dagues pour des attaques rapides.', 1, 3, 'weapon', 70, NULL),
(28, 'Potion de furtivité', 'Rend invisible temporairement.', 1, 1, 'consumable', 60, NULL),
(30, 'Fourrure de loup', 'Une fourrure sombre et dense, utile pour les vêtements.', 1, 2, 'miscellaneous', 10, NULL),
(31, 'Croc de loup', 'Un croc acéré, parfait pour les artisans ou comme trophée.', 1, 2, 'miscellaneous', 5, NULL),
(32, 'Peau de sanglier', 'Une peau épaisse, idéale pour renforcer une armure.', 1, 1, 'miscellaneous', 15, NULL),
(33, 'Défense de sanglier', 'Une grande défense, très recherchée par les collectionneurs.', 1, 3, 'miscellaneous', 20, NULL),
(34, 'Bouclier', 'Un bouclier de base', 1, 2, 'weapon', 100, NULL),
(35, 'Dague', 'Une dague de base', 1, 1, 'weapon', 50, NULL),
(36, 'Codex Umbrae', 'Un ancien grimoire contenant des secrets liés à la magie des ombres et de la peur.', 1, 3, 'codex', 200, NULL),
(37, 'Codex Thanatos', 'Un codex noir qui explore les arcanes de la nécromancie et de la manipulation des âmes.', 1, 4, 'codex', 250, NULL),
(38, 'Codex Carnifex', 'Un livre de rituels sanguinaires et de pouvoirs tirés de la douleur et du sacrifice.', 1, 5, 'codex', 300, NULL),
(39, 'Codex Obsidianus', 'Un codex mystérieux lié aux cristaux maudits et aux pièges dimensionnels.', 1, 3, 'codex', 220, NULL),
(40, 'Codex Inferna', 'Un grimoire ancien dédié aux flammes et à la destruction totale.', 1, 4, 'codex', 350, NULL),
(41, 'Codex Venenum', 'Un ouvrage de sciences sombres, enseignant la manipulation des poisons et des maladies.', 1, 3, 'codex', 180, NULL),
(42, 'Codex Noctis', 'Un codex astral détaillant la magie obscure et abyssale, explorant les forces des ténèbres et des entités cosmiques des abysses.', 1, 5, 'codex', 400, NULL),
(43, 'Codex Fulgoris', 'Un grimoire rendant maître des tempêtes et de la foudre dévastatrice.', 1, 4, 'codex', 275, NULL),
(44, 'Codex Mortis', 'Un codex qui explore la magie des cadavres et des rituels morbides.', 1, 4, 'codex', 250, NULL),
(45, 'Codex Arcanum', 'Un livre des connaissances interdites et des secrets ancestraux liés aux dimensions perdues.', 1, 3, 'codex', 350, NULL),
(46, 'Codex Malachior', 'Un codex permettant de manipuler les esprits et de contrôler les âmes.', 1, 3, 'codex', 230, NULL),
(47, 'Codex Venator', 'Un grimoire traitant de la chasse magique, des malédictions et des pièges magiques.', 1, 4, 'codex', 200, NULL),
(48, 'Codex Tenebris', 'Un ouvrage d’ombres et de rituels puissants, nécessitant des sacrifices.', 1, 5, 'codex', 280, NULL),
(49, 'Codex Lugdor', 'Un livre dédié à l’invocation des anciens dieux oubliés et des rituels cosmiques.', 1, 6, 'codex', 500, NULL),
(50, 'Codex Ferox', 'Un codex qui enseigne la transformation en créatures sauvages et l’invocation de bêtes infernales.', 1, 4, 'codex', 300, NULL),
(51, 'Capuche de necromencien', 'Une capuche cauchemardesque, symbole du désespoir et de la folie du porteur ', 1, 2, 'armor', 15, NULL),
(52, 'Robe de necromencien', 'Une robe tâchée de sang, preuve du passée et des terreurs crée par son porteur\n', 4, 1, 'armor', 50, NULL),
(53, 'Gant de necromencien', 'des gants en lambeau, détruit par des années d expérience et des meurtre perpetuer ', 2, 1, 'armor', 5, NULL),
(54, 'Faux de l Exilé', 'Une grande faux, forgée à partir d un métal sombre et rouillé, aux courbes sinistres. Elle porte des marques anciennes, comme si elle avait été utilisée pour faucher les âmes des damnés.', 6, 5, 'weapon', 200, NULL),
(55, 'Dague des Horreurs Abandonnéés', 'Une dague petite mais extrêmement aiguisée, taillée dans un os humain et imprégnée de magie noire. La lame semble trembler lorsqu elle est utilisée, comme si elle aspirait l âme de ses victimes. ', 2, 1, 'weapon', 50, NULL),
(56, 'Sceptre de Lumiere', 'Un sceptre éclatant de lumière divine.', 1, 5, 'weapon', 150, NULL),
(57, 'Bouclier de Vérité', 'Un bouclier protégeant contre les ténèbres.', 1, 8, 'weapon', 120, NULL),
(58, 'Heaume d Inquisition', 'Un heaume imposant pour les inquisiteurs.', 1, 5, 'armor', 80, NULL),
(59, 'Plastron d Inquisiteur', 'Une armure protectrice pour les justiciers divins.', 1, 15, 'armor', 120, NULL),
(60, 'Jambières de Lumière', 'Jambières légères et brillantes.', 1, 10, 'armor', 70, NULL),
(61, 'Gants de Justice', 'Des gants renforcés pour un meilleur contrôle.', 1, 3, 'armor', 50, NULL),
(62, 'Cagoule des Ombres', 'Cagoule légère pour dissimuler l identité et augmenter la furtivité.', 1, 4, 'armor', 50, NULL),
(63, 'Veste des Tenebres', 'Veste noire qui se fond dans l ombre, offrant une grande discrétion.', 1, 12, 'armor', 150, NULL),
(64, 'Jambieres legeres', 'Jambières souples qui augmentent la mobilité tout en offrant une protection modérée.', 2, 7, 'armor', 75, NULL),
(65, 'Gants d’agilite', 'Gants légers permettant une meilleure prise et agilité.', 1, 2, 'armor', 60, NULL),
(66, 'Arbalete d Ombre', 'Arbalète légère et silencieuse, idéale pour les attaques furtives.', 1, 3, 'weapon', 100, NULL),
(67, 'Dague des Profondeurs', 'Dague magique, forgée dans les ténèbres, idéale pour les attaques rapides.', 1, 6, 'weapon', 120, NULL),
(68, 'Heaume de Braise', 'Heaume orné de braises et de cendres, symbole de la puissance du feu.', 1, 6, 'armor', 70, NULL),
(69, 'Plastron des Flammes', 'Plastron résistant à la chaleur intense, conçu pour les mages du feu.', 1, 18, 'armor', 200, NULL),
(70, 'Jambières Enflammees', 'Jambières qui protègent contre la chaleur et augmentent la vitesse de déplacement.', 2, 12, 'armor', 110, NULL),
(71, 'Gants Ardents', 'Gants capables de canaliser l énergie du feu pour des attaques puissantes.', 1, 5, 'armor', 90, NULL),
(72, 'Bâton des Cendres', 'Bâton magique imprégné de cendres ardentes, capable de canaliser des pouvoirs de feu.', 2, 8, 'weapon', 150, NULL),
(73, 'Sceptre Ardant', 'Sceptre enflammé, utilisé par les prêtres des cendres pour invoquer des flammes destructrices.', 1, 4, 'weapon', 130, NULL),
(74, 'Heaume Forestier', 'Heaume fait de lianes et de bois renforcé, offrant une protection tout en permettant la respiration.', 1, 6, 'armor', 80, NULL),
(75, 'Armure Vivante', 'Armure vivante constituée de racines et de feuilles, capable de s adapter aux environnements.', 1, 20, 'armor', 250, NULL),
(76, 'Jambières Sylvestres', 'Jambières souples faites de peau d animaux et de lianes, offrant souplesse et protection.', 2, 10, 'armor', 120, NULL),
(77, 'Gants de Feuillage', 'Gants faits de feuilles renforcées, augmentant l agilité et la force des attaques.', 1, 4, 'armor', 95, NULL),
(78, 'Bâton de la Nature', 'Bâton magique permettant de contrôler les éléments naturels et d invoquer des créatures sylvestres.', 2, 7, 'weapon', 180, NULL),
(79, 'Dague Sylvestre', 'Dague en bois renforcé, légère et idéale pour les attaques rapides.', 1, 6, 'weapon', 110, NULL),
(80, 'Heaume Obscur', 'Heaume robuste fait d os et de métal, offrant une excellente protection tout en restant intimidant.', 1, 8, 'armor', 90, NULL),
(81, 'Cuirasse des Abysses', 'Cuirasse sombre et pesante, renforcée par les ténèbres, offrant une protection exceptionnelle.', 1, 25, 'armor', 300, NULL),
(82, 'Jambières de l’Ombre', 'Jambières lourdes mais efficaces pour se déplacer dans les ténèbres, avec une protection accrue.', 2, 15, 'armor', 150, NULL),
(83, 'Gants du Ravage', 'Gants en cuir renforcé, conçus pour les combats brutaux et la manipulation d armes lourdes.', 1, 6, 'armor', 130, NULL),
(84, 'Hache des Profondeurs', 'Hache massive forgée dans les abysses, capable de briser presque n importe quelle défense.', 3, 12, 'weapon', 250, NULL),
(85, 'Masse des Abysses', 'Masse lourde et cruelle, forgée dans les ténèbres, idéale pour les attaques puissantes.', 1, 10, 'weapon', 230, NULL),
(86, 'Glande Fongique', 'Une masse spongieuse et vivante, pulsant d une énergie étrange. Elle est imbibée d un liquide acide qui semble avoir des propriétés alchimiques.', 1, 2, 'miscellaneous', 150, NULL),
(87, 'Essence de Contagion', 'Une fiole contenant une substance vaporeuse capturée au moment de la mort du Miasme. Le gaz tourbillonne, évoquant une aura de menace.', 1, 1, 'miscellaneous', 250, NULL),
(88, 'Peau de Parasite', 'Une membrane résistante mais malléable, arrachée à la surface du Miasme. Des motifs organiques y sont gravés, comme si elle portait une mémoire vivante.', 2, 5, 'miscellaneous', 300, NULL);

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

--
-- Déchargement des données de la table `Level`
--

INSERT INTO `Level` (`id`, `class_id`, `level`, `required_xp`, `pv_bonus`, `mana_bonus`, `strength_bonus`, `initiative_bonus`) VALUES
(2, 1, 2, 400, 20, 0, 4, 0),
(3, 1, 3, 900, 30, 0, 6, 0),
(4, 1, 4, 1600, 40, 0, 8, 0),
(5, 1, 5, 2500, 50, 0, 10, 1),
(6, 1, 6, 3600, 60, 0, 12, 1),
(7, 1, 7, 4900, 70, 0, 14, 1),
(8, 1, 8, 6400, 80, 0, 16, 1),
(9, 1, 9, 8100, 90, 0, 18, 1),
(10, 1, 10, 10000, 100, 0, 20, 2),
(11, 1, 11, 12100, 110, 0, 22, 2),
(12, 1, 12, 14400, 120, 0, 24, 2),
(13, 1, 13, 16900, 130, 0, 26, 2),
(14, 1, 14, 19600, 140, 0, 28, 2),
(15, 1, 15, 22500, 150, 0, 30, 3),
(16, 1, 16, 25600, 160, 0, 32, 3),
(17, 1, 17, 28900, 170, 0, 34, 3),
(18, 1, 18, 32400, 180, 0, 36, 3),
(19, 1, 19, 36100, 190, 0, 38, 3),
(20, 1, 20, 40000, 200, 0, 40, 4),
(21, 1, 21, 44100, 210, 0, 42, 4),
(22, 1, 22, 48400, 220, 0, 44, 4),
(23, 1, 23, 52900, 230, 0, 46, 4),
(24, 1, 24, 57600, 240, 0, 48, 4),
(25, 1, 25, 62500, 250, 0, 50, 5),
(26, 1, 26, 67600, 260, 0, 52, 5),
(27, 1, 27, 72900, 270, 0, 54, 5),
(28, 1, 28, 78400, 280, 0, 56, 5),
(29, 1, 29, 84100, 290, 0, 58, 5),
(30, 1, 30, 90000, 300, 0, 60, 6),
(31, 1, 31, 96100, 310, 0, 62, 6),
(32, 1, 32, 102400, 320, 0, 64, 6),
(33, 1, 33, 108900, 330, 0, 66, 6),
(34, 1, 34, 115600, 340, 0, 68, 6),
(35, 1, 35, 122500, 350, 0, 70, 7),
(36, 1, 36, 129600, 360, 0, 72, 7),
(37, 1, 37, 136900, 370, 0, 74, 7),
(38, 1, 38, 144400, 380, 0, 76, 7),
(39, 1, 39, 152100, 390, 0, 78, 7),
(40, 1, 40, 160000, 400, 0, 80, 8),
(41, 1, 41, 168100, 410, 0, 82, 8),
(42, 1, 42, 176400, 420, 0, 84, 8),
(43, 1, 43, 184900, 430, 0, 86, 8),
(44, 1, 44, 193600, 440, 0, 88, 8),
(45, 1, 45, 202500, 450, 0, 90, 9),
(46, 1, 46, 211600, 460, 0, 92, 9),
(47, 1, 47, 220900, 470, 0, 94, 9),
(48, 1, 48, 230400, 480, 0, 96, 9),
(49, 1, 49, 240100, 490, 0, 98, 9),
(50, 1, 50, 250000, 500, 0, 100, 10),
(51, 1, 51, 260100, 510, 0, 102, 10),
(52, 1, 52, 270400, 520, 0, 104, 10),
(53, 1, 53, 280900, 530, 0, 106, 10),
(54, 1, 54, 291600, 540, 0, 108, 10),
(55, 1, 55, 302500, 550, 0, 110, 11),
(56, 1, 56, 313600, 560, 0, 112, 11),
(57, 1, 57, 324900, 570, 0, 114, 11),
(58, 1, 58, 336400, 580, 0, 116, 11),
(59, 1, 59, 348100, 590, 0, 118, 11),
(60, 1, 60, 360000, 600, 0, 120, 12),
(61, 1, 61, 372100, 610, 0, 122, 12),
(62, 1, 62, 384400, 620, 0, 124, 12),
(63, 1, 63, 396900, 630, 0, 126, 12),
(64, 1, 64, 409600, 640, 0, 128, 12),
(65, 1, 65, 422500, 650, 0, 130, 13),
(66, 1, 66, 435600, 660, 0, 132, 13),
(67, 1, 67, 448900, 670, 0, 134, 13),
(68, 1, 68, 462400, 680, 0, 136, 13),
(69, 1, 69, 476100, 690, 0, 138, 13),
(70, 1, 70, 490000, 700, 0, 140, 14),
(71, 1, 71, 504100, 710, 0, 142, 14),
(72, 1, 72, 518400, 720, 0, 144, 14),
(73, 1, 73, 532900, 730, 0, 146, 14),
(74, 1, 74, 547600, 740, 0, 148, 14),
(75, 1, 75, 562500, 750, 0, 150, 15),
(76, 1, 76, 577600, 760, 0, 152, 15),
(77, 1, 77, 592900, 770, 0, 154, 15),
(78, 1, 78, 608400, 780, 0, 156, 15),
(79, 1, 79, 624100, 790, 0, 158, 15),
(80, 1, 80, 640000, 800, 0, 160, 16),
(81, 1, 81, 656100, 810, 0, 162, 16),
(82, 1, 82, 672400, 820, 0, 164, 16),
(83, 1, 83, 688900, 830, 0, 166, 16),
(84, 1, 84, 705600, 840, 0, 168, 16),
(85, 1, 85, 722500, 850, 0, 170, 17),
(86, 1, 86, 739600, 860, 0, 172, 17),
(87, 1, 87, 756900, 870, 0, 174, 17),
(88, 1, 88, 774400, 880, 0, 176, 17),
(89, 1, 89, 792100, 890, 0, 178, 17),
(90, 1, 90, 810000, 900, 0, 180, 18),
(91, 1, 91, 828100, 910, 0, 182, 18),
(92, 1, 92, 846400, 920, 0, 184, 18),
(93, 1, 93, 864900, 930, 0, 186, 18),
(94, 1, 94, 883600, 940, 0, 188, 18),
(95, 1, 95, 902500, 950, 0, 190, 19),
(96, 1, 96, 921600, 960, 0, 192, 19),
(97, 1, 97, 940900, 970, 0, 194, 19),
(98, 1, 98, 960400, 980, 0, 196, 19),
(99, 1, 99, 980100, 990, 0, 198, 19),
(100, 1, 100, 1000000, 1000, 0, 200, 20),
(102, 2, 2, 400, 2, 20, 0, 0),
(103, 2, 3, 900, 3, 30, 0, 1),
(104, 2, 4, 1600, 4, 40, 0, 1),
(105, 2, 5, 2500, 5, 50, 0, 1),
(106, 2, 6, 3600, 6, 60, 0, 2),
(107, 2, 7, 4900, 7, 70, 0, 2),
(108, 2, 8, 6400, 8, 80, 0, 2),
(109, 2, 9, 8100, 9, 90, 0, 3),
(110, 2, 10, 10000, 10, 100, 0, 3),
(111, 2, 11, 12100, 11, 110, 0, 3),
(112, 2, 12, 14400, 12, 120, 0, 4),
(113, 2, 13, 16900, 13, 130, 0, 4),
(114, 2, 14, 19600, 14, 140, 0, 4),
(115, 2, 15, 22500, 15, 150, 0, 5),
(116, 2, 16, 25600, 16, 160, 0, 5),
(117, 2, 17, 28900, 17, 170, 0, 5),
(118, 2, 18, 32400, 18, 180, 0, 6),
(119, 2, 19, 36100, 19, 190, 0, 6),
(120, 2, 20, 40000, 20, 200, 0, 6),
(121, 2, 21, 44100, 21, 210, 0, 7),
(122, 2, 22, 48400, 22, 220, 0, 7),
(123, 2, 23, 52900, 23, 230, 0, 7),
(124, 2, 24, 57600, 24, 240, 0, 8),
(125, 2, 25, 62500, 25, 250, 0, 8),
(126, 2, 26, 67600, 26, 260, 0, 8),
(127, 2, 27, 72900, 27, 270, 0, 9),
(128, 2, 28, 78400, 28, 280, 0, 9),
(129, 2, 29, 84100, 29, 290, 0, 9),
(130, 2, 30, 90000, 30, 300, 0, 10),
(131, 2, 31, 96100, 31, 310, 0, 10),
(132, 2, 32, 102400, 32, 320, 0, 10),
(133, 2, 33, 108900, 33, 330, 0, 11),
(134, 2, 34, 115600, 34, 340, 0, 11),
(135, 2, 35, 122500, 35, 350, 0, 11),
(136, 2, 36, 129600, 36, 360, 0, 12),
(137, 2, 37, 136900, 37, 370, 0, 12),
(138, 2, 38, 144400, 38, 380, 0, 12),
(139, 2, 39, 152100, 39, 390, 0, 13),
(140, 2, 40, 160000, 40, 400, 0, 13),
(141, 2, 41, 168100, 41, 410, 0, 13),
(142, 2, 42, 176400, 42, 420, 0, 14),
(143, 2, 43, 184900, 43, 430, 0, 14),
(144, 2, 44, 193600, 44, 440, 0, 14),
(145, 2, 45, 202500, 45, 450, 0, 15),
(146, 2, 46, 211600, 46, 460, 0, 15),
(147, 2, 47, 220900, 47, 470, 0, 15),
(148, 2, 48, 230400, 48, 480, 0, 16),
(149, 2, 49, 240100, 49, 490, 0, 16),
(150, 2, 50, 250000, 50, 500, 0, 16),
(151, 2, 51, 260100, 51, 510, 0, 17),
(152, 2, 52, 270400, 52, 520, 0, 17),
(153, 2, 53, 280900, 53, 530, 0, 17),
(154, 2, 54, 291600, 54, 540, 0, 18),
(155, 2, 55, 302500, 55, 550, 0, 18),
(156, 2, 56, 313600, 56, 560, 0, 18),
(157, 2, 57, 324900, 57, 570, 0, 19),
(158, 2, 58, 336400, 58, 580, 0, 19),
(159, 2, 59, 348100, 59, 590, 0, 19),
(160, 2, 60, 360000, 60, 600, 0, 20),
(161, 2, 61, 372100, 61, 610, 0, 20),
(162, 2, 62, 384400, 62, 620, 0, 20),
(163, 2, 63, 396900, 63, 630, 0, 21),
(164, 2, 64, 409600, 64, 640, 0, 21),
(165, 2, 65, 422500, 65, 650, 0, 21),
(166, 2, 66, 435600, 66, 660, 0, 22),
(167, 2, 67, 448900, 67, 670, 0, 22),
(168, 2, 68, 462400, 68, 680, 0, 22),
(169, 2, 69, 476100, 69, 690, 0, 23),
(170, 2, 70, 490000, 70, 700, 0, 23),
(171, 2, 71, 504100, 71, 710, 0, 23),
(172, 2, 72, 518400, 72, 720, 0, 24),
(173, 2, 73, 532900, 73, 730, 0, 24),
(174, 2, 74, 547600, 74, 740, 0, 24),
(175, 2, 75, 562500, 75, 750, 0, 25),
(176, 2, 76, 577600, 76, 760, 0, 25),
(177, 2, 77, 592900, 77, 770, 0, 25),
(178, 2, 78, 608400, 78, 780, 0, 26),
(179, 2, 79, 624100, 79, 790, 0, 26),
(180, 2, 80, 640000, 80, 800, 0, 26),
(181, 2, 81, 656100, 81, 810, 0, 27),
(182, 2, 82, 672400, 82, 820, 0, 27),
(183, 2, 83, 688900, 83, 830, 0, 27),
(184, 2, 84, 705600, 84, 840, 0, 28),
(185, 2, 85, 722500, 85, 850, 0, 28),
(186, 2, 86, 739600, 86, 860, 0, 28),
(187, 2, 87, 756900, 87, 870, 0, 29),
(188, 2, 88, 774400, 88, 880, 0, 29),
(189, 2, 89, 792100, 89, 890, 0, 29),
(190, 2, 90, 810000, 90, 900, 0, 30),
(191, 2, 91, 828100, 91, 910, 0, 30),
(192, 2, 92, 846400, 92, 920, 0, 30),
(193, 2, 93, 864900, 93, 930, 0, 31),
(194, 2, 94, 883600, 94, 940, 0, 31),
(195, 2, 95, 902500, 95, 950, 0, 31),
(196, 2, 96, 921600, 96, 960, 0, 32),
(197, 2, 97, 940900, 97, 970, 0, 32),
(198, 2, 98, 960400, 98, 980, 0, 32),
(199, 2, 99, 980100, 99, 990, 0, 33),
(200, 2, 100, 1000000, 100, 1000, 0, 33),
(202, 3, 2, 400, 10, 6, 4, 4),
(203, 3, 3, 900, 15, 9, 6, 6),
(204, 3, 4, 1600, 20, 12, 8, 8),
(205, 3, 5, 2500, 25, 15, 10, 10),
(206, 3, 6, 3600, 30, 18, 12, 12),
(207, 3, 7, 4900, 35, 21, 14, 14),
(208, 3, 8, 6400, 40, 24, 16, 16),
(209, 3, 9, 8100, 45, 27, 18, 18),
(210, 3, 10, 10000, 50, 30, 20, 20),
(211, 3, 11, 12100, 55, 33, 22, 22),
(212, 3, 12, 14400, 60, 36, 24, 24),
(213, 3, 13, 16900, 65, 39, 26, 26),
(214, 3, 14, 19600, 70, 42, 28, 28),
(215, 3, 15, 22500, 75, 45, 30, 30),
(216, 3, 16, 25600, 80, 48, 32, 32),
(217, 3, 17, 28900, 85, 51, 34, 34),
(218, 3, 18, 32400, 90, 54, 36, 36),
(219, 3, 19, 36100, 95, 57, 38, 38),
(220, 3, 20, 40000, 100, 60, 40, 40),
(221, 3, 21, 44100, 105, 63, 42, 42),
(222, 3, 22, 48400, 110, 66, 44, 44),
(223, 3, 23, 52900, 115, 69, 46, 46),
(224, 3, 24, 57600, 120, 72, 48, 48),
(225, 3, 25, 62500, 125, 75, 50, 50),
(226, 3, 26, 67600, 130, 78, 52, 52),
(227, 3, 27, 72900, 135, 81, 54, 54),
(228, 3, 28, 78400, 140, 84, 56, 56),
(229, 3, 29, 84100, 145, 87, 58, 58),
(230, 3, 30, 90000, 150, 90, 60, 60),
(231, 3, 31, 96100, 155, 93, 62, 62),
(232, 3, 32, 102400, 160, 96, 64, 64),
(233, 3, 33, 108900, 165, 99, 66, 66),
(234, 3, 34, 115600, 170, 102, 68, 68),
(235, 3, 35, 122500, 175, 105, 70, 70),
(236, 3, 36, 129600, 180, 108, 72, 72),
(237, 3, 37, 136900, 185, 111, 74, 74),
(238, 3, 38, 144400, 190, 114, 76, 76),
(239, 3, 39, 152100, 195, 117, 78, 78),
(240, 3, 40, 160000, 200, 120, 80, 80),
(241, 3, 41, 168100, 205, 123, 82, 82),
(242, 3, 42, 176400, 210, 126, 84, 84),
(243, 3, 43, 184900, 215, 129, 86, 86),
(244, 3, 44, 193600, 220, 132, 88, 88),
(245, 3, 45, 202500, 225, 135, 90, 90),
(246, 3, 46, 211600, 230, 138, 92, 92),
(247, 3, 47, 220900, 235, 141, 94, 94),
(248, 3, 48, 230400, 240, 144, 96, 96),
(249, 3, 49, 240100, 245, 147, 98, 98),
(250, 3, 50, 250000, 250, 150, 100, 100),
(251, 3, 51, 260100, 255, 153, 102, 102),
(252, 3, 52, 270400, 260, 156, 104, 104),
(253, 3, 53, 280900, 265, 159, 106, 106),
(254, 3, 54, 291600, 270, 162, 108, 108),
(255, 3, 55, 302500, 275, 165, 110, 110),
(256, 3, 56, 313600, 280, 168, 112, 112),
(257, 3, 57, 324900, 285, 171, 114, 114),
(258, 3, 58, 336400, 290, 174, 116, 116),
(259, 3, 59, 348100, 295, 177, 118, 118),
(260, 3, 60, 360000, 300, 180, 120, 120),
(261, 3, 61, 372100, 305, 183, 122, 122),
(262, 3, 62, 384400, 310, 186, 124, 124),
(263, 3, 63, 396900, 315, 189, 126, 126),
(264, 3, 64, 409600, 320, 192, 128, 128),
(265, 3, 65, 422500, 325, 195, 130, 130),
(266, 3, 66, 435600, 330, 198, 132, 132),
(267, 3, 67, 448900, 335, 201, 134, 134),
(268, 3, 68, 462400, 340, 204, 136, 136),
(269, 3, 69, 476100, 345, 207, 138, 138),
(270, 3, 70, 490000, 350, 210, 140, 140),
(271, 3, 71, 504100, 355, 213, 142, 142),
(272, 3, 72, 518400, 360, 216, 144, 144),
(273, 3, 73, 532900, 365, 219, 146, 146),
(274, 3, 74, 547600, 370, 222, 148, 148),
(275, 3, 75, 562500, 375, 225, 150, 150),
(276, 3, 76, 577600, 380, 228, 152, 152),
(277, 3, 77, 592900, 385, 231, 154, 154),
(278, 3, 78, 608400, 390, 234, 156, 156),
(279, 3, 79, 624100, 395, 237, 158, 158),
(280, 3, 80, 640000, 400, 240, 160, 160),
(281, 3, 81, 656100, 405, 243, 162, 162),
(282, 3, 82, 672400, 410, 246, 164, 164),
(283, 3, 83, 688900, 415, 249, 166, 166),
(284, 3, 84, 705600, 420, 252, 168, 168),
(285, 3, 85, 722500, 425, 255, 170, 170),
(286, 3, 86, 739600, 430, 258, 172, 172),
(287, 3, 87, 756900, 435, 261, 174, 174),
(288, 3, 88, 774400, 440, 264, 176, 176),
(289, 3, 89, 792100, 445, 267, 178, 178),
(290, 3, 90, 810000, 450, 270, 180, 180),
(291, 3, 91, 828100, 455, 273, 182, 182),
(292, 3, 92, 846400, 460, 276, 184, 184),
(293, 3, 93, 864900, 465, 279, 186, 186),
(294, 3, 94, 883600, 470, 282, 188, 188),
(295, 3, 95, 902500, 475, 285, 190, 190),
(296, 3, 96, 921600, 480, 288, 192, 192),
(297, 3, 97, 940900, 485, 291, 194, 194),
(298, 3, 98, 960400, 490, 294, 196, 196),
(299, 3, 99, 980100, 495, 297, 198, 198),
(300, 3, 100, 1000000, 500, 300, 200, 200),
(301, 5, 2, 400, 18, 2, 2, 1),
(302, 5, 3, 900, 36, 4, 4, 2),
(303, 5, 4, 1600, 54, 6, 6, 3),
(304, 5, 5, 2500, 72, 8, 8, 4),
(305, 5, 6, 3600, 90, 10, 10, 5),
(306, 5, 7, 4900, 108, 12, 12, 6),
(307, 5, 8, 6400, 126, 14, 14, 7),
(308, 5, 9, 8100, 144, 16, 16, 8),
(309, 5, 10, 10000, 162, 18, 18, 9),
(310, 5, 11, 12100, 180, 20, 20, 10),
(311, 5, 12, 14400, 198, 22, 22, 11),
(312, 5, 13, 16900, 216, 24, 24, 12),
(313, 5, 14, 19600, 234, 26, 26, 13),
(314, 5, 15, 22500, 252, 28, 28, 14),
(315, 5, 16, 25600, 270, 30, 30, 15),
(316, 5, 17, 28900, 288, 32, 32, 16),
(317, 5, 18, 32400, 306, 34, 34, 17),
(318, 5, 19, 36100, 324, 36, 36, 18),
(319, 5, 20, 40000, 342, 38, 38, 19),
(320, 5, 21, 44100, 360, 40, 40, 20),
(321, 5, 22, 48400, 378, 42, 42, 21),
(322, 5, 23, 52900, 396, 44, 44, 22),
(323, 5, 24, 57600, 414, 46, 46, 23),
(324, 5, 25, 62500, 432, 48, 48, 24),
(325, 5, 26, 67600, 450, 50, 50, 25),
(326, 5, 27, 72900, 468, 52, 52, 26),
(327, 5, 28, 78400, 486, 54, 54, 27),
(328, 5, 29, 84100, 504, 56, 56, 28),
(329, 5, 30, 90000, 522, 58, 58, 29),
(330, 5, 31, 96100, 540, 60, 60, 30),
(331, 5, 32, 102400, 558, 62, 62, 31),
(332, 5, 33, 108900, 576, 64, 64, 32),
(333, 5, 34, 115600, 594, 66, 66, 33),
(334, 5, 35, 122500, 612, 68, 68, 34),
(335, 5, 36, 129600, 630, 70, 70, 35),
(336, 5, 37, 136900, 648, 72, 72, 36),
(337, 5, 38, 144400, 666, 74, 74, 37),
(338, 5, 39, 152100, 684, 76, 76, 38),
(339, 5, 40, 160000, 702, 78, 78, 39),
(340, 5, 41, 168100, 720, 80, 80, 40),
(341, 5, 42, 176400, 738, 82, 82, 41),
(342, 5, 43, 184900, 756, 84, 84, 42),
(343, 5, 44, 193600, 774, 86, 86, 43),
(344, 5, 45, 202500, 792, 88, 88, 44),
(345, 5, 46, 211600, 810, 90, 90, 45),
(346, 5, 47, 220900, 828, 92, 92, 46),
(347, 5, 48, 230400, 846, 94, 94, 47),
(348, 5, 49, 240100, 864, 96, 96, 48),
(349, 5, 50, 250000, 882, 98, 98, 49),
(350, 5, 51, 260100, 900, 100, 100, 50),
(351, 5, 52, 270400, 918, 102, 102, 51),
(352, 5, 53, 280900, 936, 104, 104, 52),
(353, 5, 54, 291600, 954, 106, 106, 53),
(354, 5, 55, 302500, 972, 108, 108, 54),
(355, 5, 56, 313600, 990, 110, 110, 55),
(356, 5, 57, 324900, 1008, 112, 112, 56),
(357, 5, 58, 336400, 1026, 114, 114, 57),
(358, 5, 59, 348100, 1044, 116, 116, 58),
(359, 5, 60, 360000, 1062, 118, 118, 59),
(360, 5, 61, 372100, 1080, 120, 120, 60),
(361, 5, 62, 384400, 1098, 122, 122, 61),
(362, 5, 63, 396900, 1116, 124, 124, 62),
(363, 5, 64, 409600, 1134, 126, 126, 63),
(364, 5, 65, 422500, 1152, 128, 128, 64),
(365, 5, 66, 435600, 1170, 130, 130, 65),
(366, 5, 67, 448900, 1188, 132, 132, 66),
(367, 5, 68, 462400, 1206, 134, 134, 67),
(368, 5, 69, 476100, 1224, 136, 136, 68),
(369, 5, 70, 490000, 1242, 138, 138, 69),
(370, 5, 71, 504100, 1260, 140, 140, 70),
(371, 5, 72, 518400, 1278, 142, 142, 71),
(372, 5, 73, 532900, 1296, 144, 144, 72),
(373, 5, 74, 547600, 1314, 146, 146, 73),
(374, 5, 75, 562500, 1332, 148, 148, 74),
(375, 5, 76, 577600, 1350, 150, 150, 75),
(376, 5, 77, 592900, 1368, 152, 152, 76),
(377, 5, 78, 608400, 1386, 154, 154, 77),
(378, 5, 79, 624100, 1404, 156, 156, 78),
(379, 5, 80, 640000, 1422, 158, 158, 79),
(380, 5, 81, 656100, 1440, 160, 160, 80),
(381, 5, 82, 672400, 1458, 162, 162, 81),
(382, 5, 83, 688900, 1476, 164, 164, 82),
(383, 5, 84, 705600, 1494, 166, 166, 83),
(384, 5, 85, 722500, 1512, 168, 168, 84),
(385, 5, 86, 739600, 1530, 170, 170, 85),
(386, 5, 87, 756900, 1548, 172, 172, 86),
(387, 5, 88, 774400, 1566, 174, 174, 87),
(388, 5, 89, 792100, 1584, 176, 176, 88),
(389, 5, 90, 810000, 1602, 178, 178, 89),
(390, 5, 91, 828100, 1620, 180, 180, 90),
(391, 5, 92, 846400, 1638, 182, 182, 91),
(392, 5, 93, 864900, 1656, 184, 184, 92),
(393, 5, 94, 883600, 1674, 186, 186, 93),
(394, 5, 95, 902500, 1692, 188, 188, 94),
(395, 5, 96, 921600, 1710, 190, 190, 95),
(396, 5, 97, 940900, 1728, 192, 192, 96),
(397, 5, 98, 960400, 1746, 194, 194, 97),
(398, 5, 99, 980100, 1764, 196, 196, 98),
(399, 5, 100, 1000000, 1782, 198, 198, 99),
(401, 6, 2, 400, 5, 10, 0, 1),
(402, 6, 3, 900, 10, 20, 0, 2),
(403, 6, 4, 1600, 15, 30, 1, 3),
(404, 6, 5, 2500, 20, 40, 1, 4),
(405, 6, 6, 3600, 25, 50, 2, 5),
(406, 6, 7, 4900, 30, 60, 2, 6),
(407, 6, 8, 6400, 35, 70, 3, 7),
(408, 6, 9, 8100, 40, 80, 3, 8),
(409, 6, 10, 10000, 45, 90, 4, 9),
(410, 6, 11, 12100, 50, 100, 4, 10),
(411, 6, 12, 14400, 55, 110, 5, 11),
(412, 6, 13, 16900, 60, 120, 5, 12),
(413, 6, 14, 19600, 65, 130, 6, 13),
(414, 6, 15, 22500, 70, 140, 6, 14),
(415, 6, 16, 25600, 75, 150, 7, 15),
(416, 6, 17, 28900, 80, 160, 7, 16),
(417, 6, 18, 32400, 85, 170, 8, 17),
(418, 6, 19, 36100, 90, 180, 8, 18),
(419, 6, 20, 40000, 95, 190, 9, 19),
(420, 6, 21, 44100, 100, 200, 9, 20),
(421, 6, 22, 48400, 105, 210, 10, 21),
(422, 6, 23, 52900, 110, 220, 10, 22),
(423, 6, 24, 57600, 115, 230, 11, 23),
(424, 6, 25, 62500, 120, 240, 11, 24),
(425, 6, 26, 67600, 125, 250, 12, 25),
(426, 6, 27, 72900, 130, 260, 12, 26),
(427, 6, 28, 78400, 135, 270, 13, 27),
(428, 6, 29, 84100, 140, 280, 13, 28),
(429, 6, 30, 145000, 145, 290, 14, 29),
(430, 6, 31, 96100, 150, 300, 14, 30),
(431, 6, 32, 102400, 155, 310, 15, 31),
(432, 6, 33, 108900, 160, 320, 15, 32),
(433, 6, 34, 115600, 165, 330, 16, 33),
(434, 6, 35, 122500, 170, 340, 16, 34),
(435, 6, 36, 129600, 175, 350, 17, 35),
(436, 6, 37, 136900, 180, 360, 17, 36),
(437, 6, 38, 144400, 185, 370, 18, 37),
(438, 6, 39, 152100, 190, 380, 18, 38),
(439, 6, 40, 160000, 195, 390, 19, 39),
(440, 6, 41, 168100, 200, 400, 19, 40),
(441, 6, 42, 176400, 205, 410, 20, 41),
(442, 6, 43, 184900, 210, 420, 20, 42),
(443, 6, 44, 193600, 215, 430, 21, 43),
(444, 6, 45, 202500, 220, 440, 21, 44),
(445, 6, 46, 211600, 225, 450, 22, 45),
(446, 6, 47, 220900, 230, 460, 22, 46),
(447, 6, 48, 230400, 235, 470, 23, 47),
(448, 6, 49, 240100, 240, 480, 23, 48),
(449, 6, 50, 250000, 245, 490, 24, 49),
(450, 6, 51, 260100, 250, 500, 24, 50),
(451, 6, 52, 270400, 250, 510, 25, 51),
(452, 6, 53, 281100, 255, 520, 25, 52),
(453, 6, 54, 292000, 260, 530, 26, 53),
(454, 6, 55, 303100, 265, 540, 26, 54),
(455, 6, 56, 314400, 270, 550, 27, 55),
(456, 6, 57, 325900, 275, 560, 27, 56),
(457, 6, 58, 337600, 280, 570, 28, 57),
(458, 6, 59, 349500, 285, 580, 28, 58),
(459, 6, 60, 361600, 290, 590, 29, 59),
(460, 6, 61, 373900, 295, 600, 29, 60),
(461, 6, 62, 386400, 300, 610, 30, 61),
(462, 6, 63, 399100, 305, 620, 30, 62),
(463, 6, 64, 412000, 310, 630, 31, 63),
(464, 6, 65, 425100, 315, 640, 31, 64),
(465, 6, 66, 438400, 320, 650, 32, 65),
(466, 6, 67, 451900, 325, 660, 32, 66),
(467, 6, 68, 465600, 330, 670, 33, 67),
(468, 6, 69, 479500, 335, 680, 33, 68),
(469, 6, 70, 493600, 340, 690, 34, 69),
(470, 6, 71, 507900, 345, 700, 34, 70),
(471, 6, 72, 522400, 350, 710, 35, 71),
(472, 6, 73, 537100, 355, 720, 35, 72),
(473, 6, 74, 552000, 360, 730, 36, 73),
(474, 6, 75, 567100, 365, 740, 36, 74),
(475, 6, 76, 582400, 370, 750, 37, 75),
(476, 6, 77, 597900, 375, 760, 37, 76),
(477, 6, 78, 613600, 380, 770, 38, 77),
(478, 6, 79, 629500, 385, 780, 38, 78),
(479, 6, 80, 645600, 390, 790, 39, 79),
(480, 6, 81, 661900, 395, 800, 39, 80),
(481, 6, 82, 678400, 400, 810, 40, 81),
(482, 6, 83, 695100, 405, 820, 40, 82),
(483, 6, 84, 712000, 410, 830, 41, 83),
(484, 6, 85, 729100, 415, 840, 41, 84),
(485, 6, 86, 746400, 420, 850, 42, 85),
(486, 6, 87, 763900, 425, 860, 42, 86),
(487, 6, 88, 781600, 430, 870, 43, 87),
(488, 6, 89, 799500, 435, 880, 43, 88),
(489, 6, 90, 817600, 440, 890, 44, 89),
(490, 6, 91, 835900, 445, 900, 44, 90),
(491, 6, 92, 854400, 450, 910, 45, 91),
(492, 6, 93, 873100, 455, 920, 45, 92),
(493, 6, 94, 892000, 460, 930, 46, 93),
(494, 6, 95, 911100, 465, 940, 46, 94),
(495, 6, 96, 930400, 470, 950, 47, 95),
(496, 6, 97, 949900, 475, 960, 47, 96),
(497, 6, 98, 969600, 480, 970, 48, 97),
(498, 6, 99, 989500, 485, 980, 48, 98),
(499, 6, 100, 1000000, 490, 990, 49, 99);

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
(4, 2, 3, 'Le vent vous guide vers un sentier sinueux. Ignorant le cris.'),
(5, 2, 4, 'vous avancez à travers les ronces.'),
(24, 3, 5, 'Vous croisez un vieux paysan qui vous avertit des créatures de la forêt.'),
(25, 3, 6, 'Vous ignorez les bruits et continuez.'),
(26, 4, 7, NULL),
(27, 4, 10, NULL),
(28, 5, 7, 'Le paysan vous avertit, mais vous continuez et arrivez dans une clairière entourée de pierres.'),
(29, 6, 7, NULL),
(30, 7, 8, 'Dans la clairière, vous apercevez un ruisseau paisible et des murmures étranges.'),
(31, 7, 9, 'Vous avancez vers le château en ruines.'),
(33, 8, 9, 'Vous ignorez les murmures et vous approchez du château, toujours plus près du mystère.'),
(34, 9, 15, 'Le château en ruines cache un mal ancien prêt à surgir.'),
(35, 10, 1, 'L’obscurité vous engloutit, vous guidant vers une lumière qui pourrait vous coûter cher.'),
(37, 4, 11, NULL),
(38, 6, 10, NULL),
(45, 11, 13, 'Votre fuite vous mène à un étang scintillant, où des murmures étranges emplissent l’air.'),
(46, 11, 14, 'Vous découvrez un sentier oublié qui serpente entre les arbres.'),
(47, 12, 13, 'En vous éloignant précipitamment, vous arrivez à un étang paisible et mystérieux.'),
(48, 12, 14, 'Votre marche hasardeuse vous mène à un sentier recouvert de végétation.'),
(49, 13, 9, 'Le murmure de l’étang semble vous guider vers une colline menaçante.'),
(50, 14, 9, 'Le sentier vous conduit au pied d’une colline sombre où se dresse un château en ruines.'),
(51, 6, 12, NULL),
(52, 15, 1, NULL),
(53, 15, 16, NULL),
(54, 15, 1, NULL),
(55, 16, 17, NULL),
(56, 17, 18, NULL),
(57, 17, 10, NULL),
(58, 17, 19, NULL),
(59, 19, 17, 'Retournez au combat !'),
(60, 18, 20, NULL),
(61, 20, 21, 'Explorez la forge.'),
(62, 20, 22, 'Visitez le commerce.'),
(63, 20, 23, 'Parlez aux villageois.'),
(64, 22, 20, NULL),
(65, 21, 20, NULL);

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
(4, 32, 1, 2, 25),
(5, 86, 1, 4, 15),
(6, 87, 1, 4, 50),
(7, 88, 1, 4, 65);

-- --------------------------------------------------------

--
-- Structure de la table `Merchant`
--

CREATE TABLE `Merchant` (
  `npc_id` int(11) NOT NULL,
  `gold` int(11) NOT NULL DEFAULT 0,
  `trickery_level` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `Merchant`
--

INSERT INTO `Merchant` (`npc_id`, `gold`, `trickery_level`) VALUES
(4, 50, 7),
(5, 10, 1);

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

--
-- Déchargement des données de la table `MerchantStock`
--

INSERT INTO `MerchantStock` (`merchant_id`, `item_id`, `stock`, `price`) VALUES
(4, 7, 10, 100),
(4, 8, 5, 80),
(4, 11, 1, 40),
(5, 2, 1, 50),
(5, 4, 1, 85);

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
(1, 'Loup Noir', 15, 0, 6, 7, 'Morsure vicieuse', 50),
(2, 'Sanglier Enragé', 5, 0, 4, 8, 'Charge brutale', 70),
(3, 'Gor\'huga', 50, 0, 0, 50, 'Masse bruleuse', 700),
(4, 'Miasme Corrompu', 17, NULL, 2, 10, 'Empalement enpoisonnée', 400);

-- --------------------------------------------------------

--
-- Structure de la table `NPC`
--

CREATE TABLE `NPC` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `INTRO_SENTENCE` text NOT NULL,
  `OST` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `NPC`
--

INSERT INTO `NPC` (`id`, `name`, `description`, `INTRO_SENTENCE`, `OST`) VALUES
(1, 'Edgar\n', NULL, '\"B....bienvenue cher voyageur dans la forêt ! vous m\'avez fait sacrément peur ! Mon nom est Edgar, vous avez besoins d\'aide ?\"', 'TheLetterToElsa'),
(2, '???', '???', 'Pitoyable....', 'BeyondTheVoid'),
(3, 'Théobald Duramont', 'Ancien bourgmestre du Val Perdu, Théobald est un homme imposant au regard sévère, portant les marques de nombreuses batailles pour protéger son village. Malgré son apparence austère, il est profondément attaché à ses habitants.', '\"Je suis Théobald Duramont, bourgmestre de ce village. Chaque jour, je vois mon peuple sombrer un peu plus dans la peur. Vous êtes notre seul espoir contre cette abomination.\"', NULL),
(4, 'Gaspard Trichepoche', 'Un marchand pauvre à l\'allure débraillée, Gaspard est connu pour son avarice légendaire. Malgré ses faibles revenus, il scrute chaque occasion pour tirer le maximum de profit, souvent au détriment des autres. Il porte une bourse trouée qu\'il ne quitte jamais, symbole de son obsession pour l\'argent.', '\"Oh, un client ! Heh... Vous avez l air riche... enfin, je veux dire, vous avez l air d avoir des goûts exquis. Regardez ma marchandise, tout est à moitié prix ! Ou plutôt deux fois sa valeur, hihihi...\"', NULL),
(5, 'Guillaume Tison', 'Un forgeron humble et généreux, Guillaume est connu pour ses prix abordables et son désir sincère d\'aider ceux dans le besoin. Bien qu\'il manque de ressources et travaille avec des outils rudimentaires, ses créations, bien que simples, sont robustes et fiables.', '\"Ah, vous êtes à la recherche d\'équipement ? Je n\'ai pas grand-chose, mais ce que j\'ai, c\'est solide et pas cher. Je fais ce que je peux pour mes clients.\"', NULL);

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
  `is_end` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `NPC_Dialogue`
--

INSERT INTO `NPC_Dialogue` (`id_npc`, `id_dialogue`, `choix`, `reponse`, `condition`, `is_end`) VALUES
(1, 1, '\"Comment allez au chateau ?\"', '\"suivez le chemin ici... mais faites attention, des bêtes féroce vivent ici....\"', 0, 0),
(1, 2, '\"Tres bien, merci pour vos informations\"', '\"Avec plaisir !\"', 1, 1),
(1, 3, '\"Et vous, Edgar ? Que faites-vous ici dans la foret ?\"', '\"Ah, moi ? Eh bien... Je suis un simple vagabond. Je suis ici depuis des années, vivant seul. Je n ai pas de famille, ni d amis proches... cette foret me protège. Mais parfois, je pense qu elle me cache quelque chose, quelque chose de plus sombre...\"', 1, 0),
(1, 4, '\"Pourquoi vivre dans une foret aussi dangereuse ?\"', '\"J ai mes raisons, mon ami. Parfois, la solitude est un choix. D autres fois, c est la seule option. Et puis, il y a toujours quelque chose de mystérieuse qui vous attire ici. L Arcanique, peut-être...\"', 3, 0),
(1, 5, '\"Il semble que vous sachiez beaucoup de choses. Avez-vous vu des choses etranges ici ?\"', '\"Oh, j ai vu des choses... Des ombres qui bougent, des bruits venant de nulle part, des lumières qui clignotent dans l obscurité. La foret elle-même semble vivante... Et plus vous en apprenez sur l Arcanique, plus elle devient... étrange. Qui sait ce que j ai vu... peut-être que vous le découvrirez un jour.\"', 4, 0),
(1, 6, '\"Merci pour vos informations, Edgar. Je vais continuer mon chemin.\"', '\"Bonne chance, voyageur. Faites attention a vous. Et souvenez-vous, tout ce qui brille n est pas de l or...\"', 5, 1),
(1, 7, '\"Pouvez vous me parler plus de cette foret ?\"', '\"Hé bien.... ma foi... cette foret a ses petits mysteres, on raconte qu elle est a l origine de l Arcanique...\"', 3, 0),
(1, 8, '\"Arcanique ? Qu est-ce que c est exactement ?\"', '\"L Arcanique... C est une magie etrange, nee des mains des humains eux-memes. Contrairement aux pouvoirs divins, elle fut creee pour remplacer les hommes, pour les rendre obsoletes. On dit que ceux qui la maitrisent peuvent alterer la realite elle-meme...\"', 7, 0),
(1, 9, '\"Donc, les humains ont cree l Arcanique pour remplacer l humanite ? Pourquoi ?\"', '\"C est ce qu on raconte. Les premiers sorciers pensaient que l Arcanique permettrait d atteindre une perfection que l humanite ne pouvait pas realiser. Mais les choses ne se sont pas passees comme prevu. La magie a pris le controle, et beaucoup de ceux qui l ont utilisee ont disparu, perdus dans ses meandres.\"', 8, 0),
(1, 10, '\"Y a-t-il des traces de l Arcanique dans cette foret ?\"', '\"Ah, oui... il y a une clairiere de pierre, non loin d ici. On dit que c est un lieu ou l Arcanique a laisse ses marques. Des symboles graves dans la pierre, des motifs qui brillent sous la lumiere de la lune. C est un endroit dangereux, cependant... certaines personnes qui s y sont aventurees n en sont jamais revenues.\"', 9, 0),
(1, 11, '\"Merci pour vos informations sur l Arcanique. Je vais continuer mon chemin.\"', '\"Faites attention. L Arcanique est un pouvoir qui peut vous consumer si vous ne savez pas le manipuler... Soyez prudent, voyageur.\" ', 10, 1),
(2, 1, '\"...\"', '\"Regarde-toi. Pathetique. Une existence banale et insipide, remplie de decisions mediocres. Tu pensais etre special ? Un heros ? Quelle illusion risible. Meme les dieux que tu idolatres s’ennuient a te regarder trebucher.\"', 0, 0),
(2, 2, '\"...\"', '\"Je suis la depuis le debut, spectateur de ton existence... ou devrais-je dire, de ton absence d’existence. Chaque instant que tu passes ici est un affront a la realite elle-meme. Mais continue, essaie donc de justifier ton insignifiance. Cela me divertit, parfois.\"', 1, 0),
(2, 3, '\"...\"', '\"La mort... ah, cette grande farce cosmique. Tu la crains, n’est-ce pas ? Et pourtant, elle n’a aucun sens. Ni la vie, d’ailleurs. Mais toi... toi, pauvre creature, tu continues a lutter comme si cela changeait quoi que ce soit. Pathetique.\"', 2, 0),
(2, 4, '\"Je vous ecoute.\"', '\"Oh, quelle politesse ! Peut-etre y a-t-il un soupcon d’espoir en toi, apres tout. Non, je plaisante. Je sais deja ce que tu veux, mais avant que tu ne dises un mot, laisse-moi eclairer ta misérable existence : tu es moins qu’un grain de poussiere dans l’eternite.\"', 3, 0),
(2, 5, '\"Je...\"', '\"Silence ! Tu ne comprends rien. Mais sois patient, petit etre. Voici ton seul choix : mourir ici et etre oublie comme tant d’autres, ou retourner en arriere et affronter ton desastre une fois de plus. Parle, maintenant.\"', 4, 0),
(2, 6, '\"Laissez-moi mourir.\"', '\"Enfin ! Un acte de soumission. Peut-etre avais-tu encore un peu de dignite, apres tout. Mais tu vois, cela n’a aucune importance. Peu importe ce que tu choisis. Tu vas te reincarner. Je vais m’amuser un peu.\"', 5, 0),
(2, 7, '\"Reincarnez-moi dans le passe.\"', '\"Interessant. Tu choisis de retourner dans ce bourbier qu’est ta vie. Tres bien, retourne donc dans le passe, mais sache ceci : cela ne changera rien. Je vais t’amener la-bas, et nous recommencerons tout depuis le debut. Fais face a ton propre ridicule. Ah, que c’est amusant.\"', 5, 0),
(2, 8, '\"...\"', '\"De toute facon, je suis le seul a decider ici. Peu importe ce que tu penses. Allez, retourne dans le passe et amuse-toi bien avec ton destin, misérable. Nous nous reverrons, oh, assurément.\"', 6, 1),
(2, 9, '\"...\"', '\"De toute facon, je suis le seul a decider ici. Peu importe ce que tu penses. Allez, retourne dans le passe et amuse-toi bien avec ton destin, misérable. Nous nous reverrons, oh, assurément.\"', 7, 1),
(3, 1, '\"Bourgmestre Duramont, pourquoi votre peuple est-il si terrifié ?\"', '\"La peur est devenue une compagne constante ici. Depuis des siècles, des ombres planent sur notre village. Elles viennent de la forêt, emportant nos jeunes et brisant nos espoirs.\"', 0, 0),
(3, 2, '\"Que savez-vous de ces ombres ?\"', '\"Elles ne sont ni vivantes ni mortes. Certains disent qu elles sont des fragments de l Arcanique, échappés au contrôle de leurs créateurs. Tout ce que je sais, c est qu elles frappent sans avertissement.\"', 1, 0),
(3, 3, '\"Pourquoi n’avez-vous pas quitté ce lieu maudit ?\"', '\"Quitter ce village ? Impossible. Nous sommes liés à cette terre, par choix ou par malédiction. Et même si je le voulais, les bois environnants sont plus mortels que jamais.\"', 2, 0),
(3, 4, '\"Comment puis-je vous aider ?\"', '\"Vous êtes audacieux, étranger. Si vous voulez vraiment nous aider, trouvez la source de cette corruption. Une ancienne crypte, à l’ouest, semble être leur point d origine. Mais d abord, équipez vous et acheter du matériel !\"', 3, 0),
(3, 5, '\"Je trouverai cette crypte et mettrai fin à tout cela.\"', '\"Soyez prudent. Peu sont revenus de cette crypte. Si vous y parvenez, vous serez un héros pour nous tous.\"', 4, 1),
(3, 6, '\"Je ne peux pas risquer ma vie. Je suis désolé.\"', '\"Je ne vous en veux pas. Votre survie est importante. Mais sachez que sans votre aide, nous sommes condamnés.\"', 4, 1);

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

--
-- Déchargement des données de la table `Race`
--

INSERT INTO `Race` (`id`, `name`, `description`, `question`) VALUES
(1, 'Humains', 'Les humains sont une race fragile et éphémère, condamnée à la souffrance et à la mort, sans la bénédiction de l\'immortalité ou des pouvoirs surnaturels. Ils sont les seuls à jouir d\'une liberté de choix dans un monde qui écrase tout sur son passage. Mais cette liberté, comme leur vie, est vouée à disparaître.', 'Pourquoi persister dans un monde où chaque instant est une marche vers l\'oubli ? Que valent des vies aussi fragiles face à l\'infini ?'),
(2, 'Sépulcrales', 'Les Sépulcrales sont des êtres morts-vivants, réanimés par des forces sombres et mystérieuses. Leur corps décomposé erre, sans âme véritable, rongé par la corruption, mais ils continuent de vivre dans une agonie éternelle.', 'Peut-on encore être humain quand l\'âme s\'effrite et que le corps ne fait que subsister dans l\'agonie ?'),
(3, 'Boréals', 'Les Boréals viennent des régions glacées, leur corps est marqué par l\'hiver éternel. Leur peau est translucide, marbrée de cristaux glacés, et leurs émotions sont figées, comme le sol sous un froid mortel. Ils sont coupés de la chaleur et de la chaleur humaine, se retrouvant eux-mêmes prisonniers d\'un monde de froid.', 'Peut-on vivre sans chaleur, sans lien, ou l’humanité n\'est-elle qu’un feu éphémère dans le froid éternel ?'),
(4, 'Sang-de-Sang', 'Les Sang-de-Sang sont des créatures nées de rituels sombres, où le sang est la source de leur pouvoir et de leur malédiction. Leur peau est marquée de cicatrices vivantes, et leur essence même est une malédiction qu\'ils manipulent pour en tirer de la puissance. Mais chaque utilisation de leur pouvoir les dévore peu à peu.', 'Que vaut le pouvoir si la source de ce pouvoir est la souffrance, et quel prix sommes-nous prêts à payer pour cela ?'),
(5, 'Miasmes', 'Les Miasmes sont des êtres nés de la fusion avec des parasites, des moisissures et des maladies. Leur corps en décomposition est une arme, une contagion qu\'ils contrôlent. Ils vivent dans un état constant de putréfaction, transformant cette souffrance en pouvoir, mais à quel prix ?', 'La souffrance peut-elle être transcendée en force, ou ne fait-elle que révéler notre nature pourrie à l’intérieur ?'),
(6, 'Oubliés', 'Les Oubliés sont des âmes privées de mémoire et d’identité. Ils errent dans l’ombre, dépossédés de leur passé et de leur humanité, en quête d’une vérité qu\'ils ne peuvent plus atteindre.', 'Peut-on encore se définir sans souvenir, ou la mémoire est-elle ce qui fait de nous des êtres ?'),
(7, 'Profanés', 'Les Profanés sont des êtres marqués par des pactes avec des entités obscures, des démons ou des puissances occultes. Leur corps et leur âme portent les cicatrices de ces alliances, et chaque pouvoir qu’ils invoquent les éloigne un peu plus de l’humanité.', 'Faut-il sacrifier son âme pour obtenir la puissance, ou ce sacrifice nous prive-t-il de notre humanité ?'),
(8, 'Résidus', 'Les Résidus sont des âmes déconnectées de leur propre corps, errant entre les mondes. Leur existence est une forme de limbes, où ils n\'ont ni passé, ni futur, et leur être tout entier se dérobe sous le poids de l\'indéfinissable.', 'Peut-on réellement vivre quand l’âme est séparée du corps, ou l’essence même de notre existence disparaît-elle ?'),
(9, 'Cendres', 'Les Cendres sont des êtres nés de la destruction totale, survivants d\'un cataclysme dont personne ne se souvient. Leur chair est marquée par des brûlures indélébiles et leur esprit est constamment en proie à des visions de ce qui fut.', 'Peut-on se reconstruire quand tout ce que l\'on était a été détruit, ou l\'on n\'est qu\'un reste ?'),
(10, 'Hérétiques', 'Les Hérétiques sont des créatures bannies, souvent nées du rejet de leurs origines ou d\'une rébellion contre les anciennes croyances. Leur peau est marquée de symboles interdits, et leur esprit a été fracturé par des vérités trop terribles à comprendre.', 'Faut-il rechercher la vérité à tout prix, même si elle nous dévore ?'),
(11, 'Spectres', 'Les Spectres sont des entités qui flottent entre les plans, leurs corps physiques étant depuis longtemps absents. Ils sont liés à des événements ou des émotions passées, et leur essence est devenue éthérée, évasive.', 'Un être peut-il encore exister sans forme, sans poids, sans impact sur le monde ?'),
(12, 'Larmes', 'Les Larmes sont des êtres nés de la douleur collective, comme des amalgames d\'émotions humaines pures. Leur corps semble se transformer constamment, entre liquide et solide, car ils sont eux-mêmes la douleur qui les a créés.', 'Peut-on guérir sans oublier la souffrance, ou est-ce la souffrance elle-même qui nous façonne ?');

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
(1, 36, 'Obscuritas Noctis', 'Plonge l ennemi dans une nuit noire éternelle, réduisant sa perception et ses attaques pendant 3 tours.', 20, 1, 'reduce_attack(5, 3); reduce_perception(10, 3)'),
(2, 36, 'Pallium desperationis', 'Entoure l ennemi d un voile de désespoir, réduisant son moral et sa résistance pendant 2 tours.', 25, 2, 'reduce_morale(5, 2); reduce_resistance(5, 2)'),
(3, 36, 'Nightmare Weaver', 'Crée une illusion dévastatrice qui fait vivre les plus grandes peurs de la cible, la paralysant brièvement pendant 1 tour.', 30, 3, 'paralyze(1)'),
(4, 37, 'Soul Reaver', 'Extraire l âme d un ennemi pour ajouter temporairement de la mana à l utilisateur pendant 1 tour.', 15, 5, 'gain_mana(20, 1)'),
(5, 37, 'Necrotic Drain', 'Drainer la vie des ennemis autour, leur infligeant des dégâts tout en soignant l utilisateur pendant 2 tours.', 10, 1, 'drain_health(10, 2); heal_user_per_turn(10, 2)'),
(6, 37, 'Death Embrace', 'Invoque une étreinte spectrale qui immobilise la cible et l empêche d utiliser ses capacités pendant 2 tours.', 35, 7, 'paralyze(2);'),
(7, 38, 'Bloodrend Sacrifice', 'L utilisateur sacrifice une partie de sa vie pour infliger de puissants dégâts physiques à un ennemi.', 30, 6, 'sacrifice_health(30); damage(50)'),
(8, 38, 'Sanguine Fury', 'Augmente temporairement la force physique de l utilisateur en échange de sa santé pendant 2 tours.', 35, 7, 'increase_attack(15, 2); sacrifice_health(20)'),
(9, 38, 'Crimson Chain', 'Utilise le sang de la cible pour créer une chaîne magique qui l empêche de se déplacer pendant 1 tour. En contre partie, demande un lancer de dés en initiations', 40, 8, 'bind_target(1)'),
(10, 39, 'Crystal Prison', 'Piège un ennemi dans un cristal maudit, l empêchant de bouger pendant 2 tours.', 30, 6, 'immobilize(2)'),
(11, 39, 'Dark Obsidian', 'Invoque une attaque de cristaux sombres qui frappe tous les ennemis dans la zone d effet.', 35, 7, 'damage(40)'),
(12, 39, 'Soulstone Convergence', 'Puise dans son âme pour augmenter sa puissance magique.', 40, 8, 'soul_recovery(0)'),
(13, 40, 'Infernal Burst', 'Inflige de lourds dégâts de feu sur une zone ciblée, brûlant tous les ennemis à l intérieur pendant 2 tour.', 15, 1, 'damage(4); burst(2)'),
(14, 40, 'Flamecloak', 'Entoure l utilisateur d une flamme protectrice qui inflige des dégâts à quiconque l attaque au corps à corps pendant 3 tours.', 20, 2, 'flame_protection(3)'),
(15, 40, 'Fireball', 'Projette une boule de feu qui explose en infligeant des dégâts massifs à une cible.', 25, 3, 'damage(15)'),
(16, 41, 'Wind Rush', 'Accélère l utilisateur, augmentant sa vitesse de déplacement pendant 3 tours.', 20, 5, 'increase_speed(15, 3)'),
(17, 41, 'Cyclone Strike', 'Crée un vent violent qui projette les ennemis dans la zone, les déséquilibrant pendant 1 tour.', 25, 6, 'knock_back(5, 1)'),
(18, 41, 'Tempest Fury', 'Invoque une tempête dévastatrice qui frappe tous les ennemis dans une large zone pendant 1 tour.', 35, 7, 'damage(70, 1)'),
(19, 42, 'Abyssal Restoration', 'Restaure la santé de l utilisateur en concentrant l énergie abyssale sur lui pendant 2 tours, réduisant sa perception.', 25, 5, 'heal_user(30, 2); reduce_perception(10, 2)'),
(20, 42, 'Voidflare', 'Libère une explosion d énergie de l abîme, aveuglant tous les ennemis dans la zone tout en réduisant leur attaque.', 30, 6, 'blind_target(2); reduce_attack(10, 2)'),
(21, 42, 'Abyssal Barrier', 'Crée un bouclier fait de ténèbres abyssales qui protège l utilisateur contre les attaques physiques et ralentit ses ennemis.', 35, 7, 'shield_user(20, 3); reduce_speed(10, 3)'),
(22, 43, 'Shadow Curse', 'Lance une malédiction qui affaiblit les ennemis, réduisant leur vitesse et leur attaque pendant 2 tours.', 30, 6, 'reduce_attack(5, 2); reduce_speed(5, 2)'),
(23, 43, 'Void Blast', 'Lance une décharge d énergie ténébreuse qui inflige de lourds dégâts magiques pendant 1 tour.', 35, 7, 'damage(60)'),
(24, 43, 'Dark Binding', 'Enchaîne un ennemi dans des chaînes ténébreuses, le ralentissant et l immobilisant partiellement pendant 2 tours.', 40, 8, 'bind_target(1, 2); slow_target(3, 2)'),
(25, 44, 'Poison Touch', 'Envenime les ennemis au contact, infligeant des dégâts continus pendant 2 tours.', 15, 3, 'poison_effect(2, 2)'),
(26, 44, 'Toxic Cloud', 'Crée une nuée toxique qui inflige des dégâts sur la durée aux ennemis dans la zone pendant 2 tours.', 20, 4, 'damage(10)'),
(27, 44, 'Venomous Strike', 'Inflige un coup empoisonné, paralysant l ennemi et réduisant ses capacités de mouvement pendant 2 tours.', 25, 5, 'paralyze(2); reduce_speed(4, 2)'),
(28, 45, 'Arcane Blast', 'Lance une vague d énergie magique qui frappe tous les ennemis dans la zone pendant 1 tour.', 5, 1, 'damage(3)'),
(29, 45, 'Mana Shield', 'Crée un bouclier magique qui protège l utilisateur en absorbant une partie des dégâts pendant 3 tours.', 10, 2, 'mana_shield(20, 3)'),
(30, 45, 'Mana Surge', 'Augmente temporairement la quantité de mana disponible de l utilisateur pendant 2 tours.', 21, 4, 'increase_mana(30, 2)'),
(31, 46, 'Flame Burst', 'Crée une explosion de flammes qui inflige des dégâts dans une petite zone pendant 1 tour.', 30, 7, 'damage(20)'),
(32, 46, 'Fire Wave', 'Projette une vague de feu, infligeant des dégâts à tous les ennemis dans sa trajectoire pendant 1 tour.', 35, 8, 'damage(40)'),
(33, 46, 'Inferno', 'Provoque un gigantesque incendie dans une large zone, brûlant tous les ennemis dedans pendant 2 tours.', 45, 9, 'damage(60)'),
(34, 47, 'Gust of Wind', 'Crée une bourrasque qui repousse les ennemis et déséquilibre ceux qui sont proches pendant 1 tour.', 25, 5, 'knock_back(5, 1)'),
(35, 47, 'Stormcall', 'Invoque une tempête violente qui frappe tous les ennemis avec des éclairs pendant 2 tours.', 40, 8, 'damage(50)'),
(36, 47, 'Whirlwind', 'Crée un tourbillon qui attire et endommage tous les ennemis dans sa zone d effet pendant 2 tours.', 45, 10, 'damage(30); pull_enemies(2)'),
(37, 48, 'Gravity Well', 'Crée une zone de gravité intense qui ralentit et attire tous les ennemis au centre pendant 2 tours.', 30, 7, 'slow_target(5, 2); pull_enemies(2)'),
(38, 48, 'Space Rift', 'Ouvre une distorsion spatiale qui fait apparaître des éclats d énergie, infligeant des dégâts à tous ceux qui se trouvent à proximité pendant 1 tour.', 40, 9, 'damage(40)'),
(39, 48, 'Time Slow', 'Ralentit le temps dans une zone pour toutes les cibles à l intérieur, réduisant leur vitesse d attaque et de déplacement pendant 2 tours.', 35, 8, 'slow_target(5, 2); reduce_attack(5, 2)'),
(40, 49, 'Sacred Flame', 'Invoque une flamme sacrée qui soigne le lanceur et inflige des dégâts aux ennemis pendant 2 tours.', 30, 6, 'heal_user(30, 2); damage(20)'),
(41, 49, 'Divine Shield', 'Crée un bouclier divin qui protège l utilisateur ou un allié des dégâts magiques et physiques pendant 3 tours.', 40, 8, 'shield_target(50, 3)'),
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
(22, 5, 6, 0, 4),
(27, 1, 3, 4, 1),
(34, 1, 5, 0, 5),
(35, 1, 1, 1, 0),
(54, 1, 4, 4, 0),
(55, 1, 1, 2, 0),
(56, 1, 6, 5, 0),
(57, 1, 3, 3, 1),
(66, 1, 3, 3, 1),
(67, 1, 6, 5, 0),
(72, 1, 8, 4, 1),
(73, 1, 4, 2, 3),
(78, 1, 7, 3, 2),
(79, 1, 6, 5, 0),
(84, 1, 12, 6, 0),
(85, 1, 10, 7, 1);

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
-- Index pour la table `Chapter`
--
ALTER TABLE `Chapter`
  ADD PRIMARY KEY (`id`);

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
  ADD KEY `related_treasure_id` (`related_treasure_id`),
  ADD KEY `fk_event_related_npc` (`related_npc_id`);

--
-- Index pour la table `Hero`
--
ALTER TABLE `Hero`
  ADD PRIMARY KEY (`id`),
  ADD KEY `race_id` (`race_id`),
  ADD KEY `class_id` (`class_id`);

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
-- Index pour la table `NPC`
--
ALTER TABLE `NPC`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `NPC_Dialogue`
--
ALTER TABLE `NPC_Dialogue`
  ADD PRIMARY KEY (`id_npc`,`id_dialogue`);

--
-- Index pour la table `Race`
--
ALTER TABLE `Race`
  ADD PRIMARY KEY (`id`);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT pour la table `Chapter`
--
ALTER TABLE `Chapter`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT pour la table `Class`
--
ALTER TABLE `Class`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT pour la table `Hero`
--
ALTER TABLE `Hero`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT pour la table `Hero_Story`
--
ALTER TABLE `Hero_Story`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=76;

--
-- AUTO_INCREMENT pour la table `Inventory`
--
ALTER TABLE `Inventory`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=474;

--
-- AUTO_INCREMENT pour la table `Items`
--
ALTER TABLE `Items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=89;

--
-- AUTO_INCREMENT pour la table `Links`
--
ALTER TABLE `Links`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=66;

--
-- AUTO_INCREMENT pour la table `NPC`
--
ALTER TABLE `NPC`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

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
  ADD CONSTRAINT `Event_ibfk_3` FOREIGN KEY (`related_treasure_id`) REFERENCES `Treasure` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_event_related_npc` FOREIGN KEY (`related_npc_id`) REFERENCES `NPC` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Contraintes pour la table `Hero`
--
ALTER TABLE `Hero`
  ADD CONSTRAINT `Hero_ibfk_1` FOREIGN KEY (`id`) REFERENCES `Account` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
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
-- Contraintes pour la table `Miscellaneous`
--
ALTER TABLE `Miscellaneous`
  ADD CONSTRAINT `Miscellaneous_ibfk_1` FOREIGN KEY (`item_id`) REFERENCES `Items` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `NPC_Dialogue`
--
ALTER TABLE `NPC_Dialogue`
  ADD CONSTRAINT `NPC_Dialogue_ibfk_1` FOREIGN KEY (`id_npc`) REFERENCES `NPC` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

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
