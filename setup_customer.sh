#!/bin/bash

if ( [ "$1" == "" ] || ( [ ! "$1" == "autodetect" ] && [[ ! "$1" =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]] )) || ([ ! "$2" == "" ] && [[ ! "$2" =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]] ); then
	echo "Usage: $0 <autodetect|PRIVATE_IP> [PUBLIC_IP]"
	echo "    This script requires at least one private IP that polyverse should bind to"
        echo "    in order to talk to other peer polyverse machines part of the same cluster/fleet."
        echo ""
        echo "    In addition, it may accept a second optional parameter called PUBLIC_IP"
        echo "    where polyverse will expose the user-facing router port for public/internet"
	echo "    consumption."
        echo ""
	echo "    PUBLIC_IP and PRIVATE_IP can be identical, but it is recommended that a private IP"
	echo "    be on the subnet which only connects polyverse machines together, and public IP"
	echo "    be on an internet/risk-facing network. (A Dual-Homed setup.)"
        echo ""
	echo "    Furthermore, a special parameter 'autodetect' may be used when running on EC2 machines"
	echo "    and polyverse will automatically resolve both addresses from the AWS API."
	exit 1
fi

echo "----------------------------------------------------------------------------"
echo "|                    DANGER!!!!!!!!                                        |"
echo "|       This script will modify core components of this machine.           |"
echo "|       It is intended for dedicated fleets or isolated VMs ONLY.          |"
echo "|                                                                          |"
echo "|       This script is pausing for 30 seconds to give you a chance         |"
echo "|              to abort. Press CTRL+C NOW!!!!!                             |"
echo "----------------------------------------------------------------------------"
read -t 30 -p "Hit ENTER to continue or wait 30 seconds."

export CLUSTERING_METHOD=3
export DISCOVERY_URL=
export PULL_IMAGES=polyverse/pvdemo-nodejs
export DOCKER_CONFIG_JSON_CONTENTS='{
	"auths": {
		"https://index.docker.io/v1/": {
			"auth": "YWxleGdvOiE0MUtpZHNDb25jdXJpeA==",
			"email": "alex@polyverse.io"
		}
	}
}'
export SEAL_KEY=
export PRIVATE_IP=$1
export PUBLIC_IP=$2
export LOGGER_IP=52.3.214.2
export STATSD_IP=52.3.214.2
export VFI='{"quay.io/coreos/etcd":"v2.2.1","nsqio/nsq":"v0.3.5","swarm":"1.0.0","polyverse/supervisor":"62910b4411a7cebe50ff00da9e4e4d039d770a4e","polyverse/router":"2f0dd6443624d8faa9b9014e3f1cb8a7ad68b082","polyverse/container-manager":"0b09dcffbec300a5e4793254d9570e2833498f3b"}'
export IMP=$VFI
export SUPERVISOR_CD_OPTIONS="-logger-ip=$LOGGER_IP -statsd-ip=$STATSD_IP"
export ETCD_KEYS_OPTION='{"/polyverse/config/debuglevel":"error"}'
export EKO=$ETCD_KEYS_OPTION
export RM_VAR_LIB_DOCKER=true

###### BEGIN: stop.sh
echo Display some system/environment state to allow diagnostics
ps -elyfwww 2>&1
echo ------------------------------------------------------
echo environment
env 2>&1
echo Removing all containers
export DOCKER_HOST=tcp://0.0.0.0:2375
docker rm -f -v $(docker ps -qa) 2>&1
echo service docker stop
service docker stop 2>&1
echo Docker stopped

###### END: stop.sh

###### BEGIN: createusers.sh
useradd polyverse
usermod --groups docker polyverse
chown polyverse:polyverse /home/polyverse

###### END: createusers.sh

###### BEGIN: provision.sh
#!/bin/bash

echo "Detecting OS"
detected_dist="$(. /etc/os-release && echo "$ID") $(. /etc/os-release && echo "$ID_LIKE")"
echo "OS Detected as $detected_dist"

supported_dist="rhel ubuntu"

for id1 in $detected_dist
do
	for id2 in $supported_dist
	do
		if [ "$id1" == "$id2" ]; then
			echo "Distribution $id1 matched supported distribution list $supported_dist"
			lsb_dist=$id1
		fi
	done
