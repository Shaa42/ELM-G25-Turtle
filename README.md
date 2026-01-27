# ELM Turtle Graphics (Groupe 25)

Ce projet est une implémentation d'une page web possédant un interpréteur graphique Turtle écrit en Elm. Cet interpréteur permet de dessiner des formes géométriques à l'aide de commandes. 


## Installation

**Node.js** et **npm** doivent être installés.

Installation des dépendances (elm, elm-format)
```sh
npm install
```


## Développement

### Étape 1 :

Lancement du serveur de développement Elm :

```sh
npx elm reactor
```

### Étape 2 :

Pour compiler le code Elm pour les tests :

```sh
npm run dev
```

Pour compiler le code Elm pour la production :

```sh
npm run build
```

Puis ouvrir :  [http://localhost:8000/static/index.html](http://localhost:8000/static/index.html)


## Commandes :
Forward n : Avance le turtle de n pixels

Right n : Tourne le turtle vers la droite de n degrés

Left n : Tourne le turtle vers la gauche de n degrés

Repeat n [...] : Répète n fois l'instruction entre crochets


## Exemples de commandes :
`[Repeat 360 [ Right 1, Forward 1]]`

`[Repeat 18 [ Left 135, Forward 63, Repeat 110 [ Forward 1, Right 2 ], Right 195, Repeat 110 [ Forward 1, Right 2 ], Forward 66] ]`

`[Repeat 36 [Repeat 360 [ Right 1, Forward 0.5], Left 10 ]]`

## Structure du projet

```sh
├── src/
|   ├── Turtle/
|       ├── Core.elm   # Definie les types et fonctions d'affichage
│       └── Parser.elm # Fonction pour le parsing de l'utilisateur
│   └── Main.elm       # Script principal
├── static/
│   └── main.js        # Fichier compilé (généré)
├── elm.json           # Configuration du projet Elm
└── package.json       # Dépendances NPM et scripts
```

Ce projet a été réalisé dans le cadre du cours d'ELP par :
- Vigourex Ryan
- Matsumoto Taïga
- Dương Trần Hữu Tùng
