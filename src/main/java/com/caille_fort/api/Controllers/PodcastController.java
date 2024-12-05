package com.caille_fort.api.Controllers;

import com.caille_fort.api.Entities.Podcast;
import com.caille_fort.api.Services.PodcastService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

@RestController
@RequestMapping("/api/podcasts")
public class PodcastController {

    private final PodcastService podcastService;
    private static final String UPLOAD_DIR = "./uploads/";

    public PodcastController(PodcastService podcastService) {
        this.podcastService = podcastService;
    }

    @Operation(summary = "Get all podcasts", description = "Retrieve all podcasts from the database.")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Successfully retrieved podcasts"),
            @ApiResponse(responseCode = "500", description = "Internal server error")
    })
    @GetMapping
    public ResponseEntity<List<Podcast>> getAllPodcasts() {
        return ResponseEntity.ok(podcastService.getAllPodcasts());
    }

    @Operation(summary = "Get podcast by ID", description = "Retrieve a specific podcast by its ID.")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Successfully retrieved podcast"),
            @ApiResponse(responseCode = "404", description = "Podcast not found")
    })
    @GetMapping("/{id}")
    public Podcast getPodcastById(@PathVariable Long id) {
        return podcastService.getPodcastById(id);
    }

    @Operation(summary = "Create a new podcast", description = "Add a new podcast to the database.")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "201", description = "Successfully created podcast"),
            @ApiResponse(responseCode = "400", description = "Invalid input")
    })
    @PostMapping
    public ResponseEntity<Podcast> createPodcast(@RequestBody Podcast podcast) {
        return ResponseEntity.status(201).body(podcastService.savePodcast(podcast));
    }

    @PostMapping("/{podcastId}/upload")
    @Operation(summary = "Upload a file for a podcast", description = "Allows uploading a file (e.g., audio file) for a specific podcast")
    public ResponseEntity<String> uploadPodcastFile(
            @PathVariable @Parameter(description = "ID of the podcast to upload the file for") Long podcastId,
            @RequestParam("file") @Parameter(description = "File to upload") MultipartFile file) {

        // Check if the podcast exists
        Podcast podcast = podcastService.getPodcastById(podcastId);
        if (podcast == null) {
            return ResponseEntity.notFound().build();
        }

        // Ensure the upload directory exists
        File uploadDir = new File(UPLOAD_DIR);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        // Save the file locally
        try {
            Path filePath = Paths.get(UPLOAD_DIR + file.getOriginalFilename());
            Files.write(filePath, file.getBytes());
            podcast.setFileUrl(filePath.toString());
            podcastService.updatePodcast(podcast);
            return ResponseEntity.ok("File uploaded successfully: " + filePath);
        } catch (IOException e) {
            e.printStackTrace();
            return ResponseEntity.status(500).body("File upload failed: " + e.getMessage());
        }
    }

    @Operation(summary = "Delete a podcast", description = "Remove a podcast from the database by ID.")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "204", description = "Successfully deleted podcast"),
            @ApiResponse(responseCode = "404", description = "Podcast not found")
    })
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deletePodcast(@PathVariable Long id) {
        if (podcastService.getPodcastById(id) != null) {
            podcastService.deletePodcast(id);
            return ResponseEntity.noContent().build();
        }
        return ResponseEntity.notFound().build();
    }
}