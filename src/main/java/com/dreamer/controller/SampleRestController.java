package com.dreamer.controller;

import static org.springframework.http.MediaType.APPLICATION_JSON_UTF8_VALUE;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import lombok.extern.log4j.Log4j;


@RestController
@RequestMapping("/sample/*")
@CrossOrigin("*")
@Log4j
public class SampleRestController {
	
	@GetMapping(value = "/gettest", produces = APPLICATION_JSON_UTF8_VALUE, consumes = APPLICATION_JSON_UTF8_VALUE)
	public ResponseEntity<String> getTest() {
		log.info("in Controller======================");
		return new ResponseEntity<>("안녕",HttpStatus.OK);
	}

	
	
	
}
