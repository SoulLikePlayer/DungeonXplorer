-- phpMyAdmin SQL Dump
-- version 5.2.1deb1
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost:3306
-- Généré le : mar. 17 déc. 2024 à 13:32
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
  `first_name` varchar(100) DEFAULT '',
  `last_name` varchar(100) DEFAULT '',
  `is_admin` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `Account`
--

INSERT INTO `Account` (`id`, `username`, `password`, `email`, `is_admin`) VALUES
(15, 'Admin', '$2y$10$fsdb1N03Tyk7FeMlXZ1s0e5t24wvE23LsiGNHaWdJM7olJpBUtQSe', 'admin@admin.admin', 1),
(51, 'testMiasme', '$2y$10$A/o/clIWKi7fTDPFqYuqC.ltpaEhqyRF4.YTEKZV8Hyuu5pTC0qRC', 'test@gmail.com', 0),
(52, 'testMage', '$2y$10$/2WwHJ7DHEc5YT57G9mjvugtetFwdbM/Gn9HsaO0JQh5cUIvHR2Rq', 'testM@gmail.com', 0);

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
(58, 15, 5, 'head'),
(59, 25, 15, 'body'),
(60, 20, 10, 'legs'),
(61, 10, 3, 'hands'),
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
(1, 'Le ciel est lourd ce soir sur le village du Val Perdu, dissimulé entre les montagnes. La petite taverne, dernier refuge avant l\'immense forêt, est étrangement calme quand le bourgmestre s\'approche de vous. Homme d\'apparence usée par les années et les soucis, il vous adresse un regard désespéré. \"Ma fille… elle a disparu dans la forêt. Personne n\'a osé la chercher… sauf vous, peut-être ? On raconte qu\'un sorcier vit dans un château en ruines, caché au cœur des bois. Depuis des mois, des jeunes filles disparaissent… J\'ai besoin de vous pour la retrouver.\" Vous sentez le poids de la mission qui s\'annonce, et un frisson parcourt votre échine. Bientôt, la forêt s\'ouvre devant vous, sombre et menaçante. La quête commence.', 'Introduction de votre mort'),
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
(23, 'Dès votre sortie dans la forêt, un Miasme corrompue se jette sur vous pour essayez de vous tuer. Attirez vous les miasme ou seulement une coincidence ?', 'La lois de l\'attraction miasmique'),
(24, 'Vous vous insérez dans cette forêt, une forêt bien plus calme que à votre époque, on dirait qu\'il n\'y a pas la même magie dans l\'air, cette forêt semble plus... détruite et ravagé par du sang et de la corruption, excepter carnifex, aucune créature n\'aurait pu avoir cette puissance.', 'Les ravages dans la forêt'),
(25, 'Après votre fuite des plus remarquablement lâche, vous vous insérez profondément dans la forêt ne remarquant en rien les ravage et le silence planant.', '\"incroyable\" fuite'),
(26, 'Dans la forêt, vous arrivez devant une structure.... une crypte ancienne ! cependant... en commençant a y aller, vous vous retrouver devant un miasme... rouge, des griffes acerez et rouge vif faisant couler un liquide sanguinaire... c\'est yeux d\'une couleur horrifique, il vous charge !', 'Le Miasme au goût du sang'),
(27, 'Bravo !', 'Victoire contre le miasme carnifex'),
(28, 'fuite ?', 'fuite contre le miasme carnifex');

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
(112, 21, 'merchent', NULL, NULL, NULL, NULL, 5),
(113, 23, 'combat', NULL, 4, NULL, NULL, NULL),
(114, 26, 'combat', NULL, 5, NULL, NULL, NULL);

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
  `gold` float NOT NULL DEFAULT 1000,
  `talent_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `Hero`
--

INSERT INTO `Hero` (`id`, `lastname`, `class_id`, `race_id`, `biography`, `pv_max`, `mana_max`, `strength`, `initiative`, `xp`, `current_level`, `poids_max`, `nb_items_max`, `firstname`, `gold`, `talent_id`) VALUES
(51, 'miasme', 2, 5, '', 15, 30, 3, 4, 0, 1, 100, 20, 'test', 1000, 6),
(52, 'Caria', 2, 12, '', 20, 180, 3, 29, 214, 6, 100, 20, 'Rennala', 410, 14);

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
(51, 19, 20, NULL, 21),
(52, 19, 20, NULL, 21);

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
(88, 50, 56, 14, '17'),
(89, 47, 17, 70, '16'),
(91, 52, 20, 100, '26'),
(92, 53, 17, 90, '26');

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
(51, 22, 35),
(52, 22, 35);

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
(632, 51, 19, 1, 1),
(633, 51, 20, 1, 1),
(634, 51, 21, 1, 1),
(635, 51, 22, 1, 1),
(636, 51, 23, 1, 1),
(637, 51, 35, 1, 1),
(638, 51, 40, 1, 1),
(639, 51, 45, 1, 1),
(640, 52, 19, 1, 1),
(641, 52, 20, 1, 1),
(642, 52, 21, 1, 1),
(643, 52, 22, 1, 1),
(644, 52, 23, 1, 1),
(645, 52, 35, 1, 1),
(646, 52, 40, 1, 1),
(647, 52, 45, 1, 1),
(650, 52, 7, 0, 3),
(651, 52, 8, 0, 3),
(652, 52, 2, 0, 1),
(653, 52, 33, 0, 6),
(654, 52, 86, 0, 2),
(655, 52, 87, 0, 1);

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
  `level` int(99) NOT NULL,
  `required_xp` int(99) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `Level`
--

INSERT INTO `Level` (`id`, `level`, `required_xp`) VALUES
(1090, 2, 400),
(1091, 3, 440),
(1092, 4, 484),
(1093, 5, 532),
(1094, 6, 586),
(1095, 7, 644),
(1096, 8, 709),
(1097, 9, 779),
(1098, 10, 857),
(1099, 11, 943),
(1100, 12, 1037),
(1101, 13, 1141),
(1102, 14, 1255),
(1103, 15, 1381),
(1104, 16, 1519),
(1105, 17, 1671),
(1106, 18, 1838),
(1107, 19, 2022),
(1108, 20, 2224),
(1109, 21, 2446),
(1110, 22, 2691),
(1111, 23, 2960),
(1112, 24, 3256),
(1113, 25, 3582),
(1114, 26, 3940),
(1115, 27, 4334),
(1116, 28, 4767),
(1117, 29, 5244),
(1118, 30, 5768),
(1119, 31, 6345),
(1120, 32, 6980),
(1121, 33, 7678),
(1122, 34, 8446),
(1123, 35, 9290),
(1124, 36, 10219),
(1125, 37, 11241),
(1126, 38, 12365),
(1127, 39, 13602),
(1128, 40, 14962),
(1129, 41, 16458),
(1130, 42, 18104),
(1131, 43, 19914),
(1132, 44, 21905),
(1133, 45, 24096),
(1134, 46, 26506),
(1135, 47, 29156),
(1136, 48, 32072),
(1137, 49, 35279),
(1138, 50, 38807),
(1139, 51, 42688),
(1140, 52, 46956),
(1141, 53, 51652),
(1142, 54, 56817),
(1143, 55, 62499),
(1144, 56, 68749),
(1145, 57, 75624),
(1146, 58, 83186),
(1147, 59, 91505),
(1148, 60, 100655),
(1149, 61, 110721),
(1150, 62, 121793),
(1151, 63, 133972),
(1152, 64, 147369),
(1153, 65, 162106),
(1154, 66, 178317),
(1155, 67, 196148),
(1156, 68, 215763),
(1157, 69, 237339),
(1158, 70, 261073),
(1159, 71, 287181),
(1160, 72, 315899),
(1161, 73, 347489),
(1162, 74, 382238),
(1163, 75, 420461),
(1164, 76, 462507),
(1165, 77, 508758),
(1166, 78, 559634),
(1167, 79, 615597),
(1168, 80, 677157),
(1169, 81, 744873),
(1170, 82, 819360),
(1171, 83, 901296),
(1172, 84, 991426),
(1173, 85, 1090568),
(1174, 86, 1199625),
(1175, 87, 1319588),
(1176, 88, 1451546),
(1177, 89, 1596701),
(1178, 90, 1756371),
(1179, 91, 1932008),
(1180, 92, 2125209),
(1181, 93, 2337730),
(1182, 94, 2571503),
(1183, 95, 2828653),
(1184, 96, 3111519),
(1185, 97, 3422670),
(1186, 98, 3764937),
(1187, 99, 4141431),
(1188, 100, 4555574);

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
  `initiative_bonus` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `LevelBonus`
--

INSERT INTO `LevelBonus` (`id`, `class_id`, `pv_bonus`, `mana_bonus`, `strength_bonus`, `initiative_bonus`) VALUES
(1, 1, 20, 0, 10, 0),
(2, 2, 1, 30, 0, 5),
(3, 3, 5, 5, 1, 20),
(4, 5, 15, 1, 2, 1),
(5, 6, 5, 27, 0, 1),
(6, 7, 9, 1, 2, 17),
(7, 8, 7, 10, 0, 7),
(8, 9, 5, 25, 1, 1),
(9, 10, 10, 10, 10, 10);

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
(64, 22, 20, NULL),
(65, 21, 20, NULL),
(66, 20, 23, 'Aller dans la forêt'),
(67, 23, 24, NULL),
(68, 23, 10, NULL),
(69, 23, 25, NULL),
(70, 24, 26, 'continuer sa route'),
(71, 25, 26, 'continuer de fuir'),
(72, 26, 27, NULL),
(73, 26, 10, NULL),
(74, 26, 28, NULL);

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
(7, 88, 1, 4, 65),
(8, 38, 1, 5, 10);

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
(4, 500, 7),
(5, 100, 1);

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
-- Structure de la table `Merchant_Racisme`
--

CREATE TABLE `Merchant_Racisme` (
  `npc_id` int(11) NOT NULL,
  `race_id` int(11) NOT NULL,
  `refus_vente_achat` tinyint(1) NOT NULL DEFAULT 0,
  `multiplicateur` decimal(5,2) NOT NULL DEFAULT 1.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `Merchant_Racisme`
--

INSERT INTO `Merchant_Racisme` (`npc_id`, `race_id`, `refus_vente_achat`, `multiplicateur`) VALUES
(4, 5, 1, 1.00),
(5, 5, 0, 5.00);

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
  `xp` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `Monster`
--

INSERT INTO `Monster` (`id`, `name`, `pv`, `mana`, `initiative`, `strength`, `xp`) VALUES
(1, 'Loup Noir', 15, 0, 6, 7, 50),
(2, 'Sanglier Enragé', 5, 0, 4, 8, 70),
(3, 'Gor\'huga', 50, 100, 50, 50, 700),
(4, 'Miasme Corrompu', 10, 50, 2, 5, 400),
(5, 'Miasme Carnifex', 15, 60, 5, 8, 415);

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

--
-- Déchargement des données de la table `Monster_Attack`
--

INSERT INTO `Monster_Attack` (`id`, `monster_id`, `name`, `effect`, `effect_function`, `mana_cost`, `is_physical`) VALUES
(6, 1, 'Croc Sauvage', 'Inflige des dégâts physiques puissants avec les crocs.', NULL, 0, 1),
(7, 1, 'Hurlement Terrifiant', 'Réduit l initiative et la force de l\'ennemi pendant 2 tours.', 'reduce_initiative(5, 2); reduce_strength(3, 2)', 0, 0),
(8, 2, 'Charge Furieuse', 'Charge violemment l ennemi, infligeant des dégâts physiques importants.', NULL, 0, 1),
(9, 3, 'Poing Dévastateur', 'Une attaque physique destructrice qui frappe violemment l ennemi.', NULL, 0, 1),
(10, 3, 'Souffle de Chaos', 'Libère une vague de chaos magique, infligeant des dégâts à plusieurs cibles.', 'burst(5)', 0, 1),
(11, 4, 'Nuée Toxique', 'Infecte l ennemi avec un gaz nocif, réduisant sa vie chaque tour pendant 3 tours.', 'poison_effect(1, 3)', 5, 0),
(12, 4, 'Impact Fétide', 'Attaque physique utilisant des émanations toxiques pour infliger des dégâts.', 'poison_effect(1, 1)', 0, 1),
(13, 5, 'Drain de Sang', 'Absorbe la vie de la cible pour soigner le lanceur.', 'drain_health(10, 1);', 5, 0),
(14, 5, 'Saignée Spectrale', 'Inflige des dégâts à l aide d une attaque basée sur le sang.', NULL, 0, 1);

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

--
-- Déchargement des données de la table `PlayerSessions`
--

INSERT INTO `PlayerSessions` (`id`, `player_id`, `session_start`, `session_end`) VALUES
(16, 47, '2024-12-16 14:03:03', '2024-12-16 14:03:14'),
(17, 47, '2024-12-16 14:08:12', '2024-12-16 14:24:00'),
(19, 50, '2024-12-16 20:11:02', '2024-12-16 20:11:31'),
(20, 47, '2024-12-16 20:11:37', NULL),
(21, 50, '2024-12-17 01:28:54', '2024-12-17 01:29:50'),
(22, 53, '2024-12-17 09:57:31', NULL),
(23, 53, '2024-12-17 10:01:29', '2024-12-17 10:25:16'),
(24, 52, '2024-12-17 10:41:10', NULL);

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
-- Structure de la table `Racisme`
--

CREATE TABLE `Racisme` (
  `npc_id` int(11) NOT NULL,
  `race_id` int(11) NOT NULL,
  `colère` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `Racisme`
--

INSERT INTO `Racisme` (`npc_id`, `race_id`, `colère`) VALUES
(4, 5, '\"Vous êtes un Miasme, n\'est-ce pas ? Après tout ce que vous avez fait à mon village, je n\'ai rien à vous dire ! Vous avez massacré mes amis, tué des innocents... Vous ne méritez que le mépris !\"'),
(5, 5, '\"Vous êtes un Miasme... Je n\'aime pas ce que vous êtes, mais... si vous avez besoin d\'un outil ou d\'une arme, je peux vous aider. Cependant, cela vous coûtera cher, très cher !\"');

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
(14, 40, 'Flamecloak', 'Entoure l utilisateur d une flamme protectrice qui inflige des dégâts à quiconque l attaque au corps à corps pendant 3 tours.', 20, 2, 'flame_protection(4)'),
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
-- Structure de la table `Talent`
--

CREATE TABLE `Talent` (
  `id` int(11) NOT NULL,
  `name` text DEFAULT NULL,
  `description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `Talent`
