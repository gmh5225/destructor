// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/// @author philogy <https://github.com/philogy>
interface IRenderer {
    function render(uint256 id) external view returns (string memory);
}
