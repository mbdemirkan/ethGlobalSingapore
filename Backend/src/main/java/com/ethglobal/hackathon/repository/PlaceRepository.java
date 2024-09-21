package com.ethglobal.hackathon.repository;

import com.ethglobal.hackathon.entity.Place;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.UUID;

/**
 * Repository is an interface that provides access to data in a database
 */
public interface PlaceRepository extends JpaRepository<Place, UUID> {
}