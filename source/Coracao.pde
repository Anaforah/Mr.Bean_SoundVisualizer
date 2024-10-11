//////////////////////////////CLASSE MÃE CORAÇÃO//////////////////////////////
class Coracao {
  float tx, ty;                                              //COORDENADAS DA TRANSLAÇÃO
  float x, y;                                                //COORDENADAS POSIÇÃO
  PVector txy = new PVector(tx, ty);                         //VETOR
  PVector pos = new PVector(x, y);                           //VETOR
  color c;                                                   //COR DO CORAÇÃO
  color cchange;                                             //ARMANEZENAR A COR BASE PARA CONSEGUIR TROCAR DE COR
  int stroke, strokeWeight;
  float r;                                                   //RAIO
  int vida;                                                  //NÚMERO DE VIDA DO OBJETO

  Coracao(float r, color c, int stroke, int strokeWeight) {  //CONSTRUTOR
    this.c = c;
    this.stroke = stroke;
    this.strokeWeight = strokeWeight;
    this.r = r;
    cchange = c;
    vida = 255;
  }

  void desenha(PVector txy) {            
    this.txy=txy;
    pushMatrix();                                           //limitar a deslocação apenas nesta área de código
    translate(txy.x, txy.y);
    fill(c, vida);
    stroke(stroke, vida);
    strokeWeight(strokeWeight);
    beginShape();                                          //excerto retirado de: https://www.youtube.com/watch?v=oUBAi9xQ2X4&list=LL&index=3&t=1s
    for (float a = 0; a < TWO_PI; a += 0.01) {             
      float px = r * 16 * pow(sin(a), 3);                  //pow = a potência de um número que recebe a base e o expoente, e retorna a base elevada ao expoente
      float py = -r * (13 * cos(a) - 5 * cos(2*a) - 2 * cos(3*a)- cos(4*a)); //formula matemática de uma cardioide
      PVector p = new PVector(px, py);
      p.add(pos);
      vertex(p.x, p.y);
    }
    endShape();
    popMatrix();
  }
  
    void amplitude(){                                       
    r=map(amplitude.analyze(),0,1,2,15);                   //RAIO VARIA CONSOANTE A AMPLITUDE
  }


}
