-- -----------------------------------------------------
-- BASE DE DONNÉES TIFOSI
-- Script d'insertion des données de test'
-- -----------------------------------------------------
-- Description : Alimentation de la base de données avec les données
--               issues des fichiers Exel fournis (marque, boisson,
--               focaccia, ingredient)
-- -----------------------------------------------------

USE tifosi;

-- -----------------------------------------------------
-- DÉSACTIVATION DES VÉRIFICATIONS (performance)
-- -----------------------------------------------------
SET FOREIGN_KEY_CHECKS = 0;
SET UNIQUE_CHECKS = 0;

-- -----------------------------------------------------
-- NETTOYAGE DES TABLES (pour pouvoir réexécuter le script)
-- -----------------------------------------------------
-- Supression dans l'ordre inverse des dépendances
TRUNCATE TABLE comprend;
TRUNCATE TABLE boisson;
TRUNCATE TABLE marque;
TRUNCATE TABLE ingredient;
TRUNCATE TABLE focaccia;


-- -----------------------------------------------------
-- INSERTION DES MARQUES
-- -----------------------------------------------------
-- Données extraites du fichier marque.xlsx
INSERT INTO marque (id_marque, nom) VALUES
(1, 'Coca-cola'),
(2, 'Cristaline'),
(3, 'Monster'),
(4, 'Pepsico');

-- -----------------------------------------------------
-- INSERTION DES BOISSONS
-- -----------------------------------------------------
-- Données extraites du fichier boisson.xlsx
-- Les boisson sont liées aux marques via id_marque
INSERT INTO boisson (id_boisson, nom, id_marque) VALUES
(1, 'Coca-cola zéro', 1),
(2, 'Coca-col original', 1),
(3, 'Fanta citron', 1),
(4, 'Fanta orange', 1),
(5, 'Capri-sun', 1),
(6, 'Pepsi', 4),
(7, 'Pepsi Max Zéro', 4),
(8, 'Lipton zéro citron', 4),
(9, 'Lipton Peach', 4),
(10, 'Monster energy ultra gold', 3),
(11, 'Monster energy ultra blue', 3),
(12, 'Eau de source', 2);

-- -----------------------------------------------------
-- INSERTION DES FOCACCIA
-- -----------------------------------------------------
-- Données extraites du fichier focaccia.xlsx
INSERT INTO focaccia (id_focaccia, nom, prix) VALUES
(1, 'Mozaccia', 9.80),
(2, 'Gorgonzollaccia', 10.80),
(3, 'Raclaccia', 8.90),
(4, 'Emmentalaccia', 9.80),
(5, 'Tradizione', 8.90),
(6, 'Hawaienne', 11.20),
(7, 'Américaine', 10.80),
(8, 'Paysanne', 12.80);

-- -----------------------------------------------------
-- INSERTION DES INGRÉDIENTS
-- -----------------------------------------------------
-- Données extraites du fichier ingredient.xlsx
INSERT INTO ingredient (id_ingredient, nom) VALUES
(1, 'Ail'),
(2, 'Ananas'),
(3, 'Artichaut'),
(4, 'Bacon'),
(5, 'Base Tomate'),
(6, 'Base crème'),
(7, 'Champignon'),
(8, 'Chevre'),
(9, 'Cresson'),
(10, 'Emmental'),
(11, 'Gorgonzola'),
(12, 'Jambon cuit'),
(13, 'Jambon fumé'),
(14, 'Oeuf'),
(15, 'Oignon'),
(16, 'Olive noire'),
(17, 'Olive verte'),
(18, 'Parmesan'),
(19, 'Piment'),
(20, 'Poivre'),
(21, 'Pomme de terre'),
(22, 'Raclette'),
(23, 'Salami'),
(24, 'Tomate cerise'),
(25, 'Mozarella');

-- -----------------------------------------------------
-- INSERTION DES ASSOCIATIONS FOCACCIA - INGRÉDIENT
-- -----------------------------------------------------
-- Table comprend : relie les focaccias aux ingrédients avec quantités (en grammes)
-- Données extraite de la colonne "ingrédients" du fichier focaccia.xlsx

-- Mozaccia (id=1) : Base tomate, Mozarella, cresson, jambon fumé, ail, artichaut, champignon, parmesan, poivre, olive noire
INSERT INTO comprend (id_focaccia, id_ingredient, quantite) VALUES
(1, 5, 200),    -- Base tomate
(1, 25, 50),    -- Mozarella
(1, 9, 20),     -- Cresson
(1, 13, 80),    -- Jambon fumé
(1, 1, 2),      -- Ail
(1, 3, 20),     -- Artichaut
(1, 7, 40),     -- Champignon
(1, 18, 50),    -- Parmesan
(1, 20, 1),     -- Poivre
(1, 16, 20);    -- Olive noire

