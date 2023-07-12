package examples.animals.cats;

import com.intuit.karate.junit5.Karate;

public class CatsRunner {
    @Karate.Test
    Karate testCats(){ return Karate.run("cats-get").relativeTo(getClass());
    }

    @Karate.Test
    Karate testSomethingElseCats(){ return Karate.run("cats-something-else").relativeTo(getClass());
    }

}
