package com.caille_fort.api.Services;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import io.github.cdimascio.dotenv.Dotenv;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;

@Service
public class GPTService {

    private static final Dotenv dotenv = Dotenv.load();
    private static final String API_KEY = dotenv.get("OPENAI_API_KEY");
    private static final String API_URL = dotenv.get("OPENAI_API_URL");

    private final Gson gson = new Gson();

    public String getGptResponse(String question, String answer) throws IOException, InterruptedException {
        HttpClient client = HttpClient.newHttpClient();

        String prompt = String.format(
                "Dans un objectif éducatif et ludique, une question a été posée à une personne pour approfondir ses connaissances sur " +
                        "le thème de la mer. Voici la question et sa réponse :" +
                "Question : %s" + "Réponse proposée : %s" +
                "Évalue cette réponse en respectant les consignes suivantes :\n" +
                        "1. Réponds par 'Oui' ou 'Non' pour indiquer si la réponse est correcte.\n " +
                        "2. Explique brièvement les raisons de cette évaluation en te basant uniquement " +
                        "sur les faits et les arguments, sans t'adresser directement à la personne ni utiliser " +
                        "des formulations comme 'Vous avez raison' ou 'Vous avez tort'.\n" +
                        "3. Retourne la réponse au format suivant pour faciliter l'analyse :" +
                        "{\n" +
                        "  \"evaluation\": \"Oui\" ou \"Non\",\n" +
                        "  \"explication\": \"Explication claire et concise ici.\"\n" +
                        "}",
                question, answer
        );

        JsonObject messageObject = new JsonObject();
        messageObject.addProperty("role", "user");
        messageObject.addProperty("content", prompt);

        JsonArray messagesArray = new JsonArray();
        messagesArray.add(messageObject);

        JsonObject requestBody = new JsonObject();
        requestBody.addProperty("model", "gpt-3.5-turbo");
        requestBody.add("messages", messagesArray);

        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(API_URL))
                .header("Content-Type", "application/json")
                .header("Authorization", "Bearer " + API_KEY)
                .POST(HttpRequest.BodyPublishers.ofString(gson.toJson(requestBody)))
                .build();

        HttpResponse<String> response = client.send(request, HttpResponse.BodyHandlers.ofString());

        JsonObject jsonResponse = gson.fromJson(response.body(), JsonObject.class);
        return jsonResponse.getAsJsonArray("choices")
                .get(0).getAsJsonObject().get("message")
                .getAsJsonObject().get("content").getAsString();
    }
}
