# #!/usr/bin/env bash
if [[ $UNAME -ne 'Darwin' ]]; then
  # video modes
  VM_U2713HM="U2713HM"
  VM_U2713HM_MODELINE="172.80 1920 2040 2248 2576  1080 1081 1084 1118 -hsync +vsync"
  VM_WORK=$VM_U2713HM
  VM_SURFACE_SCALED="109.50  1368 1448 1592 1816  768 771 781 805 -hsync +vsync"
  VM_B2440="172.80  1920 2040 2248 2576  1080 1081 1084 1118  -hsync +vsync"
  DISPLAY_INTERNAL=`xrandr | sed -n 2p | cut -f1 -d$' '`

  # define some video modes for different monitor configurations
  xrandr --newmode "$VM_U2713HM" $VM_U2713HM_MODELINE &> /dev/null
  xrandr --newmode "INTERNAL_SCALED" $VM_SURFACE_SCALED &> /dev/null
  xrandr --newmode "VM_B2440" $VM_B2440 &> /dev/null
fi

