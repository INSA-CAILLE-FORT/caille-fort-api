package com.caille_fort.api.Repositories;

import com.caille_fort.api.Entities.Question;
import org.springframework.data.jpa.repository.JpaRepository;

public interface QuestionRepository extends JpaRepository<Question, Long> {
}