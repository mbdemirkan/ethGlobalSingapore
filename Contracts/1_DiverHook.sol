// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import { Ownable } from "@openzeppelin/contracts/access/Ownable.sol";
import { IERC20 } from "@openzeppelin/contracts/interfaces/IERC20.sol";
import { ISPHook } from "@ethsign/sign-protocol-evm/src/interfaces/ISPHook.sol";

// @dev This contract manages the whitelist. We are separating the whitelist logic from the hook to make things easier
// to read.
contract DiverHookManager is Ownable {
    mapping(address attester => bool allowed) public diver;

    constructor() Ownable(_msgSender()) { }

    function addDiver(address attester, bool allowed) external onlyOwner {
        diver[attester] = allowed;
    }

    function _checkAttesterStatus(address attester) internal view {
        // solhint-disable-next-line custom-errors
        require(diver[attester], "UnauthorizedAttester");
    }
}

// @dev This contract implements the actual schema hook.
contract DiverHook is ISPHook, DiverHookManager {
    function didReceiveAttestation(
        address attester,
        uint64, // schemaId
        uint64, // attestationId
        bytes calldata // extraData
    )
        external
        payable
    {
        _checkAttesterStatus(attester);
    }

    function didReceiveAttestation(
        address attester,
        uint64, // schemaId
        uint64, // attestationId
        IERC20, // resolverFeeERC20Token
        uint256, // resolverFeeERC20Amount
        bytes calldata // extraData
    )
        external
        view
    {
        _checkAttesterStatus(attester);
    }

    function didReceiveRevocation(
        address attester,
        uint64, // schemaId
        uint64, // attestationId
        bytes calldata // extraData
    )
        external
        payable
    {
        _checkAttesterStatus(attester);
    }

    function didReceiveRevocation(
        address attester,
        uint64, // schemaId
        uint64, // attestationId
        IERC20, // resolverFeeERC20Token
        uint256, // resolverFeeERC20Amount
        bytes calldata // extraData
    )
        external
        view
    {
        _checkAttesterStatus(attester);
    }
}