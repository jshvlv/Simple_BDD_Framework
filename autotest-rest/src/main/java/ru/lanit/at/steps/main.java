package ru.lanit.at.steps;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ArrayNode;

public class main {
    public static void main(String[] args) throws JsonProcessingException {
        String json = "{\"server\":536632,\"photos_list\":\"[{\\\"markers_restarted\\\":true,\\\"photo\\\":\\\"4e25602c04:z\\\",\\\"sizes\\\":[],\\\"latitude\\\":0,\\\"longitude\\\":0,\\\"kid\\\":\\\"7d2545ba775faa7a7e32d32ad504a2b2\\\",\\\"sizes2\\\":[[\\\"s\\\",\\\"fb0d3a3728ddb58f3433341010bc39bd09a3e6e05354f5d9d9f94f47\\\",\\\"-4340074615996909359\\\",75,59],[\\\"m\\\",\\\"95185d9ef23d31c46b27817681a5b578239c3aff49234b3a49603fb7\\\",\\\"3924100166080530182\\\",130,102],[\\\"x\\\",\\\"681931e09d7a5ca661515e672662abb3542b9878ad2fa31ecde0f9d9\\\",\\\"1396500414409238761\\\",604,472],[\\\"y\\\",\\\"f9053ac969f001d42396938659f381ee163d5ba4139a1b4e9f941f37\\\",\\\"-3467454491114824009\\\",807,631],[\\\"z\\\",\\\"8636dda0421200a9772e7282316bc1fa97fab35d9caa5fc0fb9b002b\\\",\\\"2937889505029847578\\\",1200,938],[\\\"o\\\",\\\"95185d9ef23d31c46b27817681a5b578239c3aff49234b3a49603fb7\\\",\\\"3924100166080530182\\\",130,102],[\\\"p\\\",\\\"3e17d4ccacef79082227c4dc229a55ed8b15335644ffe070f22ec4f9\\\",\\\"-6972860840523529997\\\",200,156],[\\\"q\\\",\\\"03d1ec588f7aaddd683e8473a8fdbdc128c1a6ec59dcaa2cf10a387e\\\",\\\"2182562547470517504\\\",320,250],[\\\"r\\\",\\\"63adc64fd38b752030fa9c332fc42bb3ca06ba25326afb6f230fb9f2\\\",\\\"-7801328461453929461\\\",510,399]],\\\"urls\\\":[],\\\"urls2\\\":[\\\"-w06NyjdtY80MzQQELw5vQmj5uBTVPXZ2flPRw/0XjQpiH1xMM.jpg\\\",\\\"lRhdnvI9McRrJ4F2gaW1eCOcOv9JI0s6SWA_tw/BgdIbk80dTY.jpg\\\",\\\"aBkx4J16XKZhUV5nJmKrs1QrmHitL6MezeD52Q/6WiMWbpdYRM.jpg\\\",\\\"-QU6yWnwAdQjlpOGWfOB7hY9W6QTmhtOn5QfNw/t55E_oIg4c8.jpg\\\",\\\"hjbdoEISAKl3LnKCMWvB-pf6s12cql_A-5sAKw/GvqmcPB6xSg.jpg\\\",\\\"lRhdnvI9McRrJ4F2gaW1eCOcOv9JI0s6SWA_tw/BgdIbk80dTY.jpg\\\",\\\"PhfUzKzveQgiJ8TcIppV7YsVM1ZE_-Bw8i7E-Q/8wBdZAJsO58.jpg\\\",\\\"A9HsWI96rd1oPoRzqP29wSjBpuxZ3Kos8Qo4fg/AEUNvhIFSh4.jpg\\\",\\\"Y63GT9OLdSAw-pwzL8Qrs8oGuiUyavtvIw-58g/C9Tk9hgdvJM.jpg\\\"]}]\",\"aid\":241585786,\"hash\":\"7c8e458fca6d0fa2224b066c2e165e25\"}";
        String newJson = json.replaceAll("\\\\", "");
        System.out.printf("Json = %s \n\n\n new Json = %s", json, newJson);

    }
}
