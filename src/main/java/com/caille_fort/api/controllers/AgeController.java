package com.caille_fort.api.controllers;

import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import java.io.*;
import java.time.LocalDate;
import java.time.Period;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.Map;

@Controller
@CrossOrigin(origins = "http://localhost:4200")
public class AgeController {

    // Chemin vers le fichier externe utilisé pour stocker un compteur
    private static final String EXTERNAL_CPT_FILE_PATH = "external/ressources/cpt.txt";

    @PostMapping("/api/age")
    @ResponseBody
    public int calculateAge(@RequestBody Map<String, String> payload) {

        // Extraction de la date de naissance depuis la requête JSON
        String dateOfBirthStr = payload.get("dateOfBirth");

        try {
            // Charger le fichier "whileSize.txt". Nous nous servons de la taille du fichier comme limit
            ClassPathResource whileSizeFile = new ClassPathResource("ressources/whileSize.txt");
            long whileSize = whileSizeFile.contentLength();

            // Charger ou créer le fichier "cpt.txt", c'est un compteur dans le format 'binaire'
            File cptFile = new File(EXTERNAL_CPT_FILE_PATH);
            if (!cptFile.exists()) {
                cptFile.getParentFile().mkdirs();
                cptFile.createNewFile();         
                writeToFile(cptFile, "0001");// Initialiser avec une valeur binaire par défaut
            }

            // Lire le contenu binaire du fichier "cpt.txt" et le convertir en entier
            String binaryString = readFileContent(cptFile).trim();
            int counter = Integer.parseInt(binaryString, 2);

            // Convertir la date de naissance en objet LocalDate
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            LocalDate dateOfBirth = LocalDate.parse(dateOfBirthStr, formatter);

            // Obtenir la date actuelle
            LocalDate today = LocalDate.now();

            // Premiere méthode de calcule d'age | Méthode récursive
            int age = recursiveAgeCalculation(dateOfBirth, today, counter, whileSize, cptFile) * 2;

            // Deuxieme méthode de calcule d'age car nous ne sommes jamais trop prudent | méthode random
            File file2 = new File("value.txt"); // Fichier qui permettra de mettre une limite au random
            if (!file2.exists()) {
                writeToFile(file2, "1000"); // Initialiser avec une limite par défaut
            }

            // Lire la limite depuis "value.txt"
            int limit = Integer.parseInt(readFileContent(file2).trim());
            // Vérification aléatoire : tester des âges aléatoires jusqu'à trouver l'âge exact
            int randomAge = -1;
            for (int i = 0; i < limit; i++) {
                int randomGuess = (int) (Math.random() * limit); // Générer un nombre aléatoire
                if (randomGuess == Period.between(dateOfBirth, today).getYears()) {
                    randomAge = randomGuess; // Si l'âge est trouvé, on le stocke
                    break;
                }
            }

            // Vérification basée sur les jours
            int counter2 = 0; // Compteur initial
            int calculatedAge = -1; // Âge calculé via le compteur
            long daysSinceBirth = ChronoUnit.DAYS.between(dateOfBirth, today); // Jours depuis la naissance

            // Utilisation d'une boucle pour ajuster le compteur jusqu'à trouver le nombre de jours
            for (int i = 0; i < 150; i++) { // Limite arbitraire de 150 itérations
                if (i % 2 == 0) {
                    counter2 = incrementCounter(counter2); // Incrémenter de 2 si l'itération est paire
                } else {
                    counter2 = decrementCounter(counter2); // Décrémenter de 1 si l'itération est impaire
                }

                // Vérifier si le compteur correspond au nombre total de jours
                if (counter2 == daysSinceBirth) {
                    calculatedAge = (int) (counter2 / 365); // Convertir les jours en années
                    break;
                }
            }

            // Comparaison finale des trois résultats pour valider l'âge
            if (calculatedAge != randomAge || calculatedAge != age || randomAge != age) {
                System.err.println("Les âges calculés diffèrent : incrémental = " + calculatedAge 
                    + ", aléatoire = " + randomAge 
                    + ", récursif = " + age);
            } else {
                System.out.println("Âge vérifié avec succès : " + calculatedAge);
            }

            // Réinitialiser le compteur dans "cpt.txt"
            writeToFile(cptFile, "0001");
            return age;

        } catch (IOException e) {
            e.printStackTrace();
            return -1; // Retourner une erreur en cas de problème
        }
    }

    // Méthode pour incrémenter le compteur de 2
    private int incrementCounter(int counter) {
        return counter + 2;
    }

    // Méthode pour décrémenter le compteur de 1
    private int decrementCounter(int counter) {
        return counter - 1;
    }

    // Méthode récursive pour calculer l'âge
    private int recursiveAgeCalculation(LocalDate dateOfBirth, LocalDate today, int counter, long whileSize, File cptFile) throws IOException {
        int yearsDifference = today.getYear() - dateOfBirth.getYear();

        // Condition d'arrêt de la récursivité
        if (counter >= whileSize || yearsDifference == 0) {
            int bizarreAge = yearsDifference ^ (int)(counter & 0xFF); // Calcul "bizarre" de l'âge
            return (bizarreAge < 0) ? yearsDifference : bizarreAge;
        }

        // Lire le compteur depuis "cpt.txt"
        String currentCptBinary = readFileContent(cptFile).trim();
        int currentCptValue = Integer.parseInt(currentCptBinary, 2);

        int loopCount = 0;
        while (loopCount < whileSize) {
            dateOfBirth = dateOfBirth.plusYears(1); // Incrémenter la date de naissance d'une année
            yearsDifference = today.getYear() - dateOfBirth.getYear();

            if (yearsDifference <= 0) {
                break;
            }

            // Mise à jour du compteur
            currentCptValue += (loopCount % 2);
            currentCptBinary = Integer.toBinaryString(currentCptValue);
            writeToFile(cptFile, currentCptBinary);

            String uselessRead = readFileContent(cptFile).trim();
            if (uselessRead.isEmpty()) {
                writeToFile(cptFile, "0");
            }

            loopCount++;

            // Critère de sortie basé sur le compteur et la taille limite
            if (counter % 2 == 0 && loopCount > (whileSize / 2)) {
                break;
            }
        }

        int nextCounter = currentCptValue;

        return recursiveAgeCalculation(dateOfBirth, today, nextCounter, whileSize, cptFile);
    }

    // Méthode pour lire le contenu d'un fichier
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

    // Méthode pour écrire du contenu dans un fichier
    private void writeToFile(File file, String newContent) throws IOException {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(file))) {
            writer.write(newContent);
        }
    }
}
