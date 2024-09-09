// SPDX-License-Identifier: GPL-3.0-or-later

pragma solidity >=0.8.26;

contract Cyrograf {
    struct RGB {
        uint8 x;
        uint8 y;
        uint8 z;
    }

    struct Background {
        address author;
        RGB northWest;
        RGB southEast;
    }

    Background currentBackground;

    constructor() {
        currentBackground = Background(msg.sender, RGB(21,37,69), RGB(128,64,32));
    }

    function getBackground() public view returns (Background memory){
        return currentBackground;
    }

    function setBackground(RGB memory northWest, RGB memory southEast) external {
        currentBackground.author = msg.sender;
        currentBackground.northWest = northWest;
        currentBackground.southEast = southEast;
    }
}
