#!/bin/bash

# Find the Addresss of the L2 OutPutOracle
L2OO_ADDR=$(cat /opstack/optimism/packages/contracts-bedrock/deployments/getting-started/L2OutputOracleProxy.json | jq -r '.address')
echo $L2OO_ADDR

code=$(curl -s -o /dev/null -w "%{http_code}" 'http://opnode:8547')
echo "OPProposer Code: "
echo $code

if [ "$code" = 200 ]; then
    echo "Proposer - Opnode:8547 200. Launching Proposer "
    cd /opstack/optimism/op-proposer
    ./bin/op-proposer \
        --poll-interval 12s \
        --rpc.port 8560 \
        --rollup-rpc http://opnode:8547 \
        --l2oo-address $L2OO_ADDR \
        --private-key $PROPOSER_KEY \
        --l1-eth-rpc $L1_RPC
else
    echo "Proposer cannot detect OPNode... Waiting..."
fi