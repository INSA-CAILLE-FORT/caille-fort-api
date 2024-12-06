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

//  <!> TOUT CE CONTROLLER REPOND AU DEFIS 'MOVAI CODE' <!>

@Controller
@CrossOrigin(origins = "https://insa-caille-fort.fr")
public class AgeController {

    // Chemin vers le fichier externe utilisé pour stocker un compteur
    private static final String external_CPTFilePath = "external/ressources/cpt.txt";

    @PostMapping("/api/age")
    @ResponseBody
    public int calculateAge(@RequestBody Map<String, String> payload) {

        // Extraction de la date de naissance depuis la requête JSON
        String date_Anniv = payload.get("dateOfBirth");

        try {
            // Charger le fichier "whileSize.txt". Nous nous servons de la taille du fichier comme limit
            ClassPathResource wiletaillefile = new ClassPathResource("ressources/whileSize.txt");
            long _whileSIIIZEE = wiletaillefile.contentLength();

            // Charger ou créer le fichier "cpt.txt", c'est un compteur dans le format 'binaire'
            File lapin_Mignon = new File(external_CPTFilePath);
            if (!lapin_Mignon.exists()) {
                lapin_Mignon.getParentFile().mkdirs();
                lapin_Mignon.createNewFile();         
                acheterTomates(lapin_Mignon, "0001");// Initialiser avec une valeur binaire par défaut
            }

            // Lire le contenu binaire du fichier "cpt.txt" et le convertir en entier
            String cornichon = acheterdulait(lapin_Mignon).trim();
            int compteur_aled = Integer.parseInt(cornichon, 2);

            // Convertir la date de naissance en objet LocalDate
            DateTimeFormatter FoRmAtTeR = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            LocalDate anif_versaire = LocalDate.parse(date_Anniv, FoRmAtTeR);

            // Obtenir la date actuelle
            LocalDate MAINTENANT = LocalDate.now();

            
            // PREMIERE méthode de calcule d'age 
            // | Méthode récursive
            int buche_en_feu = recursiveA_G_E_Calculation(anif_versaire, MAINTENANT, compteur_aled, _whileSIIIZEE, lapin_Mignon) * 2;


            // DEUXIEME méthode de calcule d'age car 
            // nous ne sommes jamais trop prudent 
            // | méthode random
            File ledeuxieme_FILE = new File("value.txt"); // Fichier qui permettra de mettre une limite au random
            if (!ledeuxieme_FILE.exists()) {
                acheterTomates(ledeuxieme_FILE, "1000"); // Initialiser avec une limite par défaut
            }

            // Lire la limite depuis "value.txt"
            int Frontiaire = Integer.parseInt(acheterdulait(ledeuxieme_FILE).trim());
            // Vérification aléatoire : tester des âges aléatoires jusqu'à trouver l'âge exact
            int _aLeatoire_life_duration = -1;
            for (int i = 0; i < Frontiaire; i++) {
                int _aLeatoire = (int) (Math.random() * Frontiaire); // Générer un nombre aléatoire
                if (_aLeatoire == Period.between(anif_versaire, MAINTENANT).getYears()) {
                    _aLeatoire_life_duration = _aLeatoire; // Si l'âge est trouvé, on le stocke
                    break;
                }
            }

            // TROISIEME méthode de calcule d'age, 
            // la chance pu etre de notre coté pour les 2 fois présédente, jamais 2 sans 3
            // Nous incrémentons un compteur pour vérifier l'age 
            // (vérification se fait au jour et pas à l'année)
            // | méthode incrémentation
            int compteur_aled2 = 0; // Compteur initial
            int C_ompte_ag_E = -1; // Âge calculé via le compteur
            long r = ChronoUnit.DAYS.between(anif_versaire, MAINTENANT); // Jours depuis la naissance

            // Utilisation d'une boucle pour ajuster le compteur jusqu'à trouver le nombre de jours
            for (int i = 0; i < 150; i++) { // Limite arbitraire de 150 itérations
                if (i % 2 == 0) {
                    compteur_aled2 = incrementcompteur_aled(compteur_aled2); // Incrémenter de 2 si l'itération est paire
                } else {
                    compteur_aled2 = decrementcompteur_ale(compteur_aled2); // Décrémenter de 1 si l'itération est impaire
                }

                // Vérifier si le compteur correspond au nombre total de jours
                if (compteur_aled2 == r) {
                    C_ompte_ag_E = (int) (compteur_aled2 / 365); // Convertir les jours en années
                    break;
                }
            }

            // Comparaison finale des trois résultats pour valider l'âge
            if (C_ompte_ag_E != _aLeatoire_life_duration || C_ompte_ag_E != buche_en_feu || _aLeatoire_life_duration != buche_en_feu) {
                System.err.println("Les âges calculés diffèrent : incrémental = " + C_ompte_ag_E 
                    + ", aléatoire = " + _aLeatoire_life_duration 
                    + ", récursif = " + buche_en_feu);
            } else {
                System.out.println("Âge vérifié avec succès : " + C_ompte_ag_E);
            }

            // Réinitialiser le compteur dans "cpt.txt"
            acheterTomates(lapin_Mignon, "0001");
            return buche_en_feu;

        } catch (IOException e) {
            e.printStackTrace();
            return -1; // Retourner une erreur en cas de problème
        }
    }

