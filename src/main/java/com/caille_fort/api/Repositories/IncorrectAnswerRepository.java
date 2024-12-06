package com.caille_fort.api.Repositories;

import com.caille_fort.api.Entities.IncorrectAnswer;
import org.springframework.data.jpa.repository.JpaRepository;

public interface IncorrectAnswerRepository extends JpaRepository<IncorrectAnswer, Long> {
}