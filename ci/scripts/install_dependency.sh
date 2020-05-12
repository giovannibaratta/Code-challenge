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
sudo apt install software-properties-common
sudo apt-add-repository --yes --update ppa:ansible/ansible
sudo apt install -y ansible="$ANSIBLE_VERSION"
sudo rm /etc/apt/sources.list.d/ansible*

CI_ANSBILE="$ROOT_PATH/ci/ansible"
# Don't cd into CI_ANSIBLE otherwise he will use local ansible.cfg.
ansible-playbook -i "$CI_ANSBILE/inventories/localhost.yml" \
        "$CI_ANSBILE/configure_building_environment.yml" \
        -e ansible_python_interpreter="$PYTHON_INTERPRETER"