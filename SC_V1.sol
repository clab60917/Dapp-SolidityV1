// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract LuxuryWatchNFT is ERC721Enumerable, Ownable {
    using Counters for Counters.Counter;
    using Strings for uint256;
    Counters.Counter private _tokenIds;

    struct Watch {
        string brand;
        string model;
        string serialNumber;
        uint256 price;
    }

    uint256 public constant royaltyPercentage = 5; // 5% royalty
    mapping(uint256 => Watch) public watchInfo;
    mapping(uint256 => address[]) public watchOwnershipHistory;
    mapping(uint256 => string) public watchMetadataURI;

    // Events
    event WatchNFTCreated(uint256 indexed tokenId, string name, string model, string serialNumber);
    event WatchNFTSold(uint256 indexed tokenId, address from, address to, uint256 price);
    event ApprovalForSale(uint256 indexed tokenId, address indexed approved, uint256 price);

    constructor() ERC721("LuxuryWatchNFT", "LWNFT") {}

    function createWatchNFT(string memory _brand, string memory _model, string memory _serialNumber, uint256 _price, string memory _metadataURI) public onlyOwner {
        _tokenIds.increment();
        uint256 newItemId = _tokenIds.current();
        _mint(msg.sender, newItemId);

        Watch memory newWatch = Watch({
            brand: _brand,
            model: _model,
            serialNumber: _serialNumber,
            price: _price
        });

        watchInfo[newItemId] = newWatch;
        watchOwnershipHistory[newItemId].push(msg.sender);
        watchMetadataURI[newItemId] = _metadataURI;

        emit WatchNFTCreated(newItemId, _brand, _model, _serialNumber);
    }

    function approveForSale(uint256 _tokenId, address _approved, uint256 _price) public {
        require(ownerOf(_tokenId) == msg.sender, "Only the owner can approve for sale");
        approve(_approved, _tokenId);
        watchInfo[_tokenId].price = _price;
        emit ApprovalForSale(_tokenId, _approved, _price);
    }

    function sellWatchNFT(uint256 _tokenId, address _buyer) public {
        require(getApproved(_tokenId) == _buyer, "The buyer is not approved by the owner");
        uint256 salePrice = watchInfo[_tokenId].price;
        uint256 royaltyFee = (salePrice * royaltyPercentage) / 100;

        // Transfer the royalty fee to the original creator
        address payable creator = payable(ownerOf(_tokenId));
        require(payable(creator).send(royaltyFee), "Could not pay out royalties");

        // Transfer the remaining amount to the seller
        address payable seller = payable(msg.sender);
        require(payable(seller).send(salePrice - royaltyFee), "Could not pay out seller");

        watchOwnershipHistory[_tokenId].push(_buyer);
        _transfer(msg.sender, _buyer, _tokenId);

        emit WatchNFTSold(_tokenId, msg.sender, _buyer, salePrice);
    }

    function getWatchOwnershipHistory(uint256 _tokenId) public view returns (address[] memory) {
        return watchOwnershipHistory[_tokenId];
    }

    function updateMetadataURI(uint256 _tokenId, string memory _newMetadataURI) public {
        require(ownerOf(_tokenId) == msg.sender, "Only the owner can update the metadata");
        watchMetadataURI[_tokenId] = _newMetadataURI;
    }

    // On peut mettre ici d'autres fonctions si besoin
}

//fonction approveForSale permet au propriétaire d'un NFT de donner l'approbation à un autre utilisateur pour vendre la montre NFT.
//fonction sellWatchNFT a été modifiée pour inclure la logique de paiement des royalties au créateur original du NFT.
//Un historique de propriété est enregistré pour chaque NFT dans le mapping watchOwnershipHistory.
//fonction updateMetadataURI permet au propriétaire du NFT de mettre à jour

// RÉSUMÉ GÉNÉRAL DU CODE :
//Ce code est un point de départ qui crée un token NFT pour chaque montre avec des détails comme le nom, le modèle, le numéro de série pour la traçabilité, et le prix.
//Il comprend des événements pour la création et la vente.
