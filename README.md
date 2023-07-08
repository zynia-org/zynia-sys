# zynia-sys
Scripts, etc for building zynia on top of an OS

To build Zynia:

1.  Create SD card conatining latest Debian release for the VisionFive2 board from rvspace.org.
2.  Boot the VF2 board using this SD card; username is "user"; password is "starfive"
3.  Open a terminal and get the osconfig.sh and zynia.sh scripts using:
     `wget https://github.com/zynia-org/zynia-sys/releases/latest/download/osconfig.sh`
     `wget https://github.com/zynia-org/zynia-sys/releases/latest/download/zynia.sh`
4.  Run the osconfig.sh script using: `bash osconfig.sh`
    This will ask for the following:
       > a. Password for current "user" account (which is "starfive").
       >
       > b. Username for new user account to create for all further uses of this SD card
       >
       > c. Full name and email corresponding for username account (for git configuration)
       > 
       > d. Passwd for new username account

    It will ten run for several minutes (10 minutes?) while it downloads, installs and configures the basic OS setup.

    When its finished it will automatically reboot.

5.  When it comes back up, login with the new user account (i.e., NOT the account named "user")

6.  Open a terminal and run `bash zynia.sh`.

    This will run unattended for 10+ minutes while it downloads, installs, and configures the various components of the currrent zynia configuration.

    When its done, it will automatically reboot.

7.  Login as the new user account. 

8.  Some of the things you can now do are:

One
1.  Start QJackCtrl (via the Activities button in upper left, then the 3x3 Matrix, then clicking on QJackCtrl icon)
2.  From QJackCtrl UI open the Graph window.
3.  Open a Terminal.
4.  In terminal: cd /usr/share/sounds
5.  In terminal: fluidsynth -n -i -a jack sf2/FluidR3_GM.sf2 midi/Fur\ Elise.mid
6.  Fluidsynth should show up in the Jack graph.  You will need to connect its outputs to the System playback ports.  Then you should hear the music via the earphone jack.
7.  You can also switch the "-a jack" to "-a pulseaudio" in the fluidsynth invocation above and the output will come via HDMI.
8.  There are other sf2 and midi files you can try in the sf2 and midi folders in /usr/share/sounds.

Two.
1.  QJackCtrl and terminal as above
2.  In terminal: jalv.gtk3 http://invadarecords.com/plugins/lv2/testtone
3.  In the QJackCtrl graph: connect the testtone out port to one or more system playback ports.
4.  Should hear testtone, freq of which can be changed by UI for testone that pops up.
5.  In terminal:  "lv2ls" will list all the LV2 plugins that I downloaded
6.  You can jalv.gtk3 one or more of these and connect them up in the QJackCtrl graph to get what sounds you want.

Three.
1.  QJackCtl as above
2.  From the 3x3 grid place (what the hell do they call that) click on the ZynAddFx-Jack icon.
3.  Connect things up in the QJackCtrl graph
4.  Play the virtual keyboard in the ZynAddFx UI - should get sound from the earphone jack.
5.  BTW: I haven't been able to get the  ZynAddFx-Alsa version to work via HDMI.

