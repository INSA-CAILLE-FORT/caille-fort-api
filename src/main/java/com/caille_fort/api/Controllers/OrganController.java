package com.caille_fort.api.Controllers;

import com.caille_fort.api.Entities.Organ;
import com.caille_fort.api.Services.OrganService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/organs")
@CrossOrigin(origins = "https://insa-caille-fort.fr")
public class OrganController {

    private final OrganService organService;

    public OrganController(OrganService organService) {
        this.organService = organService;
    }

    @Operation(summary = "Get all organs", description = "Retrieve all organs from the database.")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Successfully retrieved organs"),
            @ApiResponse(responseCode = "500", description = "Internal server error")
    })
    @GetMapping
    public ResponseEntity<List<Organ>> getAllOrgans() {
        return ResponseEntity.ok(organService.getAllOrgans());
    }

    @Operation(summary = "Get organ by ID", description = "Retrieve a specific organ by its ID.")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Successfully retrieved organ"),
            @ApiResponse(responseCode = "404", description = "Organ not found")
    })
    @GetMapping("/{id}")
    public ResponseEntity<Organ> getOrganById(@PathVariable Long id) {
        return organService.getOrganById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @Operation(summary = "Create a new organ", description = "Add a new organ to the database.")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "201", description = "Successfully created organ"),
            @ApiResponse(responseCode = "400", description = "Invalid input")
    })
    @PostMapping
    public ResponseEntity<Organ> createOrgan(@RequestBody Organ organ) {
        return ResponseEntity.status(201).body(organService.saveOrgan(organ));
    }

    @Operation(summary = "Delete an organ", description = "Remove an organ from the database by ID.")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "204", description = "Successfully deleted organ"),
            @ApiResponse(responseCode = "404", description = "Organ not found")
    })
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteOrgan(@PathVariable Long id) {
        if (organService.getOrganById(id).isPresent()) {
            organService.deleteOrgan(id);
            return ResponseEntity.noContent().build();
        }
        return ResponseEntity.notFound().build();
    }
}