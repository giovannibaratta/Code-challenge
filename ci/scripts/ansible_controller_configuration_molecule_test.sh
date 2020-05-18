# Verifica se ROOT_PATH è settato e non vuoto
if [ ! ${ROOT_PATH:-} ]
then 
    echo "ROOT_PATH not set"
    exit 1
fi

SCRIPT_DIR="$ROOT_PATH/ci/scripts"
YML_TO_TEST_ROOT="$ROOT_PATH/aws/ansible"
VIRTUAL_ENV_DIR=$( $SCRIPT_DIR/retrieve_virtual_environment_dir.sh )

cd "$YML_TO_TEST_ROOT"
. "$VIRTUAL_ENV_DIR/bin/activate"
molecule test
MOLECULE_TEST_EXIT_CODE=$?
deactivate
echo "Cleaning resources"
rm -f "/tmp/archive_repo.zip"
rm -f "/tmp/ansible_controller_address"

exit $MOLECULE_TEST_EXIT_CODE
