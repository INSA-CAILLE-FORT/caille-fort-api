package com.caille_fort.api.Entities;

import jakarta.persistence.*;

@Entity
@Table(name = "podcasts")
public class Podcast {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String title;

    @Column(nullable = false)
    private String description;

    @Column(nullable = false)
    private String fileUrl; // Path or URL to the podcast file

    @Column(nullable = true)
    private String filePath; // Path to the locally stored file

    public void setFileUrl(String fileUrl) {
        this.fileUrl = fileUrl;
    }

    // Getters and Setters
}
