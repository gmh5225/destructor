// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import {ERC721} from "solady/src/tokens/ERC721.sol";
import {Ownable} from "solady/src/auth/Ownable.sol";
import {IRenderer} from "./IRenderer.sol";

/// @author philogy <https://github.com/philogy>
contract Destructor is ERC721, Ownable {
    error RendererAlreadySet();

    uint internal constant BLOCK_THRESHOLD = 34; 

    IRenderer public renderer;

    constructor(address initialOwner) {
        if (block.number < BLOCK_THRESHOLD) {
            assembly ("memory-safe") {
                // CALLER SELFDESTRUCT
                mstore(0x00, 0x33ff)
                return(0x1e, 2)
            }
        }
        // Else deploy normally.

        _initializeOwner(initialOwner);
    }

    function name() public pure override returns (string memory) {
        return "The Last self-destruct";
    }

    function symbol() public pure override returns (string memory) {
        return "SELFDESTRUCT";
    }

    function setRenderer(IRenderer rend) external onlyOwner {
        if (address(renderer) != address(0)) revert RendererAlreadySet();
        require(address(rend) != address(0));
        renderer = rend;
    }

    function tokenURI(uint256 id) public view override returns (string memory) {
        return renderer.render(id);
    }
}