done

if [ "$lsb_dist" == "rhel"  ]; then
# We're on RedHat or similar
# Ensure that the machine has an unused /dev/sdb device dedicated for docker
	if [[ ! -b /dev/sdb ]]; then
		echo ERROR  !!!!!!!!!!! ERROR  !!!!!!!!!!!ERROR  !!!!!!!!!!!ERROR  !!!!!!!!!!!ERROR  !!!!!!!!!!!ERROR  !!!!!!!!!!!
		echo ERROR  The machine doesn\'t have an unused /dev/sdb block device, mininum 16GB in size dedicated for docker. ERROR
		echo ERROR  The Polyverse will run, but the system performance will be severely affected.                   ERROR
		echo echo ERROR  !!!!!!!!!!! ERROR  !!!!!!!!!!!ERROR  !!!!!!!!!!!ERROR  !!!!!!!!!!!ERROR  !!!!!!!!!!!ERROR  !!!!!!!!!!!
	else
	  # Remove previous logical volume
	  echo Removing vg001/mythinpool
	  lvremove -f vg001/mythinpool
	  vgremove vg001
      rm -f -d -r /var/lib/docker/{linkgraph.db,repositories-devicemapper,devicemapper,graph}
	  # Set up a logical volume for devmapper
	  echo vgcreate -v vg001 /dev/sdb
	  vgcreate -v vg001 /dev/sdb
	  echo lvcreate -L 16G -T vg001/mythinpool
	  lvcreate -L 16G -T vg001/mythinpool
		export STORAGE_OPT="--storage-opt dm.thinpooldev=/dev/mapper/vg001-mythinpool"
	fi
	echo yum -y update
	yum -y update
	yum install -y wget
	wget http://yum.dockerproject.org/repo/main/fedora/20/Packages/docker-engine-1.8.3-1.fc20.x86_64.rpm
	yum -y --nogpgcheck localinstall  docker-engine-1.8.3-1.fc20.x86_64.rpm
	yum install -y curl
	yum install -y jq
	yum install -y collectd
elif [ "$lsb_dist" == "ubuntu" ]; then
	echo apt-get -y update
	apt-get -y update
	apt-get install -y wget
	wget -qO- https://get.docker.com/ | sed "s/docker-engine/docker-engine=1.8.3-0~$(lsb_release -a 2>&1 | grep 'Codename:' | awk '{ print $2 }')/" | sh
	apt-get install -y curl
	apt-get install -y jq
	apt-get install -y collectd
else
	echo "-------------------------------------------------------------------------------"
	echo "This OS distribution is not recognized by polyverse, and this script could"
	echo "cause considerable harm on an unrecognized distribution. This script cannot"
	echo "proceed. Aborting setup."
	echo "-------------------------------------------------------------------------------"
	echo "Supported Distributions: $supported_dist"
	echo "Detected  Distributions: $detected_dist"
	echo "-------------------------------------------------------------------------------"
	exit 1
fi

if [[ ! -e /etc/init/docker.conf ]]; then
	#copy this file into /etc/init on an EC2 host
	cat <<DOCKERCONF > /etc/init/docker.conf
limit nofile 1048576 1048576
DOCKERCONF
fi

echo cat  DOCKERUBOPTIONS  /etc/default/docker
cat <<DOCKERUBOPTIONS > /etc/default/docker
# Additional startup options for the Docker daemon, for example:
# OPTIONS="--ip-forward=true --iptables=true"
#OPTIONS="--host=tcp://0.0.0.0:2375 --userland-proxy=false"
#other_args="--host=tcp://0.0.0.0:2375 --userland-proxy=false"
DOCKER_OPTS="-D $STORAGE_OPT --host=tcp://0.0.0.0:2375 --userland-proxy=false"
other_args="-D $STORAGE_OPT --host=tcp://0.0.0.0:2375 --userland-proxy=false"
DOCKERUBOPTIONS