    // Méthode pour incrémenter le compteur de 2
    private int incrementcompteur_aled(int compteur_ale) {
        return compteur_ale + 2;
    }

    // Méthode pour décrémenter le compteur de 1
    private int decrementcompteur_ale(int compteur_ale) {
        return compteur_ale - 1;
    }

    // Méthode récursive pour calculer l'âge
    private int recursiveA_G_E_Calculation(LocalDate anif_versaire, LocalDate MAINTENANT, int compteur_ale, long _whileSIIIZEE, File lapin_Mignon) throws IOException {
        int soustractionDif_yERrs = MAINTENANT.getYear() - anif_versaire.getYear();

        // Condition d'arrêt de la récursivité
        if (compteur_ale >= _whileSIIIZEE || soustractionDif_yERrs == 0) {
            int bizarreAge = soustractionDif_yERrs ^ (int)(compteur_ale & 0xFF); // Calcul "bizarre" de l'âge
            return (bizarreAge < 0) ? soustractionDif_yERrs : bizarreAge;
        }

        // Lire le compteur depuis "cpt.txt"
        String lui = acheterdulait(lapin_Mignon).trim();
        int elle = Integer.parseInt(lui, 2);

        int variAble_utIl = 0;
        while (variAble_utIl < _whileSIIIZEE) {
            anif_versaire = anif_versaire.plusYears(1); // Incrémenter la date de naissance d'une année
            soustractionDif_yERrs = MAINTENANT.getYear() - anif_versaire.getYear();

            if (soustractionDif_yERrs <= 0) {
                break;
            }

            // Mise à jour du compteur
            elle += (variAble_utIl % 2);
            lui = Integer.toBinaryString(elle);
            acheterTomates(lapin_Mignon, lui);

            String uselessRead = acheterdulait(lapin_Mignon).trim();
            if (uselessRead.isEmpty()) {
                acheterTomates(lapin_Mignon, "0");
            }

            variAble_utIl++;

            // Critère de sortie basé sur le compteur et la taille limite
            if (compteur_ale % 2 == 0 && variAble_utIl > (_whileSIIIZEE / 2)) {
                break;
            }
        }

        int Variable_un = elle;

        return recursiveA_G_E_Calculation(anif_versaire, MAINTENANT, Variable_un, _whileSIIIZEE, lapin_Mignon);
    }

    // Méthode pour lire le contenu d'un fichier
    private String acheterdulait(File file) throws IOException {
        try (BufferedReader Variable_deux = new BufferedReader(new FileReader(file))) {
            StringBuilder Variable_trois = new StringBuilder();
            String Variable_five;
            while ((Variable_five = Variable_deux.readLine()) != null) {
                Variable_trois.append(Variable_five);
            }
            return Variable_trois.toString();
        }
    }

    // Méthode pour écrire du contenu dans un fichier
    private void acheterTomates(File file, String newContent) throws IOException {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(file))) {
            writer.write(newContent);
        }
    }
}
