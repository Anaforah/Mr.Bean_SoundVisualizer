//////////////////////////////SUPER CLASSE BOTAO//////////////////////////////
class Botao{
  float x,y,l,a;                                                     //POSIÇAO X, POSIÇAO Y, LARGURA, ALTURA
  color c,acor;                                                      //COR ORGINAL E COR ARMAZENADA
  boolean texto;                                                     //BOOLEAN SE O EFEITO DO TEXTO É ATIVADO OU NÃO
  Botao(float x, float y, float l, float a, color c,boolean texto){  //CONSTRUTOR
    this.x=x;
    this.y=y;
    this.l=l;
    this.a=a;
    this.c=c;
    this.acor=c;
    this.texto=texto;
  }
  
  void desenha(){                                                    //DESENHO
    rectMode(CENTER);
    fill(acor);
    rect(x,y,l,a);
  }
  
 void mudaCor(color cor){                                            //SE O MOUSE ESTIVER EM CIMA DELE MUDA COR
   if(mouseX>x-(l/2) && mouseX<x+(l/2) && mouseY>y-(a/2) && mouseY<y+(a/2)){
     acor=cor;    
     texto=true;
   } else {
     acor=c;
     texto=false;
   }
 }
 
 boolean press(){                                                    //SE O MOUSE ESTIVER NO BOTAO RETORNA TRUE
   if(mouseX>x-(l/2) && mouseX<x+(l/2) && mouseY>y-(a/2) && mouseY<y+(a/2)){
     return true;
   } else {
     return false;
   }
 }
}
