package com.datn.food_delivery;

import com.datn.food_delivery.models.User;
import com.datn.food_delivery.service.UserService;
import com.google.firebase.auth.FirebaseAuth;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

@SpringBootApplication
public class FoodDeliveryApplication implements CommandLineRunner {

	@Autowired
	private UserService userService;


	public static void main(String[] args) {
		SpringApplication.run(FoodDeliveryApplication.class, args);
	}

	@Override
	public void run(String... args) throws Exception {
		try {
			userService.getUser("admin123@gmail.com");
		} catch (Exception e) {
			userService.saveUser(User.builder()
					.roles("ADMIN")
					.email("admin123@gmail.com")
					.password(new BCryptPasswordEncoder().encode("admin"))
					.build()
			);
		}
	}
}
