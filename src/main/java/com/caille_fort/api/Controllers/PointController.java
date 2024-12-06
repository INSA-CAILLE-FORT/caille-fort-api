package com.caille_fort.api.Controllers;

import com.caille_fort.api.Entities.Point;
import com.caille_fort.api.Services.PointService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/points")
@CrossOrigin(origins = "https://insa-caille-fort.fr")
public class PointController {

    private final PointService pointService;

    public PointController(PointService pointService) {
        this.pointService = pointService;
    }

    @Operation(summary = "Get all points", description = "Retrieve all points from the database.")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Successfully retrieved points"),
            @ApiResponse(responseCode = "500", description = "Internal server error")
    })
    @GetMapping
    public ResponseEntity<List<Point>> getAllPoints() {
        return ResponseEntity.ok(pointService.getAllPoints());
    }

    @Operation(summary = "Get point by ID", description = "Retrieve a specific point by its ID.")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Successfully retrieved point"),
            @ApiResponse(responseCode = "404", description = "Point not found")
    })
    @GetMapping("/{id}")
    public ResponseEntity<Point> getPointById(@PathVariable Long id) {
        return pointService.getPointById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @Operation(summary = "Create a new point", description = "Add a new point to the database.")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "201", description = "Successfully created point"),
            @ApiResponse(responseCode = "400", description = "Invalid input")
    })
    @PostMapping
    public ResponseEntity<Point> createPoint(@RequestBody Point point) {
        return ResponseEntity.status(201).body(pointService.savePoint(point));
    }

    @Operation(summary = "Delete a point", description = "Remove a point from the database by ID.")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "204", description = "Successfully deleted point"),
            @ApiResponse(responseCode = "404", description = "Point not found")
    })
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deletePoint(@PathVariable Long id) {
        if (pointService.getPointById(id).isPresent()) {
            pointService.deletePoint(id);
            return ResponseEntity.noContent().build();
        }
        return ResponseEntity.notFound().build();
    }
}
