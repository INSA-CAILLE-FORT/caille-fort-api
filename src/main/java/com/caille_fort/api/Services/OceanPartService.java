package com.caille_fort.api.Services;

import com.caille_fort.api.Entities.OceanPart;
import com.caille_fort.api.Repositories.OceanPartRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class OceanPartService {

    private final OceanPartRepository oceanPartRepository;

    public OceanPartService(OceanPartRepository oceanPartRepository) {
        this.oceanPartRepository = oceanPartRepository;
    }

    public List<OceanPart> getAllOceanParts() {
        return oceanPartRepository.findAll();
    }

    public Optional<OceanPart> getOceanPartById(Long id) {
        return oceanPartRepository.findById(id);
    }

    public OceanPart saveOceanPart(OceanPart oceanPart) {
        return oceanPartRepository.save(oceanPart);
    }

    public void deleteOceanPart(Long id) {
        oceanPartRepository.deleteById(id);
    }
}