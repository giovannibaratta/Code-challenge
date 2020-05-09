# Verifica se ROOT_PATH è settato e non è vuoto
if [ ! ${ROOT_PATH:-} ]
then 
    echo "ROOT_PATH not set"
    exit 1
fi

cat "$ROOT_PATH/ansible/vars/configure_building_environment.yml" \
    | grep virtual_env_path: \
    | cut -d' ' -f2