#!/bin/sh

NETWORK=$(./configes/get_network.sh)
CONTRACTS=$(./configes/get_contracts.sh)
TVM_LINKER=$(./configes/get_tvm_linker.sh)
TONOS_CLI=$(./configes/get_tonos_cli.sh)
CURRENT_DIR=$(./configes/get_current_dir.sh)

echo ========================================================================
# echo Deploy client1

# mkdir $CURRENT_DIR/client1

# CLIENT_ADDR=$($TONOS_CLI -u $NETWORK genaddr ../$CONTRACTS/DEXclient.tvc ../$CONTRACTS/DEXclient.abi.json --genkey $CURRENT_DIR/client1/deploy.keys.json --wc 0 | grep "Raw address:" | cut -c 14-)
# echo { \"address\": \"$CLIENT_ADDR\"} > $CURRENT_DIR/client1/address.json

# KEYS_FILE="$CURRENT_DIR/client1/deploy.keys.json"
# PUBKEY=$(cat $KEYS_FILE | grep public | cut -c 14-77)

# ROOT_DATA='{"pubkey":"'0x$PUBKEY'"}'
# ROOT_DATA='{"pubkey":"'0xd9239d54a34c9234cd540d70639bb71fc11a207ba7c0d4dc5f18dfae183d695f'"}'

# echo PUBKEY client1: ROOT_DATA

BOMBER_ADDR_FILE="$CURRENT_DIR/bomber/address.json"
BOMBER_ADDR=$(cat $BOMBER_ADDR_FILE | grep address | cut -c 15-80)
echo Bomber address: $BOMBER_ADDR

# echo $CLIENT_ADDR

# DEPLOYDEADDRESS="0:7f111969fc05c0c061887d3eeb6cdaf164c1090eebed41195333c779d32301ca"
# DEPLOYDEADDRESS=$($TONOS_CLI -u $NETWORK call $ROOT_ADDR computeDEXclientAddr $ROOT_DATA --abi ../$CONTRACTS/DEXroot.abi.json  --sign $CURRENT_DIR/Root/deploy.keys.json | grep "value0" | cut -c 14-79)

# echo Deployed client Address: $BOMBER_ADDR

echo ========================================================================
ACCOUNT_STATUS=$($TONOS_CLI -u $NETWORK account $BOMBER_ADDR | grep "balance:" | cut -c 11-)
echo Balance Bomber: $ACCOUNT_STATUS
# $TONOS_CLI -u $NETWORK account $BOMBER_ADDR

# echo Waiting. Transaction from Giver...

# if [ $NETWORK = "http://127.0.0.1" ]
# then
#     GIVER_RESULT=$($TONOS_CLI -u $NETWORK call 0:841288ed3b55d9cdafa806807f02a0ae0c169aa5edfe88a789a6482429756a94 sendGrams "{\"dest\":\"$DEPLOYDEADDRESS\",\"amount\":\"100000000000\"}" --abi ./local_giver.abi.json | grep "Succeeded" | cut -c 1-)
# elif [ $NETWORK = "https://net.ton.dev" ] 
# then
#     GIVER_RESULT=$($TONOS_CLI -u $NETWORK call 0:2225d70ebde618b9c1e3650e603d6748ee6495854e7512dfc9c287349b4dc988 pay '{"addr":"'$DEPLOYDEADDRESS'"}' --abi ./giver.abi.json | grep "Succeeded" | cut -c 1-)
# fi

# echo $GIVER_RESULT

SINK_ADDR_FILE="$CURRENT_DIR/sink/address.json"
SINK_ADDR=$(cat $SINK_ADDR_FILE | grep address | cut -c 15-80)
echo ========================================================================
echo Sink address: $SINK_ADDR

# $TONOS_CLI -u $NETWORK account $SINK_ADDR
echo ========================================================================
ACCOUNT_STATUS=$($TONOS_CLI -u $NETWORK account $SINK_ADDR | grep "balance:" | cut -c 11-)
echo Balance Sink: $ACCOUNT_STATUS

ROOT_DATA='{"addr":"'$SINK_ADDR'"}'

# DEPLOYDEADDRESS=$(
    # $TONOS_CLI -u $NETWORK call $ROOT_ADDR createDEXclient $ROOT_DATA --abi ../$CONTRACTS/DEXroot.abi.json --sign $CURRENT_DIR/client1/deploy.keys.json #| grep "deployedAddress" | cut -c 23-88)
    # $TONOS_CLI -u $NETWORK call $ROOT_ADDR createDEXclient $ROOT_DATA --abi ../$CONTRACTS/DEXroot.abi.json --sign $CURRENT_DIR/client1/deploy.keys.json #| grep "Succeeded" | cut -c 23-88)
