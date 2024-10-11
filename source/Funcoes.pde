//////////////////////////////FUNÇÕES//////////////////////////////  

//desenhar_bolasconsoante_amplitude(audio_e_imagem)------------------------------------
  void desenhaBall(){                                  
    int ampe = int(amp.analyze()*1000);   
    for(int i = 0; i <ampe; i++){
      float x = random (0,width);                        //POSIÇÃO X DA BOLA
      float px = map(amp.analyze(),0, .5, 10, 60);       //RAIO DA BOLA
      float y = random(0, height);                       //POSIÇÃO Y DA BOLA
      color c = i1.get(int(x),int(y));                   //COR DA IMAGEM
      fill(c);    
      noStroke();
      ellipse(x,y,px,px);
    }
  } 
  
  
//desenharfundo(Audioeimagem)------------------------------------
 void desenhaFundo(){                                   
     PImage img;
     img=createImage(width,height,ARGB);
     float m = map(amp.analyze(),0.1,0.5,50,250);       //INTENSIDADE DO BRANCO
  if(amp.analyze()>0.1){
    img.loadPixels();
    for(int x = 0; x < img.width; x++){
      for(int y = 0; y < img.height; y++){
        int loc = x + y * img.width;
         color  c= color(m);
          img.pixels[loc]=c;
        
      }
    }
    img.updatePixels();
    image(img, width/2, height/2);
  }
}



//SeleçãoSom------------------------------------
void songSelected(File selection) {
  if(selection == null){                                  
  } else {
    listaMusica[4] = new SoundFile(this, selection.getAbsolutePath());   //SE NÃO FOR NULO CRIA-SE UM NOVO SOUNDFILE
            amplitude.input(listaMusica[musica]);
            fft.input(listaMusica[musica]);
  }
}
