# Processing-Audio-Visualizer
Processing Audio Visualizer for Ws2C Module

This Project uses the minim sound Library to detect the beat from a song. It creates a pattern with the so called SuperFormula, moves around and flashes the dots, as soon as a kick is detected. 

#How to Install
First of all you'll need to install the minim sound library. It is available in the Contribution Manager so it's very easy:
Open the AudioVisualizer.pde file in Processing.
Select the Sketch Menu > Import Library... > Add Library...
Search for "Minim" and select the library.
Hit install and Close the Contribution manager once completed.
Hit the play button in Processing. It will start in fullscreen and play the song in loop.

#About the Animation
The animation is created with the so called SuperFormula. You can use the sliders in the upper right corner to adjust the a,b,m & n1 values. I'm only offering you 4 parameters, as this brings you already more then enough room to play around. For the parameters n2 & n3 i'm using cos&sin function to have it constantly moving.

#KeyMapping
m: toggles the slider menu on and off.
r: sets a random value to the 4 sliders between -10 and 10.
SPACE: play / pauses the song (animation is still running, but obviously the beat is not detected anymore.

#Change the song
You can change the song by adding a new song into the project folder and change the name on line 41:
song = minim.loadFile("AnySong.mp3", 2048);
Please note that sometimes the beat detection algorithm needs to be dampen, depending on the song played. You can do that with setSensitivity. Default value is 10.
beat.setSensitivity(150);

#Fancy stuff you can change in the code
If you comment out value a & b on line 106 & 107, the sliders a & b won't work anymore, but a & b are moving in and out between -0.2 and 0.2. This leads to an even fancier animation.
  a = mySliderCollection[0].sliderVal/10.0;
  b = mySliderCollection[1].sliderVal/10.0;
