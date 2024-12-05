package com.caille_fort.api.Repositories;

import com.caille_fort.api.Entities.Podcast;
import org.springframework.data.jpa.repository.JpaRepository;

public interface PodcastRepository extends JpaRepository<Podcast, Long> {
}