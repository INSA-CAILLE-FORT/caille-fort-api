package com.caille_fort.api.Repositories;

import com.caille_fort.api.Entities.Point;
import org.springframework.data.jpa.repository.JpaRepository;

public interface PointRepository extends JpaRepository<Point, Long> {
}