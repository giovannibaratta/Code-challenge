# Verifica se ROOT_PATH è settato e non vuoto
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

ansible-playbook -i inventories/localhost.yml deploy_aws_network.yml \
        -e ansible_python_interpreter="$VIRTUAL_ENV_DIR/bin/python"

ANSIBLE_PLAYBOOK_EXIT_CODE=$?
deactivate
exit $ANSIBLE_PLAYBOOK_EXIT_CODE