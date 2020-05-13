
# Verifica se ROOT_PATH è settato e non vuoto
if [ ! ${ROOT_PATH:-} ]
then 
    echo "ROOT_PATH not set"
    exit 1
fi

$ROOT_PATH/aws/scripts/deploy_network.sh && \
      $ROOT_PATH/aws/scripts/deploy_ec2.sh && \
      $ROOT_PATH/aws/scripts/configure_ansible_controller.sh && \
      $ROOT_PATH/aws/scripts/launch_docker_configuration.sh