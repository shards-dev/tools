#!/bin/bash
#heathcheck opgeth, and run

code=$(curl -s -o /dev/null -w "%{http_code}" 'http://opnode:8547')
echo "Code: "
echo $code

if [ "$code" = 200 ]; then
    echo "OpNode detected. Starting Batcher."
    cd /opstack/optimism/op-batcher
    ./bin/op-batcher \
    --l2-eth-rpc=http://opgeth:8545 \
    --rollup-rpc=http://opnode:8547 \
    --poll-interval=1s \
    --sub-safety-margin=6 \
    --num-confirmations=1 \
    --safe-abort-nonce-too-low-count=3 \
    --resubmission-timeout=30s \
    --rpc.addr=0.0.0.0 \
    --rpc.port=8548 \
    --rpc.enable-admin \
    --max-channel-duration=1 \
    --l1-eth-rpc=$L1_RPC \
    --private-key=$BATCHER_KEY
else
    echo "Cannot detect Node... Batcher Waiting..."
fi