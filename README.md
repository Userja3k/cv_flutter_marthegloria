# CV Flutter - Mathe-Gloria ALIKA MUBARHUZI

Application Flutter présentant le CV interactif de Mathe-Gloria ALIKA MUBARHUZI.
Elle utilise une palette orange clair, une typographie Poppins et une barre de
navigation inférieure personnalisée.

## Fonctionnalités

- **Connexion** : formulaire de validation simple, sans authentification réelle.
- **CV** : profil, expériences, formations, compétences, langues et intérêts.
- **Famille** : liste des membres de la famille présentés dans le contenu.
- **Contact** : coordonnées avec liens pour appeler, envoyer un e-mail ou ouvrir
  une carte.
- **Interface** : cartes blanches, ombres douces et navigation animée.
- **Photos** : portraits du dossier `assets/images/`, avec leurs extensions
  réelles (`P.png`, `M.png`, `G.jpg` et `s.jpeg`).

## Organisation du code

- `lib/main.dart` : point d’entrée de l’application.
- `lib/app.dart` : configuration du thème et écran de démarrage.
- `lib/theme/app_colors.dart` : palette de couleurs.
- `lib/pages/` : écrans de connexion, CV, famille, contact et navigation.
- `lib/widgets/` : composants réutilisables, dont la barre de navigation.

## Installation

1. Installer [Flutter](https://docs.flutter.dev/get-started/install).
2. Depuis le dossier du projet, installer les dépendances :

   ```sh
   flutter pub get
   ```

3. Lancer l'application :

   ```sh
   flutter run
   ```

## Technologies

- Flutter / Dart
- `google_fonts` pour la typographie Poppins
- `url_launcher` pour les actions de contact
