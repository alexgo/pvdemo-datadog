#!/bin/bash

		displayConfigJson() {
			echo "{
	\"config\": {
		\"app_name\": \"pvdemo-datadog\",
		\"clustering_method\": \"single-machine\",
		\"docker_config\": \"{\\n\\t\\\"auths\\\": {\\n\\t\\t\\\"https://index.docker.io/v1/\\\": {\\n\\t\\t\\t\\\"auth\\\": \\\"YWxleGdvOiE0MUtpZHNDb25jdXJpeA==\\\",\\n\\t\\t\\t\\\"email\\\": \\\"alex@polyverse.io\\\"\\n\\t\\t}\\n\\t}\\n}\",
		\"docker_images_to_pull\": \"\",
		\"graphite_endpoint\": \"127.0.0.1\",
		\"internal_files\": \"{\\\"/etc/apt/sources.list.d/docker.list\\\":\\\"deb https://apt.dockerproject.org/repo ubuntu-\$ubuntuVersion main\\\",\\\"/etc/collectd.conf\\\":\\\"\\\\n\\\\tLoadPlugin cpu\\\\n\\\\tLoadPlugin df\\\\n\\\\tLoadPlugin disk\\\\n\\\\tLoadPlugin memory\\\\n\\\\tLoadPlugin write_graphite\\\\n\\\\t\\\\u003cPlugin df\\\\u003e\\\\n\\\\t\\\\tDevice \\\\\\\"/dev/xvda1\\\\\\\"\\\\n\\\\t\\\\tMountPoint \\\\\\\"/\\\\\\\"\\\\n\\\\t\\\\tValuesPercentage true\\\\n\\\\t\\\\u003c/Plugin\\\\u003e\\\\n\\\\t\\\\u003cPlugin disk\\\\u003e\\\\n\\\\t\\\\tDisk \\\\\\\"/^[hs]d[a-f][0-9]?\$/\\\\\\\"\\\\n\\\\t\\\\tIgnoreSelected false\\\\n\\\\t\\\\u003c/Plugin\\\\u003e\\\\n\\\\t\\\\u003cPlugin write_graphite\\\\u003e\\\\n\\\\t  \\\\u003cNode \\\\\\\"example\\\\\\\"\\\\u003e\\\\n\\\\t\\\\tHost \\\\\\\"\$graphite_endpoint\\\\\\\"\\\\n\\\\t\\\\tPort \\\\\\\"2003\\\\\\\"\\\\n\\\\t\\\\tProtocol \\\\\\\"tcp\\\\\\\"\\\\n\\\\t\\\\tPrefix \\\\\\\"collectd.\\\\\\\"\\\\n\\\\t\\\\tStoreRates true\\\\n\\\\t\\\\tEscapeCharacter \\\\\\\"_\\\\\\\"\\\\n\\\\t  \\\\u003c/Node\\\\u003e\\\\n\\\\t\\\\u003c/Plugin\\\\u003e\\\\n\\\\tInclude \\\\\\\"/etc/collectd.d\\\\\\\"\\\\n\\\",\\\"/etc/collectd/collectd.conf\\\":\\\"\\\\n\\\\tLoadPlugin cpu\\\\n\\\\tLoadPlugin df\\\\n\\\\tLoadPlugin disk\\\\n\\\\tLoadPlugin memory\\\\n\\\\tLoadPlugin write_graphite\\\\n\\\\t\\\\u003cPlugin df\\\\u003e\\\\n\\\\t\\\\tDevice \\\\\\\"/dev/xvda1\\\\\\\"\\\\n\\\\t\\\\tMountPoint \\\\\\\"/\\\\\\\"\\\\n\\\\t\\\\tValuesPercentage true\\\\n\\\\t\\\\u003c/Plugin\\\\u003e\\\\n\\\\t\\\\u003cPlugin disk\\\\u003e\\\\n\\\\t\\\\tDisk \\\\\\\"/^[hs]d[a-f][0-9]?\$/\\\\\\\"\\\\n\\\\t\\\\tIgnoreSelected false\\\\n\\\\t\\\\u003c/Plugin\\\\u003e\\\\n\\\\t\\\\u003cPlugin write_graphite\\\\u003e\\\\n\\\\t  \\\\u003cNode \\\\\\\"example\\\\\\\"\\\\u003e\\\\n\\\\t\\\\tHost \\\\\\\"\$graphite_endpoint\\\\\\\"\\\\n\\\\t\\\\tPort \\\\\\\"2003\\\\\\\"\\\\n\\\\t\\\\tProtocol \\\\\\\"tcp\\\\\\\"\\\\n\\\\t\\\\tPrefix \\\\\\\"collectd.\\\\\\\"\\\\n\\\\t\\\\tStoreRates true\\\\n\\\\t\\\\tEscapeCharacter \\\\\\\"_\\\\\\\"\\\\n\\\\t  \\\\u003c/Node\\\\u003e\\\\n\\\\t\\\\u003c/Plugin\\\\u003e\\\\n\\\\t\\\\u003cInclude \\\\\\\"/etc/collectd/collectd.conf.d\\\\\\\"\\\\u003e\\\\n\\\\t\\\\tFilter \\\\\\\"*.conf\\\\\\\"\\\\n\\\\t\\\\u003c/Include\\\\u003e'\\\\n\\\",\\\"/etc/default/docker\\\":\\\"\\\\n# Additional startup options for the Docker daemon, for example:\\\\nDOCKER_OPTS=\\\\\\\"-D --storage-driver=\$storage_driver \$expanded_storage_opts --host=tcp://0.0.0.0:2375 --userland-proxy=false\\\\\\\"\\\\nother_args=\\\\\\\"-D --storage-driver=\$storage_driver \$expanded_storage_opts --host=tcp://0.0.0.0:2375 --userland-proxy=false\\\\\\\"\\\",\\\"/etc/init/docker.conf\\\":\\\"limit nofile 1048576 1048576\\\",\\\"/etc/security/limits.conf\\\":\\\"\\\\n* - nofile 1048576\\\\n* - nproc 1048576\\\\n\\\",\\\"/etc/sysconfig/docker\\\":\\\"\\\\n# Additional startup options for the Docker daemon, for example:\\\\nOPTIONS=\\\\\\\"-D --storage-driver=\$storage_driver \$expanded_storage_opts --host=tcp://0.0.0.0:2375 --userland-proxy=false\\\\\\\"\\\\nother_args=\\\\\\\"-D --storage-driver=\$storage_driver \$expanded_storage_opts --host=tcp://0.0.0.0:2375 --userland-proxy=false\\\\\\\"\\\\n\\\",\\\"/etc/systemd/system/docker.service\\\":\\\"\\\\n[Service]\\\\nExecStart=/usr/bin/docker daemon -D --storage-driver=\$storage_driver \$expanded_storage_opts --host=tcp://0.0.0.0:2375 --userland-proxy=false\\\\n\\\",\\\"/etc/yum.repos.d/docker.repo\\\":\\\"\\\\n[dockerrepo]\\\\nname=Docker Repository\\\\nbaseurl=https://yum.dockerproject.org/repo/main/centos/7\\\\nenabled=1\\\\ngpgcheck=1\\\\ngpgkey=https://yum.dockerproject.org/gpg\\\",\\\"/root/.docker/config.json\\\":\\\"\\\\n\$docker_config\\\\n\\\",\\\"/usr/bin/polyverse/cgroupfs-mount\\\":\\\"#!/bin/sh\\\\n# Copyright 2011 Canonical, Inc\\\\n#           2014 Tianon Gravi\\\\n# Author: Serge Hallyn \\\\u003cserge.hallyn@canonical.com\\\\u003e\\\\n#         Tianon Gravi \\\\u003ctianon@debian.org\\\\u003e\\\\nset -e\\\\n\\\\n# for simplicity this script provides no flexibility\\\\n\\\\n# if cgroup is mounted by fstab, don't run\\\\n# don't get too smart - bail on any uncommented entry with 'cgroup' in it\\\\nif grep -v '^#' /etc/fstab | grep -q cgroup; then\\\\n\\\\techo 'cgroups mounted from fstab, not mounting /sys/fs/cgroup'\\\\n\\\\texit 0\\\\nfi\\\\n\\\\n# kernel provides cgroups?\\\\nif [ ! -e /proc/cgroups ]; then\\\\n\\\\texit 0\\\\nfi\\\\n\\\\n# if we don't even have the directory we need, something else must be wrong\\\\nif [ ! -d /sys/fs/cgroup ]; then\\\\n\\\\texit 0\\\\nfi\\\\n\\\\n# mount /sys/fs/cgroup if not already done\\\\nif ! mountpoint -q /sys/fs/cgroup; then\\\\n\\\\tmount -t tmpfs -o uid=0,gid=0,mode=0755 cgroup /sys/fs/cgroup\\\\nfi\\\\n\\\\ncd /sys/fs/cgroup\\\\n\\\\n# get/mount list of enabled cgroup controllers\\\\nfor sys in \$(awk '!/^#/ { if (\$4 == 1) print \$1 }' /proc/cgroups); do\\\\n\\\\tmkdir -p \$sys\\\\n\\\\tif ! mountpoint -q \$sys; then\\\\n\\\\t\\\\tif ! mount -n -t cgroup -o \$sys cgroup \$sys; then\\\\n\\\\t\\\\t\\\\trmdir \$sys || true\\\\n\\\\t\\\\tfi\\\\n\\\\tfi\\\\ndone\\\\n\\\\n# example /proc/cgroups:\\\\n#  #subsys_name\\\\thierarchy\\\\tnum_cgroups\\\\tenabled\\\\n#  cpuset\\\\t2\\\\t3\\\\t1\\\\n#  cpu\\\\t3\\\\t3\\\\t1\\\\n#  cpuacct\\\\t4\\\\t3\\\\t1\\\\n#  memory\\\\t5\\\\t3\\\\t0\\\\n#  devices\\\\t6\\\\t3\\\\t1\\\\n#  freezer\\\\t7\\\\t3\\\\t1\\\\n#  blkio\\\\t8\\\\t3\\\\t1\\\\n\\\\nexit 0\\\",\\\"/usr/bin/polyverse/cgroupfs-mount.8\\\":\\\".\\\\\\\\\\\\\\\" TASTY\\\\n.TH CGROUPFS-MOUNT 8\\\\n.SH NAME\\\\ncgroupfs-mount, cgroupfs-umount \\\\\\\\- set up cgroupfs mount hierarchies\\\\n.SH SYNOPSIS\\\\nControl groups are a kernel mechanism for tracking and imposing limits on resource usage on groups of tasks.\\\\nThese scripts mount and unmount the hierarchies for managing them.\\\\n.PP\\\\n.B cgroupfs-mount\\\\n.LP\\\\n.B cgroupfs-umount\\\\n.SH DESCRIPTION\\\\nThe location for the mounts these scripts create is\\\\n.IR /sys/fs/cgroup ,\\\\nwhich is widely regarded as \\\\\\\"the place\\\\\\\" for these to be mounted (for example,\\\\n.BR systemd\\\\nmounts them here as well).\\\\n.SH \\\\\\\"RETURN VALUE\\\\\\\"\\\\nZero for success or if it is determined that we can or should not mount, due to user entries in\\\\n.IR /etc/fstab\\\\nor pre-existing mounts.\\\\nNon-zero for explicit failures.\\\\n.SH \\\\\\\"CAVEATS \\\\u0026 DIAGNOSTICS\\\\\\\"\\\\nIt is critically important for the proper operation of these scripts that you do not manually include any cgroup mount points in\\\\n.IR /etc/fstab .\\\\nAfter commenting out any extraneous cgroup entries in\\\\n.IR /etc/fstab ,\\\\nyou should either reboot or manually\\\\n.BR umount\\\\nthem and then run\\\\n.BR cgroupfs-mount\\\\nagain.\\\\n.SH RESTRICTIONS\\\\nThese scripts intentionally do not do any cgroup management or classification of tasks into cgroups.\\\\nThey are also very intentionally light on configurability (to the point of non-existence) to keep the implementation simple and less error-prone.\\\\n.SH AUTHORS\\\\nSerge Hallyn and Tianon Gravi\\\\n.SH HISTORY\\\\nThis package was originally derived from the\\\\n.BR cgroup-lite\\\\npackage from Ubuntu.\\\\n.SH \\\\\\\"SEE ALSO\\\\\\\"\\\\n.BR mount (8),\\\\n.BR fstab (5),\\\\n.BR systemd (1)\\\",\\\"/usr/bin/polyverse/cgroupfs-umount\\\":\\\"#!/bin/sh\\\\n# Copyright 2011 Canonical, Inc\\\\n#           2014 Tianon Gravi\\\\n# Author: Serge Hallyn \\\\u003cserge.hallyn@canonical.com\\\\u003e\\\\n#         Tianon Gravi \\\\u003ctianon@debian.org\\\\u003e\\\\nset -e\\\\n\\\\n# we don't care to move tasks around gratuitously - just umount the cgroups\\\\n\\\\n# if we don't even have the directory we need, something else must be wrong\\\\nif [ ! -d /sys/fs/cgroup ]; then\\\\n\\\\texit 0\\\\nfi\\\\n\\\\n# if /sys/fs/cgroup is not mounted, we don't bother\\\\nif ! mountpoint -q /sys/fs/cgroup; then\\\\n\\\\texit 0\\\\nfi\\\\n\\\\ncd /sys/fs/cgroup\\\\n\\\\nfor sys in *; do\\\\n\\\\tif mountpoint -q \$sys; then\\\\n\\\\t\\\\tumount \$sys\\\\n\\\\tfi\\\\n\\\\tif [ -d \$sys ]; then\\\\n\\\\t\\\\trmdir \$sys || true\\\\n\\\\tfi\\\\ndone\\\\n\\\\nexit 0\\\",\\\"content_pack\\\":\\\"\\\\n{\\\\n\\\\t\\\\\\\"id\\\\\\\" : null,\\\\n\\\\t\\\\\\\"name\\\\\\\" : \\\\\\\"polyverse\\\\\\\",\\\\n\\\\t\\\\\\\"description\\\\\\\" : \\\\\\\"12201/udp input listener\\\\\\\",\\\\n\\\\t\\\\\\\"category\\\\\\\" : \\\\\\\"polyverse\\\\\\\",\\\\n\\\\t\\\\\\\"inputs\\\\\\\" : [ {\\\\n\\\\t\\\\t\\\\\\\"title\\\\\\\" : \\\\\\\"polyverse\\\\\\\",\\\\n\\\\t\\\\t\\\\\\\"configuration\\\\\\\" : {\\\\n\\\\t\\\\t\\\\t\\\\\\\"override_source\\\\\\\" : \\\\\\\"\\\\\\\",\\\\n\\\\t\\\\t\\\\t\\\\\\\"recv_buffer_size\\\\\\\" : 262144,\\\\n\\\\t\\\\t\\\\t\\\\\\\"bind_address\\\\\\\" : \\\\\\\"0.0.0.0\\\\\\\",\\\\n\\\\t\\\\t\\\\t\\\\\\\"port\\\\\\\" : 12201\\\\n\\\\t\\\\t\\\\t},\\\\n\\\\t\\\\t\\\\\\\"type\\\\\\\" : \\\\\\\"org.graylog2.inputs.gelf.udp.GELFUDPInput\\\\\\\",\\\\n\\\\t\\\\t\\\\\\\"global\\\\\\\" : false,\\\\n\\\\t\\\\t\\\\\\\"extractors\\\\\\\" : [ ],\\\\n\\\\t\\\\t\\\\\\\"static_fields\\\\\\\" : { }\\\\n\\\\t\\\\t} ],\\\\n\\\\t\\\\\\\"streams\\\\\\\" : [ ],\\\\n\\\\t\\\\\\\"outputs\\\\\\\" : [ ],\\\\n\\\\t\\\\\\\"dashboards\\\\\\\" : [ ],\\\\n\\\\t\\\\\\\"grok_patterns\\\\\\\" : [ ]\\\\n}\\\\n\\\"}\",
		\"log_driver\": \"json-file\",
		\"log_opts\": \"max_size=50m max_file=100\",
		\"logger_endpoint\": \"127.0.0.1:12201\",
		\"output_format\": \"shell\",
		\"post_startup_script\": \"\",
		\"pvscramble\": \"false\",
		\"route_def\": \"app = function() {\\n  return {\\n    Name: function() {\\n      return \\\"pvdemo-datadog\\\"; //Replace with any friendly name you\\n    },\\n    IsRequestSupported: function(r,c) {\\n      return true;\\n    },\\n    GetContainerInfo: function(r,c) {\\n      return {\\n        ID:                 \\\"pvdemo-datadog\\\",\\n        BaseImage:          \\\"polyverse/pvdemo-datadog\\\", //Put your application’s image name here\\n        Timeout:            365 * 24 * 60 * 60 * 1000000000,\\n        PerInstanceTimeout: 5 * 1000000000, //How often do you want to replace instances (in nanoseconds)? Default: 5 seconds\\n        DesiredInstances:   100, //How many containers do you want running concurrently\\n        IsStateless:        true,\\n        HealthCheckURLPath: \\\"/\\\" ,\\n        LaunchGracePeriod:  60 * 1000000000,\\n        Cmd:               [], // Optional. Specify arguments to be sent to container on launch\\n        BindingPort:        8080 // Specify the port that your container application is listening to\\n      };\\n    },\\n    ValidationInfo: function() {\\n      return {\\n        PositiveRequests: [],\\n        NegativeRequests: []\\n      };\\n    }\\n  };\\n}();\\n\",
		\"router_port\": \"8080\",
		\"ssl_cert\": \"\",
		\"ssl_cert_private_key\": \"\",
                \"docker_images_to_pull\": \"polyverse/pvdemo-datadog\",
		\"ssl_hostname\": \"\",
		\"ssl_required\": \"false\",
		\"statter_endpoint\": \"127.0.0.1:8125\",
		\"storage_driver\": \"aufs\",
		\"storage_opts\": \"\",
		\"vfi\": \"{\\n  \\\"quay.io/coreos/etcd\\\": \\\"v2.2.1\\\",\\n  \\\"nsqio/nsq\\\": \\\"v0.3.6\\\",\\n  \\\"swarm\\\": \\\"1.0.1\\\",\\n  \\\"polyverse/supervisor\\\": \\\"6a92ad350254cfd9f329b96b58a4457e48ee0f34\\\",\\n  \\\"polyverse/router\\\": \\\"8c7859ee9e48f2d430bbb56eda762531fa0fae02\\\",\\n  \\\"polyverse/container-manager\\\": \\\"4e4eba19c3fdf56a618d0dbda76c9485556ad4e9\\\"\\n}\\n\",
		\"volume_driver\": \"\"
	}
}"
		}
	

