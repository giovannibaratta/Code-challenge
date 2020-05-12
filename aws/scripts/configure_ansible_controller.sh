# Verifica se ROOT_PATH è settato e non è vuoto
if [ ! ${ROOT_PATH:-} ]
then 
    echo "ROOT_PATH not set"
    exit 1
fi

CI_SCRIPT_DIR="$ROOT_PATH/ci/scripts"
VIRTUAL_ENV_DIR=$( $CI_SCRIPT_DIR/retrieve_virtual_environment_dir.sh )
echo "VIRTUAL_ENV_DIR -> $VIRTUAL_ENV_DIR"

. "$VIRTUAL_ENV_DIR/bin/activate"
cd "$ROOT_PATH/aws/ansible"

ansible-playbook -i inventories/ansible_controller_aws_ec2.yml \
    configure_ansible_controller.yml \
    --private-key "$ROOT_PATH/aws/ansible/files/ssh_keys/ansible_controller.pem"


ANSIBLE_PLAYBOOK_EXIT_CODE=$?
deactivate
exit $ANSIBLE_PLAYBOOK_EXIT_CODE