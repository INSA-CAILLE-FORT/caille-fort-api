package com.caille_fort.api.Services;

import com.caille_fort.api.Entities.Point;
import com.caille_fort.api.Repositories.PointRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class PointService {

    private final PointRepository pointRepository;

    public PointService(PointRepository pointRepository) {
        this.pointRepository = pointRepository;
    }

    public List<Point> getAllPoints() {
        return pointRepository.findAll();
    }

    public Optional<Point> getPointById(Long id) {
        return pointRepository.findById(id);
    }

    public Point savePoint(Point point) {
        return pointRepository.save(point);
    }

    public void deletePoint(Long id) {
        pointRepository.deleteById(id);
    }
}