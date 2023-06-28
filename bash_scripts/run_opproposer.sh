
code=$(curl -s -o /dev/null -w "%{http_code}" 'http://opnode:8547')
echo "Code: "
echo $code

if [ "$code" = 200 ]; then
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