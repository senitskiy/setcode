#!/bin/sh

NETWORK=$(./configes/get_network.sh)
CONTRACTS=$(./configes/get_contracts.sh)
TVM_LINKER=$(./configes/get_tvm_linker.sh)
TONOS_CLI=$(./configes/get_tonos_cli.sh)
CURRENT_DIR=$(./configes/get_current_dir.sh)

echo ==========================================================================

ROOT_ADDR=$($TONOS_CLI -u $NETWORK genaddr ./src/NewVersion.tvc ./src/NewVersion.abi.json --genkey $CURRENT_DIR/NewVersion/deploy.keys.json --wc 0 | grep "Raw address:" | cut -c 14-)
# tonos-cli genaddr ../DEXrootAndWalletcompile/RootTokenContract.tvc ../DEXrootAndWalletcompile/RootTokenContract.abi.json --genkey ./addrsAndKeys/2021-04-12-150601/RootA/deploy.keys.json --wc 0

echo { \"address\": \"$ROOT_ADDR\"} > $CURRENT_DIR/NewVersion/address.json
echo sink: $ROOT_ADDR

# KEYS_FILE="$CURRENT_DIR/bomber/deploy.keys.json"
# PUBKEY=$(cat $KEYS_FILE | grep public | cut -c 14-77)
# ROOT_OWNER_PK=$PUBKEY



echo Waiting. Transaction from Giver...

if [ $NETWORK = "http://127.0.0.1" ]
then
    GIVER_RESULT=$($TONOS_CLI -u $NETWORK call 0:841288ed3b55d9cdafa806807f02a0ae0c169aa5edfe88a789a6482429756a94 sendGrams "{\"dest\":\"$ROOT_ADDR\",\"amount\":\"1000000000000\"}" --abi ./local_giver.abi.json | grep "Succeeded" | cut -c 1-)
elif [ $NETWORK = "https://net.ton.dev" ]
then
    GIVER_RESULT=$($TONOS_CLI -u $NETWORK call 0:ed069a52b79f0bc21d13da9762a591e957ade1890d4a1c355e0010a8cb291ae4 pay '{"addr":"'$ROOT_ADDR'","count":"'111000000000'"}' --abi ./giver.abi.json  | grep "Succeeded" | cut -c 1-)
    # GIVER_RESULT=$($TONOS_CLI -u $NETWORK call 0:ed069a52b79f0bc21d13da9762a591e957ade1890d4a1c355e0010a8cb291ae4 pay '{"addr":"'$ROOT_ADDR'"}' --abi ./giver.abi.json  | grep "Succeeded" | cut -c 1-)
fi

echo Result transaction from Giver: $GIVER_RESULT

echo Waiting. Deploy Root from Blockchain...
RESULT_DEPLOY=$($TONOS_CLI -u $NETWORK deploy ./src/NewVersion.tvc {} --abi ./src/NewVersion.abi.json --sign ./NewVersion/deploy.keys.json --wc 0 | grep "Transaction" | cut -c 12-) #| awk '/Transaction /')

echo Status Deploy: $RESULT_DEPLOY


ACCOUNT_STATUS=$($TONOS_CLI -u $NETWORK account $ROOT_ADDR | grep "acc_type:" | cut -c 10-)
echo Status account: $ACCOUNT_STATUS
