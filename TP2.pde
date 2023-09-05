import ddf.minim.*;

Minim minim;
AudioSample boing;
AudioSample bobh;
AudioPlayer vientop;
AudioPlayer inicio;
AudioPlayer perder;
AudioPlayer ganar;
AudioPlayer juego;
import fisica.*;

FWorld mundo;

FBox caja, pat;
FCircle hamb, medusa,Hamb1, bob;
FCircle almj;
FCircle plankton;

int segundos, estadoI, posXT, posYT, posXF, posYF,viento;
int comer, vientotiempo;
int X, posXJ;
int tiempo =0;
int maxImages3 = 2;
int imageIndex3 = 0;
float vientofuerza;
boolean contacto;
PFont font;
//Fondo
PImage img, Hamb,hamb1, patricio1,letrero1, pantallainicio, pantallafinal,planktongg, almeja,ganaste, patboca;

//Animacion Medusa
int maxImages = 6;
int imageIndex = 0;
PImage [] images = new PImage [maxImages];
//Animacion viento
int maxImages1 = 10;
int imageIndex1 = 0;
PImage [] images1 = new PImage [maxImages1];
//Animacion Almeja
int maxImages4 = 8;
int imageIndex4 = 0;
PImage [] images4 = new PImage [maxImages4];

//Animacion Bob
int maxImages2 = 4;
int imageIndex2 = 0;
PImage [] images2 = new PImage [maxImages2];
PImage [] images3 = new PImage [maxImages3];

void setup() {
 
size( 1080, 720 );
  
Fisica.init(this);
 
mundo=new FWorld();
minim= new Minim (this);
font = loadFont("BookmanOldStyle-Bold-48.vlw");
img = loadImage("fondo.png");
Hamb = loadImage("hamb.png");
letrero1=loadImage("letrero12.png");
hamb1 = loadImage("hamb1.png");
patricio1 = loadImage("pat_1.png");
pantallainicio = loadImage("lugar.png");
pantallafinal = loadImage("lugar2.png");
boing= minim.loadSample ("Rebote.mp3",512);
vientop= minim.loadFile ("Mar.mp3",2048);
planktongg=loadImage("plankton.png");
inicio=minim.loadFile("Inicio.mp3",2048);
perder=minim.loadFile("Perder.mp3",2048);
ganar=minim.loadFile("Ganar.mp3",2048);
juego=minim.loadFile("Juego.mp3",2048);
almeja=loadImage("almeja_0.png");
bobh=minim.loadSample("Tiro.mp3",512);
ganaste= loadImage("Ganar.png");
patboca= loadImage("pat_boca.png");
//for para animacion medusa
for (int i = 0; i < images.length; i++){
  images[i] = loadImage("medu_" + i + ".png");
}

//for para animacion almeja
for (int i = 0; i < images4.length; i++){
  images4[i] = loadImage("almeja_" + i + ".png");
}

//for para animacion bob
for (int i = 0; i < images2.length; i++){
  images2[i] = loadImage("bob_" + i + ".png");
}
for (int i = 0; i < images3.length; i++){
  images3[i] = loadImage("pat_" + i + ".png");
}
//for para animacion viento
for (int i = 0; i < images1.length; i++){
  images1[i] = loadImage("viento_" + i + ".png");
}
hamb= new FCircle(30);
Hamb1= new FCircle(30);
medusa= new FCircle(60);
plankton= new FCircle(30);
almj= new FCircle(40);
bob= new FCircle(70);
//caja= new FBox(450,90);
//patricio= new FBox(60,100);
 pat= new FBox(80,100);
contacto=false;
 
 mundo.add(bob);
 //mundo.add(caja);
 //mundo.add(patricio);
 mundo.add(plankton);
 mundo.add(medusa);
 mundo.add(hamb);
 mundo.add(Hamb1);
 mundo.add(almj);
 mundo.add(pat);

//contacto = hamb.isTouchingBody(medusa);
  
//-------//
  posXF = width;
  posYF = height;
  segundos = 5000;
  viento = 300;
  posXT = 400;
  posYT = 30;
  
  comer=0;
   //estado -1 es inicio, 0 en juego, 1 victoria, 2 derrota 
  estadoI=-1;
  vientotiempo=100;
 
  //movimiento de medusa//
  posXJ = width; 
  X=posXJ/2;
  medusa.setStatic(true);
  bob.setStatic(true);
 // caja.setStatic(true);
  //patricio.setStatic(true);
 pat.setStatic(true); 
pat.setPosition(width-50,height-100);
  //----------------//
  
  //caja.setPosition(550,20);
  //caja.attachImage(letrero1);
  //caja.setNoStroke();
  // parametros hamb
  //hamb.setNoStroke();
  //hamb.setFill(247, 226, 132);
 
  hamb.setVelocity(200, -500);
 
  hamb.setPosition(100, height-150);
 
   // parametros almeja
  //almj.setNoStroke();
  //almj.setFill(105, 38, 139);
  //almj.setVelocity(100, -400);
 almj.setPosition(random (50,900), -5);
 // almj.attachImage(almeja);
  //------------------------//
 Hamb1.setPosition(780,20);
 Hamb1.setStatic(true);
 Hamb1.attachImage(hamb1);
 
 //parametros patricio
/*patricio.setPosition(width-50,height-100);
patricio.setStatic(true);
patricio.attachImage(patricio1);
*/
 /*parametros medusa

 
 mundo.setEdges();
  
 medusa = new FCircle(70);
 
 hamb = new FCircle (20);
  
  medusa.setPosition(width/2, 590);
  
  medusa.setStatic(true);
  
  mundo.add(medusa);
*/

 //------------------------//
 
 //parametros bob
bob.setPosition(100,height-100);
bob.setStatic(true);
//bob.setFill(255, 244, 99);
//bob.setNoStroke();
 //------------------------//
 
//-------Parametros de Plankton---------//
  
plankton.setPosition(1060,400);
plankton.setStatic(true);
 plankton.attachImage(planktongg);

 for(int i=0; i< images1.length;i++){
 images1[i]=loadImage("viento_"+ i+".png");
 }
 
}


