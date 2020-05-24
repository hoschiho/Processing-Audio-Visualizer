import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
AudioPlayer song;
BeatDetect beat;
BeatListener bl;


//initialize sliders to modify values
int amountSliders = 4;
myVertSlider [] mySliderCollection = new myVertSlider[amountSliders];


//variables
float t = random(-6.5,-2);
float vt = 0.001;
float a =0;
float va = 0.001;
float b =0;
float vb = 0.001;
float m = 6;
float n1 = 1;
boolean showMenu = true;



void setup(){
  
  //create sliders
  for(int i = 0; i < amountSliders; i++){
    // posX posY tall valMax valMin initialVal
    mySliderCollection[i] = new myVertSlider(i*30+30, 30, 200, -10, 10, int(random(-10,10)));
  }
  
  fullScreen(P3D);

  
  //load song
  minim = new Minim(this);
  song = minim.loadFile("Audio Visualisation Project (Jelly Fish Particle Animation).mp3", 2048);

  //play song in loop.
  song.loop();
  beat = new BeatDetect(song.bufferSize(), song.sampleRate());
  
  //depending on the song, beat sensitifity can be used to dampen the algorithm. default values is 10
  //beat.setSensitivity(100);  
  
  // make a new beat listener, so that we won't miss any buffers for the analysis
  bl = new BeatListener(beat, song);  
}


void keyPressed(){
  
//press "r" to randomize sliders
  if (key == 'r'){
    for(int i = 0; i < amountSliders; i++){
      mySliderCollection[i].setSliderVal(int (random(-10,10)));
    }
  }

  //press "m" to display sliders
  if (key == 'm'){
    if (showMenu == true){
      showMenu = false;
      noCursor();
    } else {
      showMenu = true;
      cursor();
    }
  }
  
  
  //press SPACE to play/pause music
  if (key == ' ' ){
    if (song.isPlaying())
    {
      song.pause();
    } else {
      song.loop();
    }
  }
}


void draw(){
  background(0);


//draw sliders
  for(int i = 0; i < amountSliders; i++){
    mySliderCollection[i].update();
    mySliderCollection[i].display(showMenu);
  }

//put the animation in the middle of the screen
  translate(width /2, height /2);

  
//Assign sliders to value
//comment out value a & b to get it moving between 0.2 & -0.2. 
//otherwise you can use slider 0 & 1 to change the value

  a = mySliderCollection[0].sliderVal/10.0;
  b = mySliderCollection[1].sliderVal/10.0;
  m = mySliderCollection[2].sliderVal;
  n1 = mySliderCollection[3].sliderVal;

    
 beat.detect(song.mix);

 
//values move between a range
  t+=vt;
  if (t > -2 || t < -6.5) {
    vt = vt*-1;
  }
  
  a+=va;
  if (a > 0.2 || a < -0.2) {
    va = va*-1;
  }
  
  b+=vb;
  if (b > 0.2 || b < -0.2) {
    vb = vb*-1;
  }
 
  
//create a few SuperFormula dots
  for(float i=0; i<3.5; i+=0.1){
    drawSuperFormula(t + i);
 }
 

//Flash dots on Kick
  if (beat.isKick()) {
   stroke(random(100,255),random(100,255),random(100,255));
   strokeWeight(7);
 } else {
   strokeWeight(2);
   stroke(255);
 }
}

  

//magic Formula
float superFormula(float theta, float a, float b, float m, float n1, float n2, float n3){
  return pow(pow(abs(cos(m * theta / 4.0) / a), n2) + 
  pow(abs(sin(m * theta / 4.0) / b), n3), -1.0 / n1);
}


void drawSuperFormula(float t){
  beginShape();
    for (float theta = t; theta <= 2* PI+t; theta += 0.1){
      float rad = superFormula(theta,
      a, 
      b,
      m,
      n1,
      
      //use sin & cos to get a moving value
      sin(t)*10, // n2
      cos(t)*10  // n3
      ); 
    float x = rad * cos(theta) * 50;
    float y = rad * sin(theta) * 50;
    point(x,y);
  }
  endShape(); 

}

  
class BeatListener implements AudioListener{
  private BeatDetect beat;
  private AudioPlayer source;
  
  BeatListener(BeatDetect beat, AudioPlayer source){
    this.source = source;
    this.source.addListener(this);
    this.beat = beat;
  }
  
  void samples(float[] samps){
    beat.detect(source.mix);
  }
  
  void samples(float[] sampsL, float[] sampsR){
    beat.detect(source.mix);
  }
}
