// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.13;

import "./BaseTest.sol";
import "../IdleCDORegistry.sol";

contract FakeCDO {
  address public token;
  constructor(address _token) {
    token = _token;
  }
}

contract IdleCDORegistryTest is BaseTest {
  IdleCDORegistry public reg;
  FakeCDO public cdo1;
  FakeCDO public cdo2;

  function setUp() public {
    address[] memory _cdos = new address[](2);
    cdo1 = new FakeCDO(address(1));
    cdo2 = new FakeCDO(address(2));
    _cdos[0] = address(cdo1);
    _cdos[1] = address(cdo2);
    reg = new IdleCDORegistry(_cdos);
  }

  function testIsValidCdo() public {
    assertTrue(reg.isValidCdo(address(cdo1)));
    assertTrue(reg.isValidCdo(address(cdo2)));
    assertTrue(!reg.isValidCdo(address(3)));
  }
  function testToggleCdo() public {
    assertTrue(!reg.isValidCdo(address(3)));
    reg.toggleCDO(address(3), true);
    assertTrue(reg.isValidCdo(address(3)));
    reg.toggleCDO(address(3), false);
    assertTrue(!reg.isValidCdo(address(3)));
  }
  function testIdleCdoToToken() public {
    assertEq(reg.idleCdoToToken(address(cdo1)), address(1));
    assertEq(reg.idleCdoToToken(address(cdo2)), address(2));
    assertEq(reg.idleCdoToToken(address(3)), address(0));
  }
}
