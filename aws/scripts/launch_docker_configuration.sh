# Viene invocato dall'ambiente di building, si connette tramite ssh e invoca il 
# comando per la configurazione dei nodi docker

# Verifica se ROOT_PATH è settato e non vuoto
if [ ! ${ROOT_PATH:-} ]
then 
    echo "ROOT_PATH not set"
    exit 1
fi

ANSIBLE_CONTROLLER_ADDRESS="centos@$( cat '/tmp/ansible_controller_address' )"
REMOTE_REPO_DIR='~/Code-challenge'
PATH_SSH_KEY="$ROOT_PATH/aws/ansible/files/ssh_keys/ansible_controller.pem"
REMOTE_COMMAND="$REMOTE_REPO_DIR/ansible_controller/scripts/configure_docker_from_controller.sh"

ssh -i $PATH_SSH_KEY $ANSIBLE_CONTROLLER_ADDRESS $REMOTE_COMMAND