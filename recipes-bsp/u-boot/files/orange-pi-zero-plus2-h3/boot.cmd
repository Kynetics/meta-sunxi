# Default to (primary) SD
rootdev=mmcblk0p2
if itest.b *0x28 == 0x02 ; then
	# U-Boot loaded from eMMC or secondary SD so use it for rootfs too
	echo "U-boot loaded from eMMC or secondary SD"
	rootdev=mmcblk2p2
fi
setenv bootargs console=${console} console=tty1 root=/dev/${rootdev} rootwait panic=10 ${extra}
load mmc ${devnum}:1 ${fdt_addr_r} ${fdtfile} || load mmc ${devnum}:1 ${fdt_addr_r} boot/${fdtfile}
load mmc ${devnum}:1 ${kernel_addr_r} zImage || load mmc ${devnum}:1 ${kernel_addr_r} boot/zImage || load mmc ${devnum}:1 ${kernel_addr_r} uImage || load mmc ${devnum}:1 ${kernel_addr_r} boot/uImage
bootz ${kernel_addr_r} - ${fdt_addr_r} || bootm ${kernel_addr_r} - ${fdt_addr_r}
