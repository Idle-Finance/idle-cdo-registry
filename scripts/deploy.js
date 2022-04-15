import ethers from 'ethers'
import { wallet, deployContract } from './helpers.js'

import Artifact from '../out/IdleCDORegistry.sol/IdleCDORegistry.json'

const main = async () => {
  const Factory = new ethers.ContractFactory(
    Artifact.abi, Artifact.bytecode.object, wallet
  );

  await deployContract({
    name: 'IdleCDORegistry',
    deployer: wallet,
    factory: Factory,
    args: [
      [
        '0xd0DbcD556cA22d3f3c142e9a3220053FD7a247BC', // idledai
        '0x77648a2661687ef3b05214d824503f6717311596', // idlefei
        '0x34dcd573c5de4672c8248cd12a99f875ca112ad8', // lido
        '0x4ccaf1392a17203edab55a1f2af3079a8ac513e7', // cvxfrax3crv
        '0x151e89e117728ac6c93aae94c621358b0ebd1866', // cvxmim3crv
        '0x008c589c471fd0a13ac2b9338b69f5f7a1a843e1', // cvxalusd3crv
        '0x16d88C635e1B439D8678e7BAc689ac60376fBfA6', // cvxmusd3crv
        '0x858F5A3a5C767F8965cF7b77C51FD178C4A92F05', // cvx3eurCrv
        '0x7ecfc031758190eb1cb303d8238d553b1d4bc8ef', // cvxstecrv
        '0xf324Dca1Dc621FCF118690a9c6baE40fbD8f09b7', // cvxpbtccrv
        '0x70320A388c6755Fc826bE0EF9f98bcb6bCCc6FeA', // mstable
      ]
    ],
    opts: {
      gasLimit: 1000000
    }
  });
}

main()
  .then(() => process.exit(0))
  .catch(error => {
      console.error(error);
      process.exit(1);
  });