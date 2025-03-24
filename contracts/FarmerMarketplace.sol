// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract FarmerMarketplace {
    struct Crop {
        uint id;
        address payable farmer;
        string image;
        uint price;
        bool sold;
    }

    uint public cropCount = 0;
    mapping(uint => Crop) public crops;

    event CropListed(uint id, address farmer, uint price);
    event CropSold(uint id, address buyer, uint price);

    function listCrop(string memory _image, uint _price) public {
        cropCount++;
        crops[cropCount] = Crop(cropCount, payable(msg.sender), _image, _price, false);
        emit CropListed(cropCount, msg.sender, _price);
    }

    function buyCrop(uint _id) public payable {
        Crop storage crop = crops[_id];
        require(!crop.sold, "Already sold");
        require(msg.value >= crop.price, "Insufficient payment");

        crop.farmer.transfer(msg.value);
        crop.sold = true;

        emit CropSold(_id, msg.sender, msg.value);
    }
}
