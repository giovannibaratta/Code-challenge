# Verifica se ROOT_PATH è settato e non è vuoto
if [ ! ${ROOT_PATH:-} ]
then 
    echo "ROOT_PATH not set"
    exit 1
fi

SCRIPT_DIR="$ROOT_PATH/scripts"
VIRTUAL_ENV_DIR=$( $SCRIPT_DIR/retrieve_virtual_environment_dir.sh )

. "$VIRTUAL_ENV_DIR/bin/activate"
cd "$ROOT_PATH/ansible"
ansible-playbook -i inventories/ansible_controller_aws_ec2.yml configure_ansible_controller.yml --private-key "$ROOT_PATH/ansible/files/ssh_keys/ansible_controller.pem"
if [ "$?" -ne 0 ]
then
    echo "Errore durante l'esecuzione del playbook"
    exit 1
fi
deactivate
ssh -i "$ROOT_PATH/ansible/files/ssh_keys/ansible_controller.pem" centos@$(cat /tmp/ansible_controller_address) 'export ROOT_PATH=~/Code-challenge; ~/Code-challenge/scripts/configure_docker.sh'