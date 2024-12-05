package com.caille_fort.api.Entities;

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
    private String status; // Ex: "benefit", "consequence", "learn", "share", "act"

    @Column(nullable = false)
    private String correctAnswer;

    @ElementCollection
    @CollectionTable(name = "incorrect_answers", joinColumns = @JoinColumn(name = "question_id"))
    @Column(name = "answer")
    private List<String> incorrectAnswers;

    @ManyToOne
    @JoinColumn(name = "ocean_part_id")
    private OceanPart oceanPart;

    @ManyToOne
    @JoinColumn(name = "organ_id")
    private Organ organ;

    // Getters and Setters
}
