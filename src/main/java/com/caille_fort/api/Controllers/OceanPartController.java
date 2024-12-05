package com.caille_fort.api.Controllers;

import com.caille_fort.api.Entities.OceanPart;
import com.caille_fort.api.Services.OceanPartService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/ocean-parts")
public class OceanPartController {

    private final OceanPartService oceanPartService;

    public OceanPartController(OceanPartService oceanPartService) {
        this.oceanPartService = oceanPartService;
    }

    @Operation(summary = "Get all ocean parts", description = "Retrieve all ocean parts from the database.")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Successfully retrieved ocean parts"),
            @ApiResponse(responseCode = "500", description = "Internal server error")
    })
    @GetMapping
    public ResponseEntity<List<OceanPart>> getAllOceanParts() {
        return ResponseEntity.ok(oceanPartService.getAllOceanParts());
    }

    @Operation(summary = "Get ocean part by ID", description = "Retrieve a specific ocean part by its ID.")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Successfully retrieved ocean part"),
            @ApiResponse(responseCode = "404", description = "Ocean part not found")
    })
    @GetMapping("/{id}")
    public ResponseEntity<OceanPart> getOceanPartById(@PathVariable Long id) {
        return oceanPartService.getOceanPartById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @Operation(summary = "Create a new ocean part", description = "Add a new ocean part to the database.")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "201", description = "Successfully created ocean part"),
            @ApiResponse(responseCode = "400", description = "Invalid input")
    })
    @PostMapping
    public ResponseEntity<OceanPart> createOceanPart(@RequestBody OceanPart oceanPart) {
        return ResponseEntity.status(201).body(oceanPartService.saveOceanPart(oceanPart));
    }

    @Operation(summary = "Delete an ocean part", description = "Remove an ocean part from the database by ID.")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "204", description = "Successfully deleted ocean part"),
            @ApiResponse(responseCode = "404", description = "Ocean part not found")
    })
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteOceanPart(@PathVariable Long id) {
        if (oceanPartService.getOceanPartById(id).isPresent()) {
            oceanPartService.deleteOceanPart(id);
            return ResponseEntity.noContent().build();
        }
        return ResponseEntity.notFound().build();
    }
}