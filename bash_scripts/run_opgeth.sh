#!/bin/bash


if [ ! -f "/opstack/optimism/op-node/genesis.json" ]; then
    echo "Genesis file not found... Waiting ..."
    exit 666
else
    echo "Found genesis file. Starting Geth."
    cd /opstack/op-geth
    ./build/bin/geth \
        --datadir ./datadir \
        --http \
        --http.corsdomain="*" \
        --http.vhosts="*" \
        --http.addr=0.0.0.0 \
        --http.api=web3,debug,eth,txpool,net,engine \
        --ws \
        --ws.addr=0.0.0.0 \
        --ws.port=8546 \
        --ws.origins="*" \
        --ws.api=debug,eth,txpool,net,engine \
        --syncmode=full \
        --gcmode=archive \
        --nodiscover \
        --maxpeers=0 \
        --networkid=$L2_CHAIN_ID \
        --authrpc.vhosts="*" \
        --authrpc.addr=0.0.0.0 \
        --authrpc.port=8551 \
        --authrpc.jwtsecret=./jwt.txt \
        --rollup.disabletxpoolgossip=true \
        --password=./datadir/password \
        --allow-insecure-unlock \
        --mine \
        --miner.etherbase=$SEQUENCER_ADDRESS \
        --unlock=$SEQUENCER_ADDRESS
fi