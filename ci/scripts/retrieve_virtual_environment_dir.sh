# Recupera il PATH utilizzato per la creazione dell'env
# leggendo dal file delle variabili

# Verifica se ROOT_PATH è settato e non vuoto
if [ ! ${ROOT_PATH:-} ]
then 
    echo "ROOT_PATH not set"
    exit 1
fi

cat "$ROOT_PATH/ci/ansible/vars/configure_building_environment.yml" \
    | grep virtual_env_path: \
    | cut -d' ' -f2