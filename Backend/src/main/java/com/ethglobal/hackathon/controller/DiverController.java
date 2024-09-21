package com.ethglobal.hackathon.controller;

import com.ethglobal.hackathon.entity.Diver;
import com.ethglobal.hackathon.entity.Place;
import com.ethglobal.hackathon.service.DiverService;
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
@RequestMapping("/diver/v1")
@RequiredArgsConstructor
@Validated
public class DiverController {

    private final DiverService diverService;

    @GetMapping("/")
    public ResponseEntity<List<Diver>> getAllDivers(){
        return ResponseEntity.ok().body(diverService.getAllDivers());
    }

    @GetMapping("/{address}")
    public ResponseEntity<Diver> getDiverById(@PathVariable String address) {
        return ResponseEntity.ok().body(diverService.getDiverById(address));
    }

}