void draw() {
 // println(almj.getY());
 //---------inicio
  if (estadoI==-1) {
    
    image(pantallainicio,0,0);
    if(inicio.isPlaying()==false){
   inicio.loop();}
    /*textSize(20);
    textAlign(CENTER, CENTER);
    text("Presiona ENTER para comenzar", width/2, height/2);
    fill(255, 0, 0);
    // background(6, 153, 3);*/
  }
  if (keyCode== ENTER&&estadoI==-1) {
    estadoI=0;

  }
  
  
  
  //------------------estado 0 juego----------//
  if (estadoI==0) {

    if(inicio.isPlaying()==true){
      inicio.pause();}
      if(juego.isPlaying()==false){
    juego.loop();}
    
  background(255);
  image(img,0,0);
  image(letrero1, 347,0);
  mundo.step();
  mundo.draw();
  
  //hamb.setPosition(0, height-20);
  //mundo.add(hamb);
  
//Animacion Bob
 bob.attachImage(images2[imageIndex2]);
 if(frameCount%5==0){
 imageIndex2 = (imageIndex2+1) % images2.length;
 }
pat.attachImage(images3[imageIndex3]);
 if(frameCount%30==0){
 imageIndex3 = (imageIndex3+1) % images3.length;
 }
///Animacion Almeja
almj.attachImage(images4[imageIndex4]);
 if(frameCount%5==0){
 imageIndex4 = (imageIndex4+1) % images4.length;
 }

//Animacion medusa
 medusa.setPosition(X,650);
 medusa.attachImage(images[imageIndex]);
 if(frameCount%5==0){
 imageIndex = (imageIndex+1) % images.length;
 }

 hamb.setRestitution(2);
 hamb.attachImage(Hamb);
 if(hamb.getX()>=950){
   pat.attachImage(patboca); 
 }
 
  if (hamb.getY()>=640||hamb.getX()>=1080||hamb.getX()<-10) {
 hamb.setPosition(100, height-150);
 hamb.setVelocity(random(100, 400),random(-200, -700));
 bobh.trigger();
  }
  if(hamb.isTouchingBody(pat)){
   hamb.setPosition(100, height-150);
 hamb.setVelocity(random(100, 400),random(-200, -700));
 comer = comer +1;
  }
  /*if(hamb.isTouchingBody(patricio)){
   hamb.setPosition(100, height-150);
 hamb.setVelocity(random(100, 400),random(-200, -700));
 comer = comer +1;
  }*/
if(hamb.isTouchingBody(medusa)){

boing.trigger();
}

 /* if (segundos!=0) {              //segundos si es distinto a 0 
      segundos = segundos-1;
    } else if (segundos==0) {
      estadoI=3;
    }
    */
    tiempo = 35 -millis()/1000;
    if (tiempo ==0){
      estadoI=3;
    }
    
    fill(255);
    textFont(font);
    textSize(20);
    //text("H:", posXT+20, posYT+38);
    text(tiempo, posXT+40, posYT+38);
  textFont(font);
  textSize(20);
  text(comer, 650, 70);
  Hamb1.setPosition(690,60);
 /* if ((frameCount % 100) == 0) {
    almj.attachImage(images1[imageIndex1]);
 imageIndex1 = (imageIndex1+1) % images1.length;*/
  /*  almj.setPosition(random(200 , 1000),-20);
    almj.setVelocity(random(50, 200),random(-200, -450));
    almj.setRestitution(2);*/
  //}
almj.setRestitution(2);
 
if (almj.getY()>=723||almj.getX()<-10 ) {
     almj.setPosition(random(200 , 900),-5);
     almj.setVelocity(random(50, 200),random(-200, -450));
  }
  
 /*if(almj.isTouchingBody(patricio)){
estadoI=3;
    
  }*/
  if(almj.isTouchingBody(pat)){
estadoI=3;
    
  }
      
 //-----------------Corriente----------//
 
    if(estadoI==0){
    viento--;
   //text("Contador",100,300);
    //text(viento,150,350);
    }
    if(viento<=0){
      image(images1[imageIndex1],random(width),random(100,500));
      imageIndex1=(imageIndex+1) %images1.length;
      if(vientop.isPlaying()==false){
        vientop.loop();    
      }
      if(hamb.getX()>500){
          vientofuerza= -0.4 * hamb.getX();
            hamb.addForce(vientofuerza,0);
      }
      if(viento<=0){
     
         vientotiempo--;
      }
      if(vientotiempo<=0){
    viento=300;
    vientotiempo=100;
    plankton.setRestitution(2);
     vientop.pause();
    }
      
       if (plankton.getY()>=630||plankton.getX()>=1080||plankton.getX()<-10) {
     plankton.setPosition(random(400 , 1000),-20);
  }
    }
       
  
    }
//boing.trigger();  para que sueneeeeeee
// if (almj.getY()>=630||almj.getX()>=1080||almj.getX()<-10) {
//     almj.setPosition(random(200 , 1000),-20);
//}
  
//if(almj.isTouchingBody(patricio)){
// almj.setPosition(100, -50);
// almj.setVelocity(random(50, 200),random(-200, -450));
//}
 //-----------------------------------//   

  if (estadoI==0 && comer==1) {
    estadoI=2;
   juego.pause(); }

  //-------Estado perder ----------//
  if (estadoI==3) {
    pushStyle();
     image(pantallafinal,0,0);
    popStyle();
  
    if(juego.isPlaying()==true){
   juego.pause(); }
   if(perder.isPlaying()==false){
    perder.loop();;}
   
  }
  //--------------//
  //------reiniciar-------
  if (key=='r'&&(estadoI==3 || estadoI==2)) {
    background(255);
    estadoI=-1; 
    //segundos=900;
    posXF = width;
  posYF = height;
  //segundos = 5000;
  tiempo = 30 -millis()/1000;
  viento = 300;
  posXT = 400;
  posYT = 30;
  
  comer=0;
   //estado -1 es inicio, 0 en juego, 1 victoria, 2 derrota 
  estadoI=-1;
  vientotiempo=100;
 
  //movimiento de medusa//
  posXJ = width; 
  X=posXJ/2;
  medusa.setStatic(true);
  bob.setStatic(true);
  //caja.setStatic(true);
  //patricio.setStatic(true);
 
  //----------------//
 // caja.setPosition(550,20);
  //caja.attachImage(letrero1);

  hamb.setVelocity(200, -500);
 
  hamb.setPosition(100, height-150);
 

  almj.setPosition(random (50,900), -5);
 almj.attachImage(almeja);
  //------------------------//
 Hamb1.setPosition(780,20);
 Hamb1.setStatic(true);
 Hamb1.attachImage(hamb1);
 
 //parametros patricio
/*patricio.setPosition(width-50,height-100);
patricio.setStatic(true);
patricio.attachImage(patricio1);*/

 
 //parametros bob
bob.setPosition(100,height-100);
bob.setStatic(true);

 //------------------------//
 
//-------Parametros de Plankton---------//
  
plankton.setPosition(1060,400);
plankton.setStatic(true);
 plankton.attachImage(planktongg);
  }
  //-------------------//

  //-----------Ganar---------//     
  if (estadoI==2) {
  
    image(ganaste,0, 0);
    textAlign(CENTER, CENTER);
   textFont(font);
    text("¡Ganaste!\nPresiona R para volver a jugar", posXF/2, posYF/2);

   if(ganar.isPlaying()==false){
    ganar.loop();}
  
  }
}

 
     


void keyPressed() {
  
  if (keyCode==LEFT) {
  
    X=X-25;
  }
  else if (keyCode==RIGHT) {
  
    X=X+25;
 
}

}
