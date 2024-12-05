package com.caille_fort.api.Entities;

import jakarta.persistence.*;
import java.util.List;

@Entity
@Table(name = "ocean_parts")
public class OceanPart {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, unique = true)
    private String name;

    @OneToMany(mappedBy = "oceanPart", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Question> questions;

    // Getters and Setters
}
