package com.ethglobal.hackathon.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import com.ethglobal.hackathon.entity.Dive;
import org.springframework.data.jpa.repository.Query;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

/**
 * Repository is an interface that provides access to data in a database
 */
public interface DiveRepository extends JpaRepository<Dive, UUID> {
    // @Query(value = "SELECT d.* FROM DIVE d WHERE d.DIVE_MASTER_ADDRESS = ?1", nativeQuery = true)
    @Query(value = "SELECT d.*, p.name place_name FROM diver.DIVE d LEFT JOIN place p ON d.place_id = p.id WHERE d.NFT_ADDRESS IS NULL AND d.DIVE_MASTER_ADDRESS = ?1", nativeQuery = true)
    Optional<List<Dive>> getDiveListByDiveMaster(String address);

}