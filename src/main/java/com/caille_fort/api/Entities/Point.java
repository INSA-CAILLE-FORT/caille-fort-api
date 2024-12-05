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


    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Organ getOrgan() {
        return organ;
    }

    public void setOrgan(Organ organ) {
        this.organ = organ;
    }

    public OceanPart getOceanPart() {
        return oceanPart;
    }

    public void setOceanPart(OceanPart oceanPart) {
        this.oceanPart = oceanPart;
    }
}