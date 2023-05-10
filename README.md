##### Create vm with terraform on proxmox


qm create 905 --name suse-15.4-min --memory 1024 --core 1 --cpu host --numa 1 --sockets 1 --net0 virtio,bridge=vmbr0

qm importdisk 905 openSUSE-Leap-15.4-Minimal-VM.x86_64-OpenStack-Cloud.qcow2 local

qm set 905 -scsihw virtio-scsi-pci --scsi0 local:905/vm-905-disk-0.raw --ide2 local:cloudinit --boot c --bootdisk scsi0 --serial0 socket --vga serial0 --agent enabled=1





###### Source the image
$ wget http://cdimage.debian.org/cdimage/openstack/current-10/debian-10-openstack-amd64.qcow2

##### Create the instance
qm create 9000 -name debian-cloudinit -memory 1024 -net0 virtio,bridge=vmbr0 -cores 1 -sockets 1

##### Import the OpenStack disk image to Proxmox storage
qm importdisk 9000 debian-10-openstack-amd64.qcow2 local-lvm

##### Attach the disk to the virtual machine
qm set 9000 -scsihw virtio-scsi-pci -virtio0 local-lvm:vm-9000-disk-0

##### Add a serial output
qm set 9000 -serial0 socket

##### Set the bootdisk to the imported Openstack disk
qm set 9000 -boot c -bootdisk virtio0

##### Enable the Qemu agent
qm set 9000 -agent 1

##### Allow hotplugging of network, USB and disks
qm set 9000 -hotplug disk,network,usb

##### Add a single vCPU (for now)
qm set 9000 -vcpus 1

##### Add a video output
qm set 9000 -vga qxl

##### Set a second hard drive, using the inbuilt cloudinit drive
qm set 9000 -ide2 local-lvm:cloudinit

##### Resize the primary boot disk (otherwise it will be around 2G by default)
##### This step adds another 8G of disk space, but change this as you need to
qm resize 9000 virtio0(sc) +8G

##### Convert the VM to the template
qm template 9000