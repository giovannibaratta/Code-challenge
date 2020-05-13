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
YAML_LINT_CONFIG="$SCRIPT_DIR/yamllint_configuration.yml"

. "$VIRTUAL_ENV_DIR/bin/activate"
yamllint -c "$YAML_LINT_CONFIG" $AWS_ANSIBLE_FILES

if [ "$?" -ne 0 ]
then
    echo "Yamllint aws non superato"
    exit 1
fi

echo "Linting aws superato"

yamllint -c "$YAML_LINT_CONFIG" $CONTROLLER_ANSIBLE_FILES

if [ "$?" -ne 0 ]
then
    echo "Yamllint controller non superato"
    exit 1
fi

echo "Linting controller superato"

deactivate
exit 0