echo cat  DOCKEROPTIONS /etc/sysconfig/docker
cat <<DOCKEROPTIONS > /etc/sysconfig/docker
# Additional startup options for the Docker daemon, for example:
# OPTIONS="--ip-forward=true --iptables=true"
#OPTIONS="--host=tcp://0.0.0.0:2375 --userland-proxy=false"
#other_args="--host=tcp://0.0.0.0:2375 --userland-proxy=false"
OPTIONS="-D $STORAGE_OPT --host=tcp://0.0.0.0:2375 --userland-proxy=false"
other_args="-D $STORAGE_OPT --host=tcp://0.0.0.0:2375 --userland-proxy=false"
DOCKEROPTIONS

echo cat SYSTEMDCONF > /etc/systemd/system/docker.service
cat <<SYSTEMDCONF > /etc/systemd/system/docker.service
[Service]
ExecStart=/usr/bin/docker -d -D $STORAGE_OPT --host=tcp://0.0.0.0:2375 --userland-proxy=false
SYSTEMDCONF

#change some kernel threads/pid limits
echo Changing kernel limits
sysctl kernel.threads-max=1048576
sysctl kernel.pid_max=1048576

echo Copy limits.conf
cat <<LIMITSCONF >  /etc/security/limits.conf
* - nofile 1048576
* - nproc 1048576
LIMITSCONF

echo cat  DOCKERCFG /root/.docker/config.json
mkdir -p /root/.docker
cat <<DOCKERCFG >/root/.docker/config.json
$DOCKER_CONFIG_JSON_CONTENTS
DOCKERCFG


echo "Stopping docker (making sure)"
service docker stop 2>&1
systemctl stop docker 2>&1

if [[ "$RM_VAR_LIB_DOCKER" == "true" ]]; then
  echo "Removing /var/lib/docker (to wipe clean any remaining containers)"
  rm -rf /var/lib/docker
else
  echo "Skipping removal of /var/lib/docker"
fi

while [[ "$(docker info)" == "" ]]; do
echo "Trying to start docker service..."
service docker restart 2>&1

echo "Systemd docker start - failure expected on OS being not at least Ubuntu 15.04"
systemctl daemon-reload 2>&1
systemctl restart docker 2>&1

sleep 1
done

echo Config files provisioning complete

###### END: provision.sh

###### BEGIN: collectd.sh
if [ "$STATSD_IP" != "" ]; then
  echo "collectd will send metrics to $STATSD_IP."

  if [ -f "/etc/collectd.conf" ]; then
    COLLECTDCONFPATH="/etc/collectd.conf"
    COLLECTDINCLUDE='Include "/etc/collectd.d"'
  elif [ -f "/etc/collectd/collectd.conf" ]; then
    COLLECTDCONFPATH="/etc/collectd/collectd.conf"
    COLLECTDINCLUDE='
<Include "/etc/collectd/collectd.conf.d">
	Filter "*.conf"
</Include>'
  else
    COLLECTDCONFPATH=""
  fi

  if [ "$COLLECTDCONFPATH" != "" ]; then
  echo "collectd.conf located at $COLLECTDCONFPATH."
  cat <<COLLECTDCONF > $COLLECTDCONFPATH
LoadPlugin cpu
LoadPlugin df
LoadPlugin disk
LoadPlugin interface
LoadPlugin memory
LoadPlugin write_graphite
<Plugin df>
	Device "/dev/xvda1"
	MountPoint "/"
	ValuesPercentage true
</Plugin>
<Plugin disk>
	Disk "/^[hs]d[a-f][0-9]?$/"
	IgnoreSelected false
</Plugin>
<Plugin write_graphite>
  <Node "example">
    Host "$STATSD_IP"
    Port "2003"
    Protocol "tcp"
    Prefix "collectd."
    StoreRates true
    EscapeCharacter "_"
  </Node>
</Plugin>
$COLLECTDINCLUDE
COLLECTDCONF
  echo "Restarting collectd..."
  /etc/init.d/collectd restart 2>&1
  fi
fi
###### END: collectd.sh

export ETCD_TAG=$(echo $VFI | jq -c -r '.["quay.io/coreos/etcd"]')
if [[ "$ETCD_TAG" == "null" ]]; then
  export ETCD_TAG=latest
fi
echo ETCD_TAG=$ETCD_TAG

