package com.ethglobal.hackathon.repository;

import com.ethglobal.hackathon.entity.Diver;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 * Repository is an interface that provides access to data in a database
 */
public interface DiverRepository extends JpaRepository<Diver, String> {
}