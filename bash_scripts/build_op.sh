#!/bin/bash

mv /opstack-temp/* /opstack/

# Run builder and replace files
cd /opstack/tools/
node server.js
cp /opstack/tools/builds/getting-started.json /opstack/optimism/packages/contracts-bedrock/deploy-config/getting-started.json
cp /opstack/tools/builds/hardhat.config.js /opstack/optimism/packages/contracts-bedrock/hardhat.config.ts

# Deploy Contracts: OK ✅
cd /opstack/optimism/packages/contracts-bedrock
npx hardhat deploy --network getting-started --tags l1

# Generate the L2 config files
cd /opstack/optimism/op-node
go run cmd/main.go genesis l2 \
--deploy-config ../packages/contracts-bedrock/deploy-config/getting-started.json \
--deployment-dir ../packages/contracts-bedrock/deployments/getting-started/ \
--outfile.l2 genesis.json \
--outfile.rollup rollup.json \
--l1-rpc $L1_RPC
openssl rand -hex 32 > jwt.txt
cp genesis.json /opstack/op-geth
cp jwt.txt /opstack/op-geth

# Initialize op-geth
cd /opstack/op-geth
mkdir datadir
echo "pwd" > datadir/password
echo $PRIVATE_KEY_SEQUENCER > datadir/block-signer-key
./build/bin/geth account import --datadir=datadir --password=datadir/password datadir/block-signer-key
build/bin/geth init --datadir=datadir genesis.json
