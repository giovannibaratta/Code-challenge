# Verifica se ROOT_PATH è settato e non vuoto
if [ ! ${ROOT_PATH:-} ]
then 
    echo "ROOT_PATH not set"
    exit 1
fi

SCRIPT_DIR="$ROOT_PATH/ci/scripts"

AWS_ANSIBLE_FILES=$( $SCRIPT_DIR/collect_ansible_files.sh $ROOT_PATH/aws/ansible/ )
CONTROLLER_ANSIBLE_FILES=$( $SCRIPT_DIR/collect_ansible_files.sh $ROOT_PATH/ansible_controller/ansible/ )

ansible-playbook $AWS_ANSIBLE_FILES --syntax-check

if [ "$?" -ne 0 ]
then
    echo "Syntax check aws non superato"
    exit 1
fi

ansible-playbook $CONTROLLER_ANSIBLE_FILES --syntax-check

if [ "$?" -ne 0 ]
then
    echo "Syntax check controller non superato"
    exit 1
fi

exit 0