--

INSERT INTO `Talent` (`id`, `name`, `description`) VALUES
(5, 'Chaire putrifiée', 'Sous l’effet de la décomposition, chaque coup porté permet de récupérer des fragments de l’énergie vitale qui vous échappent. Vous gagnez 2 PV à chaque attaque, mais les potions de soin et de mana deviennent des poisons pour votre corps dégradé, leur efficacité étant réduite de moitié. Cette malédiction transforme votre chair en une arme, mais au prix d’une dégradation permanente.'),
(6, 'Puissance du Poison', 'Véritable maître de la corruption, vous êtes en symbiose avec le poison qui coule dans vos veines. Les effets des toxines que vous infligez sont doublés en intensité et en durée. Cependant, à chaque poison lancé, vous ressentez sa morsure dans votre propre chair, et plus le poison est violent, plus vous ressentez une part de sa souffrance en vous.'),
(7, 'Flamme Profanée', 'Le Codex Inferna vous accorde la puissance du feu infernal, doublant l’intensité de vos sorts. Cependant, cette malédiction porte en elle une répercussion terrible : vous subissez la fureur de votre dieu déchu, et chaque attaque magique que vous infligez est renvoyée avec la même violence contre vous. Vous incarnez le feu, mais à quel prix ?'),
(8, 'Puissance Fragile', 'Les vents de la fragilité soufflent sur votre âme et votre corps. Vous gagnez 5 de force, mais cette force est une double lame : vous subissez les mêmes dégâts que vous infligez. Votre puissance n’est qu’illusion, un masque cachant la vérité de votre faiblesse éternelle.'),
(9, 'Ombre du Passé', 'Vous êtes un spectre du temps, vos souvenirs disparus vous permettent de vous faufiler entre les ombres. Vous devenez intangible et plus difficile à atteindre, mais cette absence de passé vous empêche de frapper avec certitude. Chaque tentative d’attaque semble glisser au-delà de votre compréhension. Le vide du souvenir vous isole du monde.'),
(10, 'Souffrance Partagée', 'Les Profanés connaissent la douleur, et ils choisissent de la partager. En infligeant des blessures à leurs ennemis, ces derniers ressentent la même souffrance. Mais cette puissance est un fardeau. Chaque souffrance partagée vous fragilise, et plus vous infligez de douleur, plus vous sentez votre propre esprit vaciller sous le poids de cette malédiction.'),
(11, 'Âme Dissociée', 'Les Résidus ont quitté leur corps pour errer dans les limbes. Vous êtes capables d’esquiver des attaques avec une aisance surnaturelle, mais chaque fois que vous quittez votre forme physique, vous perdez un peu de votre lien avec la réalité. À chaque esquive, un peu de votre âme se dissipe, et votre pouvoir devient plus fragile.'),
(12, 'Pacte Démoniaque', 'Les Hérétiques ont payé le prix du savoir interdit. Votre pacte avec des forces démoniaques vous accorde des pouvoirs prodigieux, doublant l’intensité de vos attaques. Mais chaque incantation vous consume lentement, et chaque fois que vous puisez dans ce pouvoir, vous vous éloignez de l’humanité qui vous reste. La vérité dévastatrice des pactes passés devient votre fardeau.'),
(13, 'Invisible au Vent', 'Les Spectres sont des créatures d’outre-monde, capables de se dissiper dans l’air comme une brume. Vous devenez invisible aux yeux de vos ennemis, mais ce pouvoir a un prix. Chaque déplacement invisible vous fragilise, car plus vous vous éloignez de votre forme corporelle, plus votre esprit vacille et se dissipe dans le néant.'),
(14, 'Larmes de Guérison', 'Les Larmes, nées du chagrin collectif, détiennent la capacité unique de soigner à travers la douleur. Vous pouvez guérir les blessures des autres, mais chaque soin absorbe une partie de votre propre douleur, vous rendant plus faible à chaque acte de guérison. Votre corps est à la fois le baume et la plaie, guérissant sans jamais pouvoir échapper à la souffrance.'),
(15, 'Rugissement Glacial', 'Les Boréals peuvent libérer un cri glacé qui protège leur corps et repousse leurs ennemis. Toutefois, ce talent les rend plus lents, et leur mobilité est réduite en raison de la froideur qui les envahit.'),
(16, 'Sang sacrificielle', 'Les Sang-de-Sang tirent leur pouvoir directement du flot sanguin. En utilisant leur propre sang, ils peuvent doubler leurs dégâts, mais à chaque utilisation, ils perdent une partie de leur propre vitalité, réduisant leur maximum de PV. Plus ils exploitent leur propre essence, plus leur corps devient faible et vulnérable.');

