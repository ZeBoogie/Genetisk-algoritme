import java.util.ArrayList;

class Person {
    public ArrayList<Integer> thingsInBag;
    public ArrayList<Integer> weightInBag;
    public int fitness;
    public Person(ArrayList<Integer> _thingsInBag, ArrayList<Integer> _weightInBag)
    {
        thingsInBag = _thingsInBag;
        weightInBag = _weightInBag;
        CalculateFitness();
    }
    public Person()
    {
        thingsInBag = new ArrayList<Integer>();
        weightInBag = new ArrayList<Integer>();
    }
    public void CalculateFitness()
    {
        int sum = 0;
        for(int i = 0; i < thingsInBag.size(); i++)
            sum += thingsInBag.get(i);
        fitness = sum;
    }

}
