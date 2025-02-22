export NUM=1
fabric-ca-client register --id.name peer${NUM} --id.secret peer${NUM}_pw --id.type peer
FABRIC_CA_CLIENT_HOME=./config fabric-ca-client enroll -d -u http://peer${NUM}:peer${NUM}_pw@localhost:7054 -M peer${NUM}_MSP/msp


# generate tls certificates
FABRIC_CA_CLIENT_HOME=./config fabric-ca-client enroll -u http://peer${NUM}:peer${NUM}_pw@$localhost:7054 -M peer${NUM}_MSP/tls --enrollment.profile tls --csr.hosts peer1-hlf-peer.peers.svc.cluster.local

# create tls certificates for orderer node
cp ./config/peer${NUM}_MSP/tls/tlscacerts/* ./config/peer${NUM}_MSP/tls/ca.crt
cp ./config/peer${NUM}_MSP/tls/signcerts/* ./config/peer${NUM}_MSP/tls/server.crt
cp ./config/peer${NUM}_MSP/tls/keystore/* ./config/peer${NUM}_MSP/tls/server.key

# create tls certificates for orderer org
mkdir -p ./config/PeerMSP/tlscacerts
cp ./config/peer${NUM}_MSP/tls/tlscacerts/* ./config/PeerMSP/tlscacerts/tlsca.peer1.svc.cluster.local-cert.pem