-- --------------------------------------------------------

--
-- Structure de la table `Talent_Race`
--

CREATE TABLE `Talent_Race` (
  `race_id` int(11) DEFAULT NULL,
  `talent_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `Talent_Race`
--

INSERT INTO `Talent_Race` (`race_id`, `talent_id`) VALUES
(5, 5),
(5, 6),
(2, 8),
(3, 15),
(6, 9),
(7, 10),
(8, 11),
(9, 7),
(4, 16),
(10, 12),
(11, 13),
(12, 14);

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
  ADD KEY `class_id` (`class_id`),
  ADD KEY `Jero_ibfk_4` (`talent_id`);

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
  ADD PRIMARY KEY (`id`);

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
  ADD PRIMARY KEY (`id_npc`,`id_dialogue`);

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
  ADD PRIMARY KEY (`id`);

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
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `Account`
--
ALTER TABLE `Account`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=54;

--
-- AUTO_INCREMENT pour la table `Chapter`
--
ALTER TABLE `Chapter`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT pour la table `Class`
--
ALTER TABLE `Class`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT pour la table `Hero`
--
ALTER TABLE `Hero`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=54;

--
-- AUTO_INCREMENT pour la table `Hero_Story`
--
ALTER TABLE `Hero_Story`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=93;

--
-- AUTO_INCREMENT pour la table `Inventory`
--
ALTER TABLE `Inventory`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=666;

--
-- AUTO_INCREMENT pour la table `Items`
--
ALTER TABLE `Items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=89;

--
-- AUTO_INCREMENT pour la table `Level`
--
ALTER TABLE `Level`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1189;

--
-- AUTO_INCREMENT pour la table `LevelBonus`
--
ALTER TABLE `LevelBonus`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT pour la table `Links`
--
ALTER TABLE `Links`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=75;

--
-- AUTO_INCREMENT pour la table `Monster_Attack`
--
ALTER TABLE `Monster_Attack`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT pour la table `NPC`
--
ALTER TABLE `NPC`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT pour la table `Talent`
--
ALTER TABLE `Talent`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

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
  ADD CONSTRAINT `NPC_Dialogue_ibfk_1` FOREIGN KEY (`id_npc`) REFERENCES `NPC` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

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
  ADD CONSTRAINT `PlayerSessions_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `Hero` (`id`);

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
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
