# Verifica se ROOT_PATH è settato e non è vuoto
if [ ! ${ROOT_PATH:-} ]
then 
    echo "ROOT_PATH not set"
    exit 1
fi

ansible-playbook "$ROOT_PATH/ansible/configure_building_environment.yml"