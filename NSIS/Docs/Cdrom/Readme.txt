*****************************************************************
***                  CDRom NSIS plugin v1.0                   ***
*****************************************************************

2005 Shengalts Aleksander aka Instructor (Shengalts@mail.ru)


Features:
1. Open/Close CD-ROM door
2. Get CD-ROM status (ready, not ready)
3. Get CD-ROM information (volume name, volume serial number)
4. Find all CD-ROMs in the system (based on EnumCDs plugin)


**** Output variables ****
.r0-.r9 == $0-$9
.R0-.R9 == $R0-$R9


**** Open CD-ROM door ****
cdrom::Open "[disk]" .r0

"[disk]"      - Disk (e.g. "E:")
                if empty, then first CD-ROM drive will be used

.r0  - $0=0  success
       $0=-1 error

Note:
Virtual CD-ROM also will be ejected


**** Close CD-ROM door ****
cdrom::Close "[disk]" .r0

"[disk]"      - Disk (e.g. "E:")
                if empty, then first CD-ROM drive will be used

.r0  - $0=0  success
       $0=-1 error


**** Get CD-ROM status ****
cdrom::Status "[disk]" .r0

"[disk]"      - Disk (e.g. "E:")
                if empty, then first CD-ROM drive will be used

.r0  - $0=1  ready
       $0=0  not ready
       $0=-1 error


**** Get CD-ROM volume name ****
cdrom::VolumeName "[disk]" .r0

"[disk]"      - Disk (e.g. "E:")

.r0  - $0=name
       $0=""  error


**** Get CD-ROM volume serial number ****
cdrom::VolumeSerialNumber "[disk]" .r0

"[disk]"      - Disk (e.g. "E:")

.r0  - $0=number
       $0=""  error


**** Enumerate CD-ROMs ****

#### Find first and next CD-ROMs ####
cdrom::FindNext /NOUNLOAD .r0

.r0  - $0=disk (e.g. "E:\")
       $0=""  done

#### Close search ####
cdrom::FindClose
