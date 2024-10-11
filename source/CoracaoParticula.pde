//////////////////////////////CLASSE HERANÇA CORAÇÃO PARTÍCULA//////////////////////////////
class CoracaoParticula extends Coracao{
  PVector acel, vel;                                        //ACELERAÇÃO E VELOCIDADE
  
 CoracaoParticula(float r, color c, int stroke, int strokeWeight,PVector acel, PVector vel){ //CONSTRUTOR
    super(r,c,stroke,strokeWeight);                        //REUTILIZAR VALORES DA CLASSE DE ORIGEM
    this.vel=vel;
    this.acel=acel;
    super.vida=100;                                        //ALTERAR O VALOR DA VIDA DA CLASSE DE ORIGEM

  }
   
  void executa() {
    atualiza();
    super.desenha(txy);                                    //DESENHAR COM OS ATRIBUTOS DA SUPER
  }
  
  void atualiza() {                                       //ADICIONAR A VELOCIDADE E ACELERAÇAO                 
    vel.add(acel);
    super.txy.add(vel);
    vida -= 1;
  }
    
  boolean extinta(){                                      //O FIM DA VIDA DA PARTÍCULA
    return vida <=0;
    }
       
  }
