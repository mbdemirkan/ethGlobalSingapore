package com.ethglobal.hackathon.repository;

import com.ethglobal.hackathon.entity.DiveMaster;
import com.ethglobal.hackathon.entity.Diver;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 * Repository is an interface that provides access to data in a database
 */
public interface DiveMasterrRepository extends JpaRepository<DiveMaster, String> {
}