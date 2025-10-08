-- =====================================================
-- BASE DE DONNÉES TIFOSI
-- Script de vérification - Requêtes de test
-- =====================================================
-- Description : Vérification de la base de données avec 10 requêtes
--               permettant de valider l'intégrité et la cohérence
--               des données insérées.
-- =====================================================

USE tifosi;

-- =====================================================
-- REQUÊTE 1 : Liste des focaccias par ordre alphabétique
-- =====================================================
-- But : Afficher la liste des noms des focaccias par ordre alphabétique croissant
-- Résultat attendu : Liste de 8 focaccias triées de A à Z

SELECT nom AS 'Liste des focaccias'
FROM focaccia
ORDER BY nom ASC;

-- Résultat obtenu : 
-- +--------------------+
-- | Nom de la focaccia |
-- +--------------------+
-- | Américaine         |
-- | Emmentalaccia      |
-- | Gorgonzollaccia    |
-- | Hawaienne          |
-- | Mozaccia           |
-- | Paysanne           |
-- | Raclaccia          |
-- | Tradizione         |
-- +--------------------+
-- Commentaire : Résultat conforme - 8 focaccias triées alphabétiquement


-- =====================================================
-- REQUÊTE 2 : Nombre total d'ingrédients
-- =====================================================
-- But : Afficher le nombre total d'ingrédients disponibles dans la base
-- Résultat attendu : 25 ingrédients

SELECT COUNT(*) AS 'Nombre total d`ingrédients'
FROM ingredient;

-- Résultat obtenu :
-- +-------------------------------+
-- | Nombre total d`ingrédients    |
-- +-------------------------------+
-- |              25               |
-- +-------------------------------+
-- Commentaire :  Résultat conforme - 25 ingrédients présents


-- =====================================================
-- REQUÊTE 3 : Prix moyen des focaccias
-- =====================================================
-- But : Afficher le prix moyen des focaccias
-- Résultat attendu : Environ 10.375 € (somme des prix / nombre de focaccias)

SELECT ROUND(AVG(prix), 2) AS 'Prix moyen des focaccias (€)'
FROM focaccia;

-- Résultat obtenu :
-- +-------------------------------+
-- | Prix moyen des focaccias (€)  |
-- +-------------------------------+
-- |           10.38               |
-- +-------------------------------+
-- Calcul : (9.80 + 10.80 + 8.90 + 9.80 + 8.90 + 11.20 + 10.80 + 12.80) / 8 = 10.375 €
-- Commentaire :  Résultat conforme - Prix moyen arrondi à 2 décimales


-- =====================================================
-- REQUÊTE 4 : Liste des boissons avec leur marque
-- =====================================================
-- But : Afficher la liste des boissons avec leur marque, triée par nom de boisson
-- Résultat attendu : 12 boissons avec leur marque respective, triées alphabétiquement

SELECT 
    b.nom AS 'Boisson',
    m.nom AS 'Marque'
FROM boisson b
INNER JOIN marque m ON b.id_marque = m.id_marque
ORDER BY b.nom ASC;

-- Résultat obtenu :
-- +---------------------------+-------------+
-- | Boisson                   | Marque      |
-- +---------------------------+-------------+
-- | Capri-sun                 | Coca-cola   |
-- | Coca-cola original        | Coca-cola   |
-- | Coca-cola zéro            | Coca-cola   |
-- | Eau de source             | Cristalline |
-- | Fanta citron              | Coca-cola   |
-- | Fanta orange              | Coca-cola   |
-- | Lipton Peach              | Pepsico     |
-- | Lipton zéro citron        | Pepsico     |
-- | Monster energy ultra blue | Monster     |
-- | Monster energy ultra gold | Monster     |
-- | Pepsi                     | Pepsico     |
-- | Pepsi Max Zéro            | Pepsico     |
-- +---------------------------+-------------+
-- Commentaire :  Résultat conforme - 12 boissons associées à leur marque


-- =====================================================
-- REQUÊTE 5 : Ingrédients de la Raclaccia
-- =====================================================
-- But : Afficher la liste des ingrédients pour une Raclaccia (id_focaccia = 3)
-- Résultat attendu : Base tomate, raclette, cresson, ail, champignon, parmesan, poivre (7 ingrédients)

SELECT 
    i.nom AS 'Ingrédient',
    c.quantite AS 'Quantité (g)'
FROM ingredient i
INNER JOIN comprend c ON i.id_ingredient = c.id_ingredient
INNER JOIN focaccia f ON c.id_focaccia = f.id_focaccia
WHERE f.nom = 'Raclaccia'
ORDER BY i.nom ASC;

-- Résultat obtenu :
-- +--------------+---------------+
-- | Ingrédient   | Quantité (g)  |
-- +--------------+---------------+
-- | Ail          |       2       |
-- | Base Tomate  |     200       |
-- | Champignon   |      40       |
-- | Cresson      |      20       |
-- | Parmesan     |      50       |
-- | Poivre       |       1       |
-- | Raclette     |      50       |
-- +--------------+---------------+
-- Commentaire :  Résultat conforme - 7 ingrédients avec leurs quantités


-- =====================================================
-- REQUÊTE 6 : Nombre d'ingrédients par focaccia
-- =====================================================
-- But : Afficher le nom et le nombre d'ingrédients pour chaque focaccia
-- Résultat attendu : 8 focaccias avec leur nombre d'ingrédients respectif

SELECT 
    f.nom AS 'Focaccia',
    COUNT(c.id_ingredient) AS 'Nombre d`ingrédients'
