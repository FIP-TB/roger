# roger, \#FIP bot.

Basé sur [GitHub/Hubot](https://hubot.github.com/).  
Voir [`HUBOT.md`](https://github.com/FIP-TB/roger/blob/master/HUBOT.md) pour les details techniques.

## Déploiement

Pour installer Node.js:
```bash
# Sur Debian/Ubuntu
curl -sL https://deb.nodesource.com/setup | sudo bash -
sudo apt-get install -y nodejs

# Sur OSX
brew install node
```

Pour installer les dépendances du robot (dans `roger/`), nécéssaire seulement une fois:
```bash
npm install
```

Pour lancer le robot:
```bash
./start.sh # L'adresse du serveur et le chan peuvent être modifiés dans ce fichier.
```

## Scripts

Les scripts sont écrits en [CoffeeScript](http://coffeescript.org/), un langage qui compile en JavaScript.

Pour activer un script il suffit de le rajouter dans `hubot-scripts.json`, par exemple: 
```json
[ "9gag.coffee", "kittens.coffee" ]
```

Pour créer un script personnalisé il faut le rajouter dans `/script` et l'activer dans `hubot-scripts.json`. Voir [example.coffee](https://github.com/FIP-TB/roger/blob/master/scripts/example.coffee).
