package ru.lanit.at.steps;

import io.cucumber.datatable.DataTable;
import io.cucumber.java.ru.И;
import io.qameta.allure.Allure;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.testng.Assert;
import ru.lanit.at.api.ApiRequest;
import ru.lanit.at.api.models.RequestModel;
import ru.lanit.at.api.testcontext.ContextHolder;
import ru.lanit.at.utils.*;

import java.util.*;

import static ru.lanit.at.api.testcontext.ContextHolder.replaceVarsIfPresent;
import static ru.lanit.at.utils.JsonUtil.getFieldFromJson;
import static ru.lanit.at.utils.FileUtil.readValueFromProperties;

public class ApiSteps {

    private static final Logger LOG = LoggerFactory.getLogger(ApiSteps.class);
    private ApiRequest apiRequest;

    @И("создать запрос")
    public void createRequest(RequestModel requestModel) {
        apiRequest = new ApiRequest(requestModel);
    }

    @И("добавить header")
    public void addHeaders(DataTable dataTable) {
        Map<String, String> headers = new HashMap<>();
        dataTable.asLists().forEach(it -> headers.put(it.get(0), it.get(1)));
        apiRequest.setHeaders(headers);
    }

    //Можно добавить секретные параметры из проперти. Файл положить в папку ресурсов
    @И("добавить query параметры")
    public void addQuery(DataTable dataTable) {
        Map<String, String> query = new HashMap<>();
        dataTable.asLists().forEach(it -> {
            if(it.get(1).equals("fromProperties")){
                String param = readValueFromProperties("secret.properties", it.get(0));
                query.put(it.get(0), param);
            } else query.put(it.get(0), it.get(1));
        });
        apiRequest.setQuery(query);
    }

    @И("отправить запрос")
    public void send() {
        apiRequest.sendRequest();
    }

    @И("статус код {int}")
    public void expectStatusCode(int code) {
        int actualStatusCode = apiRequest.getResponse().statusCode();
        Assert.assertEquals(actualStatusCode, code);
    }

    @И("извлечь данные")
    public void extractVariables(Map<String, String> vars) {
        String responseBody = apiRequest.getResponse().body().asPrettyString();
        vars.forEach((k, jsonPath) -> {
            jsonPath = replaceVarsIfPresent(jsonPath);
            String extractedValue = VariableUtil.extractBrackets(getFieldFromJson(responseBody, jsonPath));
            ContextHolder.put(k, extractedValue);
            Allure.addAttachment(k, "application/json", extractedValue, ".txt");
            LOG.info("Извлечены данные: {}={}", k, extractedValue);
        });
    }

    @И("сгенерировать переменные")
    public void generateVariables(Map<String, String> table) {
        table.forEach((k, v) -> {
            String value = DataGenerator.generateValueByMask(replaceVarsIfPresent(v));
            ContextHolder.put(k, value);
            Allure.addAttachment(k, "application/json", k + ": " + value, ".txt");
            LOG.info("Сгенерирована переменная: {}={}", k, value);
        });
    }

    @И("создать контекстные переменные")
    public void createContextVariables(Map<String, String> table) {
        table.forEach((k, v) -> {
            ContextHolder.put(k, v);
            LOG.info("Сохранена переменная: {}={}", k, v);
        });
    }

    @И("сравнить значения")
    public void compareVars(DataTable table) {
        table.asLists().forEach(it -> {
            String expect = replaceVarsIfPresent(it.get(0));
            String actual = replaceVarsIfPresent(it.get(2));
            boolean compareResult = CompareUtil.compare(expect, actual, it.get(1));
            Assert.assertTrue(compareResult, String.format("Ожидаемое: '%s'\nФактическое: '%s'\nОператор сравнения: '%s'\n", expect, actual, it.get(1)));
            Allure.addAttachment(expect, "application/json", expect + it.get(1) + actual, ".txt");
            LOG.info("Сравнение значений: {} {} {}", expect, it.get(1), actual);
        });
    }

    @И("подождать {int} сек")
    public void waitSeconds(int timeout) {
        Sleep.pauseSec(timeout);
    }

    //                                                                   -- new steps --

    @И("заполнить пустые поля и добавить их в query параметры")
    public void fillValues(DataTable table){
        Map<String, String> query = new HashMap<>();
        ContextHolder.asMap().forEach((k, v) -> {
            if(v==""){
                query.put(k, table.asMap(String.class, String.class).get(k).toString());
                LOG.info("Заполняем пустое поле {} значением {}", k, table.asMap(String.class, String.class).get(k));
            }
        });
        apiRequest.setQuery(query);
    }

    @И("добавить файлы")
    public void addFiles(DataTable files){
        apiRequest.addMultiPart(files.asMap(String.class, String.class));
    }

    @И("создать запрос с параметрами по ссылке из контекста {word}")
    public void extractData(String url){
        String uri = ContextHolder.getValue(url);
        String[] params = uri.split("\\?")[1].split("&");
        Map<String, String> query = new HashMap<>();
        Arrays.stream(params).forEach(p -> {
            query.put(p.split("=")[0], p.split("=")[1]);
        });
        apiRequest = new ApiRequest(new RequestModel("POST", "", "", uri));
        apiRequest.setQuery(query);
        ContextHolder.remove(url);
    }


}