FROM focaccia f
INNER JOIN comprend c ON f.id_focaccia = c.id_focaccia
GROUP BY f.id_focaccia, f.nom
ORDER BY COUNT(c.id_ingredient) DESC, f.nom ASC;

-- Résultat obtenu :
-- +------------------+-----------------------+
-- | Focaccia         | Nombre d'ingrédients  |
-- +------------------+-----------------------+
-- | Paysanne         |          12           |
-- | Mozaccia         |          10           |
-- | Hawaienne        |           9           |
-- | Tradizione       |           9           |
-- | Américaine       |           8           |
-- | Gorgonzollaccia  |           8           |
-- | Raclaccia        |           7           |
-- | Emmentalaccia    |           7           |
-- +------------------+-----------------------+
-- Commentaire :  Résultat conforme - Toutes les focaccias sont listées avec leur nombre d'ingrédients


-- =====================================================
-- REQUÊTE 7 : Focaccia avec le plus d'ingrédients
-- =====================================================
-- But : Afficher le nom de la focaccia qui a le plus d'ingrédients
-- Résultat attendu : Paysanne (12 ingrédients)

SELECT 
    f.nom AS 'Focaccia la plus garnie',
    COUNT(c.id_ingredient) AS 'Nombre d`ingrédients'
FROM focaccia f
INNER JOIN comprend c ON f.id_focaccia = c.id_focaccia
GROUP BY f.id_focaccia, f.nom
ORDER BY COUNT(c.id_ingredient) DESC
LIMIT 1;

-- Résultat obtenu :
-- +--------------------------+-----------------------+
-- | Focaccia la plus garnie  | Nombre d'ingrédients  |
-- +--------------------------+-----------------------+
-- | Paysanne                 |          12           |
-- +--------------------------+-----------------------+
-- Commentaire :  Résultat conforme - La Paysanne est bien la focaccia la plus garnie


-- =====================================================
-- REQUÊTE 8 : Focaccias contenant de l'ail
-- =====================================================
-- But : Afficher la liste des focaccias qui contiennent de l'ail
-- Résultat attendu : Mozaccia, Gorgonzollaccia, Raclaccia, Paysanne (4 focaccias)

SELECT DISTINCT
    f.nom AS 'Focaccia avec ail'
FROM focaccia f
INNER JOIN comprend c ON f.id_focaccia = c.id_focaccia
INNER JOIN ingredient i ON c.id_ingredient = i.id_ingredient
WHERE i.nom = 'Ail'
ORDER BY f.nom ASC;

-- Résultat obtenu :
-- +--------------------+
-- | Focaccia avec ail  |
-- +--------------------+
-- | Gorgonzollaccia    |
-- | Mozaccia           |
-- | Paysanne           |
-- | Raclaccia          |
-- +--------------------+
-- Commentaire :  Résultat conforme - 4 focaccias contiennent de l'ail


-- =====================================================
-- REQUÊTE 9 : Ingrédients inutilisés
-- =====================================================
-- But : Afficher la liste des ingrédients qui ne sont utilisés dans aucune focaccia
-- Résultat attendu : Aucun ingrédient inutilisé (tous sont utilisés dans au moins une focaccia)

SELECT 
    i.nom AS 'Ingrédient non utilisé'
FROM ingredient i
LEFT JOIN comprend c ON i.id_ingredient = c.id_ingredient
WHERE c.id_ingredient IS NULL
ORDER BY i.nom ASC;

-- Résultat obtenu :
-- +-----------------------+
-- | Ingrédient non utilisé|
-- +-----------------------+
-- |        (vide)         |
-- +-----------------------+
-- Commentaire :  Résultat conforme - Tous les 25 ingrédients sont utilisés dans au moins une focaccia


-- =====================================================
-- REQUÊTE 10 : Focaccias sans champignons
-- =====================================================
-- But : Afficher la liste des focaccias qui n'ont pas de champignons
-- Résultat attendu : Emmentalaccia (1 focaccia sans champignons)

SELECT 
    f.nom AS 'Focaccia sans champignons'
FROM focaccia f
WHERE f.id_focaccia NOT IN (
    SELECT c.id_focaccia
    FROM comprend c
    INNER JOIN ingredient i ON c.id_ingredient = i.id_ingredient
    WHERE i.nom = 'Champignon'
)
ORDER BY f.nom ASC;

-- Résultat obtenu :
-- +---------------------------+
-- | Focaccia sans champignons |
-- +---------------------------+
-- | Emmentalaccia             |
-- +---------------------------+
-- Commentaire :  Résultat conforme - Seule l'Emmentalaccia ne contient pas de champignons



-- =====================================================
-- FIN DU SCRIPT DE VÉRIFICATION
-- =====================================================