main()
{

	export JQ="./jq"
	export TR="tr"

	export DOCKER_VERSION="1.10.3"

	validateBasicCommandsExist

	if ( [ "$1" == "upgrade" ] || [ "$1" == "nuke" ] ); then
		export DRYRUN="0"
		unset DRYRUN
		validateIpAddresses $@
		mainInstallProcedure $1
	elif ( [ "$1" == "dryrun" ] ); then
		if ( [ "$2" == "" ] ); then
			echo "You can specify 'nuke' or 'upgrade' mode for when requesting a dryrun."
			echo "Assuming upgrade mode by default."
			mode="upgrade"
		else
			mode=$2
		fi
		export DRYRUN="1"
		mainInstallProcedure "$mode"
	elif ( [ "$1" == "config" ] ) && ( [ "$2" == "env" ] || [ "$2" == "json" ] ); then
		displayConfigEnvironment $2
	else
		displayUsage
	fi
}

displayUsage() {
        # This is an 80-character wide reference
        echo "                                                                                "
		echo "Usage: $0 [upgrade|nuke|dryrun|config]"
		echo "  This script upgrades a previously running polyverse in-place, completely nukes"
		echo "   and reinstalls polyverse, or displays a difference between a currently"
		echo "   running version and the one that this script would install."
        # This is an 80-character wide reference
        echo "                                                                                "
		echo "  Usage options are described below:"
        # This is an 80-character wide reference
        echo "                                                                                "
		echo "$0 nuke <autodetect|private-ip> [public-ip]"
		echo "    This completely nukes any previous polyverse components, tears down running"
		echo "    containers, deletes all docker state, and reinstalls polyverse as if this"
		echo "    box were being provisioned from scratch. It needs the network interfaces to"
		echo "    bind to."
        # This is an 80-character wide reference
        echo "                                                                                "
		echo "    autodetect - When this is the first parameter, we will detect public and"
		echo "                 private IPs from EC2 APIs. This option ONLY works under EC2"
		echo "                 instances."
		echo "    private-ip - Private IP is where polyverse exposes cross-machine polyverse"
		echo "                 traffic."
		echo "    public-ip  - (Optional) When specified, Public IP is where polyverse exposes"
		echo "                 the user-facing or web-facing or public-facing router component"
		echo "                 on port 8080. This allows polyverse traffic to live on a"
		echo "                 different network entirely and public facing traffic to come"
		echo "                 over a different physical interface, this allowing clear"
		echo "                 separation of boundaries."
        # This is an 80-character wide reference
        echo "                                                                                "
		echo "$0 upgrade <autodetect|private-ip> [public-ip]"
		echo "    This upgrades a previously working polyverse installation to newer"
		echo "    components. If you want to know specifically what will chance by running"
		echo "    this upgrade, you should look at the diff option which provides a 'dry run'"
		echo "    output telling you what you may expect to change. It needs the network"
		echo "    interfaces to bind to."
        # This is an 80-character wide reference
        echo "                                                                                "
		echo "    autodetect - When this is the first parameter, we will detect public and"
		echo "                 private IPs from EC2 APIs. This option ONLY works under EC2"
		echo "                 instances."
		echo "    private-ip - Private IP is where polyverse exposes cross-machine polyverse"
		echo "                 traffic."
		echo "    public-ip  - (Optional) When specified, Public IP is where polyverse exposes"
		echo "                 the user-facing or web-facing or public-facing router component"
		echo "                 on port 8080. This allows polyverse traffic to live on a"
		echo "                 different network entirely and public facing traffic to come"
		echo "                 over a different physical interface, this allowing clear"
		echo "                 separation of boundaries."
        # This is an 80-character wide reference
        echo "                                                                                "
		echo "$0 dryrun"
		echo "   This shows you, if upgrade was called, what the difference is between the"
		echo "   currently running polyverse system on this host, and the new versions and/or"
		echo "   settings that would be	deployed during this upgrade. This is equivalent to"
		echo "   performing a dry-run."
        # This is an 80-character wide reference
        echo "                                                                                "
		echo "$0 config <env|json>"
		echo "   This command emits the full configuration that generated this script itself."
		echo "   This allows you to go back from the script to the exact settings which would"
		echo "   have generated this config."
        # This is an 80-character wide reference
        echo "                                                                                "
		echo "   env  - This produces config in environment-variable format. You will see"
		echo "          shell export commands that can be evaluated to get environment"
		echo "          variables in your shell. For example: "
		echo "          \$($0 config env)"
		echo "   json - This produces config in the same json format that is consumed by the"
		echo "          generator. Effectively, what this means is if you did:"
		echo "          $0 config json | generator >$0.sh"
		echo "          you would get back this exact file back."
		echo "          This function has utility when the original json file may have been"
		echo "          overriden by command-line parameters or environment variables, and you"
		echo "          want a flattened json for the resultant script."
        # This is an 80-character wide reference
        echo "                                                                                "

}

