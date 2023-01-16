 import java.util.*;
 import java.util.ArrayList;
 import java.io.File;  
 import java.io.FileNotFoundException;  
 import java.util.Scanner; 
  int graph_h=10;
  int liste_h=300;
  float kant=5;
  int txtSize=25;
  ArrayList<Integer> Data = new ArrayList<Integer>();
  ArrayList<String> taske = new ArrayList<String>();
  ArrayList<Person> person= new ArrayList<Person>();
  int[] Individ = {0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,1,0,0,0,1};
  
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
 
 changelist();
}
 

void draw()
{
  background(51,204,204);
  fill(255);
  rect(graph_h,graph_h,width-3*graph_h-liste_h,height-2*graph_h);
  rect(width-graph_h-liste_h,graph_h,liste_h,height-2*graph_h); 
  graphmaking(Data);
  liste(person, Individ);
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

void liste(ArrayList<Person> Taske, int[] Bedste)
{
  fill(0);
  ArrayList<String> Indhold = new ArrayList<String>();
  for (int i = 0; i < Taske.size(); i++)
  {
    if (Bedste[i] == 1)
    {
      Indhold.add(Taske.get(i).name);
    }
  }
  text("Taske:",width-graph_h-liste_h+kant,graph_h+txtSize-kant);
  for (int i = 0; i < Indhold.size(); i++)
  {
    text("- "+Indhold.get(i),width-graph_h-liste_h+kant,graph_h+2*txtSize-kant+i*txtSize);
  }
}

void faktorer()
{
  text("Generation: "+Data.size()+"/300",graph_h+kant,graph_h+txtSize-kant);
  text("Maks fitness: "+"ole",graph_h+kant,graph_h+2*txtSize-kant);
}

void changelist()
{
  String[] lines = loadStrings("data.txt");
  println("there are " + lines.length + " lines");
  for (int i = 0 ; i < lines.length; i++) 
  {
    
    String[] svendole = split(lines[i], " ");
    person.add(new Person(svendole[0], svendole[1], svendole[2]));
  }
  
         /*
        try {
            File myObj = new File("data.txt");
            Scanner myReader = new Scanner(myObj);
            while (myReader.hasNextLine()) {
                String data = myReader.nextLine();
                System.out.println(data);
                
      }
      myReader.close();
    } 
        catch (FileNotFoundException e) {
            System.out.println("An error occurred.");
            e.printStackTrace();
        }*/

}
