# WINDOWS BOOT NOTES

<https://www.nvidia.com/en-us/geforce/forums/game-ready-drivers/13/54045/the-nvlddmkm-error-what-is-it-an-fyi-for-those-s/>

RAM testing: PASS
installing <https://memtest.org/> Memtest86 to external USB

- IMC frequency of 1330MHz effectively supports memory speeds up to 2660MHz (1330MHz x 2)
- UEFI > XMP profile easiest way to overclock RAM to supported 3600MHz :: windows did not boot < use GPU-Z to confirm RAM speed
— manual overclocking

REINSTALL WINDOWS
<https://support.microsoft.com/en-us/windows/reinstall-windows-d8369486-3e33-7d9c-dccc-859e2b022fc7#bkmk_clean_install_of_windows_10_using_installation_media>

## BSOD NTFS.SYS

wmic > diskdrive get status
possible issue with disk, will do mem

- <https://crystalmark.info/en/software/crystaldiskmark/> OR
- <https://semiconductor.samsung.com/consumer-storage/magician/>

## EXTERNAL USB INSTALL WINDOWS

- installer failed to create suitable drive to install win11 in
<https://www.thewindowsclub.com/windows-setup-couldnt-create-a-new-partition-or-locate-an-existing-one>
- diskpart :: partitions, volumes, drive mount point, formats
- UEFI > set SATA controller OFF had no effect

### DISKPART

DISK > VOLUME > PARTITION >

`diskpart`> `list disk`

FAT32 filesystem max filesize is 4 GB, when createing bootable USB install.wim >split> install.swm + install2.swm

## BOOTABLE WINDOWS USB CREATION

!WORKING: balenaetcher >> unetbootin

- [bootable windows usb on macOS](https://onmac.net/create-bootable-windows-usb-on-mac/) - manual creation with `wimlib-imagex` worked

- [ventoy](https://itsfoss.com/use-ventoy/) - multiple bootable distros on one USB

## explorer.exe class not registered

## reinstall Windows from 8 GB USB

Seem to have less issues with RTX 3060 compared to RTX 4070 SUPER. Stuttering and nvlmddmkm errors in Event Viewer.

- UEFI boots into 2560 x 1440p with RTX 4070 SUPER and 4K with RTX 3060, which is weird behaviour > auto switch to 4K takes a while but happens
- - maybe something with drivers

- missing Internet Edge

[ ] CMOS reset
[ ] DDU driver reinstall
