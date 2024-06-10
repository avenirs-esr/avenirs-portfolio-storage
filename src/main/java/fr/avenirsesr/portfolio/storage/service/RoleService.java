package fr.avenirsesr.portfolio.storage.service;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import fr.avenirsesr.portfolio.storage.model.Role;
import fr.avenirsesr.portfolio.storage.repository.RoleRepository;

@Service
public class RoleService {
	
	/** Logger */
	private static final Logger LOGGER = LoggerFactory.getLogger(RoleService.class);
	
	@Autowired
	private RoleRepository roleRepository;
	
	/**
	 * Gives all the role.
	 * 
	 * @return An iterable over all roles.
	 */
	public Iterable<Role> getRoles() {
		LOGGER.debug("---------------> getRoles");
		return this.roleRepository.findAll();
	}
}
