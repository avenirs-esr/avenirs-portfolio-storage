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
	
	
	public Role getRole(final Long roleId){
		return this.roleRepository.findById(roleId).get();
	}
	
	/**
	 * Gives all the role.
	 * @return An iterable over all roles.
	 */
	public Iterable<Role> getRoles() {
		return this.roleRepository.findAll();
	}
	
	/**
	 * Creates a role.
	 * @param role The role to create.
	 * @return The new created role.
	 */
	public Role createRole(Role role) {
		return this.roleRepository.save(role);
	}
	
	/**
	 * Updates a role.
	 * @param role The role to update.
	 * @return The updated role.
	 */
	public Role  updateRole(Role role) {
		
		Role storedRole = this.roleRepository.findById(role.getId()).get();
		
		if (storedRole != null && ! storedRole.equals(role)) {
				storedRole.setName(role.getName());
				storedRole.setDescription(role.getDescription());
				return this.roleRepository.save(storedRole);
		}
		return storedRole;
	}
	
	/**
	 * Deletes a role
	 * @param id The id of the role to delete.
	 */
	public void deleteRole(Long id) {
		this.roleRepository.deleteById(id);
	}
	
	
}
