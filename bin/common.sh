#!/bin/bash
set -e
set -x

ROOT=`readlink -f "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/../"`

# Determines whether a container is running
# container_running <CONTAINER_NAME>
function container_running {
  container_name=$1

  docker inspect ${container_name} > /dev/null 2>&1

  return $?
}

# Kills an hcf role
# kill_role <ROLE_NAME>
function kill_role {
  role=$1
  container=$(docker ps -a -q --filter "label=fissile_role=${role}")
  if [[ ! -z $container ]]; then
    docker rm --force $container > /dev/null 2>&1
  fi
}

# Starts an hcf role
# start_role <IMAGE_NAME> <CONTAINER_NAME> <ROLE_NAME> <EXTRA_DOCKER_ARGUMENTS>
function start_role {
  image=$1
  name=$2
  role=$3
  extra=$4

  mkdir -p $store_dir/$role
  mkdir -p $log_dir/$role

  docker run -it -d --name $name \
    --privileged \
    --label=fissile_role=$role \
    --dns=127.0.0.1 --dns=8.8.8.8 \
    --cgroup-parent=instance \
    -v $store_dir/$role:/var/vcap/store \
    -v $log_dir/$role:/var/vcap/sys/log \
    -v $FISSILE_COMPILATION_DIR:$FISSILE_COMPILATION_DIR \
    -v $FISSILE_DOCKERFILES_DIR/$role/packages:/var/vcap/packages \
    $extra \
    $image \
    $consul_address \
    $config_prefix > /dev/null
}

# Starts the hcf consul server
# start_hcf_consul <CONTAINER_NAME>
function start_hcf_consul() {
  container_name=$1

  mkdir -p $store_dir/$container_name

  cid=$(docker run -d \
    --net=bridge --net=hcf --privileged=true \
    -p 8401:8401 -p 8501:8501 -p 8601:8601 -p 8310:8310 -p 8311:8311 -p 8312:8312 \
    --name $container_name \
    -v $store_dir/$container_name:/opt/hcf/share/consul \
    -t hcf/consul-server:latest \
    -bootstrap -client=0.0.0.0 --config-file /opt/hcf/etc/consul.json)

  #docker network connect hcf $cid
}

# Waits for the hcf consul server to start
# wait_hcf_consul <CONSUL_ADDRESS>
function wait_hcf_consul() {
  $ROOT/bootstrap-scripts/wait_for_consul.bash $1
}

# gets container name from a fissile docker image name
# get_container_name <IMAGE_NAME>
function get_container_name() {
  echo "${1/:/-}"
}

# gets a role name from a fissile image name
# get_role_name <IMAGE_NAME>
function get_role_name() {
  role=$(echo $1 | awk -F":" '{print $1}')
  echo ${role#"${FISSILE_REPOSITORY}-"}
}

# checks if the appropriate version of a role is running
# if it isn't, the currently running role is killed, and
# the correct image is started;
# uses fissile to determine what are the correct images to run
# handle_restart <IMAGE_NAME> <EXTRA_DOCKER_ARGUMENTS>
function handle_restart() {
  image=$1
  extra=$@

  container_name=$(get_container_name $image)
  role_name=$(get_role_name $image)

  if container_running $container_name ; then
    echo "Role ${role_name} running with appropriate version ..."
    return 1
  else
    echo "Restarting ${role_name} ..."
    kill_role $role_name
    start_role $image $container_name $role $extra
    return 0
  fi
}
