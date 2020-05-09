# Verifica se ROOT_PATH è settato e non è vuoto
if [ ! ${ROOT_PATH:-} ]
then 
    echo "ROOT_PATH not set"
    exit 1
fi

SCRIPT_DIR="$ROOT_PATH/scripts/"

ANSIBLE_FILES=$( $SCRIPT_DIR/collect_ansible_files.sh $ROOT_PATH/ansible/ )
VIRTUAL_ENV_DIR=$( $SCRIPT_DIR/retrieve_virtual_environment_dir.sh )
YAML_LINT_CONFIG="$ROOT_PATH/scripts/yamllint_configuration.yml"

. "$VIRTUAL_ENV_DIR/bin/activate"
yamllint -c "$YAML_LINT_CONFIG" $ANSIBLE_FILES
LINT_EXIT_CODE=$?
deactivate
exit $LINT_EXIT_CODE