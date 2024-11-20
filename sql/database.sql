--
-- Structure de la table `Account`
--

CREATE TABLE `Account` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(100) NOT NULL,
  `hero_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
  `event_type` enum('exploration','combat','dungeon','npc_interaction','treasure','puzzle','death') NOT NULL,
  `description` text DEFAULT NULL,
  `related_monster_id` int(11) DEFAULT NULL,
  `related_treasure_id` int(11) DEFAULT NULL,
  `related_puzzle` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


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
            (NEW.id, 13),  (NEW.id, 14),  (NEW.id, 15), (NEW.id, 16), (NEW.id, 17), (NEW.id, 34);

        -- Ajout des armures associées
        INSERT INTO Hero_Armor (hero_id, helmet_id, armor_id, greaves_id) VALUES 
            (NEW.id, 13, 14, 15);
        
    ELSEIF NEW.class_id = 2 THEN
        -- Magicien : arme principale et secondaire par défaut
        INSERT INTO Hero_Weapons (hero_id, primary_weapon_id, secondary_weapon_id)
        VALUES (NEW.id, 22, 35);

        -- Ajout des objets dans l'inventaire
        INSERT INTO Inventory (hero_id, item_id) VALUES 
            (NEW.id, 19), (NEW.id, 20), (NEW.id, 21), (NEW.id, 22),  (NEW.id, 23), (NEW.id, 35);

        -- Ajout des armures associées
        INSERT INTO Hero_Armor (hero_id, helmet_id, armor_id, greaves_id) VALUES 
            (NEW.id, 19, 20, NULL);
        
    ELSEIF NEW.class_id = 3 THEN
        -- Voleur : arme principale et secondaire par défaut
        INSERT INTO Hero_Weapons (hero_id, primary_weapon_id, secondary_weapon_id)
        VALUES (NEW.id, 3, 35);

        -- Ajout des objets dans l'inventaire
        INSERT INTO Inventory (hero_id, item_id) VALUES 
            (NEW.id, 24), (NEW.id, 25), (NEW.id, 26), (NEW.id, 27), (NEW.id, 28), (NEW.id, 35);

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

-- --------------------------------------------------------

--
-- Structure de la table `Inventory`
--

CREATE TABLE `Inventory` (
  `id` int(11) NOT NULL,
  `hero_id` int(11) DEFAULT NULL,
  `item_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
  `item_type` enum('weapon','armor','consumable','miscellaneous') NOT NULL,
  `gold_value` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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


-- --------------------------------------------------------

--
-- Structure de la table `Loot`
--

CREATE TABLE `Loot` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `item_id` int(11) DEFAULT NULL,
  `quantity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `Miscellaneous`
--

CREATE TABLE `Miscellaneous` (
  `item_id` int(11) NOT NULL,
  `special_property` varchar(100) DEFAULT NULL
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
  `attack` text DEFAULT NULL,
  `loot_id` int(11) DEFAULT NULL,
  `xp` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
  `damage` int(11) NOT NULL,
  `porter` int(11) NOT NULL,
  `weight` int(11) NOT NULL
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

--
--Table Spell
--

CREATE TABLE Spell (
  id int(11) NOT NULL,
  name varchar(50) NOT NULL,
  description text DEFAULT NULL,
  mana_cost int(11) NOT NULL,
  power int(11) NOT NULL,
  spell_type enum('attack','defense','utility') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
--Trigger
--

DELIMITER $$
CREATE TRIGGER check_spell_uniqueness_before_insert BEFORE INSERT ON Spell FOR EACH ROW BEGIN
    DECLARE item_count INT;

    -- Vérifier si l'item_id existe dans Weapon
    SELECT COUNT(*) INTO item_count FROM Weapon WHERE item_id = NEW.id;
    IF item_count > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'L''id existe déjà dans Weapon, il ne peut pas être dans Spell.';
    END IF;

    -- Vérifier si l'item_id existe dans Armor
    SELECT COUNT(*) INTO item_count FROM Armor WHERE item_id = NEW.id;
    IF item_count > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'L''id existe déjà dans Armor, il ne peut pas être dans Spell.';
    END IF;

    -- Vérifier si l'item_id existe dans Consumable
    SELECT COUNT(*) INTO item_count FROM Consumable WHERE item_id = NEW.id;
    IF item_count > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'L''id existe déjà dans Consumable, il ne peut pas être dans Spell.';
    END IF;

    -- Vérifier si l'item_id existe dans Miscellaneous
    SELECT COUNT(*) INTO item_count FROM Miscellaneous WHERE item_id = NEW.id;
    IF item_count > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'L''id existe déjà dans Miscellaneous, il ne peut pas être dans Spell.';
    END IF;
END
$$
DELIMITER ;


--
--Hero_Spell
--

CREATE TABLE Hero_Spell (
  hero_id int(11) NOT NULL,
  spell_id int(11) NOT NULL,
  PRIMARY KEY (hero_id, spell_id),
  FOREIGN KEY (hero_id) REFERENCES Hero (id) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (spell_id) REFERENCES Spell (id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


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
  ADD KEY `fk_loot_item` (`item_id`);

--
-- Index pour la table `Miscellaneous`
--
ALTER TABLE `Miscellaneous`
  ADD PRIMARY KEY (`item_id`);

--
-- Index pour la table `Monster`
--
ALTER TABLE `Monster`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_monster_loot` (`loot_id`);

--
-- Index pour la table `Quest`
--
ALTER TABLE `Quest`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_quest_hero` (`hero_id`),
  ADD KEY `fk_quest_chapter` (`chapter_id`);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=74;

--
-- AUTO_INCREMENT pour la table `Level`
--
ALTER TABLE `Level`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `Links`
--
ALTER TABLE `Links`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT pour la table `Loot`
--
ALTER TABLE `Loot`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

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
  ADD CONSTRAINT `fk_loot_item` FOREIGN KEY (`item_id`) REFERENCES `Items` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `Miscellaneous`
--
ALTER TABLE `Miscellaneous`
  ADD CONSTRAINT `Miscellaneous_ibfk_1` FOREIGN KEY (`item_id`) REFERENCES `Items` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `Monster`
--
ALTER TABLE `Monster`
  ADD CONSTRAINT `fk_monster_loot` FOREIGN KEY (`loot_id`) REFERENCES `Loot` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Contraintes pour la table `Quest`
--
ALTER TABLE `Quest`
  ADD CONSTRAINT `fk_quest_chapter` FOREIGN KEY (`chapter_id`) REFERENCES `Chapter` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_quest_hero` FOREIGN KEY (`hero_id`) REFERENCES `Hero` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

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