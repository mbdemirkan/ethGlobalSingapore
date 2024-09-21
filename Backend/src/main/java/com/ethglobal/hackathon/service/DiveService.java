package com.ethglobal.hackathon.service;

import com.ethglobal.hackathon.entity.Dive;
import com.ethglobal.hackathon.entity.Diver;
import com.ethglobal.hackathon.repository.DiveRepository;
import com.ethglobal.hackathon.repository.DiverRepository;
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
public class DiveService {

    private final DiveRepository diveRepository;
    private final DiverRepository diverRepository;

    public List<Dive> getDiveListByDiveMaster(String address) {
        Optional<List<Dive>> optionalDiveList = diveRepository.getDiveListByDiveMaster(address);
        if(optionalDiveList.isPresent()){
            return optionalDiveList.get();
        }
        log.info("dive list with address: {} doesn't exist", address);
        return null;
    }

    public Dive recordDive (Dive dive) {
        if (dive.getDiverAddress() != null) {
            Optional<Diver> optionalDiver = diverRepository.findById(dive.getDiverAddress());
            if (!optionalDiver.isPresent()) {
                Diver diver = new Diver();
                diver.setAddress(dive.getDiverAddress());
                diverRepository.save(diver);
            }

            Dive savedDive = diveRepository.save(dive);

            log.info("dive with id: {} saved successfully", dive.getId());
            return savedDive;
        } else {
            return null;
        }
    }

    public Dive successDive(UUID id) {
        Optional<Dive> optionalDive = diveRepository.findById(id);
        if (optionalDive.isPresent()) {
            Dive dive = optionalDive.get();
            dive.setNftAddress("ok");
            diveRepository.save(dive);
            return dive;
        }
        return null;
    }
}