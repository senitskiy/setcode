#!/bin/sh

# ================================================================================
#
NETWORK=$(./configes/get_network.sh)
CONTRACTS=$(./configes/get_contracts.sh)
TVM_LINKER=$(./configes/get_tvm_linker.sh)
TONOS_CLI=$(./configes/get_tonos_cli.sh)
# CURRENT_DIR=$(./configes/create_current_dir.sh)

echo Конфигурация запуска:
echo Blockchain:                 $NETWORK
echo Directory contracts:       $CONTRACTS
echo Linker:                     $TVM_LINKER
echo Tonos-cli:                  $TONOS_CLI
echo Directory Address and keys: $CURRENT_DIR


./1_deploy_Contract.sh
./3_1_setcode_Version2.sh
./3_2_setcode_Version3.sh
# ./4_1_onCodeUpgrade.sh
# ./4_2_onCodeUpgrade.sh
./5_value.sh


# ./2_deploy_NewVersion.sh
# ./deploy/3_RootBTC.sh
# ./deploy/4_RootETH.sh
# ./deploy/5_RootUSDT.sh
# ./deploy/6_DEXroot.sh

# ./deploy/7_setDEXclientCode.sh
# ./deploy/8_setDEXpairCode.sh
# ./deploy/9_computeDEXpair.sh

# ./deploy/10_deploy_client1.sh

# ./deploy/deploy1WTON.sh
# ./deploy/deploy2Root4WTON.sh
# ./deploy/deploy3DEXrootA.sh
# ./deploy/deploy4DEXrootB.sh

# ./deploy/deploy5setDEXclientCode4RootA.sh
# ./deploy/deploy6setDEXclientCode4RootB.sh
# ./deploy/deploy7setDEXpairCode4RooA.sh
# ./deploy/deploy8setDEXpairCode4RootB.sh

# ./deploy/deploy9pairA-B.sh
# ./deploy/deploy10pairB-WTON.sh
# ./deploy/deploy11client1.sh
# ./deploy/deploy12client2.sh
# ./deploy/deploy13connect-client1toPairA-B.sh
# ./deploy/_deploy9connect-client1toPairA-B.sh
# ./deploy/deploy14connect-client2toPairA-B.sh