# $TONOS_CLI -u $NETWORK call $BOMBER_ADDR testSend0 $ROOT_DATA --abi ./src/20_bomber.abi.json --sign ./bomber/deploy.keys.json
# echo deployedAddress: $DEPLOYDEADDRESS
echo ========================================================================
TESTSEND0=$($TONOS_CLI -u $NETWORK call $BOMBER_ADDR testSend0 $ROOT_DATA --abi ./src/20_bomber.abi.json --sign ./bomber/deploy.keys.json | grep "Succeeded" | cut -c 1-88)
echo Result testSend0: $TESTSEND0

echo ========================================================================
ACCOUNT_STATUS=$($TONOS_CLI -u $NETWORK account $BOMBER_ADDR | grep "balance:" | cut -c 11-)
echo Balance Bomber: $ACCOUNT_STATUS
echo ========================================================================
ACCOUNT_STATUS=$($TONOS_CLI -u $NETWORK account $SINK_ADDR | grep "balance:" | cut -c 11-)
echo Balance Sink: $ACCOUNT_STATUS


echo ========================================================================
TESTSEND1=$($TONOS_CLI -u $NETWORK call $BOMBER_ADDR testSend1 $ROOT_DATA --abi ./src/20_bomber.abi.json --sign ./bomber/deploy.keys.json | grep "Succeeded" | cut -c 1-88)
echo Result testSend1: $TESTSEND1

echo ========================================================================
ACCOUNT_STATUS=$($TONOS_CLI -u $NETWORK account $BOMBER_ADDR | grep "balance:" | cut -c 11-)
echo Balance Bomber: $ACCOUNT_STATUS
echo ========================================================================
ACCOUNT_STATUS=$($TONOS_CLI -u $NETWORK account $SINK_ADDR | grep "balance:" | cut -c 11-)
echo Balance Sink: $ACCOUNT_STATUS


echo ========================================================================
TESTSEND1=$($TONOS_CLI -u $NETWORK call $BOMBER_ADDR testFlag2 $ROOT_DATA --abi ./src/20_bomber.abi.json --sign ./bomber/deploy.keys.json | grep "Succeeded" | cut -c 1-88)
echo Result testFlag2: $TESTSEND1

echo ========================================================================
ACCOUNT_STATUS=$($TONOS_CLI -u $NETWORK account $BOMBER_ADDR | grep "balance:" | cut -c 11-)
echo Balance Bomber: $ACCOUNT_STATUS
echo ========================================================================
ACCOUNT_STATUS=$($TONOS_CLI -u $NETWORK account $SINK_ADDR | grep "balance:" | cut -c 11-)
echo Balance Sink: $ACCOUNT_STATUS


echo ========================================================================
TESTSEND1=$($TONOS_CLI -u $NETWORK run $BOMBER_ADDR testValue0Flag64 {} --abi ./src/20_bomber.abi.json | grep "Succeeded" | cut -c 1-88)
echo Result testValue0Flag64: $TESTSEND1
echo ========================================================================
ACCOUNT_STATUS=$($TONOS_CLI -u $NETWORK account $BOMBER_ADDR | grep "balance:" | cut -c 11-)
echo Balance Bomber: $ACCOUNT_STATUS
echo ========================================================================
ACCOUNT_STATUS=$($TONOS_CLI -u $NETWORK account $SINK_ADDR | grep "balance:" | cut -c 11-)
echo Balance Sink: $ACCOUNT_STATUS


echo ========================================================================
TESTSEND1=$($TONOS_CLI -u $NETWORK run $BOMBER_ADDR testValue1Flag64 {} --abi ./src/20_bomber.abi.json | grep "Succeeded" | cut -c 1-88)
echo Result testValue1Flag64: $TESTSEND1

echo ========================================================================
ACCOUNT_STATUS=$($TONOS_CLI -u $NETWORK account $BOMBER_ADDR | grep "balance:" | cut -c 11-)
echo Balance Bomber: $ACCOUNT_STATUS
echo ========================================================================
ACCOUNT_STATUS=$($TONOS_CLI -u $NETWORK account $SINK_ADDR | grep "balance:" | cut -c 11-)
echo Balance Sink: $ACCOUNT_STATUS


