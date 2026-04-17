package bdd.runner;

import com.intuit.karate.junit5.Karate;


class KarateTest {

    @Karate.Test
    Karate test() {
        return Karate.run("classpath:bdd/features").relativeTo(getClass());
    }
}