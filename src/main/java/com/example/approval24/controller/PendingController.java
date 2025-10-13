package com.example.approval24.controller;

import org.springframework.stereotype.Controller; 
import org.springframework.web.bind.annotation.GetMapping;

@Controller 
public class PendingController { 
	
	@GetMapping("/pending")
	public String pendingPage() {
	    return "pending"; 
	}
	
	@GetMapping("/header")
	public String headerPage() {
	    return "header"; 
	}
}