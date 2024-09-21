package com.ethglobal.hackathon.controller;

import com.ethglobal.hackathon.entity.Place;
import com.ethglobal.hackathon.service.PlaceService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

/**
 * Controller class is where all the user requests are handled and required/appropriate
 * responses are sent
 */
@RestController
@RequestMapping("/place/v1")
@RequiredArgsConstructor
@Validated
public class PlaceController {

    private final PlaceService placeService;

    /**
     * This method is called when a GET request is made
     * URL: localhost:8080/place/v1/
     * Purpose: Fetches all the places in the place table
     *
     * @return List of places
     */
    @GetMapping("/")
    public ResponseEntity<List<Place>> getAllPlaces(){
        return ResponseEntity.ok().body(placeService.getAllPlaces());
    }

    /**
     * This method is called when a GET request is made
     * URL: localhost:8080/place/v1/1 (or any other id)
     * Purpose: Fetches place with the given id
     *
     * @param uuid - place id
     * @return place with the given id
     */
    @GetMapping("/{id}")
    public ResponseEntity<Place> getPlaceById(@PathVariable UUID uuid)
    {
        return ResponseEntity.ok().body(placeService.getPlaceById(uuid));
    }

    /**
     * This method is called when a POST request is made
     * URL: localhost:8080/place/v1/
     * Purpose: Save an place entity
     *
     * @param place - Request body is an place entity
     * @return Saved place entity
     */
    @PostMapping("/")
    public ResponseEntity<Place> savePlace(@RequestBody Place place) {
        return ResponseEntity.ok().body(placeService.savePlace(place));
    }

    /**
     * This method is called when a PUT request is made
     * URL: localhost:8080/place/v1/
     * Purpose: Update an place entity
     * @param place - place entity to be updated
     * @return Updated place
     */
    @PutMapping("/")
    public ResponseEntity<Place> updatePlace(@RequestBody Place place)
    {
        return ResponseEntity.ok().body(placeService.updatePlace(place));
    }

    /**
     * This method is called when a PUT request is made
     * URL: localhost:8080/place/v1/1 (or any other id)
     * Purpose: Delete an place entity
     * @param uuid - place's id to be deleted
     * @return a String message indicating place record has been deleted successfully
     */
    @DeleteMapping("/{id}")
    public ResponseEntity<String> deleteplaceById(@PathVariable UUID uuid)
    {
        placeService.deletePlaceById(uuid);
        return ResponseEntity.ok().body("Deleted place successfully");
    }


}