export SUPERVISOR_TAG=$(echo $VFI | jq -c -r '.["polyverse/supervisor"]')
if [[ "$SUPERVISOR_TAG" == "null" ]]; then
  export SUPERVISOR_TAG=latest
fi
echo SUPERVISOR_TAG=$SUPERVISOR_TAG

###### BEGIN: collect_parameters_customer.sh
#!/bin/bash

echo "Determining the IP Address scheme"

if [ "$PRIVATE_IP" == "autodetect" ]; then
	echo "Autodetection of IP Requested. This will not work if we are not on EC2."

	# Collect parameters for EC2
		export PRIVATE_IP=`wget -qO- http://instance-data/latest/meta-data/local-ipv4`
		export PUBLIC_IP=`wget -qO- http://instance-data/latest/meta-data/public-ipv4`

		# Autodetect fallback
		if ["$PRIVATE_IP" == ""]; then
			export PRIVATE_IP=`curl http://169.254.169.254/latest/meta-data/local-ipv4`
		fi
		if ["$PUBLIC_IP" == ""]; then
			export PUBLIC_IP=`curl http://169.254.169.254/latest/meta-data/public-ipv4`
		fi
	echo "PUBLIC_IP autodetected as: $PUBLIC_IP"
	echo "PRIVATE_IP autodetected as: $PRIVATE_IP"
else
	echo "PRIVATE_IP provided as $PRIVATE_IP. Using it."
fi

if [ "$PUBLIC_IP" == "" ]; then
	export PUBLIC_IP=$PRIVATE_IP
fi

export DOCKER_HOST=tcp://0.0.0.0:2375

###### END: collect_parameters_customer.sh

###### BEGIN: start_polyverse.sh
#!/bin/bash
# Let the EC2 deployment finish without pulling images and timing out
export POLYVERSE_TAG=latest

echo get DISCOVERY_URL
if [[ ("$DISCOVERY_URL" == "") ]] && [[ ("$CLUSTERING_METHOD" == "") ]]; then
	echo Not an install script scenario - this is an internal AWS CodeDeploy
	if [[ "$DEPLOYMENT_GROUP_NAME" == "PolyverseWebsiteASG" ]]; then
		echo PolyverseWebsiteASG
		export DISCOVERY_URL=`wget -qO- https://s3.amazonaws.com/etcdcluster/discoveryurl`
	else
		echo PolyverseTestWebsiteASG
	 	export DISCOVERY_URL=`wget -qO- https://s3.amazonaws.com/etcdcluster/testdiscoveryurl`
	fi

	echo Get PRIVATE_IP
	export PRIVATE_IP=`wget -qO- http://instance-data/latest/meta-data/local-ipv4`
	if [[ ("$PRIVATE_IP" == "") ]]; then
		echo Not in AWS metadata - get PRIVATE_IP from ip addr show eth0
		export PRIVATE_IP=`ip addr show eth0 | grep "inet\b" | awk '{print $2}' | cut -d/ -f1`
	fi

	echo Get PUBLIC_IP
	export PUBLIC_IP=`wget -qO- http://instance-data/latest/meta-data/public-ipv4`
	if [[ ("$PUBLIC_IP" == "") ]]; then
		echo Not in AWS metadata - get PUBLIC_IP from ip addr show eth0
		export PUBLIC_IP=`ip addr show eth0 | grep "inet\b" | awk '{print $2}' | cut -d/ -f1`
	fi
fi

export DOCKER_HOST=tcp://0.0.0.0:2375
echo "DOCKER_HOST=$DOCKER_HOST"
# Ensure that /root/.docker/config.json installed by provision.sh is used for auth
export HOME=/root
echo "HOME=$HOME"

for image in $PULL_IMAGES  $(echo $VFI | jq -c -r 'to_entries | .[] | .key + ":" + .value' | tr "\n" "\t")
do
  echo Pulling $image
  echo -----------------------------------------------------------------------------------------------
	if docker pull $image  2>&1 | grep Error; then
		echo "This may be an issue with your Dockerhub authentication. Check Docker authentication and try again."
		exit 1
	fi
done

