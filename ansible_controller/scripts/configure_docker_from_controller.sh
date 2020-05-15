# Invoca il playbook per la configurazione dei nodi Docker. Questo script
# verrà invocato dal nodo AnsibleController.

CONTROLLER_PATH=~/Code-challenge/ansible_controller

cd "$CONTROLLER_PATH/ansible"

ansible-playbook -i inventories/docker_node_aws_ec2.yml \
    configure_docker_node.yml \
    --private-key "$CONTROLLER_PATH/ansible/files/ssh_keys/docker_nodes.pem" \
&& ansible-playbook -i inventories/docker_node_aws_ec2.yml \
    configure_docker_manager.yml \
    --private-key "$CONTROLLER_PATH/ansible/files/ssh_keys/docker_nodes.pem" \
&& ansible-playbook -i inventories/docker_node_aws_ec2.yml \
    configure_docker_worker.yml \
    --private-key "$CONTROLLER_PATH/ansible/files/ssh_keys/docker_nodes.pem" \
&& ansible-playbook -i inventories/docker_node_aws_ec2.yml \
    configure_docker_swarm.yml \
    --private-key "$CONTROLLER_PATH/ansible/files/ssh_keys/docker_nodes.pem"