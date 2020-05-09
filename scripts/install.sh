# Verifica se ROOT_PATH è settato e non è vuoto
if [ ! ${ROOT_PATH:-} ]
then 
    echo "ROOT_PATH not set"
    exit 1
fi

# Install ansible
sudo apt update
sudo apt install software-properties-common
sudo apt-add-repository --yes --update ppa:ansible/ansible
sudo apt install -y ansible
sudo rm /etc/apt/sources.list.d/ansible*

cd "$ROOT_PATH/ansible"
ansible --version
ansible-playbook "configure_building_environment.yml" -e ansible_python_interpreter=$( which python3 )