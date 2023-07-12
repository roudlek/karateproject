package officialpackage.animals.dogs;

import com.intuit.karate.junit5.Karate;

public class DogsRunner {
    @Karate.Test
    Karate getDogs(){ return Karate.run("dogs-get").relativeTo(getClass());}
}