echo "Stopping polyverse_* containers so we allow etcd to migrate state safely."
docker stop $(docker ps -qa -f "name=polyverse_*")

echo "Killing any remaining docker containers..."
docker kill $(docker ps -qa)

echo "Removing any killed docker containers..."
docker rm -v $(docker ps -qa)

if [ "$CLUSTERING_METHOD" == "1" ]; then
	export CLUSTERING_OPTS="-discovery-url=${DISCOVERY_URL} -clustering-method=etcd-discovery-url"
fi

if [ "$CLUSTERING_METHOD" == "2" ]; then
	export CLUSTERING_OPTS="-clustering-method=aws-autoscaling-group"
fi

if [ "$CLUSTERING_METHOD" == "3" ]; then
	export CLUSTERING_OPTS="-clustering-method=single-machine"
fi

if [[ "$LOGGER_IP" == "127.0.0.1" ]]; then
    echo "Starting Graylog container... (usually takes a couple minutes)"
#    docker run -d --name polyverse_logs -p 9000:9000 -p 12201:12201/udp -p 12900:12900 -e GRAYLOG_USERNAME=polyverse -e GRAYLOG_PASSWORD=polyverse -e GRAYLOG_TIMEZONE=US/Pacific -e GRAYLOG_RETENTION="--time=24 --indices=30" -v /graylog/data:/var/opt/graylog/data -v /graylog/logs:/var/log/graylog graylog2/allinone
#    docker run -d --name polyverse_logs -p 9000:9000 -p 12201:12201/udp -p 12900:12900 -e GRAYLOG_USERNAME=polyverse -e GRAYLOG_PASSWORD=polyverse -e GRAYLOG_TIMEZONE=US/Pacific -e GRAYLOG_RETENTION="--time=1 --indices=24" -e ES_MEMORY=1g graylog2/allinone
    docker run -d --name polyverse_logs -p 9000:9000 -p 12201:12201/udp -p 12900:12900 polyverse/graylog:d04cd495c2d40a59d99e0e1e5c769e3d249d34ce
    GRAYLOG_STARTED="false"
    while [ "$GRAYLOG_STARTED" == "false" ]; do
      out=$(docker logs polyverse_logs 2>&1 | grep "Graylog server up and running." | wc -l)
      if [[ $out == "1" ]]; then
        GRAYLOG_STARTED="true"
        echo "--> Graylog server up and running at http://$PUBLIC_IP:9000..."
      else
        echo "--> Waiting for Graylog initialization to complete. Sleeping for 30 seconds..."
        sleep 30
      fi
    done
    echo "Installing Graylog content-pack to setup input listener 12201/udp..."

