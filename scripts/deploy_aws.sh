# Verifica se ROOT_PATH è settato e non è vuoto
if [ ! ${ROOT_PATH:-} ]
then 
    echo "ROOT_PATH not set"
    exit 1
fi

SCRIPT_DIR="$ROOT_PATH/scripts/"
VIRTUAL_ENV_DIR=$( $SCRIPT_DIR/retrieve_virtual_environment_dir.sh )

. "$VIRTUAL_ENV_DIR/bin/activate"
cd "$ROOT_PATH/ansible"
ansible-playbook -i inventories/localhost.yml deploy_aws_vm.yml -e ansible_python_interpreter=$( which python3 )
ANSIBLE_PLAYBOOK_EXIT_CODE=$?
deactivate
exit $ANSIBLE_PLAYBOOK_EXIT_CODE