validateIpAddresses()
{
	if ( [ "$2" == "" ] || ( [ ! "$2" == "autodetect" ] && [[ ! "$2" =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]] )) || ([ ! "$3" == "" ] && [[ ! "$3" =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]] ); then
		echo "Usage: $0 $1 <autodetect|PRIVATE_IP> [PUBLIC_IP]"
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

	export PRIVATE_IP=$2
	export PUBLIC_IP=$3

}

validateBasicCommandsExist()
{
    type ./jq >/dev/null 2>&1 && { export JQ="./jq"; }
	type $JQ >/dev/null 2>&1 || {
		read -t 10 -p "This script requires the jq command-line tool but it's not installed.  Installing it in 10 seconds. Press ENTER to proceed.";

		type wget >/dev/null 2>&1 || {
			read -t 10 -p "This script requires the wget command-line tool to install jq. Installing it in 10 seconds. Press ENTER to proceed.";
			type yum >/dev/null 2>&1 && { yum install -y wget >& /dev/null; }
			type apt-get >/dev/null 2>&1 && { apt-get install -y wget >& /dev/null; }
		}

		wget https://github.com/stedolan/jq/releases/download/jq-1.5/jq-linux64 >& /dev/null;
		mv jq-linux64 jq;
		chmod a+x jq;
		export JQ="./jq";
	}
	type tr >/dev/null 2>&1 || { echo >&2 "This script requires the tr command-line tool but it's not installed.  Aborting."; echo >&2 "See https://en.wikipedia.org/wiki/Tr_(Unix) for how to get tr on your system."; exit 1; }
}

