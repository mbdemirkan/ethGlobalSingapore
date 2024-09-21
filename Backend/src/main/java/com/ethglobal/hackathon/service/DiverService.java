package com.ethglobal.hackathon.service;

import com.ethglobal.hackathon.entity.Diver;
import com.ethglobal.hackathon.repository.DiverRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

/**
 * Service layer is where all the business logic lies
 */
@Service
@RequiredArgsConstructor
@Slf4j
public class DiverService {

    private final DiverRepository diverRepository;

    public List<Diver> getAllDivers(){
        return diverRepository.findAll();
    }

    public Diver getDiverById(String address){
        Optional<Diver> optionalPlace = diverRepository.findById(address);
        if(optionalPlace.isPresent()){
            return optionalPlace.get();
        }
        log.info("diver with address: {} doesn't exist", address);
        return null;
    }

}