echo ========================================================================
TESTSEND1=$($TONOS_CLI -u $NETWORK run $BOMBER_ADDR testValue1Flag65 {} --abi ./src/20_bomber.abi.json | grep "Succeeded" | cut -c 1-88)
echo Result testValue1Flag65: $TESTSEND1

echo ========================================================================
ACCOUNT_STATUS=$($TONOS_CLI -u $NETWORK account $BOMBER_ADDR | grep "balance:" | cut -c 11-)
echo Balance Bomber: $ACCOUNT_STATUS
echo ========================================================================
ACCOUNT_STATUS=$($TONOS_CLI -u $NETWORK account $SINK_ADDR | grep "balance:" | cut -c 11-)
echo Balance Sink: $ACCOUNT_STATUS


echo ========================================================================
TESTSEND1=$($TONOS_CLI -u $NETWORK call $BOMBER_ADDR testSend128 $ROOT_DATA --abi ./src/20_bomber.abi.json --sign ./bomber/deploy.keys.json | grep "Succeeded" | cut -c 1-88)
echo Result testSend128: $TESTSEND1

echo ========================================================================
ACCOUNT_STATUS=$($TONOS_CLI -u $NETWORK account $BOMBER_ADDR | grep "balance:" | cut -c 11-)
echo Balance Bomber: $ACCOUNT_STATUS
echo ========================================================================
ACCOUNT_STATUS=$($TONOS_CLI -u $NETWORK account $SINK_ADDR | grep "balance:" | cut -c 11-)
echo Balance Sink: $ACCOUNT_STATUS

echo ========================================================================
ACCOUNT_STATUS=$($TONOS_CLI -u $NETWORK account $BOMBER_ADDR | grep "acc_type:" | cut -c 10-)
echo Status BOMBER account: $ACCOUNT_STATUS

echo ========================================================================
echo Waiting. Transaction from Giver...

if [ $NETWORK = "http://127.0.0.1" ]
then
    GIVER_RESULT=$($TONOS_CLI -u $NETWORK call 0:841288ed3b55d9cdafa806807f02a0ae0c169aa5edfe88a789a6482429756a94 sendGrams "{\"dest\":\"$BOMBER_ADDR\",\"amount\":\"100000000000\"}" --abi ./local_giver.abi.json | grep "Succeeded" | cut -c 1-)
elif [ $NETWORK = "https://net.ton.dev" ]
then
    GIVER_RESULT=$($TONOS_CLI -u $NETWORK call 0:2225d70ebde618b9c1e3650e603d6748ee6495854e7512dfc9c287349b4dc988 pay '{"addr":"'$BOMBER_ADDR'"}' --abi ./giver.abi.json  | grep "Succeeded" | cut -c 1-)
    # timeout 5
fi

echo Result transaction from Giver: $GIVER_RESULT

echo ========================================================================
ACCOUNT_STATUS=$($TONOS_CLI -u $NETWORK account $BOMBER_ADDR | grep "balance:" | cut -c 11-)
echo Balance Bomber: $ACCOUNT_STATUS


echo ========================================================================
TESTSEND1=$($TONOS_CLI -u $NETWORK call $BOMBER_ADDR testSend160 $ROOT_DATA --abi ./src/20_bomber.abi.json --sign ./bomber/deploy.keys.json | grep "Succeeded" | cut -c 1-88)
echo Result testSend160: $TESTSEND1

echo ========================================================================
ACCOUNT_STATUS=$($TONOS_CLI -u $NETWORK account $BOMBER_ADDR | grep "balance:" | cut -c 11-)
echo Balance Bomber: $ACCOUNT_STATUS
# echo ========================================================================
# ACCOUNT_STATUS=$($TONOS_CLI -u $NETWORK account $BOMBER_ADDR | grep "acc_type:" | cut -c 11-)
# echo Balance Bomber: $ACCOUNT_STATUS



echo ========================================================================
ACCOUNT_STATUS=$($TONOS_CLI -u $NETWORK account $BOMBER_ADDR | grep "Account does not exist" | cut -c 1-)
echo Status BOMBER account: $ACCOUNT_STATUS

echo ========================================================================
ACCOUNT_STATUS=$($TONOS_CLI -u $NETWORK account $SINK_ADDR | grep "balance:" | cut -c 11-)
echo Balance Sink: $ACCOUNT_STATUS
# ACCOUNT_STATUS=$($TONOS_CLI -u $NETWORK account $ROOT_ADDR | grep ":" | cut -c 10-)
# echo Status account: $ACCOUNT_STATUS