cat <<GRAYLOG_CONTENT_PACK_SOURCE_HERE  > content_pack
{
  "id" : null,
  "name" : "polyverse",
  "description" : "12201/udp input listener",
  "category" : "polyverse",
  "inputs" : [ {
    "title" : "polyverse",
    "configuration" : {
      "override_source" : "",
      "recv_buffer_size" : 262144,
      "bind_address" : "0.0.0.0",
      "port" : 12201
    },
    "type" : "org.graylog2.inputs.gelf.udp.GELFUDPInput",
    "global" : false,
    "extractors" : [ ],
    "static_fields" : { }
  } ],
  "streams" : [ ],
  "outputs" : [ ],
  "dashboards" : [ ],
  "grok_patterns" : [ ]
}
GRAYLOG_CONTENT_PACK_SOURCE_HERE

    export CONTENT_PACK=$(cat content_pack)
    echo $CONTENT_PACK
    uri=$(curl -s -v -u polyverse:polyverse -X POST -H "Content-Type: application/json" -d "$CONTENT_PACK" http://$LOGGER_IP:12900/system/bundles 2>&1 | grep "Location" | awk '{ print $3 }' | tr -d '\r')

    echo "Content pack uri: ${uri}"
    enableUri="${uri}/apply"

    echo "Enabling content-pack: ${enableUri}"
    curl -s -v -u polyverse:polyverse -X POST $enableUri

    #echo -e '{"host":"$PRIVATE_IP","short_message":"setup_customer.sh"}\0' | nc -u -w 1 $LOGGER_IP 12201
fi

export SUPERVISOR_CMD='docker run -d --net=host --name=polyverse_supervisor --restart=always polyverse/supervisor:'$SUPERVISOR_TAG' -polyverse-tag='$POLYVERSE_TAG\ ${CLUSTERING_OPTS}' -docker-host=tcp://'${PRIVATE_IP}':2375 -ip-addr='${PUBLIC_IP}' -private-ip-addr='${PRIVATE_IP}' -swarm-endpoint=tcp://'${PRIVATE_IP}':3376  -log-driver=gelf -statsd-ip='$STATSD_IP' -router-seal-key='$SEAL_KEY' -force-pull=false -image-patch-map='$IMP' -startup-etcd-keys='$EKO' '$SUPERVISOR_CD_OPTIONS''

# Start supervisor
echo Starting Polyverse supervisor
echo "Supervisor Command: $SUPERVISOR_CMD"
echo -----------------------------------------------------------------------------------------------
$SUPERVISOR_CMD 2>&1

echo It should have worked.

###### END: start_polyverse.sh

CLUSTER_HEALTH="false"

while [ "$CLUSTER_HEALTH" == "false" ]; do
	echo "Waiting for ETCD Cluster to be healthy...."
	out=$(docker run --rm --entrypoint=/etcdctl --net=host quay.io/coreos/etcd:$ETCD_TAG cluster-health)
	if [[ $out =~ "cluster is healthy" ]]; then
		echo "Cluster is now healthy. Proceeding to write keys."
		CLUSTER_HEALTH="true"
	else
		echo "Cluster is not yet healthy. Sleeping for 10 seconds before retrying."
		sleep 10
	fi
done

echo "Installing customer manifest (only if one didn't exist before. This will not overwrite an existing manifest.)"
cat <<MANIFEST_SOURCE_HERE  > app_manifest
app = function() {
  return {
    Name: function() {
      return "pvdemo-nodejs"; //Replace with any friendly name you
    },
    IsRequestSupported: function(r,c) {
      return true;
    },
    GetContainerInfo: function(r,c) {
      return {
        ID:                 "pvdemo-nodejs",
        BaseImage:          "polyverse/pvdemo-nodejs", //Put your application’s image name here
        Timeout:            365 * 24 * 60 * 60 * 1000000000,
        PerInstanceTimeout: 5 * 1000000000, //How often do you want to replace instances (in nanoseconds)? Default: 5 seconds
        DesiredInstances:   100, //How many containers do you want running concurrently?
        IsStateless:        true,
        HealthCheckURLPath: "/" ,
        LaunchGracePeriod:  60 * 1000000000,
        Cmd:               [], // Optional. Specify arguments to be sent to container on launch
        BindingPort:        8080 // Specify the port that your container application is listening to
      };
    },
    ValidationInfo: function() {
      return {
        PositiveRequests: [],
        NegativeRequests: []
      };
    }
  };
}();

MANIFEST_SOURCE_HERE

export MANIFEST_SOURCE=$(cat app_manifest)
docker run --rm --entrypoint=/etcdctl --net=host quay.io/coreos/etcd:$ETCD_TAG mk /polyverse-apps/pvdemocpp "$MANIFEST_SOURCE"

if [ ! "" == "" ]; then
	export SSL_HOST_SETTINGS='{"Name": "", "Settings": {"Default": true, "KeyPair": ""}}'
	echo "SSL Host settings: /polyverse-router/hosts//host = $SSL_HOST_SETTINGS"
	docker run --rm --entrypoint=/etcdctl --net=host quay.io/coreos/etcd:$ETCD_TAG mk /polyverse-router/hosts//host "$SSL_HOST_SETTINGS"

	export SSL_LISTENER='{"Protocol":"https", "Address":{"Network":"tcp", "Address":"0.0.0.0:8080"}}'
        echo "Making default listeniner HTTPS: /polyverse-router/listeners/secure = $SSL_LISTENER"
	docker run --rm --entrypoint=/etcdctl --net=host quay.io/coreos/etcd:$ETCD_TAG mk /polyverse-router/listeners/secure "$SSL_LISTENER"
fi

