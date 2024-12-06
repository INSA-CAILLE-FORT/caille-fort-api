package com.caille_fort.api.Services;

import com.caille_fort.api.Entities.Organ;
import com.caille_fort.api.Repositories.OrganRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class OrganService {

    private final OrganRepository organRepository;

    public OrganService(OrganRepository organRepository) {
        this.organRepository = organRepository;
    }

    public List<Organ> getAllOrgans() {
        return organRepository.findAll();
    }

    public Optional<Organ> getOrganById(Long id) {
        return organRepository.findById(id);
    }

    public Organ saveOrgan(Organ organ) {
        return organRepository.save(organ);
    }

    public void deleteOrgan(Long id) {
        organRepository.deleteById(id);
    }
}