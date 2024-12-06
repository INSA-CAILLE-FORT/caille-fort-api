package com.caille_fort.api.Repositories;

import com.caille_fort.api.Entities.Organ;
import org.springframework.data.jpa.repository.JpaRepository;

public interface OrganRepository extends JpaRepository<Organ, Long> {
}