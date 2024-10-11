import processing.sound.*;
import processing.video.*;
//////////////////////////////VARIÁVEIS//////////////////////////////
//tipografia--------------------------
String letras = "AUDIO\nIMAGE";                //MENU
String letras2 = "AUDIO\nVISUALIZER";          //MENU
PImage i3,i4,i5;                               //MENU

//AudioeImagem------------------------------
AudioIn in;                                    //CAPTADO NO AUDIO E IMAGEM
Amplitude amp;                                 //CAPTADO NO AUDIO E IMAGEM
SoundFile s;                                   //MUSICA DO MENU

PImage i1, i2;                                 //AUDIO E IMAGEM

float x, y, posx, posy;                        //POSIÇÃO DA IMAGEM (AUDIO E IMAGEM)
float angle;                                   //ÂNGULO DE ROTAÇÃO
boolean rot,start;                             //ROT = ROTAÇÃO ATIVADA; START = MOSTRA MENU
float i4x,i5x;                                 //POSIÇÃO E MOVIMENTO DAS CABEÇAS DO MENU (MENU)
float xi4,yi4,xi5,yi5;                         //AUMENTO DO TAMANHO DAS CABEÇAS 
int time;                                      //CONTAGEM DO TEMPO PARA O EFEITO DAS LETRAS (SPEAK)
color finalC,inicialC,currentC;                //ARMENAZENAMENTO DAS CORES DO TEXTO (SPEAK)

//menuEscolherCara---------------------
boolean EscolherCara = false;                  //MENU2 PARA ESCOLHER A CARA (AUDIO E IMAGEM)
Movie video1,video2;                           //VIDEOS DO MENU VIDEO1 = ESQUERDA; VIDEO2 = DIREITA;
PImage imagemEscolhida;                        //ARMAZENAMENTO NA IMAGEM ESCOLHIDA 

//EscolherSom--------------------------
boolean EscolherSom=false;
Botao[]botaoES;                                //ARRAY DE BOTOES
String[]SongName;                              //ARRAY DO NOME DAS MUSICAS
float XbotaoES,YbotaoES;                       //POSIÇAO DOS BOTOES
color corbotao;

boolean texto=false;                           //EFEITO DE TEXTO A MEXER
int musica=0;                                  //ARMAZENAMENTO DA MUSICA ESCOLHIDA
BotaoMenu bm;                                  //BOTAO MENU

//VisualizadorLivre-----------------------
boolean VisualizadorLivre=false;
SoundFile[]listaMusica = new SoundFile[5];                             //ARRAY DE MÚSICAS
Amplitude amplitude;
Capture cap;
float RaioCoracao;                                                    //RAIO
int intervalo=0;                                                      //INTERVALO DE ESPERA ENTRE A ESCOLHA DA MUSICA E O INÍCIO DO VISUALIZADOR
PVector posicaocoracao;                                               //VETOR POSIÇAO DO CORACAOBIG
Coracao coracaoBig;                                                   //CORAÇÃO CENTRAL DO VISUALIZADORLIVRE

FFT fft;
int bandas = 512;                                                    //NÚMERO DE BANDAS ANALISADAS
float larg, scale = 5;                                               //LARGURA DAS BANDAS E ESCALA

//EfeitoMousePressed----------------------
ArrayList<CoracaoParticula> cp = new ArrayList<CoracaoParticula>();  //ARRAYLIST DE PARTÍCULAS
PVector acel,vel;                                                    //ACEL=ACELERAÇÃO; VEL=VELOCIDADE DAS PARTÍCULAS
PVector tr;                                                          //VETOR DA TRANSLAÇÃO DO CORAÇÃO ONDE É INSERIDO O MOVIMENTO

