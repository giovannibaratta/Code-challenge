# Invoca il playbook per la configurazione dei nodi Docker. Questo script
# verrà invocato dal nodo AnsibleController.

CONTROLLER_PATH="~/repo/ansible_controller"

cd "$CONTROLLER_PATH/ansible"

ansible-playbook -i inventories/docker_node_aws_ec2.yml \
    configure_docker_node.yml \
    --private-key "~/.ssh/private_key.ssh"