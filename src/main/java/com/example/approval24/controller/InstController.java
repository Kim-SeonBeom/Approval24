package com.example.approval24.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.example.approval24.dao.InstDAO;
import com.example.approval24.domain.InstDTO;

@Controller
public class InstController {
	@Autowired
	InstDAO dao;
	
	@GetMapping("/admin/insts")
	public String insts(Model model) {
		System.out.print("!!");
		List<InstDTO> getAllList = dao.getAllInst(); 
		System.out.println(getAllList.toString());
		model.addAttribute("getAllList",getAllList);
		return "insts";
	}
	
	@GetMapping("/admin/insts/new")
	public String instsCreate() {
		return "instsCreate";
	}
	
	@GetMapping("/admin/insts/detail")
	public String instsDetail() {
		return "instsDetail";
	}
}
