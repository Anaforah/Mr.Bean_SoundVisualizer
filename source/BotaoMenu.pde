//////////////////////////////CLASSE HERDADA DA CLASSE BOTAO//////////////////////////////
class BotaoMenu extends Botao {

  BotaoMenu(float x, float y, float l, float a, color c, boolean texto) {  //CONSTRUTOR
    super(x, y, l, a, c, texto);
  }
  
  void desenha(){                                                          //DESENHA ONDE ACRESCENTA O MENU
    rectMode(CENTER);
    fill(acor);
    rect(x,y,l,a);
    fill(0);
    textAlign(CENTER,CENTER);
    textSize(15);
    text("MENU", x, y);
  }
}
