package com.caille_fort.api.Entities;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import jakarta.persistence.*;
import java.util.List;

@Entity
@Table(name = "questions")
public class Question {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String text;

    @Column(nullable = false)
    private String description; // Ajout de la description

    @Column(nullable = false)
    private String status; // Ex: "description", "benefit", "consequence", "learn", "share", "act"

    @Column(nullable = false)
    private String correctAnswer;

    @JsonManagedReference
    @OneToMany(mappedBy = "question", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<IncorrectAnswer> incorrectAnswers;

    @ManyToOne
    @JoinColumn(name = "ocean_part_id")
    @JsonBackReference
    private OceanPart oceanPart;

    @ManyToOne
    @JoinColumn(name = "organ_id")
    @JsonBackReference
    private Organ organ;

    // Getters and Setters

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getCorrectAnswer() {
        return correctAnswer;
    }

    public void setCorrectAnswer(String correctAnswer) {
        this.correctAnswer = correctAnswer;
    }

    public List<IncorrectAnswer> getIncorrectAnswers() {
        return incorrectAnswers;
    }

    public void setIncorrectAnswers(List<IncorrectAnswer> incorrectAnswers) {
        this.incorrectAnswers = incorrectAnswers;
    }

    public OceanPart getOceanPart() {
        return oceanPart;
    }

    public void setOceanPart(OceanPart oceanPart) {
        this.oceanPart = oceanPart;
    }

    public Organ getOrgan() {
        return organ;
    }

    public void setOrgan(Organ organ) {
        this.organ = organ;
    }
}
