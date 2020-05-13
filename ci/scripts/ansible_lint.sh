# Verifica se ROOT_PATH è settato e non vuoto
if [ ! ${ROOT_PATH:-} ]
then 
    echo "ROOT_PATH not set"
    exit 1
fi

SCRIPT_DIR="$ROOT_PATH/ci/scripts"

AWS_ANSIBLE_FILES=$( $SCRIPT_DIR/collect_ansible_files.sh $ROOT_PATH/aws/ansible/ )
CONTROLLER_ANSIBLE_FILES=$( $SCRIPT_DIR/collect_ansible_files.sh $ROOT_PATH/ansible_controller/ansible/ )
VIRTUAL_ENV_DIR=$( $SCRIPT_DIR/retrieve_virtual_environment_dir.sh )

. "$VIRTUAL_ENV_DIR/bin/activate"
ansible-lint $AWS_ANSIBLE_FILES

if [ "$?" -ne 0 ]
then
    echo "Linting aws non superato"
    exit 1
fi

ansible-lint $CONTROLLER_ANSIBLE_FILES

if [ "$?" -ne 0 ]
then
    echo "Linting controller non superato"
    exit 1
fi

deactivate
exit 0