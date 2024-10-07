# VLC Create playlist from file

These scripts make VLC behave like MPC-HC, ie when you open a file with VLC in a folder,
it will automatically add all the files in this folder to the playlist (starting with the opened file, then sorted alphabetically),
so that you can use Previous and Next to navigate through the folder.

## Usage

### Linux using NVIDIA dGPU

Copy vlc_next.sh to ```~/.local/bin/vlc_next.sh``` and mark it executable, then copy the vlc-next.desktop file to ```~/.local/share/applications/vlc-next.desktop``` and change the $USER with your own username since .desktop files must use the absolute path on the line with ```Exec=/home/$USER/.local/bin/vlc_next.sh```.

You may want to activate the loop option in VLC preferences if VLC is configured to play the next track automatically.

## Notes

Due to internal behaviour of VLC, you cannot replace current playlist by another, only append it. Therefore the script must kill existing instances of VLC to launch a new playlist, so it works only when VLC is in one-instance mode. 

You must use ```VDPAU video decoder``` on the CODECS page of vlc in ```Hardware accelerate decoding```.
