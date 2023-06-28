#!/bin/bash
#heathcheck opgeth, and run

code=$(curl -s -o /dev/null -w "%{http_code}" 'http://opgeth:8551')
echo "Code: "
echo $code

if [ "$code" = 401 ]; then
    echo "Genesis file found. Starting Opnode."
    cd /opstack/optimism/op-node
    ./bin/op-node \
        --l2=http://opgeth:8551 \
        --l2.jwt-secret=./jwt.txt \
        --sequencer.enabled \
        --sequencer.l1-confs=3 \
        --verifier.l1-confs=3 \
        --rollup.config=./rollup.json \
        --rpc.addr=0.0.0.0 \
        --rpc.port=8547 \
        --p2p.disable \
        --rpc.enable-admin \
        --p2p.sequencer.key=$SEQ_KEY \
        --l1=$L1_RPC \
        --l1.rpckind=$RPC_KIND
else
    echo "Node cannot detect OPGeth... Waiting..."
fi