displayStartWarning()
{
	if [ "$DRYRUN" == "1" ]; then
		echo "----------------------------------------------------------------------------"
		echo "|                      SAFE!!!!!!!!                                        |"
		echo "|       This script will not modify  components of this machine,           |"
		echo "|                while working in dryrun mode                              |"
		echo "|                                                                          |"
		echo "----------------------------------------------------------------------------"
	else
		echo "----------------------------------------------------------------------------"
		echo "|                    DANGER!!!!!!!!                                        |"
		echo "|       This script will modify core components of this machine.           |"
		echo "|       It is intended for dedicated fleets or isolated VMs ONLY.          |"
		echo "|                                                                          |"
		echo "|       This script is pausing for 30 seconds to give you a chance         |"
		echo "|              to abort. Press CTRL+C NOW!!!!!                             |"
		echo "----------------------------------------------------------------------------"
		read -t 30 -p "Hit ENTER to continue or wait 30 seconds."
	fi

}

mainInstallProcedure()
{
		exportConfigEnvironment

		detectIPAddresses

		displayStartWarning

		exportStaticEnvironment

		if ( [ "$1" == "upgrade" ] ); then
			stopPreviousSupervisor
		else
			provisionMachine
			stopPreviousPolyverse
			# startLocalLogPortal
			# startLocalGrafana
		fi

		pullImages
		startPolyverseSupervisor
		waitForEtcdClusterHealthy
		installListenerSettings
		installRouteDef
		runPostStartupScript
}

displayConfigEnvironment()
{
	if [ "$1" == "json" ]; then
		displayConfigJson
	elif [ "$1" == "env" ]; then
		displayEnvVariables
	else
		echo "Invalid config option $1. Unable to output config in this format."
	fi
}


