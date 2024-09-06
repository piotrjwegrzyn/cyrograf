// SPDX-License-Identifier: GPL-3.0-or-later
        
pragma solidity >=0.8.26;

import "remix_tests.sol"; 
import "remix_accounts.sol";
import "../cyrograf.sol";

contract CyrografTestSuite {
    Cyrograf cyrograf;

    // Setup function to initialize the contract before tests run
    function beforeEach() public {
        cyrograf = new Cyrograf();
    }

    function testInitialBackground() public {
        Cyrograf.Background memory got = cyrograf.getBackground();

        Assert.equal(got.author, address(this), "The author should be the deployer");

        Assert.equal(got.northWest.x, uint8(0), "Top left X should be 0");
        Assert.equal(got.northWest.y, uint8(0), "Top left Y should be 0");
        Assert.equal(got.northWest.z, uint8(0), "Top left Z should be 0");

        Assert.equal(got.southEast.x, uint8(255), "Top right X should be 255");
        Assert.equal(got.southEast.y, uint8(255), "Top right Y should be 255");
        Assert.equal(got.southEast.z, uint8(255), "Top right Z should be 255");
    }

    function testSetAndGetBackground() public {
        cyrograf.setBackground(Cyrograf.RGB(128, 64, 32), Cyrograf.RGB(200, 150, 100));

        Cyrograf.Background memory got = cyrograf.getBackground();

        Assert.equal(got.author, address(this), "The author should be the caller");

        Assert.equal(got.northWest.x, uint8(128), "North west X should be updated");
        Assert.equal(got.northWest.y, uint8(64), "North west Y should be updated");
        Assert.equal(got.northWest.z, uint8(32), "North west Z should be updated");

        Assert.equal(got.southEast.x, uint8(200), "South east X should be updated");
        Assert.equal(got.southEast.y, uint8(150), "South east Y should be updated");
        Assert.equal(got.southEast.z, uint8(100), "South east Z should be updated");
    }
}
    