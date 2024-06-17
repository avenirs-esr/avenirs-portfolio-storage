package fr.avenirsesr.portfolio.storage.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import fr.avenirsesr.portfolio.storage.model.Role;
import fr.avenirsesr.portfolio.storage.service.RoleService;

@RestController
public class RoleController {

	/** Logger */
	private static final Logger LOGGER = LoggerFactory.getLogger(RoleController.class);
	
	@Autowired
	private RoleService roleService;
	
	
	@GetMapping("/roles")
	public Iterable<Role> getRoles(){
		return roleService.getRoles();
	}
	
	@PostMapping("/role")
	Role createRole(@RequestBody Role role){
		LOGGER.debug("Create Role role: " + role);
		return roleService.createRole(role);
	}

}
