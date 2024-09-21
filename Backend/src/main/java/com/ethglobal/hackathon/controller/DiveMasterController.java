package com.ethglobal.hackathon.controller;

import com.ethglobal.hackathon.entity.Dive;
import com.ethglobal.hackathon.entity.DiveMaster;
import com.ethglobal.hackathon.entity.Diver;
import com.ethglobal.hackathon.entity.Place;
import com.ethglobal.hackathon.service.DiveMasterService;
import com.ethglobal.hackathon.service.DiveService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * Controller class is where all the user requests are handled and required/appropriate
 * responses are sent
 */
@RestController
@RequestMapping("/dive-master/v1")
@RequiredArgsConstructor
@Validated
public class DiveMasterController {

    private final DiveMasterService diveMasterService;

    @GetMapping("/")
    public ResponseEntity<List<DiveMaster>> getAllPlaces(){
        return ResponseEntity.ok().body(diveMasterService.getAllDiveMasters());
    }
    @PutMapping("/")
    public ResponseEntity<DiveMaster> saveDiveMaster(@RequestBody DiveMaster diveMaster) {
        return ResponseEntity.ok().body(diveMasterService.saveDiveMaster(diveMaster));
    }

}
