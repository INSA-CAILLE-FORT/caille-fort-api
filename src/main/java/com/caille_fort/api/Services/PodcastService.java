package com.caille_fort.api.Services;

import com.caille_fort.api.Entities.Podcast;
import com.caille_fort.api.Repositories.PodcastRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class PodcastService {

    private final PodcastRepository podcastRepository;

    public PodcastService(PodcastRepository podcastRepository) {
        this.podcastRepository = podcastRepository;
    }

    public List<Podcast> getAllPodcasts() {
        return podcastRepository.findAll();
    }

    public Optional<Podcast> getPodcastById(Long id) {
        return podcastRepository.findById(id);
    }

    public Podcast savePodcast(Podcast podcast) {
        return podcastRepository.save(podcast);
    }

    public void deletePodcast(Long id) {
        podcastRepository.deleteById(id);
    }
}