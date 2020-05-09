# Verifica se ROOT_PATH è settato e non è vuoto
if [ ! ${ROOT_PATH:-} ]
then 
    echo "ROOT_PATH not set"
    exit 1
fi

ansible --version

cd "$ROOT_PATH/ansible"
ansible-playbook "configure_building_environment.yml"