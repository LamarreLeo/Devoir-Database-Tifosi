# Base de Données Tifosi

Base de données pour le restaurant Tifosi.

## 📋 Structure du Projet

Le projet est organisé en plusieurs scripts SQL :

1. `01_creation_schema.sql` - Création du schéma de la base de données
2. `02_insertion_donnees.sql` - Insertion des données initiales
3. `03_verification_donnees.sql` - Requêtes de vérification des données

## 🚀 Installation

1. Assurez-vous d'avoir MySQL installé sur votre machine
2. Exécutez les scripts dans l'ordre :
   ```bash
   mysql -u [utilisateur] -p < 01_creation_schema.sql
   mysql -u [utilisateur] -p tifosi < 02_insertion_donnees.sql
   mysql -u [utilisateur] -p tifosi < 03_verification_donnees.sql
   ```

## 🔍 Vérification des Données

Le script `03_verification_donnees.sql` contient des requêtes pour vérifier l'intégrité et la cohérence des données insérées.

## 📝 Notes

- Les données initiales sont basées sur des fichiers Excel fournis
- La base de données est conçue pour être évolutive et maintenable
- Des contraintes d'intégrité ont été mises en place pour assurer la cohérence des données