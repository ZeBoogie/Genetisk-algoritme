import java.util.ArrayList;
import java.io.*;
import java.util.Random;
import java.util.*;
import java.util.*;
int graph_h=10;
int liste_h=300;
float kant=5;
int txtSize=25;
ArrayList<Integer> Data = new ArrayList<Integer>();
ArrayList<String> Taske = new ArrayList<String>();


ArrayList<Person> nextGeneration;
void setup()
{ 
  size(1280,720); // 16:9 ratio
  nextGeneration = new ArrayList<Person>();
  ArrayList<Integer> A =  new ArrayList<Integer>(Arrays.asList(200, 300, 500, 400));
  ArrayList<Integer> B = new ArrayList<Integer>(Arrays.asList(300, 100, 200, 400));
  nextGeneration.add(new Person(A, B));
  A = new ArrayList<Integer>(Arrays.asList(200, 0, 0, 400));
  B = new ArrayList<Integer>(Arrays.asList(300, 0, 0, 400));
  nextGeneration.add(new Person(A, B));
  A = new ArrayList<Integer>(Arrays.asList(0, 0, 0, 400));
  B = new ArrayList<Integer>(Arrays.asList(0, 0, 0, 400));
  nextGeneration.add(new Person(A, B));
  for(int i = 0; i < 10; i++)
  {
    println("generation");
    for (Person person : nextGeneration)
    {
        println(person.fitness);
    }
    getNextGeneration(nextGeneration);
    
  }
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


void getNextGeneration(ArrayList<Person> oldGeneration)
{
  ArrayList<Person> newGeneration = new ArrayList<Person>();
  Person bestPerson = new Person();
  bestPerson.fitness = 0;
  Person secondBestPerson = new Person();
  secondBestPerson.fitness = 0;
  
  //find top two people
  for (Person person : oldGeneration)
  {
      if (person.fitness > bestPerson.fitness && person.fitness < 5000)
      {
          secondBestPerson = bestPerson;
          bestPerson = person;
      }
      else if(person.fitness > secondBestPerson.fitness)
      {
          secondBestPerson = person;
      }
  }


  for (int i = 0; i < oldGeneration.size(); i++) 
  {
      //pick random values from best and second best person, and add it to the new person
      Person newPerson = new Person();
      for(int j = 0; j < bestPerson.weightInBag.size(); j++)
      {
        float rand = random(1);
        if(rand < 0.5) //take from second best
        {
          newPerson.weightInBag.add(secondBestPerson.weightInBag.get(j));
          newPerson.valueInBag.add(secondBestPerson.valueInBag.get(j));
        }
        if(rand >= 0.5) //take from best
        {
          newPerson.weightInBag.add(bestPerson.weightInBag.get(j));
          newPerson.valueInBag.add(bestPerson.valueInBag.get(j));        
        }
        if(rand > 0.975 || rand < 0.025)
        {
          
        }
      }
      newPerson.CalculateFitness();
      newGeneration.add(newPerson);
  }
  nextGeneration = newGeneration;
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
