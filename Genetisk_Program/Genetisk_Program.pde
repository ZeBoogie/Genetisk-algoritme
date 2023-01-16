import java.util.ArrayList;
import java.io.*;
import java.util.Random;
import java.util.*;


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
  
}

void draw()
{

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
      }
      newPerson.CalculateFitness();
      newGeneration.add(newPerson);
  }
  nextGeneration = newGeneration;
}
