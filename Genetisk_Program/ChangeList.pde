import java.util.ArrayList;
import java.io.File;  
import java.io.FileNotFoundException;  
import java.util.Scanner; 

import javafx.beans.binding.When.StringConditionBuilder;
        

public class fjdkas {
    
    public static void main(String[] args) {
        ArrayList<Person> person= new ArrayList<Person>();
        
        try {
            File myObj = new File("data.txt");
            Scanner myReader = new Scanner(myObj);
            while (myReader.hasNextLine()) {
                String data = myReader.nextLine();
                System.out.println(data);
                String[] svendole = data.split(" ");
                person.add(svendole[0],svendole[1],svendole[2]);
      }
      myReader.close();
    } 
        catch (FileNotFoundException e) {
            System.out.println("An error occurred.");
            e.printStackTrace();
        }
  }
}
