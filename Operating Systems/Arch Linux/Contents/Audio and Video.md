# Audio and Video

PipeWire is now superseding PulseAudio when it comes to handling audio and video streams on Linux systems. We are going to install it on our system.

```bash
paru -S pipewire pipewire-audio pipewire-pulse lib32-pipewire \
	easyeffects playerctl wireplumber \
	gst-libav gst-plugins-base \
	gst-plugins-{good,bad,ugly} gstreamer-vaapi \
	x265 x264 lame
```

-----

-  Previous: [[Setting Up Swaylock]]
- Next: [[Setting Up The Browsers]]
