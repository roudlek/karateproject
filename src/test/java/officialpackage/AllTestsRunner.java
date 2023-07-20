package officialpackage;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import static org.junit.jupiter.api.Assertions.*;

import net.masterthought.cucumber.Configuration;
import net.masterthought.cucumber.ReportBuilder;

import org.apache.commons.io.FileUtils;
import org.junit.jupiter.api.Test;

import java.io.File;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

class AllTestsRunner {

    @Test
    void testParallel() {
//        Runner.path("classpath:animals", "classpath:some/other/package.feature") // run more than a package
//        tags("@customer", "@smoke") //for multiple tags AND
//        tags("@customer,smoke")
//        parallel() has to be the last method called, and you pass the number of parallel threads needed.
//        reportDir() method if you want to customize the directory to which the HTML, XML and JSON files will be output, it defaults to target/karate-reports
        Results results = Runner.path("classpath:officialpackage")
//                .reportDir("**/karate-reports/*.xml").outputJunitXml(true) // target/karate-reports by default
                .outputCucumberJson(true)
                .tags()
//                .outputHtmlReport(true)
                .parallel(5); //mandatory method
        generateReport(results.getReportDir());
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }
//mvn test command only runs test classes that follow the *Test.java naming convention by default. But you can choose a single test to run like this:
    // in this example it runs ExamplesTest class wich is a .java file that runs any tests in subdirectory of the path
    public static void generateReport(String karateOutputPath) {
//       https://gist.github.com/Rajithkonara/0b2711889330107857e3ace09b101db7
        Collection<File> jsonFiles = FileUtils.listFiles(new File(karateOutputPath), new String[]{"json"}, true);
        List<String> jsonPaths = new ArrayList<>(jsonFiles.size());
        jsonFiles.forEach(file -> jsonPaths.add(file.getAbsolutePath()));
        Configuration config = new Configuration(new File("target"), "KarateBaseFramework");
        ReportBuilder reportBuilder = new ReportBuilder(jsonPaths, config);
        reportBuilder.generateReports();
    }
}
