import java.util.ArrayList;

class Person {
    public ArrayList<Integer> valueInBag;
    public ArrayList<Integer> weightInBag;
    public int fitness;
    public int totalWeight;
    public Person(ArrayList<Integer> _thingsInBag, ArrayList<Integer> _weightInBag)
    {
        valueInBag = _thingsInBag;
        weightInBag = _weightInBag;
        CalculateFitness();
    }
    public Person()
    {
        valueInBag = new ArrayList<Integer>();
        weightInBag = new ArrayList<Integer>();
    }
    public void CalculateFitness()
    {
        int sum = 0;
        for(int i = 0; i < valueInBag.size(); i++)
            sum += valueInBag.get(i);
        fitness = sum;
        sum = 0;
        for(int i = 0; i < weightInBag.size(); i++)
            sum += weightInBag.get(i);
        totalWeight = sum;
    }

}
