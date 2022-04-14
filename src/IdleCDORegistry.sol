// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.13;

import "openzeppelin-contracts/access/Ownable.sol";

interface IIdleRegistry {
  function idleCdoToToken(address idleCdo) external view returns (address);
  function isValidCdo(address idleCdo) external view returns (bool);
}

interface IIdleCDO {
  function token() external view returns (address);
}

error Invalid();

contract IdleCDORegistry is IIdleRegistry, Ownable {
  mapping(address => bool) public isValidCdo;

  constructor(address[] memory _cdos) {
    uint256 _cdoLen = _cdos.length;
    for (uint256 i = 0; i < _cdoLen;) {
      isValidCdo[_cdos[i]] = true;
      unchecked {
        ++i;
      }
    }
  }

  function idleCdoToToken(address _cdo) external view returns (address _underlying) {
    if (isValidCdo[_cdo]) {
      _underlying = IIdleCDO(_cdo).token();
    }
  }

  function toggleCDO(address _cdo, bool _valid) external onlyOwner {
    if (_cdo == address(0)) {
      revert Invalid();
    }
    isValidCdo[_cdo] = _valid;
  }
}