-- Gorgonzollaccia (id=2) : Base tomate, Gorgonzola, cresson, ail, champignon, parmesan, poivre, olive noire
INSERT INTO comprend (id_focaccia, id_ingredient, quantite) VALUES
(2, 5, 200),    -- Base tomate
(2, 11, 50),    -- Gorgonzola
(2, 9, 20),     -- Cresson
(2, 1, 2),      -- Ail
(2, 7, 40),     -- Champignon
(2, 18, 50),    -- Parmesan
(2, 20, 1),     -- Poivre
(2, 16, 20);    -- Olive noire

-- Raclaccia (id=3) : Base tomate, raclette, cresson, ail, champignon, parmesan, poivre
INSERT INTO comprend (id_focaccia, id_ingredient, quantite) VALUES
(3, 5, 200),    -- Base tomate
(3, 22, 50),    -- Raclette
(3, 9, 20),     -- Cresson
(3, 1, 2),      -- Ail
(3, 7, 40),     -- Champignon
(3, 18, 50),    -- Parmesan
(3, 20, 1);     -- Poivre

-- Emmentalaccia (id=4) : Base crème, Emmental, cresson, champignon, parmesan, poivre, oignon
INSERT INTO comprend (id_focaccia, id_ingredient, quantite) VALUES
(4, 6, 200),    -- Base crème
(4, 10, 50),    -- Emmental
(4, 9, 20),     -- Cresson
(4, 7, 40),     -- Champignon
(4, 18, 50),    -- Parmesan
(4, 20, 1),     -- Poivre
(4, 15, 20);    -- Oignon

-- Tradizione (id=5) : Base tomate, Mozarella, cresson, jambon cuit, champignon, parmesan, poivre, olive noire, olive verte
INSERT INTO comprend (id_focaccia, id_ingredient, quantite) VALUES
(5, 5, 200),    -- Base tomate
(5, 25, 50),    -- Mozarella
(5, 9, 20),     -- Cresson
(5, 12, 80),    -- Jambon cuit
(5, 7, 80),     -- Champignon
(5, 18, 50),    -- Parmesan
(5, 20, 1),     -- Poivre
(5, 16, 10),    -- Olive noire
(5, 17, 10);    -- Olive verte

-- Hawaienne (id=6) : Base tomate, Mozarella, cresson, bacon, ananas, piment, parmesan, poivre, olive noire
INSERT INTO comprend (id_focaccia, id_ingredient, quantite) VALUES
(6, 5, 200),    -- Base tomate
(6, 25, 50),    -- Mozarella
(6, 9, 20),     -- Cresson
(6, 4, 80),     -- Bacon
(6, 2, 40),     -- Ananas
(6, 19, 2),     -- Piment
(6, 18, 50),    -- Parmesan
(6, 20, 1),     -- Poivre
(6, 16, 20);    -- Olive noire

-- Américaine (id=7) : Base tomate, Mozarella, cresson, bacon, pomme de terre, parmesan, poivre, olive noire
INSERT INTO comprend (id_focaccia, id_ingredient, quantite) VALUES
(7, 5, 200),    -- Base tomate
(7, 25, 50),    -- Mozarella
(7, 9, 20),     -- Cresson
(7, 4, 80),     -- Bacon
(7, 21, 40),    -- Pomme de terre
(7, 18, 50),    -- Parmesan
(7, 20, 1),     -- Poivre
(7, 16, 20);    -- Olive noire

-- Paysanne (id=8) : Base crème, Chèvre, cresson, pomme de terre, jambon fumé, ail, artichaut, champignon, parmesan, poivre, olive noire, oeuf
INSERT INTO comprend (id_focaccia, id_ingredient, quantite) VALUES
(8, 6, 200),    -- Base crème
(8, 8, 50),     -- Chèvre
(8, 9, 20),     -- Cresson
(8, 21, 80),    -- Pomme de terre
(8, 13, 80),    -- Jambon fumé
(8, 1, 2),      -- Ail
(8, 3, 20),     -- Artichaut
(8, 7, 40),     -- Champignon
(8, 18, 50),    -- Parmesan
(8, 20, 1),     -- Poivre
(8, 16, 20),    -- Olive noire
(8, 14, 50);    -- Oeuf

-- -----------------------------------------------------
-- RÉACTIVATION DES VÉRIFICATIONS
-- -----------------------------------------------------
SET FOREIGN_KEY_CHECKS = 1;
SET UNIQUE_CHECKS = 1;

-- -----------------------------------------------------
-- VÉRIFICATION DES INSERTIONS
-- -----------------------------------------------------
-- Affichage du nombre d'enregistrements dans chaquee table
SELECT 'Nombre de marques insérées :' AS Information, COUNT(*) AS Total FROM marque
UNION ALL
SELECT 'nombre de boisson insérées :', COUNT(*) FROM boisson
UNION ALL
SELECT 'Nombre de focaccias insérées :', COUNT(*) FROM focaccia
UNION ALL
SELECT 'Nombre d`ingredients insérés :', COUNT(*) FROM ingredient
UNION ALL
SELECT 'Nombre d`associations focaccia-ingredient insérées :', COUNT(*) FROM comprend;

-- -----------------------------------------------------
-- FIN DE SCRIPT D'INSERTION
-- -----------------------------------------------------
