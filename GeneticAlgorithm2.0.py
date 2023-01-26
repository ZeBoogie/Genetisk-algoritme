import random
import matplotlib.pyplot as plt

class Person:
    valuesInBag = []
    weightsInBag = []
    fitness = 0
    totalWeight = 0
    id = 0
    def __init__(self, *args):
        if(len(args) == 2):
            self.valuesInBag = args[0]
            self.weightsInBag = args[1]
            self.CalculateFitness()
        if(len(args) == 1):
            self.valuesInBag = []
            self.weightsInBag = []
            self.id = args[0]

    def CalculateFitness(self):
        sum = 0
        for i in range (len(self.valuesInBag)):
            sum += self.valuesInBag[i]
        self.fitness = sum
        sum = 0
        for i in range(len(self.weightsInBag)):
            sum += self.weightsInBag[i]
        self.totalWeight = sum

class TaskeIndhold:
    name = ""
    value = ""
    weight = ""
    def __init__(self, name, weight, value):
        self.name = name
        self.value = value
        self.weight = weight

repetitions = 50

bestResults = []
overallBestPerson = Person(random.random())
taskeindhold = []

lines = open("data.txt", "r").read()
print(lines)
seplines = lines.split("\n")
seplines.pop()
for line in seplines:
    line = line.split(" ")
    taskeindhold.append(TaskeIndhold(line[0], int(line[1]), int(line[2])))



#create first generation
nextGeneration = []
for i in range (40):
    newPerson = Person(i*random.random())
    for j in range (len(taskeindhold)):
        rand = random.random()
        if(rand < 0.5): #take from second best
            newPerson.weightsInBag.append(0)
            newPerson.valuesInBag.append(0)
        if(rand >= 0.5): #take from the best
            newPerson.weightsInBag.append(taskeindhold[j].weight)
            newPerson.valuesInBag.append(taskeindhold[j].value)
    newPerson.CalculateFitness()
    nextGeneration.append(newPerson)


def getNextGeneration(oldGeneration):
    global overallBestPerson 
    newGeneration = []
    bestPerson = Person(random.random())
    bestPerson.fitness = 0
    secondBestPerson = Person(random.random())
    secondBestPerson.fitness = 0

    #find best person
    for  person in oldGeneration:
        if person.fitness > bestPerson.fitness and person.totalWeight < 5000:
            secondBestPerson = bestPerson
            bestPerson = person
        elif person.fitness > secondBestPerson.fitness and person.totalWeight < 5000:
            secondBestPerson = person

    bestResults.append(bestPerson.fitness)
    if bestPerson.fitness > overallBestPerson.fitness:
        overallBestPerson = bestPerson


    for i in range (len(oldGeneration)):
        #pick random values from best and second best person, and add it to the new person
        newPerson = Person(random.random())
        for j in range(len(bestPerson.weightsInBag)):
            rand = random.random()
            if rand < 0.5: #take from second best
                newPerson.weightsInBag.append(secondBestPerson.weightsInBag[j])
                newPerson.valuesInBag.append(secondBestPerson.valuesInBag[j])
            if rand >= 0.5: #take from best
                newPerson.weightsInBag.append(bestPerson.weightsInBag[j])
                newPerson.valuesInBag.append(bestPerson.valuesInBag[j])  
            if rand > 0.975 or rand < 0.025:
                if(newPerson.weightsInBag[j] == 0):
                    newPerson.weightsInBag[j] = taskeindhold[j].weight
                    newPerson.valuesInBag[j] = taskeindhold[j].value
                else:
                    newPerson.weightsInBag[j] = 0
                    newPerson.valuesInBag[j] = 0
        newPerson.CalculateFitness()
        newGeneration.append(newPerson)
    global nextGeneration
    nextGeneration = newGeneration


for i in range (repetitions):
    getNextGeneration(nextGeneration)


# x axis values
x = list(range(0, repetitions))
# corresponding y axis values
y = bestResults
  

# plotting the points 
plt.plot(x, y)
  
#showing list

textstr = "bag:\n"

for i in range (len(overallBestPerson.valuesInBag)):
    if overallBestPerson.valuesInBag[i] != 0:
        textstr += "\n- "+ taskeindhold[i].name + " - weight: " + str(taskeindhold[i].weight)

plt.text(52, min(bestResults), textstr, fontsize=10)
plt.grid(True)
plt.subplots_adjust(right=0.6)

# naming the x axis
plt.xlabel('Iterationer')
# naming the y axis
plt.ylabel('Fitness')
  
# giving a title to my graph
plt.title('Fitness over iteration')
  
# function to show the plot
plt.show()