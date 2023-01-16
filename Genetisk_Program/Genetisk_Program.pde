 import java.util.*;
  int graph_h=10;
  int liste_h=300;
  float kant=5;
  int txtSize=25;
  ArrayList<Integer> Data = new ArrayList<Integer>();
  ArrayList<String> Taske = new ArrayList<String>();
  
void setup()
{
  size(1000,600);
  noStroke();
  textSize(txtSize);
  Data.add(2);
  Data.add(5);
  Data.add(9);
  Data.add(3);
  Data.add(5);
  Data.add(7);
  Data.add(8);
  
 Taske.add("Kage");
 Taske.add("Is");
 Taske.add("Telt");
}

void draw()
{
  background(51,204,204);
  fill(255);
  rect(graph_h,graph_h,width-3*graph_h-liste_h,height-2*graph_h);
  rect(width-graph_h-liste_h,graph_h,liste_h,height-2*graph_h); 
  graphmaking(Data);
  liste(Taske);
  faktorer();
}

void graphmaking(ArrayList<Integer> Fitness)
{
  fill(255,0,255);
  int maks = Collections.max(Fitness);
  for (int i = 0; i < Fitness.size(); i++)
  {
    fill(255-i*128/Fitness.size(),0,255-i*128/Fitness.size());
    rect(graph_h+kant+i*((width-3*graph_h-liste_h-2*kant)/Fitness.size()),height-graph_h-kant-(height-2*graph_h-2*kant)/(maks)*Fitness.get(i),(width-3*graph_h-liste_h-2*kant)/Fitness.size(),(height-2*graph_h-2*kant)/maks*Fitness.get(i));
  }
}

void liste(ArrayList<String> Taske)
{
  fill(0);
  text("Taske:",width-graph_h-liste_h+kant,graph_h+txtSize-kant);
  for (int i = 0; i < Taske.size(); i++)
  {
    text("- "+Taske.get(i),width-graph_h-liste_h+kant,graph_h+2*txtSize-kant+i*txtSize);
  }
}

void faktorer()
{
  text("Generation: "+Data.size()+"/300",graph_h+kant,graph_h+txtSize-kant);
  text("Maks fitness: "+"ole",graph_h+kant,graph_h+2*txtSize-kant);
}
