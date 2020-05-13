# Installa ansible all'interno della macchina per il building.
# OS: Linux
# Dist: Bionic

# Verifica se ROOT_PATH è settato e non vuoto
if [ ! ${ROOT_PATH:-} ]
then 
    echo "ROOT_PATH not set"
    exit 1
fi

if [ ! ${ANSIBLE_VERSION:-} ]
then 
    echo "ANSIBLE_VERSION not set"
    exit 1
fi

if [ ! ${PYTHON_INTERPRETER:-} ]
then 
    echo "PYTHON_INTERPRETER not set"
    exit 1
fi

# Install ansible
sudo apt update
sudo apt install -y software-properties-common
sudo apt-add-repository --yes ppa:ansible/ansible
sudo apt update
<<<<<<< HEAD:ci/scripts/install_dependencies.sh
sudo apt-cache madison ansible
=======
>>>>>>> bae58377d78393c84774e3d1772932023f9cbfd3:ci/scripts/install_dependency.sh
sudo apt install -y ansible="$ANSIBLE_VERSION"
sudo rm /etc/apt/sources.list.d/ansible*

CI_ANSBILE="$ROOT_PATH/ci/ansible"
# Don't cd into CI_ANSIBLE otherwise he will use local ansible.cfg.
ansible-playbook -i "$CI_ANSBILE/inventories/localhost.yml" \
        "$CI_ANSBILE/configure_building_environment.yml" \
        -e ansible_python_interpreter="$PYTHON_INTERPRETER"