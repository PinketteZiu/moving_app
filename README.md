# README

# Application de Gestion de Déménagement

Une application Ruby on Rails pour gérer efficacement votre déménagement en inventoriant vos biens et cartons par pièce.

## Fonctionnalités

- **Gestion des pièces** : Créez et organisez les différentes pièces de votre logement
- **Inventaire des biens** : Listez vos objets avec détails (nom, description, valeur, état)
- **Gestion des cartons** : Numérotez vos cartons et indiquez leur contenu et destination
- **Recherche et filtres** : Retrouvez rapidement un objet ou carton spécifique
- **Étiquetage** : Générez des étiquettes imprimables pour vos cartons

## Installation

1. Clonez le repository
2. Installez les dépendances :
   ```bash
   bundle install
   ```

3. Créez et configurez la base de données :
   ```bash
   rails db:create
   rails db:migrate
   rails db:seed
   ```

4. Lancez le serveur :
   ```bash
   rails server
   ```

## Utilisation

1. Créez vos pièces (salon, chambre, cuisine, etc.)
2. Ajoutez vos objets à chaque pièce
3. Créez des cartons et assignez-y vos objets
4. Utilisez la recherche pour retrouver facilement vos affaires
5. Imprimez les étiquettes pour vos cartons

## Technologies utilisées

- Ruby on Rails 7.0
- Bootstrap 5.2
- PostgreSQL
- Stimulus/Turbo

## Structure de la base de données

- `rooms` : Les pièces de votre logement
- `items` : Les objets à déménager
- `boxes` : Les cartons de déménagement

Un objet appartient à une pièce et peut être assigné à un carton.
Un carton appartient à une pièce et peut contenir plusieurs objets.
