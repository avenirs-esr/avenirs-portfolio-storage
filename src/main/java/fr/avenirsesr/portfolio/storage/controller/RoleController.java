package fr.avenirsesr.portfolio.storage.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import fr.avenirsesr.portfolio.storage.model.Role;
import fr.avenirsesr.portfolio.storage.service.RoleService;

@RestController
public class RoleController {
	
	@Autowired
	private RoleService roleService;
	
	
	@GetMapping("/roles")
	public Iterable<Role> getRoles(){
		return roleService.getRoles();
	}

}