//////////////////////////////VOID SETUP//////////////////////////////
void setup() {
  size(600, 500);
//menu----------------------------------
  start=true;                                  //PROGRAMA COMEÇA COM O MENU INICIALIZADO
  i3 = loadImage("PROJETO_imageInicial1.png"); //CORPO MENU
  i4= loadImage("PROJETO_imageinicial2.png");  //CARA MENU
  i5=loadImage("PROJETO_imageinicial3.png");   //CARA MENU
   i4.resize((i4.width)/2,(i4.height)/2);
   i5.resize((i5.width)/2,(i5.height)/2);
    i4x=(width/2+100);
    i5x=0;
    
  s = new SoundFile(this,"Mr.bean.mp3");
  s.amp(0.1); 
  s.play();
  s.loop();
  
//audioEimagem(imagem)--------------------
  i1 = loadImage("Projeto_IMAGE1.png");           //CORPO
  i2 = loadImage("projeto_IMAGE2.png");
  i2.resize(170, 235);
  x = i2.width;                                   //POSIÇÃO DA IMAGEM I2
  y = i2.height;
  posx = width/2 + 10;
  posy = 2*height/4 - 70;

//audioEimagem(som)-----------------------
  in = new AudioIn(this, 0);
  in.start();

  amp = new Amplitude(this);
  amp.input(in);

//audioEimagem(rotaçãoEefeitos)-----------
  angle = 0;
  rot = false;

//tipografia-------------------------------
  PFont font = createFont("HELVETICA",30);      //TIPO DE FONTE 
  textFont(font);
  time = 0;                                     //EFEITO TIPOGRAFIA (SPEAK)
 inicialC = color(0);                           //EFEITO TIPOGRAFIA (SPEAK)
 finalC = color(255);                           //EFEITO TIPOGRAFIA (SPEAK)
 
//MenuEscolherCara-------------------------
video1 = new Movie(this,"PROJETO_Video1.mp4");
video1.play();
video1.loop();
video2 = new Movie(this,"PROJETO_video2.mp4");
video2.play();
video2.loop();
imagemEscolhida = i2;

//EscolherSom---------------------------------
SongName = loadStrings("NomeSom.txt");
  textAlign(CENTER,CENTER);
   XbotaoES=width/2;
   YbotaoES=height/5;
   corbotao=#FF7171;
   botaoES = new Botao[5];

  for(int i = 0; i < botaoES.length; i++){
    botaoES[i] = new Botao(XbotaoES,YbotaoES*i+50,400,70,corbotao,texto);
  }
  
//VisualizadorLivre----------------------------
  amplitude = new Amplitude(this);
  fft=new FFT(this,bandas);
  
  coracaoBig=new Coracao(RaioCoracao, #FF2EDD, 255, 8);
  cap = new Capture(this, 600, 500);
  larg=width/bandas;
  
  listaMusica[0]=new SoundFile(this,"Mr.Bean_Entractev.mp3");
  listaMusica[1]=new SoundFile(this,"ILOVE.LA.mp3");
  listaMusica[2]=new SoundFile(this,"Classical piano .mp3");
  listaMusica[3]=new SoundFile(this,"Mr.bean.mp3");
  
  bm=new BotaoMenu(width-25,height-25,46,46,corbotao,texto);
  posicaocoracao = new PVector(width/2,height/2);
    
//EfeitoMousePressed----------------------
  tr = new PVector(width/2,height/2);
}

//////////////////////////////VOID DRAW//////////////////////////////
void draw() { 
  
           if (time < 255) {                    //EFEITO TEXTO
    currentC = lerpColor(inicialC, finalC, time / 255.0); //dividido por 255.0 para normalizá-lo no intervalo de 0 a 1 (valores do lerpColor())
  } else {
    currentC = lerpColor(finalC, inicialC, (time - 255) / 255.0); //intervalo de cor inversa
  }
  
//AUDIOeIMAGEM-----------------------------
if(EscolherSom==false && VisualizadorLivre==false && 
EscolherCara==false && start==false){
  float ampValue = amp.analyze();                         
  background(0);                               //FUNDO
  desenhaFundo();                              //FUNDO
            //CORPO MR BEAN----------------
    imageMode(CORNER);
    image(i1,0,0);
    noFill();
    desenhaBall();                             //FUNÇÃO PARA DESENHAR BOLAS CONSOANTE O SOM
            // TEXTO-----------------

  fill(currentC);
  textAlign(CENTER, CENTER);
  textSize(50);
  text("Speak!", width/5, height/3);
  time = (time + 1) % (2*255);

            //CARA MR BEAN-----------------
  imageMode(CENTER);
    x = map(ampValue, 0, 0.5, i2.width, i2.width*2);
    y = map(ampValue, 0, 0.5, i2.height, i2.height*2);
    
      if (ampValue > 0.3) {                   //CONDIÇÃO PARA A ROTAÇÃO
        rot = true;
  }

       if (rot) {
         pushMatrix();                        //limitar a rotaçao e tranlaçao para nao afetar o resto do codigo;
         translate(posx, posy);               //TRANSLAÇÃO
         rotate(angle);                       //ROTAÇÃO
         image(imagemEscolhida, 0, 0, x, y);
         popMatrix();

    angle += 0.2;                             //PARA FAZER UMA VOLTA COMPLETA
    if (angle >= TWO_PI) {
      angle = 0;
      rot=false;
    }
  } else {
    image(imagemEscolhida, posx, posy, x, y);
  }
    bm.desenha();
    bm.mudaCor(#FF244C);
}

//menuEscolherCara-------------------------
  if(EscolherCara == true){
    background(0);         
    fill(currentC);
    textAlign(CENTER,CENTER);
    textSize(30);
    text("Choose one", width/2, height/15);
      time = (time + 5) % (2*255);
     imageMode(CENTER);
    if (video1.available()) {
      video1.read();
    }
    if (video2.available()) {
      video2.read();
    }
    image(video1, width/4, height/2);
    image(video2, 3*(width/4), height/2);

    if (mouseX>width/4-video1.width/2 && mouseX<width/4+video1.width/2            //SE O MOUSE ESTIVER EM CIMA DO VIDEO1
      && mouseY>height/2-video1.height/2 && mouseY<height/2+video1.height/2) {
      video1.play();
    } else {
      video1.filter(BLUR, 20);                                                   //FILTRO DE DESFOQUE
      if (video1.isPlaying()) {
        video1.stop();
      }
    }


    if (mouseX>3*width/4-video2.width/2 && mouseX<3*width/4+video2.width/2        //SE O MOUSE ESTIVER EM CIMA DO VIDEO2
      && mouseY>height/2-video2.height/2 && mouseY<height/2+video2.height/2) {
      video2.play();
    } else {
      video2.filter(BLUR, 20);
      if (video2.isPlaying()) {
        video2.stop();
      }
    }
    
    bm.desenha();
    bm.mudaCor(#FF244C);
  }
  
//VisualizadorLivre--------------------------
      if(VisualizadorLivre){ 
        intervalo++;                                                               //CONTAGEM DO TEMPO POR FRAMES
        if(intervalo <=255){
  background(0);
  fill(currentC);
  textAlign(CENTER,CENTER);
  textSize(20);
  text("Press any key to advance the music",width/2,height/2);
  time = (time + 1) % (2*255);
        } else {
           if(listaMusica[musica] != null){                                        //SO COMEÇA A TOCAR QUANDO O VALOR NÃO É NULO PARA NÃO SURGIR ERRO NO PROGRAMA
              if (!listaMusica[musica].isPlaying()) {
                listaMusica[musica].play();
                listaMusica[musica].loop();         
        }
        
        cap.start();
        if(cap.available()){
          cap.read();
        }
        
        cap.loadPixels();
        
        for (int x = 0; x < cap.width; x++) {
        for (int y = 0; y < cap.height; y++) {
          int loc = x + y * cap.width;
          colorMode(HSB);                                                         //TROCAR COLORMODE PARA HSB PARA ADQUIRIR OS VALORES DE LUMINOSIDADE
          color c = cap.pixels[loc];
          float br = brightness(c);
          float sat=0;
          float map=map(amplitude.analyze(), 0, 1, 0, br);                        //LUMINOSIDADE DA CAPTURA VARIA CONSOANTE A AMPLITUDE
          float hu = hue(c);
          cap.pixels[loc]=color(hu, sat, map);                                    
        }
      }
      
      cap.updatePixels();
      image(cap,0,0);
      
      colorMode(RGB);                                                             //TROCAR DE COLOR MODE PARA NÃO ALTERAR AS CORES POSTERIORES
      float[]sa=fft.analyze();
      
       for (int i=0; i<bandas; i++) {
        float mapBandas=map(amplitude.analyze(), 0, 1, 0, 255);                   //TRANSPARÊNCIA DAS BANDAS
        stroke(255, 0, 0, mapBandas);
        strokeWeight(10);
        rect(width-i*larg, 0, larg, sa[i]*height*scale);                         //COLOQUEI 2 RECTS PARA DAR UM EFEITO MAIS ENGRAÇADO DE BANDAS MAIS ELEVADAS
        rect(i*larg, 0, larg, sa[i]*height*scale);
      }
      
      coracaoBig.desenha(posicaocoracao);
      coracaoBig.amplitude();
      
      fill(255);
      rectMode(CENTER);
      float duration=map(listaMusica[musica].position(), 0, listaMusica[musica].duration(), 0, width*2); //COMPRIMENTO DO RETANGULO CONSOANTE A POSIÇÃO
      rect(0, height-(10/2), duration, 10);
  
  noStroke();
  bm.desenha();
  bm.mudaCor(#FF244C);
  }
  }
  } else {
    intervalo=0;
  }
  
//EscolherSom-------------------------------
  if(EscolherSom){
        background(0);
      for(int i = 0; i < botaoES.length; i++){                                   //BOTOES DE SELEÇÃO
        botaoES[i].desenha();
        botaoES[i].mudaCor(#FF244C);         
      }    
       for(int j = 0; j < SongName.length; j++){
        textSize(botaoES[j].texto ? random(20,35) : 30);                         //EFEITO TEXTO
        fill(0);
        text(SongName[j], width/2, height/5*j+50);
      }
  bm.desenha();
  bm.mudaCor(#FF244C);
  }

//menu-------------------------------------
  if(start==true){
    imageMode(CORNER);
    image(i3,0,0);
     i4x = frameCount % width;                                                          //POSIÇÃO DA IMAGEM E MOVIMENTO             
     i5x = (frameCount - 300) % width;                                                  //POSIÇÃO DA IMAGEM E MOVIMENTO

      
      if(mouseX > i4x && mouseX < i4x+(i4.width) && mouseY > 0 && mouseY < i4.height){  //CONDIÇÃO PARA QUANDO O MOUSE ESTIVER NA IMAGEM
        xi4=i4.width+(i4.width/4);                                                      //AUMENTO DE TAMANHO
        yi4=i4.height+(i4.height/4);
      } else {
        xi4 = i4.width;
        yi4 = i4.height;
      }
            
             if(mouseX > i5x && mouseX < i5x+(i5.width) && mouseY > 0 && mouseY < i5.height){
                  xi5=i5.width+(i5.width/4);
                  yi5=i5.height+(i5.height/4);
            } else {
                  xi5 = i5.width;
                  yi5 = i5.height;
           }
          
    image(i4,i4x,0,xi4,yi4);
    image(i5,i5x,0,xi5,yi5);
    
//tipografia----------------------------------
     if(mouseX > i4x && mouseX < i4x+(i4.width) && mouseY > 0 && mouseY < i4.height){   //efeito sombra no texto escolhido
        fill(100);
        textSize(30);
        text(letras, i4x+2 ,i4.height/2+2);
     } else if(mouseX > i5x && mouseX < i5x+(i5.width) && mouseY > 0 && mouseY < i5.height){
       fill(100);
        textSize(30);
        text(letras2, i5x+2 ,i5.height/2+2);
      }
     
     float m = map(mouseX,0,width,100,255);                                            //mapeamente do mouseX dando origem a diferentes tons de vermelho
   textAlign(CENTER,CENTER);
    fill(m,0,0);
    textSize(30);
    text(letras, i4x ,i4.height/2);
    text(letras2, i5x, i5.height/2);

  }
  
//musica---------------------------------------
  if(EscolherSom==false && VisualizadorLivre==false && 
EscolherCara==false && start==false || VisualizadorLivre){                             //MUSICA DE FUNDO DO MENU
    if(s.isPlaying()){
      s.stop();
    }
  } else if(!s.isPlaying()){
    s.amp(0.1);
    s.play();
  }
  
//EfeitoMousePressed----------------------
 for (int i = cp.size()-1; i >= 0; i--) {
    CoracaoParticula copar = cp.get(i);
    PVector m = new PVector(mouseX, mouseY);                                           //VETOR DE POSIÇÃO
    copar.desenha(m);                                                                  //DESENHAR COM A TRANSLAÇÃO DEFINIDA
    copar.executa();                                                                   //DESENHA+ATUALIZA
    if (copar.extinta()) {                                                             //FIM DA VIDA
      cp.remove(i);
    }
  }
}

//////////////////////////////VOID MOUSEPRESSED//////////////////////////////
void mousePressed(){
//menuEscolherCara-----------------------------
  if (EscolherCara == true) {
    if (mouseX>width/4-video1.width/2 && mouseX<width/4+video1.width/2                 //SE ESCOLHER DETERMINADA IMAGEM COMEÇA O AUDIO E IMAGEM
      && mouseY>height/2-video1.height/2 && mouseY<height/2+video1.height/2) {
      imagemEscolhida = i2;                                                            //guardar a imagem selecionada para usar posteriormente
      start = false;
      EscolherCara = false;
    }
    if (mouseX>3*width/4-video2.width/2 && mouseX<3*width/4+video2.width/2
      && mouseY>height/2-video2.height/2 && mouseY<height/2+video2.height/2) {
      imagemEscolhida = i4;
      start = false;
      EscolherCara = false;
    }
  }
  
//menuEscolherSom-----------------------------
  if(EscolherSom==true){
   for (int i = 0; i < botaoES.length; i++) {
    if (botaoES[i].press() == true) {
      musica = i;
      if(i==4){
        selectInput("Select a sound file", "songSelected");                         //selecionar ficheiro audio
      }
      EscolherSom = false;
      VisualizadorLivre = true;
      
       if(musica < 4){                                                              //se a musica não for a 4 do array (musica selecionada apartir de ficheiro)
            amplitude.input(listaMusica[musica]);
            fft.input(listaMusica[musica]);                                         
      }
  }
   }
  }
  
  
//VisualizadorLivre----------------------------------
//botãoMenu(VisualizadorLivre)--------------------------
    if(VisualizadorLivre==true && bm.press()){                                      //sequencia do botaoMenu desde o start até ao VisualizadorLivre e vice versa
    EscolherSom=true;
    VisualizadorLivre=false;
    listaMusica[musica].stop();
    listaMusica[4]=null;                                                            //quando voltar a traz perde-se a música escolhida para dar lugar a uma nova selecionada
  } else if(EscolherSom && bm.press()){
    start=true;
    EscolherSom=false;
  } else if(start && mouseX > i5x && mouseX < i5x+(i5.width) && 
  mouseY > 0 && mouseY < i5.height){
    EscolherSom=true;
    start=false;
  }
  
//EfeitoMousePressed---------------------------------
  for (int i = 0; i < 10; i++) {
      acel= new PVector(random(-1, 1), random(-1, 1));                               //ACELERAÇÃO
      vel= new PVector(random(-1, 1), random(-1, 1));                                //VELOCIDADE
      cp.add(new CoracaoParticula(1, color(255, 0, 0), 0, 0, acel, vel));            //ADICIONAR 10 PÁRTICULAS DE CORAÇÃO QUANDO SE PRESSIONA O MOUSE
  }

//botãoMenu(Audio e Imagem)--------------------------
if(EscolherSom==false && VisualizadorLivre==false &&                                 //sequencia do botaoMenu desde o start até ao Audio e Imagem e vice versa
EscolherCara==false && start==false && bm.press()){
  EscolherCara=true;
} else if(EscolherCara && bm.press()){
  start=true;
  EscolherCara=false;
} else if (mouseX > i4x && mouseX < i4x+(i4.width) && mouseY > 0 && mouseY < i4.height && start){
  EscolherCara=true;
  start=false;
}
  
}

//////////////////////////////VOID KEYPRESSED//////////////////////////////
void keyPressed() {
  if (VisualizadorLivre) {
    float novaPosicao = listaMusica[musica].position() + 10;
    if (novaPosicao <= listaMusica[musica].duration()) {
      listaMusica[musica].jump(novaPosicao);
    } else {
      listaMusica[musica].jump(0);
    }
  }
}
