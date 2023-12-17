
# Luxury Watch NFT Project

## Description
Le projet Luxury Watch NFT vise à révolutionner la façon dont les montres de luxe sont échangées et tracées sur le marché secondaire. En utilisant la technologie des chaînes de blocs et des NFT (Non-Fungible Tokens), ce projet permet de lier chaque montre physique à un NFT unique, garantissant ainsi une traçabilité et une authenticité inégalées.

## Fonctionnalités
- **Création de NFT**: Permet de frapper (mint) des NFTs représentant des montres de luxe uniques.
- **Traçabilité de la propriété**: Chaque NFT maintient un historique complet des propriétaires précédents.
- **Mise à jour des métadonnées**: Les propriétaires peuvent mettre à jour les métadonnées associées à leur NFT pour refléter l'état actuel de la montre.
- **Gestion des royalties**: Un système de royalties pour récompenser les créateurs ou les propriétaires précédents lors de la revente.

## Technologies Utilisées
- Solidity pour les smart contracts.
- Ethereum comme blockchain pour déployer les smart contracts.
- OpenZeppelin pour les standards de tokens sécurisés et éprouvés.
- Truffle ou Hardhat pour le développement, le test et le déploiement.
- Ganache pour le test local et la simulation de blockchain.

## Installation et Configuration
Assurez-vous d'avoir Node.js et npm installés sur votre machine. Ensuite, suivez ces étapes :

1. Clonez le dépôt :
   ```
   git clone https://github.com/clab60917/Dapp-SolidityV1
   ```
2. Installez les dépendances :
   ```
   npm install
   ```
3. Configurez un fichier `.env` avec les clés API nécessaires et les adresses de portefeuille.

## Déploiement
Pour déployer le smart contract sur un réseau local (par exemple, Ganache) :

1. Lancez Ganache.
2. Exécutez la commande suivante pour déployer :
   ```
   truffle migrate --network development
   ```

## Tests
Pour exécuter les tests du smart contract :

```
truffle test
```

## Contribution
Les contributions sont toujours les bienvenues. Veuillez suivre les bonnes pratiques de développement et soumettre des pull requests pour toute fonctionnalité ou correction de bug.

## Licence
Ce projet est sous licence MIT. Veuillez voir le fichier LICENSE pour plus de détails.
