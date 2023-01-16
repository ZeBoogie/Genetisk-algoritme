 import java.util.*;
 import java.util.ArrayList;
 import java.io.File;  
 import java.io.FileNotFoundException;  
 import java.util.Scanner; 
  int graph_h=10;
  int liste_h=300;
  float kant=5;
  int txtSize=25;
  ArrayList<Person> person= new ArrayList<Person>();
  ArrayList<Integer> Data = new ArrayList<Integer>();
ArrayList<TaskeIndhold> taskeindhold = new ArrayList<TaskeIndhold>();
ArrayList<Person> nextGeneration;
ArrayList<Integer> bestResults = new ArrayList<Integer>();
int[] Individ = {0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,1,0,0,0,1};
  
void setup()
{ 
  size(1000,600); // 16:9 ratio
  noStroke();
  textSize(txtSize);
  
  
  
 
 changelist();
  //create first generation
  nextGeneration = new ArrayList<Person>();
  for (int i = 0; i < 100; i++)
  {
    Person newPerson = new Person();
    for(int j = 0; j < taskeindhold.size(); j++)
    {
      float rand = random(1);
      if(rand < 0.5) //take from second best
      {
        newPerson.weightInBag.add(0);
        newPerson.valueInBag.add(0);
      }
      if(rand >= 0.5) //take from best
      {
        newPerson.weightInBag.add(taskeindhold.get(j).weight);
        newPerson.valueInBag.add(taskeindhold.get(j).value);        
      }
    }
    newPerson.CalculateFitness();
    nextGeneration.add(newPerson);
  }
  for(int i = 0; i < 100; i++)
  {
    getNextGeneration(nextGeneration);
  }
  for(int goodresult : bestResults)
  {
    println(goodresult);
    Data.add(goodresult);
  }

}
 

void draw()
{

  background(51,204,204);
  fill(255);
  rect(graph_h,graph_h,width-3*graph_h-liste_h,height-2*graph_h);
  rect(width-graph_h-liste_h,graph_h,liste_h,height-2*graph_h); 
  graphmaking(Data);
  liste(taskeindhold, bestResults);
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
      if (person.fitness > bestPerson.fitness && person.totalWeight < 5000)
      {
          secondBestPerson = bestPerson;
          bestPerson = person;
      }
      else if(person.fitness > secondBestPerson.fitness && person.totalWeight < 5000)
      {
          secondBestPerson = person;
      }
  }
  bestResults.add(bestPerson.fitness); //<>//


  for (int i = 0; i < oldGeneration.size(); i++) 
  {
      //pick random values from best and second best person, and add it to the new person
      Person newPerson = new Person();
      for(int j = 0; j < bestPerson.weightInBag.size(); j++)
      {
        float rand = random(1); //<>//
        if(rand < 0.5) //take from second best
        {
          newPerson.weightInBag.add(secondBestPerson.weightInBag.get(j));
          newPerson.valueInBag.add(secondBestPerson.valueInBag.get(j));
        }
        if(rand >= 0.5) //take from best
        { //<>//
          newPerson.weightInBag.add(bestPerson.weightInBag.get(j));
          newPerson.valueInBag.add(bestPerson.valueInBag.get(j));        
        }
        if(rand > 0.7 || rand < 0.3)
        {
          if(newPerson.weightInBag.get(j) == 0)
          {
            newPerson.weightInBag.set(j,bestPerson.weightInBag.get(j));
          }
          else
          {
            newPerson.weightInBag.set(j,0);
          }
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

void liste(ArrayList<TaskeIndhold> Taske, ArrayList<Integer> Bedste)
{
  fill(0);
  ArrayList<String> Indhold = new ArrayList<String>();
  for (int i = 0; i < Taske.size(); i++)
  {
    if (Bedste.get(i) != 1)
    {
      Indhold.add(taskeindhold.get(i).name);
    }
  }
  text("Taske:",width-graph_h-liste_h+kant,graph_h+txtSize-kant);
  for (int i = 0; i < Indhold.size(); i++) //<>//
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
    taskeindhold.add(new TaskeIndhold(svendole[0], Integer.parseInt(svendole[1]), Integer.parseInt(svendole[2])));
  }
}
