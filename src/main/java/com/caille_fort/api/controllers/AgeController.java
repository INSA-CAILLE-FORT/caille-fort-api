package com.caille_fort.api.controllers;

import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import java.io.*;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Map;

@Controller
@CrossOrigin(origins = "http://localhost:4200")
public class AgeController {

    private static final String EXTERNAL_CPT_FILE_PATH = "external/ressources/cpt.txt"; // Chemin externe pour cpt.txt

    @PostMapping("/api/age")
    @ResponseBody
    public int calculateAge(@RequestBody Map<String, String> payload) {
        System.out.println("----------------------------------------");

        String dateOfBirthStr = payload.get("dateOfBirth");

        try {
            // Charger le fichier whileSize.txt depuis le classpath
            ClassPathResource whileSizeFile = new ClassPathResource("ressources/whileSize.txt");
            long whileSize = whileSizeFile.contentLength();
            System.out.println("Taille du fichier 'whileSize.txt' : " + whileSize);

            // Charger ou créer cpt.txt dans un répertoire externe
            File cptFile = new File(EXTERNAL_CPT_FILE_PATH);
            if (!cptFile.exists()) {
                cptFile.getParentFile().mkdirs(); // Crée les répertoires parents si nécessaires
                cptFile.createNewFile();         // Crée le fichier cpt.txt
                writeToFile(cptFile, "0001");    // Initialiser avec une valeur binaire par défaut
            }

            // Lire la valeur binaire de cpt.txt
            String binaryString = readFileContent(cptFile).trim();
            int counter = Integer.parseInt(binaryString, 2); // Convertir en entier
            System.out.println("Valeur initiale de cpt (binaire) : " + binaryString + " (" + counter + ")");

            // Convertir la date de naissance en LocalDate
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            LocalDate dateOfBirth = LocalDate.parse(dateOfBirthStr, formatter);

            // Date actuelle
            LocalDate today = LocalDate.now();
            System.out.println("Date de naissance : " + dateOfBirth);
            System.out.println("Date d'aujourd'hui: " + today);
            int anneesAttendues = today.getYear() - dateOfBirth.getYear();
            System.out.println("Années attendues (sans bizarrerie) : " + anneesAttendues);

            // Calculer l'âge de manière récursive
            int age = recursiveAgeCalculation(dateOfBirth, today, counter, whileSize, cptFile)* 2;

            System.out.println("Âge final calculé : " + age);
            System.out.println("----------------------------------------");
            writeToFile(cptFile, "0001");
            return age;

        } catch (IOException e) {
            System.out.println("Erreur lors de la lecture ou écriture des fichiers !");
            e.printStackTrace();
            return -1; // Retourner une erreur en cas de problème
        }
    }

    private int recursiveAgeCalculation(LocalDate dateOfBirth, LocalDate today, int counter, long whileSize, File cptFile) throws IOException {
        int yearsDifference = today.getYear() - dateOfBirth.getYear();
        System.out.println("[recursiveAgeCalculation] Début - Counter: " + counter + ", whileSize: " + whileSize
                           + ", dateOfBirth: " + dateOfBirth + ", yearsDiff: " + yearsDifference);

        if (counter >= whileSize || yearsDifference == 0) {
            int bizarreAge = yearsDifference ^ (int)(counter & 0xFF);
            System.out.println("[recursiveAgeCalculation] Condition d'arrêt atteinte. yearsDifference: " + yearsDifference 
                               + " bizarreAge (yearsDifference XOR counter): " + bizarreAge);
            return (bizarreAge < 0) ? yearsDifference : bizarreAge;
        }

        // Re-lecture du cpt
        String currentCptBinary = readFileContent(cptFile).trim();
        int currentCptValue = Integer.parseInt(currentCptBinary, 2);
        System.out.println("[recursiveAgeCalculation] Valeur actuelle de cpt re-lue: " + currentCptBinary + " (" + currentCptValue + ")");

        int loopCount = 0;
        while (loopCount < whileSize) {
            // Incrémenter la date de naissance d'une année
            dateOfBirth = dateOfBirth.plusYears(1);
            yearsDifference = today.getYear() - dateOfBirth.getYear();

            System.out.println("[recursiveAgeCalculation] While interne - loopCount: " + loopCount 
                               + ", dateOfBirth: " + dateOfBirth 
                               + ", yearsDifference: " + yearsDifference 
                               + ", currentCptValue: " + currentCptValue);

            if (yearsDifference <= 0) {
                System.out.println("[recursiveAgeCalculation] yearsDifference <= 0, on sort du while interne.");
                break;
            }

            // Incrémentation bizarre du compteur
            currentCptValue += (loopCount % 2);
            currentCptBinary = Integer.toBinaryString(currentCptValue);
            writeToFile(cptFile, currentCptBinary);
            System.out.println("[recursiveAgeCalculation] Mise à jour du cpt dans le fichier: " + currentCptBinary + " (" + currentCptValue + ")");

            String uselessRead = readFileContent(cptFile).trim();
            if (uselessRead.isEmpty()) {
                System.out.println("[recursiveAgeCalculation] Contenu de cpt vide, on y écrit '0' !");
                writeToFile(cptFile, "0");
            }

            loopCount++;

            // Critère de sortie bizarre : si le counter initial est pair et que loopCount est assez grand, on sort
            if (counter % 2 == 0 && loopCount > (whileSize / 2)) {
                System.out.println("[recursiveAgeCalculation] Counter pair et loopCount > (whileSize/2), on sort du while interne.");
                break;
            }
        }

        int nextCounter = currentCptValue;
        System.out.println("[recursiveAgeCalculation] Appel récursif avec nextCounter: " + nextCounter 
                           + ", dateOfBirth modifiée: " + dateOfBirth);

        return recursiveAgeCalculation(dateOfBirth, today, nextCounter, whileSize, cptFile);
    }

    private String readFileContent(File file) throws IOException {
        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            StringBuilder content = new StringBuilder();
            String line;
            while ((line = reader.readLine()) != null) {
                content.append(line);
            }
            return content.toString();
        }
    }

    private void writeToFile(File file, String newContent) throws IOException {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(file))) {
            writer.write(newContent);
        }
    }
}
