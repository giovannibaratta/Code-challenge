
DOCKER_KEY=$( hexdump -n 32 -e '"%X"' /dev/random )
DOCKER_IV=$( hexdump -n 16 -e '"%X"' /dev/random )
ANSIBLE_KEY=$( hexdump -n 32 -e '"%X"' /dev/random )
ANSIBLE_IV=$( hexdump -n 16 -e '"%X"' /dev/random )

DOCKER_PATH=ansible_controller/ansible/files/ssh_keys
ANSIBLE_PATH=aws/ansible/files/ssh_keys

openssl aes-256-cbc -e -K $DOCKER_KEY -iv $DOCKER_IV -in $DOCKER_PATH/docker_nodes.pem -out $DOCKER_PATH/docker_nodes.pem.enc
openssl aes-256-cbc -e -K $ANSIBLE_KEY -iv $ANSIBLE_IV -in $ANSIBLE_PATH/ansible_controller.pem -out $ANSIBLE_PATH/ansible_controller.pem.enc

echo DOCKER_KEY=$DOCKER_KEY
echo DOCKER_IV=$DOCKER_IV
echo ANSIBLE_KEY=$ANSIBLE_KEY
echo ANSIBLE_IV=$ANSIBLE_IV
