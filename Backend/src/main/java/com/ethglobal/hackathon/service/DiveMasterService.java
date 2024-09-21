package com.ethglobal.hackathon.service;

import com.ethglobal.hackathon.entity.DiveMaster;
import com.ethglobal.hackathon.entity.Diver;
import com.ethglobal.hackathon.entity.Place;
import com.ethglobal.hackathon.repository.DiveMasterrRepository;
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
public class DiveMasterService {

    private final DiveMasterrRepository diveMasterrRepository;

    public List<DiveMaster> getAllDiveMasters(){
        return diveMasterrRepository.findAll();
    }

    public DiveMaster saveDiveMaster(DiveMaster diveMaster){
        DiveMaster savedDiveMaster = diveMasterrRepository.save(diveMaster);
        log.info("diveMaster with address: {} doesn't exist", diveMaster.getAddress());
        return savedDiveMaster;
    }

}