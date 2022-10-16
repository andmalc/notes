

# Podman {{{1

Examples 
	https://www.mankier.com/1/podman-run#Examples
	create named container, attaches to terminal, stops cont. on shell exit
		podman run --name toolbox --hostname toolbox --network=bridge -v /home/:/home -it toolbox /bin/bash


Perist container after logout
    https://www.redhat.com/sysadmin/sudo-rootless-podman
    Need to prevent temp folder in /run/user/UID being destroyed on logout
    Use loginctl enable-linger for this
    Also allows sudo with rootless container


## Images {{{2

images
	lists images

subcommand image

	build 
		Build image from Dockerfile
		Runs Buildah in background

		[image] build -t podbuilt .

	load 
		Load image from a local saved archive
		-i filename

	login <URL>
		login to container registry
	
	pull

	save 
		Save image to an archive
		save -o myhttp.tar --format oci-archive myhttpd

	tag
		Add an additional name to a local image
		<image ID> <tag>



### Image storage {{{3

Default repository
/var/lib/containers/storage

Vs. Docker storage
/var/lib/docker

Get image from repo
    docker login docker.io
    podman -t hello-world docker.io/asamalik/hello-world

Push to Docker storage
    buildah push fedora-bashecho docker-daemon:fedora-bashecho:latest

Push to Docker.io
    buildah push echo docker.io/andmalc/echo:blog


## Containers {{{2

attach
    attach to running container

commit
    create new image from changed container

create 
    create but do not start container

diff
    inspect changes in container filesystem

exec
    run command in a container
		exec -it <ID> bash

export
    Export container fs to tar archive
    podman export $(podman create alpine) | tar -C rootfs -xvf -

Listing containers
	ps | ls [-a/--all]
	also containers ps | ls
    list containers, defaults to running

mount
    Mount a working container’s root filesystem

rm
	remove

start
    start stopped container
    cannot add command or change configuration

top 
    show processes running within container


## run {{{2

[man](https://github.com/containers/libpod/blob/master/docs/podman-run.1.md)


run command in a new container 
	`run <container> <options> -- <cmd>`


Options

-d  run as daemon
--hostname
--tt
--volume value, -v value
    mount a host location into the container 

--rm=true

--runtime path  
    default runc

-p 
    Ports by default not accessible, must bind with -p 
    -p <host port>:<container port>

-v
    bind mount volume
    hostdir:containerdir:options

    Options:
        default rw


in production
    runc - lightweight universal run time container,
    containerd - complete container lifecycle runtime, uses runc
    CRI-O 
%%%%



## Info {{{2

info 
    Display system info

inspect
    show container info

history
    show history of image

logs 
	fetch logs of a container

ports <cont>
    show all port mappings or for container

top <container id>
    show process info: USER, Process ID, Parent Process ID

# Buildah {{{1

https://github.com/projectatomic/buildah
buildah <cmd> <options> <container ID>

## config {{{2

https://github.com/projectatomic/buildah/blob/master/docs/buildah-config.md

config <options> <container>

--cmd
    buildah config --cmd /bin/bash $newcontainer

--entrypoint
    default command

--port
--user
    guid or name if in /etc/passwd
--workingdir
    

## copy {{{2

Copy file into container
buildah copy <options> <container> SRC [[...] DEST]

Options
    --chown owner:group

Example
    buildah copy --chown myuser:mygroup containerID '/myapp/app.conf' '/myapp/app.conf'

## commit {{{2

Saves working container to image available to run by podman or runc

commit <container> <image>

## from

https://github.com/projectatomic/buildah/blob/master/docs/buildah-from.md

Create container from image 
from <options> <image>

Options
    --name new container name
    --volume/-v <host-dir>:<container-dir>:<options> (:Z,:z etc.)

Example
    container=$(buildah from fedora)

## run

Run command in container 
    run <container> [<cmd>]

Buildah run does not execute entrypoint

## mount

<container ID>  mounts root fs of container, returns mnt point
<no args>       lists mounts

## Buildah Examples {{{2

Install package in container
    buildah run $contaidner -- dnf -y install java


scratchmnt=$(buildah mount $newcontainer)
echo $scratchmnt #see path of mount

buildah run -v /var/roothome:/root:rslave fedora-working-container bash

    -b <bundle dir - default current>


# Toolbox {{{1

Install on Ubuntu & other distros: distrobox

create 
	Create custom container.  Name is same as image plus image tag if exists
	
	toolbox create --image <image ID or name> <new container name>
	-d/--distro	+ -r/--release
		specify distro to use, otherwise default's to host's
	-i/--image
		specify image to use


list [-c/--containers | -i/--images]
	lists containers & images

Backup toolbox: https://fedoramagazine.org/backup-and-restore-toolboxes-with-podman/

# Distrobox {{{1

Run command
flatpak run io.github.luca.distrobox enter  fed36-distrobox


# Misc {{{1

Image Registries

	Fedora Registry
	https://registry.fedoraproject.org/

Filesystem issues 

	Mount host dir into container
	chcon -Rt svirt_sandbox_file_t <dir>
	    --volume/-v <host-dir>:<container-dir>:<options> (:Z,:z etc.)

	Permissions issue fix:
	    chcon -R -h -t container_file_t /var/roothome

	Share local files with containers
	sudo chcon -R -h -t container_file_t /srv
	buildah run -v /srv:/srv:rslave fedora-working-container bash


Running a server

Pull image.
Inspect to show metadata
Repo
    repo name and id
ContainerConfig
    User 
    Exposed Ports 
    Env environment vars etc.
    Entrypoint
    Cmd
    Working dir


Run container in forground (no -d), executes Cmd
Now has network info e.g.  published ports and address
podman ps
podman inspect -l | grep IPAddress\":

Container logs for monitoring in daemon mode
podman logs --latest

Container processes
podman top <container_id>

Run shell 
podman exec -u root -it <container> /usr/bin/bash

User ID inside container
Need to make this ID owner of mounted storage
podman inspect -l | grep -i user


Show host's addresses
ip a show dev eth0

Firewalld services
firewall-cmd --list-services
firewall-cmd --add-service http




