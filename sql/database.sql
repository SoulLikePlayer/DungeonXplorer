-- Création de la table Account (Comptes utilisateurs)
CREATE TABLE Account (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL,
    hero_id INT
);

-- Création de la table Class (Classe des personnages)
CREATE TABLE Class (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    description TEXT,
    base_pv INT NOT NULL,
    base_mana INT NOT NULL,
    strength INT NOT NULL,
    initiative INT NOT NULL,
    max_items INT NOT NULL
);

-- Création de la table Items (Objets disponibles dans le jeu)
CREATE TABLE Items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    description TEXT
);

-- Création de la table Loot (Butins des monstres)
CREATE TABLE Loot (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    item_id INT,
    quantity INT NOT NULL
);

-- Création de la table Treasure (Trésors dans les chapitres)
CREATE TABLE Treasure (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    item_id INT,
    quantity INT NOT NULL
);

-- Création de la table Monster (Monstres rencontrés dans l'histoire)
CREATE TABLE Monster (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    pv INT NOT NULL,
    mana INT,
    initiative INT NOT NULL,
    strength INT NOT NULL,
    attack TEXT,
    loot_id INT,
    xp INT NOT NULL
);

-- Création de la table Hero (Personnage principal)
CREATE TABLE Hero (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    class_id INT,
    image VARCHAR(255),
    biography TEXT,
    pv INT NOT NULL,
    mana INT NOT NULL,
    strength INT NOT NULL,
    initiative INT NOT NULL,
    armor VARCHAR(50),
    primary_weapon VARCHAR(50),
    secondary_weapon VARCHAR(50),
    shield VARCHAR(50),
    spell_list TEXT,
    xp INT NOT NULL,
    current_level INT DEFAULT 1
);

-- Création de la table Level (Niveaux de progression des classes)
CREATE TABLE Level (
    id INT AUTO_INCREMENT PRIMARY KEY,
    class_id INT,
    level INT NOT NULL,
    required_xp INT NOT NULL,
    pv_bonus INT NOT NULL,
    mana_bonus INT NOT NULL,
    strength_bonus INT NOT NULL,
    initiative_bonus INT NOT NULL
);

-- Création de la table Chapter (Chapitres de l'histoire)
CREATE TABLE Chapter (
    id INT AUTO_INCREMENT PRIMARY KEY,
    content TEXT NOT NULL,
    image VARCHAR(255),
    treasure_id INT
);

-- Création de la table Encounter (Rencontres dans les chapitres)
CREATE TABLE Encounter (
    id INT AUTO_INCREMENT PRIMARY KEY,
    chapter_id INT,
    monster_id INT
);

-- Table intermédiaire pour l'inventaire des héros (Hero - Items)
CREATE TABLE Inventory (
    id INT AUTO_INCREMENT PRIMARY KEY,
    hero_id INT,
    item_id INT
);

-- Création de la table Links (Liens entre chapitres)
CREATE TABLE Links (
    id INT AUTO_INCREMENT PRIMARY KEY,
    chapter_id INT,
    next_chapter_id INT,
    description TEXT
);

-- Table intermédiaire pour les trésors dans les chapitres (Chapter - Items)
CREATE TABLE Chapter_Treasure (
    id INT AUTO_INCREMENT PRIMARY KEY,
    chapter_id INT,
    item_id INT
);

-- Table intermédiaire pour les quêtes des héros (Hero - Chapter)
CREATE TABLE Quest (
    id INT AUTO_INCREMENT PRIMARY KEY,
    hero_id INT,
    chapter_id INT
);

-- Ajout des contraintes après la création des tables

-- Contraintes pour la table Account
ALTER TABLE Account
ADD CONSTRAINT uq_username UNIQUE (username),
ADD CONSTRAINT uq_email UNIQUE (email),
ADD CONSTRAINT fk_account_hero FOREIGN KEY (hero_id) REFERENCES Hero(id) ON DELETE SET NULL ON UPDATE CASCADE;

-- Contraintes pour la table Loot
ALTER TABLE Loot
ADD CONSTRAINT fk_loot_item FOREIGN KEY (item_id) REFERENCES Items(id) ON DELETE CASCADE ON UPDATE CASCADE;

-- Contraintes pour la table Treasure
ALTER TABLE Treasure
ADD CONSTRAINT fk_treasure_item FOREIGN KEY (item_id) REFERENCES Items(id) ON DELETE CASCADE ON UPDATE CASCADE;

-- Contraintes pour la table Monster
ALTER TABLE Monster
ADD CONSTRAINT fk_monster_loot FOREIGN KEY (loot_id) REFERENCES Loot(id) ON DELETE SET NULL ON UPDATE CASCADE;

-- Contraintes pour la table Hero
ALTER TABLE Hero
ADD CONSTRAINT fk_hero_class FOREIGN KEY (class_id) REFERENCES Class(id) ON DELETE SET NULL ON UPDATE CASCADE;

-- Contraintes pour la table Level
ALTER TABLE Level
ADD CONSTRAINT fk_level_class FOREIGN KEY (class_id) REFERENCES Class(id) ON DELETE CASCADE ON UPDATE CASCADE;

-- Contraintes pour la table Chapter
ALTER TABLE Chapter
ADD CONSTRAINT fk_chapter_treasure FOREIGN KEY (treasure_id) REFERENCES Treasure(id) ON DELETE SET NULL ON UPDATE CASCADE;

-- Contraintes pour la table Encounter
ALTER TABLE Encounter
ADD CONSTRAINT fk_encounter_chapter FOREIGN KEY (chapter_id) REFERENCES Chapter(id) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT fk_encounter_monster FOREIGN KEY (monster_id) REFERENCES Monster(id) ON DELETE CASCADE ON UPDATE CASCADE;

-- Contraintes pour la table Inventory
ALTER TABLE Inventory
ADD CONSTRAINT fk_inventory_hero FOREIGN KEY (hero_id) REFERENCES Hero(id) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT fk_inventory_item FOREIGN KEY (item_id) REFERENCES Items(id) ON DELETE CASCADE ON UPDATE CASCADE;

-- Contraintes pour la table Links
ALTER TABLE Links
ADD CONSTRAINT fk_links_chapter FOREIGN KEY (chapter_id) REFERENCES Chapter(id) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT fk_links_next_chapter FOREIGN KEY (next_chapter_id) REFERENCES Chapter(id) ON DELETE CASCADE ON UPDATE CASCADE;

-- Contraintes pour la table Chapter_Treasure
ALTER TABLE Chapter_Treasure
ADD CONSTRAINT fk_chapter_treasure_chapter FOREIGN KEY (chapter_id) REFERENCES Chapter(id) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT fk_chapter_treasure_item FOREIGN KEY (item_id) REFERENCES Items(id) ON DELETE CASCADE ON UPDATE CASCADE;

-- Contraintes pour la table Quest
ALTER TABLE Quest
ADD CONSTRAINT fk_quest_hero FOREIGN KEY (hero_id) REFERENCES Hero(id) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT fk_quest_chapter FOREIGN KEY (chapter_id) REFERENCES Chapter(id) ON DELETE CASCADE ON UPDATE CASCADE;