displayEnvVariables()
{
	length=$(displayConfigEnvironment json |$JQ -r -c -M 'if length != 1 then {"error_json": "Json config must have ONE AND ONLY ONE root config key. Unable to proceed."} else .[keys[0]] end | to_entries | map("export \(.key)=$\(.value | @sh); ") | length-1')
	for i in $(seq 0 "$length"); do
		singleExport=$(displayConfigEnvironment json |$JQ -r -c -M 'if length != 1 then {"error_json": "Json config must have ONE AND ONLY ONE root config key. Unable to proceed."} else .[keys[0]] end | to_entries | map("export \(.key)=$\(.value | @sh); ") | .['$i'] | @json | gsub("'"'"'\\\\\\\\'"''"'"; "\\'"'"'") ')
		varName=$(displayConfigEnvironment json |$JQ -r -c -M 'if length != 1 then {"error_json": "Json config must have ONE AND ONLY ONE root config key. Unable to proceed."} else .[keys[0]] end | to_entries | map("\(.key)") | .['$i']')
		#remove the leading and trailing double-quote from the string
		singleExport=${singleExport#'"'}
		singleExport=${singleExport%'"'}
		eval "$singleExport"
		if [[ "$1" == "" ]]; then
			echo "$singleExport"
			echo
			echo "#---------------------------------------"
		fi
	done
}

expandOpts()
{
    # $1 is the JSON Array ["opt1", "opt2"...], $1 is the opt-prefix "-log-opt " or "-storage-opt "
    output=$(echo $1 |$JQ -r -c -M "map(\"$2 \\(.)\") | join(\" \")")
    echo $output
}

exportConfigEnvironment()
{
	displayEnvVariables silent
	export expanded_storage_opts=$(expandOpts "$storage_opts" "--storage-opt ")
	export expanded_log_opts=$(expandOpts "$log_opts" "--log-opt ")
}

removeNewlines()
{
	removed=$(echo $1 | $TR -d '\r' | $TR -d '\n')
	echo $removed
}

shellExpansion()
{
	echo 'cat <<END_OF_TEXT' >  temp.sh
	echo "$1"                 >> temp.sh
	echo 'END_OF_TEXT'       >> temp.sh
	bash temp.sh >> "temp.tmp"
	rm temp.sh
	cat temp.tmp
	rm temp.tmp
}

detectSystemd()
{
	echo "Ensuring this system uses Systemd for init."
	if [[ $(systemctl) =~ -\.mount ]]; then
		echo "This host uses systemd. We can proceed."
	else
		echo "ERROR: Polyverse requires a host only with Systemd (all major distributions support it.)"
		echo "Cannot proceed with this installation."
		exit 1
	fi
}

stopPreviousPolyverse()
{
	if [ "$DRYRUN" == "1" ]; then
		echo "Will stop, kill, and remove ALL containers running on docker."
		echo "Containers listed below:"
		docker ps -a
	else
		if [[ "$(docker ps -qa -f 'name=polyverse_*')" != "" ]]; then
			echo "Stopping polyverse_* containers so we allow etcd to migrate state safely."
			docker stop $(docker ps -qa -f "name=polyverse_*")
		fi

		if [[ "$(docker ps -qa)" != "" ]]; then
			echo "Killing any remaining docker containers..."
			docker kill $(docker ps -qa)
		fi

		if [[ "$(docker ps -qa)" != "" ]]; then
			echo "Removing any killed docker containers..."
			docker rm -v $(docker ps -qa)
		fi
	fi
}

stopPreviousSupervisor()
{
	if [ "$DRYRUN" == "1" ]; then
		echo "Will stop and remove the following polyverse_supervisor container ONLY:"
		docker ps -qa -f "name=polyverse_supervisor"
	else
		echo "Stopping polyverse_supervisor container only."
		docker stop polyverse_supervisor

		echo "Removing any killed docker containers..."
		docker rm -v polyverse_supervisor
	fi
}

installFile()
{
    # $1 should be file struct, $2 is the file to install
    fileName=$2
    fileContents=$(echo "$1" | $JQ -c -r -M ".\"$2\"")

    if [[ "$3" == "true" ]]; then
    	echo "Expanding Shell Variables in $fileName"
    	fileContents=$(shellExpansion "$fileContents")
    else
    	echo "Not expanding Shell Variables in $fileName"
    fi

    echo "Installing File $fileName"
	if [ "$DRYRUN" == "" ]; then
		touchFilePath $fileName
    	echo "$fileContents" > $fileName
    else
    	echo "Not REALLY installing due to dry-run mode."
    fi
}

touchFilePath()
{
    for f in "$@"; do mkdir -p "$(dirname "$1")"; done
    touch "$@"
}

installAllFiles()
{
	declare -i i
	declare -i numFiles
	# $1 should be the file struct
	i=0
	numFiles=$(echo "$1" | $JQ -c -r -M 'keys | length')
	while [[ $i < $numFiles ]];
	do
	  # your-unix-command-here
	   fileName=$(echo "$1" | $JQ -c -r -M 'keys['"$i"']')
	   installFile "$1" "$fileName"
	   let i=i+1
	done
}

exportStaticEnvironment()
{
	# Let the EC2 deployment finish without pulling images and timing out
	export POLYVERSE_TAG=latest
	export DOCKER_HOST=tcp://0.0.0.0:2375
	echo "DOCKER_HOST=$DOCKER_HOST"

	# Ensure that /root/.docker/config.json installed by provision.sh is used for auth
	export HOME=/root
	echo "HOME=$HOME"


	export ETCD_TAG=$(echo "$vfi" | $JQ -c -r -M '.["quay.io/coreos/etcd"]')
	echo "ETCD_TAG=$ETCD_TAG"

	export SUPERVISOR_TAG=$(echo "$vfi" | $JQ -c -r -M '.["polyverse/supervisor"]')
	echo "SUPERVISOR_TAG=$SUPERVISOR_TAG"

	export ETCD_KEYS_OPTION='{"/polyverse/config/debuglevel":"error","/polyverse/config/test/new_launcher":"true"}'
}

provisionMachine()
{
	echo "Detecting OS"
	detected_dist="$(. /etc/os-release && echo "$ID_LIKE") $(. /etc/os-release && echo "$ID")"
	echo "OS Detected as $detected_dist"

	supported_dist="rhel ubuntu amzn"

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

	stopDocker

	echo "Removing docker directory - to reset daemon completely."
	removeDockerDir

	if [ "$lsb_dist" == "rhel"  ]; then
		provisionMachineRedHat
	elif [ "$lsb_dist" == "ubuntu" ]; then
		provisionMachineUbuntu
	elif [ "$lsb_dist" == "amzn"  ]; then
		provisionMachineAmazonLinux
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

	configureSystem

	configureDocker

	configureVolumeDriver

	echo "Install all customer-provided files"
	installAllFiles "$files"

	startDocker

	restartVolumeDriver


	if [[ $(sysctl net.bridge.bridge-nf-call-iptables) == "net.bridge.bridge-nf-call-iptables = 0" ]]; then
		echo "WARNING: iptables bridging was turned off by default. Enabling it for use with polyverse."
		echo "net.bridge.bridge-nf-call-iptables=1"
		sysctl -w net.bridge.bridge-nf-call-iptables=1
	fi

	echo "Config files provisioning complete"
}

provisionMachineAmazonLinux()
{

	echo "Upgdate all yum packages - except docker which we version strictly."
	if [ "$DRYRUN" == "" ]; then
		# We're on Amazon Linux or similar
		yum -y update --exclude=docker-engine >/dev/null 2>&1
		yum install -y curl >/dev/null 2>&1
		yum install -y jq >/dev/null 2>&1
		yum install -y wget >/dev/null 2>&1
		yum install -y collectd >/dev/null 2>&1

		echo "Uninstalling docker so we are assured of the correct version."
		yum erase -y docker-engine
		rm -rf /usr/bin/polyverse/docker

		# Add the Docker RPM Repo
		echo "Docker Engine Version: $DOCKER_VERSION"
		echo "Installing Docker as a straight binary and to /usr/bin/polyverse/docker"
		wget https://get.docker.com/builds/Linux/x86_64/docker-$DOCKER_VERSION  >& /dev/null;
		mkdir /usr/bin/polyverse
		mv docker-$DOCKER_VERSION /usr/bin/polyverse/docker
		chmod a+x /usr/bin/polyverse/docker
		export PATH=$PATH:/usr/bin/polyverse

		echo "Installing cgroupfs-mount scripts for manual provisioning"
		installFile "$internal_files" "/usr/bin/polyverse/cgroupfs-mount"
		installFile "$internal_files" "/usr/bin/polyverse/cgroupfs-mount.8"
		installFile "$internal_files" "/usr/bin/polyverse/cgroupfs-umount"

		chmod a+x /usr/bin/polyverse/cgroupfs-mount
		chmod a+x /usr/bin/polyverse/cgroupfs-mount.8
		chmod a+x /usr/bin/polyverse/cgroupfs-umount

		echo "Mounting cgroupfs"
		/usr/bin/polyverse/cgroupfs-mount
	fi
}

provisionMachineRedHat()
{
	echo "Upgdate all yum packages - except docker which we version strictly."
	if [ "$DRYRUN" == "" ]; then
		# We're on RedHat or similar
		yum -y update --exclude=docker-engine >/dev/null 2>&1
		yum install -y curl >/dev/null 2>&1
		yum install -y jq >/dev/null 2>&1
		yum install -y wget >/dev/null 2>&1
		yum install -y collectd >/dev/null 2>&1

		echo "Uninstalling docker so we are assured of the correct version."
		yum erase -y docker-engine

		# Add the Docker RPM Repo
		installFile "$internal_files" "/etc/yum.repos.d/docker.repo" "true"
		echo "Docker Engine Version: $DOCKER_VERSION"
		yum install -y docker-engine-$DOCKER_VERSION >/dev/null 2>&1
	fi
}

provisionMachineUbuntu()
{
	echo "Apt-get update all packages except docker-engine (which we lock to a specific version.)"
	echo "Install the following packages: wget, curl and collectd"
	if [ "$DRYRUN" == "" ]; then
		if [ "$(which docker)" != "" ]; then
		#	echo "Removing Docker Engine to ensure strict versioning is enforced"
		#	apt-get remove --force-yes -y docker-engine
			sudo apt-mark hold docker-engine >/dev/null 2>&1
		fi
  		apt-get update >/dev/null 2>&1
  		apt-get -y upgrade  >/dev/null 2>&1
  		apt-get install -y curl >/dev/null 2>&1
  		# apt-get install -y jq >/dev/null 2>&1
  		apt-get install -y wget >/dev/null 2>&1
  		apt-get install -y collectd >/dev/null 2>&1
 		apt-get install -y apt-transport-https ca-certificates >/dev/null 2>&1
 		apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D >/dev/null 2>&1
		export ubuntuVersion=$(lsb_release -a 2>&1 | grep 'Codename:' | awk '{ print $2 }')
		installFile "$internal_files" "/etc/apt/sources.list.d/docker.list" "true"
		apt-get update
		apt-get purge lxc-docker
 		apt-get install -y linux-image-extra-$(uname -r) >/dev/null 2>&1
 		apt-get update >/dev/null 2>&1

  		echo "Installing Docker Engine Version: $DOCKER_VERSION"
 		apt-get install -y docker-engine=$DOCKER_VERSION-0~$ubuntuVersion >/dev/null 2>&1
	fi
}

configureDocker()
{
	installFile "$internal_files" "/etc/systemd/system/docker.service" "true"
	installFile "$internal_files" "/etc/default/docker" "true"
	installFile "$internal_files" "/etc/sysconfig/docker" "true"

	if [ "$DRYRUN" == "" ]; then
		mkdir -p /root/.docker
		installFile "$internal_files" "/root/.docker/config.json" "true"
	fi

}

configureVolumeDriver()
{
	if [[ "$volume_driver" == "rexray" ]]; then
		echo "This installation asked for the RexRay volume driver. Installing it now...."
		curl -sSL https://dl.bintray.com/emccode/rexray/install | sh -
	fi
}

configureSystem()
{

	#change some kernel threads/pid limits
	echo "Changing kernel limits (kernel.threads-max=1048576, kernel.pid_max=1038576)"
	if [ "$DRYRUN" == "" ]; then
		sysctl kernel.threads-max=1048576
		sysctl kernel.pid_max=1048576

		installFile "$internal_files" "/etc/security/limits.conf" "true"
	fi

	configureCollectd
}


stopDocker()
{
	echo "Stopping docker (making sure)"
	if [ "$DRYRUN" == "" ]; then
		if [[ -f /usr/bin/polyverse/docker ]]; then
			echo "A wildcard docker kill (necessary for Amazon Linux)"
			killall docker
		elif [[ -f /sbin/init ]] && [[ $(/sbin/init --version 2>&1) =~ upstart ]]; then
			echo "Detected upstart."
			if [ "$(which docker)" != "" ]; then
				service docker stop 2>&1
			fi
		elif [[ $(systemctl) =~ -\.mount ]]; then
			echo "Detected systemd."
			systemctl stop docker 2>&1
		elif [[ -f /etc/init.d/cron && ! -h /etc/init.d/cron ]]; then
			echo "SysV-init detected."
			service docker stop 2>&1
		else
			echo "Init system not detected. This script supports init, upstart or systemd."
			echo "Aborting installation."
			exit 1
		fi

		if [ "$(type docker 2>&1 | grep "docker is")" != "" ]; then
                        if [[ "$(docker info)" != "" ]]; then
                                echo "Docker service failed to stop. Aborting script. Please see logs/errors for diagnostics."
                                exit 1
                        fi
		fi
	fi
}

startDocker()
{
	echo "Starting docker (making sure by doing it twice - occasionally it needs two restarts to bootstrap)"
	if [ "$DRYRUN" == "" ]; then
		if [[ -f /usr/bin/polyverse/docker ]]; then
			echo "Starting Docker from /usr/bin/polyverse/docker directly"
			nohup /usr/bin/polyverse/docker daemon  -D --storage-driver=$storage_driver $expanded_storage_opts --host=tcp://0.0.0.0:2375 --userland-proxy=false >& /var/log/docker.log &
		elif [[ -f /sbin/init ]] && [[ $(/sbin/init --version 2>&1) =~ upstart ]]; then
			echo "Detected upstart."
			service docker restart 2>&1
			service docker restart 2>&1
		elif [[ $(systemctl) =~ -\.mount ]]; then
			echo "Detected systemd."
			systemctl daemon-reload 2>&1
			systemctl restart docker 2>&1
			systemctl restart docker 2>&1
		elif [[ -f /etc/init.d/cron && ! -h /etc/init.d/cron ]]; then
			echo "SysV-init detected."
			service docker restart 2>&1
			service docker restart 2>&1
		else
			echo "Init system not detected. This script supports init, upstart or systemd."
			echo "Aborting installation."
			exit 1
		fi

		sleep 10
		if [[ "$(docker info)" == "" ]]; then
			echo "Docker service failed to start. Aborting script. Please see logs/errors for diagnostics."
			exit 1
		fi
	fi
}

restartVolumeDriver()
{
	if [[ "$volume_driver" == "rexray" ]]; then
		echo "Stopping the rexray service...."
		rexray stop

		echo "Starting the rexray service...."
		rexray start
	fi
}

removeDockerDir()
{
    if [[ -f "/var/lib/docker" ]]; then
        echo "Removing /var/lib/docker (to wipe clean any remaining containers)"
        rm -rf /var/lib/docker
    fi
}



pullImages()
{
	if [ "$DRYRUN" == "1" ]; then
		docker_images_from_vfi=$(echo "$vfi" | $JQ -c -r -M 'to_entries | .[] | .key + ":" + .value' | $TR "\n" "\t")
		echo "Pull docker images: $docker_images_to_pull  $docker_images_from_vfi"
	else
		for image in $docker_images_to_pull  $(echo "$vfi" | $JQ -c -r -M 'to_entries | .[] | .key + ":" + .value' | $TR "\n" "\t")
		do
			echo Pulling $image
			echo -----------------------------------------------------------------------------------------------
			pullImageOrExit "$image"
		done
	fi
}

pullImageOrExit()
{
	if docker pull $1  2>&1 | grep Error; then
		echo "There was an error pulling image $1. Unable to proceed with Polyverse installation."
		echo "This may be an issue with your Dockerhub authentication. Check Docker authentication and try again."
		echo "To further diagnose this error, you can try:"
		echo "export DOCKER_HOST=tcp://0.0.0.0:2375"
		echo "docker pull $1"
		exit 1
	fi
}


startLocalGrafana()
{
	if [[ "$statter_endpoint" == "127.0.0.1:8125" ]]; then
		echo "Starting Grafana container... (usually takes a couple minutes)"
		if [ "$DRYRUN" == "" ]; then
			echo "Pulling polyverse/logging..."
			pullImageOrExit "polyverse/logging"
			docker run -d --name=polyverse_graphite -p 8888:8888 -p 2003:2003 -p 8125:8125/udp polyverse/logging $PRIVATE_IP
		fi
	fi

}



startLocalLogPortal()
{
	if [[ "$logger_endpoint" == "127.0.0.1:12201" ]] && [[ "$log_driver" == "gelf" ]]; then
		echo "Starting Graylog container... (usually takes a couple minutes)"
		if [ "$DRYRUN" == "" ]; then
			echo "Pulling graylog2/allinone..."
			pullImageOrExit "graylog2/allinone"
			docker run -d --name polyverse_logs -p 9000:9000 -p 12201:12201/udp -p 12900:12900 -e GRAYLOG_USERNAME=polyverse -e GRAYLOG_PASSWORD=polyverse -e GRAYLOG_TIMEZONE=US/Pacific -e GRAYLOG_RETENTION="--time=1 --indices=24" -e ES_MEMORY=1g graylog2/allinone
			GRAYLOG_STARTED="false"
			while [ "$GRAYLOG_STARTED" == "false" ]; do
				out=$(docker logs polyverse_logs 2>&1 | grep "Graylog server up and running." | wc -l)
				if [[ $out == "1" ]]; then
					GRAYLOG_STARTED="true"
					echo "--> Graylog server up and running at http://$PRIVATE_IP:9000..."
				else
					echo "--> Waiting for Graylog initialization to complete. Sleeping for 30 seconds..."
					sleep 30
				fi
			done
		fi
		echo "Installing Graylog content-pack to setup input listener 12201/udp..."

		echo "cat GRAYLOG_CONTENT_PACK_SOURCE_HERE  > content_pack"

		if [ "$DRYRUN" == "" ]; then
			installFile "$internal_files" "content_pack" "true"
			export CONTENT_PACK=$(cat content_pack)
			echo $CONTENT_PACK
			uri=$(curl -s -v -u polyverse:polyverse -X POST -H "Content-Type: application/json" -d "$CONTENT_PACK" http://$logger_endpoint/system/bundles 2>&1 | grep "Location" | awk '{ print $3 }' | $TR -d '\r')

			echo "Content pack uri: ${uri}"
			enableUri="${uri}/apply"

			echo "Enabling content-pack: ${enableUri}"
			curl -s -v -u polyverse:polyverse -X POST $enableUri

			#echo -e '{"host":"$PRIVATE_IP","short_message":"setup_customer.sh"}\0' | nc -u -w 1 $logger_endpoint
		fi
	fi

}


startPolyverseSupervisor()
{
	CLUSTERING_OPTS="-clustering-method=$clustering_method"
	if [[ ! "$etcd_discovery_url" == "" ]]; then
		CLUSTERING_OPTS="$CLUSTERING_OPTS -discovery-url=$etcd_discovery_url"
	fi

	LOGGER_OPTS="--log-driver='$(removeNewlines "$log_driver")'"
	if [[ "$log_driver" == "gelf" ]] && [[ "$log_opts" == "" ]]; then
		LOGGER_OPTS="$LOGGER_OPTS --log-opt gelf-address=udp://$(removeNewlines "$logger_endpoint")"
	elif [[ "$expanded_log_opts" != "" ]]; then
		  LOGGER_OPTS="$LOGGER_OPTS $expanded_log_opts"
	fi

	export SUPERVISOR_CMD='docker run -d --net=host --name=polyverse_supervisor -e PVSCRAMBLE='"'"$(removeNewlines "$pvscramble")"'"' --restart=always  \
	  '$LOGGER_OPTS' \
      polyverse/supervisor:'$(removeNewlines "$SUPERVISOR_TAG")' -polyverse-tag='"'"$(removeNewlines "$POLYVERSE_TAG")"'"' \
      '$CLUSTERING_OPTS' \
			-pvscramble='"'"$(removeNewlines "$pvscramble")"'"' \
      -docker-host='"'"tcp://$(removeNewlines "$PRIVATE_IP"):2375"'"' -swarm-endpoint='"'"tcp://$(removeNewlines "$PRIVATE_IP"):3376"'"'  \
      -ip-addr='"'"$(removeNewlines "$PUBLIC_IP")"'"' -private-ip-addr='"'"$(removeNewlines "$PRIVATE_IP")"'"' \
      '$LOGGER_OPTS' -statsd-endpoint='"'"$(removeNewlines "$statter_endpoint")"'"' \
      -router-seal-key='"'"$(removeNewlines "$router_seal_key")"'"' -force-pull=false -vfi='"'"$(removeNewlines "$vfi")"'"' \
      -router-port='"'"$(removeNewlines "$router_port")"'"' \
      -volume-driver='"'"$(removeNewlines "$volume_driver")"'"' \
      -startup-etcd-keys='"'"$(removeNewlines "$ETCD_KEYS_OPTION")"'"


	# Start supervisor
	echo "Starting Polyverse supervisor"
	echo "Supervisor Command: $SUPERVISOR_CMD"
	if [ "$DRYRUN" == "" ]; then
		echo -----------------------------------------------------------------------------------------------
		eval "$SUPERVISOR_CMD" 2>&1
		echo -----------------------------------------------------------------------------------------------
	fi

	echo It should have worked.
}



waitForEtcdClusterHealthy()
{
        if [ "$DRYRUN" == "" ]; then
                CLUSTER_HEALTH="false"
    			count=0
                while [ "$CLUSTER_HEALTH" == "false" ]; do
                        echo "Attempting to connect to ETCD Cluster...."
                        out=$(docker run --rm --entrypoint=/etcdctl --net=host quay.io/coreos/etcd:$ETCD_TAG cluster-health 2>&1)
                        if [[ $out =~ "cluster is healthy" ]]; then
                                echo "Cluster is now ready. Proceeding to write keys."
                                CLUSTER_HEALTH="true"
                        else
                        	if [[ count -gt 10 ]] ; then
						   		echo "etcd cluster failed to come up. Failing the test"
						   		exit 1
        					fi
        					count=$(expr $count + 1)
                            echo "Cluster is still spinning up.... Sleeping for 10 seconds."
                            sleep 10
                        fi
                done
        fi
}

installRouteDef()
{
	echo "Installing customer routedef (only when different from the existing routedef)"
	setEtcdKeyIfNotChanged  "/polyverse-apps/$app_name" "$route_def"
}

installListenerSettings()
{
	if [ "$ssl_required" == "true" ]; then
		export SSL_HOST_SETTINGS='{"Name": "'"$ssl_hostname"'", "Settings": {"Default": true, "KeyPair": "'"$router_sealed_ssl_keypair"'"}}'

		echo "SSL Host settings: /polyverse-router/hosts/$ssl_hostname/host = $SSL_HOST_SETTINGS"
		setEtcdKeyIfNotChanged "/polyverse-router/hosts/$ssl_hostname/host" "$SSL_HOST_SETTINGS"

		export SSL_LISTENER='{"Protocol":"https", "Address":{"Network":"tcp", "Address":"0.0.0.0:'"$router_port"'"}}'
			echo "Making default listeniner HTTPS: /polyverse-router/listeners/secure = $SSL_LISTENER"
		setEtcdKeyIfNotChanged "/polyverse-router/listeners/secure" "$SSL_LISTENER"
	else
		export HTTP_LISTENER='{"Protocol":"http", "Address":{"Network":"tcp", "Address":"0.0.0.0:'"$router_port"'"}}'
			echo "Making default listeniner HTTP: /polyverse-router/listeners/insecure = $HTTP_LISTENER"
		setEtcdKeyIfNotChanged "/polyverse-router/listeners/insecure" "$HTTP_LISTENER"
	fi

}

setEtcdKeyIfNotChanged()
{
	prevValue=$(docker run --rm --entrypoint=/etcdctl --net=host quay.io/coreos/etcd:$ETCD_TAG get "$1" 2>&1)
	if ( [ "$2" == "$prevValue" ] ); then
		echo "The existing value for key $1 is the same as the one we were going to set. Not setting it."
	else
		echo "The existing value for key $1 is NOT the one we want. Setting it now..."
		if [ "$DRYRUN" == "1" ]; then
			echo "Existing Value: $prevValue"
			echo "New Value: $2"
		else
			docker run --rm --entrypoint=/etcdctl --net=host quay.io/coreos/etcd:$ETCD_TAG set "$1" "$2" 2>&1
		fi
	fi
}

detectIPAddresses()
{
	echo "Determining the IP Address scheme"

	if [ "$PRIVATE_IP" == "autodetect" ]; then
		echo "Autodetection of IP Requested. This ONLY work if we are on EC2."

		# Collect parameters for EC2
		export PRIVATE_IP=$(wget -qO- http://instance-data/latest/meta-data/local-ipv4)
		export PUBLIC_IP=$(wget -qO- http://instance-data/latest/meta-data/public-ipv4)

		# Autodetect fallback
		if [ "$PRIVATE_IP" == "" ]; then
			export PRIVATE_IP=$(curl http://169.254.169.254/latest/meta-data/local-ipv4)
		fi

	if [ "$PUBLIC_IP" == "" ]; then
		export PUBLIC_IP=$(curl http://169.254.169.254/latest/meta-data/public-ipv4)
	fi

		echo "PUBLIC_IP autodetected as: $PUBLIC_IP"
		echo "PRIVATE_IP autodetected as: $PRIVATE_IP"
	else
		echo "PRIVATE_IP provided as $PRIVATE_IP. Using it."
	fi

	if [ "$PUBLIC_IP" == "" ]; then
		export PUBLIC_IP=$PRIVATE_IP
	fi
}

configureCollectd()
{
	if [ "$graphite_endpoint" != "" ]; then
	  echo "collectd will send metrics to $graphite_endpoint."
          IFS=':' read -a sep <<< "$graphite_endpoint"

	  if [ -f "/etc/collectd.conf" ]; then
		installFile "$internal_files" "/etc/collectd.conf" "true"
	  elif [ -f "/etc/collectd/collectd.conf" ]; then
		installFile "$internal_files" "/etc/collectd/collectd.conf" "true"
	  fi

	  echo "Restarting collectd..."
		if [[ "$DRYRUN" == "" ]] && [[ -f /etc/init.d/collectd ]]; then
			/etc/init.d/collectd restart 2>&1
		fi
	fi
}


runPostStartupScript()
{
	echo "Now executing customer-provided post-startup script"
	if [ "$DRYRUN" == "1" ]; then
		echo "$post_startup_script"
	else
		eval "$post_startup_script"
	fi
}

main $@
