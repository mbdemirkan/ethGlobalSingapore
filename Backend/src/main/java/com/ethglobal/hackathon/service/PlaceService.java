package com.ethglobal.hackathon.service;

import com.ethglobal.hackathon.entity.Place;
import com.ethglobal.hackathon.repository.PlaceRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

/**
 * Service layer is where all the business logic lies
 */
@Service
@RequiredArgsConstructor
@Slf4j
public class PlaceService {

    private final PlaceRepository placeRepository;

    public List<Place> getAllPlaces(){
        return placeRepository.findAll();
    }

    public Place getPlaceById(UUID uuid){
        Optional<Place> optionalPlace = placeRepository.findById(uuid);
        if(optionalPlace.isPresent()){
            return optionalPlace.get();
        }
        log.info("place with id: {} doesn't exist", uuid);
        return null;
    }

    public Place savePlace (Place place){
        Place savedPlace = placeRepository.save(place);

        log.info("place with id: {} saved successfully", place.getId());
        return savedPlace;
    }

    public Place updatePlace (Place place) {
        Optional<Place> existingPlace = placeRepository.findById(place.getId());

        Place updatedPlace = placeRepository.save(place);

        log.info("place with id: {} updated successfully", place.getId());
        return updatedPlace;
    }

    public void deletePlaceById (UUID uuid) {
        placeRepository.deleteById(uuid);
    }

}