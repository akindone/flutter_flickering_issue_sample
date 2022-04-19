# flickering_sample

After upgrade flutter 2.10.x, the flickering happens occasionally on iOS devices;
This sample stable recurrence the flickering when run on flutter 2.10.3([video](videos/RPReplay_Final1650350856.MP4)). 
But it works well on flutter 2.8.1([video](videos/RPReplay_Final1650352491.MP4))

To stable recurrence this issue: 
  1. the dialog must overlay the bottom blur card partially just like the video shows; 
  2. the ImageSequenceAnimator is necessary, but I think this widget is not the root cause.
