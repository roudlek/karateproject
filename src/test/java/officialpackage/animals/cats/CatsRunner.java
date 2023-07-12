package officialpackage.animals.cats;

import com.intuit.karate.junit5.Karate;

public class CatsRunner {
    @Karate.Test
    Karate testCats(){ return Karate.run("cats-get").tags("@Ready").relativeTo(getClass());
    }

    @Karate.Test
    Karate testDefine(){ return Karate.run("cats-define").relativeTo(getClass());
    }

    @Karate.Test
    Karate testSomethingElseCats(){ return Karate.run("cats-something-else").relativeTo(getClass());
    }

//    to run a single method using command line : mvn test -Dtest=className#MethodName
}
