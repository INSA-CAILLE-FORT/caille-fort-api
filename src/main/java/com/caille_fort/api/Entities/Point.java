package com.caille_fort.api.Entities;

import jakarta.persistence.*;

@Entity
@Table(name = "points")
public class Point {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, unique = true)
    private String name; // Theme name

    @ManyToOne
    @JoinColumn(name = "organ_id", nullable = false)
    private Organ organ;

    @ManyToOne
    @JoinColumn(name = "ocean_part_id", nullable = false)
    private OceanPart oceanPart;

    // Getters and Setters
}