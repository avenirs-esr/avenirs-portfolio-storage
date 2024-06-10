package fr.avenirsesr.portfolio.storage;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import fr.avenirsesr.portfolio.storage.service.RoleService;

@SpringBootApplication
public class AvenirsPortfolioStorageApplication  implements CommandLineRunner {

	@Autowired
	private RoleService roleService;
	
	/** Logger */
	private static final Logger LOGGER = LoggerFactory.getLogger(AvenirsPortfolioStorageApplication.class);
	public static void main(String[] args) {
		SpringApplication.run(AvenirsPortfolioStorageApplication.class, args);
	}
	

	@Override
	public void run(String... args) throws Exception {
		LOGGER.info("AvenirsPortfolioStorageApplication is running roleService is null ???? " + (roleService == null ? "YES": "NO"));
		roleService.getRoles().forEach(r-> LOGGER.debug("Role " + r));
		
	}

}
