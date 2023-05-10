#### iso links:
```
debian  http://cdimage.debian.org/cdimage/cloud/
ubuntu  https://cloud--images-ubuntu-com.translate.goog/?_x_tr_sl=en&_x_tr_tl=ru&_x_tr_hl=ru&_x_tr_pto=sc
suse    https://get.opensuse.org/leap/15.4/#


examle:

$ wget http://cdimage.debian.org/cdimage/openstack/current-10/debian-10-openstack-amd64.qcow2

```



### Create vm on proxmox

- Create the instance
```
qm create 905 --name suse-15.4-min --memory 1024 --core 1 --cpu host --numa 1 --sockets 1 --net0 virtio,bridge=vmbr0
```



- Import the OpenStack disk image to Proxmox storage
```
qm importdisk 905 openSUSE-Leap-15.4-Minimal-VM.x86_64-OpenStack-Cloud.qcow2 local
```



- Attach the disk to the virtual machine
- Set a second hard drive, using the inbuilt cloudinit drive
- Set the bootdisk to the imported Openstack disk
- Add a serial output
- Add a video output
- Enable the Qemu agent
```
qm set 905 -scsihw virtio-scsi-pci --scsi0 local:905/vm-905-disk-0.raw --ide2 local:cloudinit --boot c --bootdisk scsi0 --serial0 socket --vga serial0 --agent enabled=1
```



- Resize the primary boot disk (otherwise it will be around 2G by default)
- This step adds another 8G of disk space, but change this as you need to
```
qm resize 9000 virtio0(sc) +8G
```



- Convert the VM to the template
```
qm template 9000
```