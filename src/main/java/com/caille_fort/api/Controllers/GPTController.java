package com.caille_fort.api.Controllers;

import com.caille_fort.api.Entities.GPTRequest;
import com.caille_fort.api.Services.GPTService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/chatgpt")
public class GPTController {

    @Autowired
    private GPTService gptService;

    @PostMapping("/validate-answer")
    public ResponseEntity<?> validateAnswer(@RequestBody GPTRequest request) {
        try {
            String response = gptService.getGptResponse(request.getQuestion(), request.getAnswer());
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            return ResponseEntity.status(500).body("Erreur lors de la communication avec l'API : " + e.getMessage());
        }
    }
}
