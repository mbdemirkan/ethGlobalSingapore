package com.ethglobal.hackathon.controller;

import com.ethglobal.hackathon.entity.Dive;
import com.ethglobal.hackathon.service.DiveService;
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
@RequestMapping("/dive/v1")
@RequiredArgsConstructor
@Validated
public class DiveController {

    private final DiveService diveService;

    @PostMapping("/")
    public ResponseEntity<Dive> recordDive(@RequestBody Dive dive) {
        System.out.println(dive);

        return ResponseEntity.ok().body(diveService.recordDive(dive));
    }
    @GetMapping("/pending/{address}")
    public ResponseEntity<List<Dive>> getDiveListByDiveMaster(@PathVariable String address) {
        return ResponseEntity.ok().body(diveService.getDiveListByDiveMaster(address));
    }

    @PostMapping("/success/{id}")
    public ResponseEntity<Object> recordDive(@PathVariable UUID id) {
        System.out.println(id);

        return ResponseEntity.ok().body(diveService.successDive(id));
    }

}
