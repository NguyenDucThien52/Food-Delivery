package com.datn.food_delivery.config;

import com.datn.food_delivery.models.User;
import com.datn.food_delivery.service.UserService;
import com.google.firebase.auth.FirebaseAuth;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import java.util.Optional;
import java.util.concurrent.ExecutionException;

@Configuration
public class UserInforDetailsService implements UserDetailsService {

    private static final Logger log = LoggerFactory.getLogger(UserInforDetailsService.class);
    @Autowired
    private UserService userService;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        try {
            Optional<User> user = Optional.ofNullable(userService.getUser(username));
            log.info(user.get().getFullName());
            return user.map(UserInforDetails::new).orElseThrow(()->new UsernameNotFoundException("User does not exist"));
        } catch (ExecutionException | InterruptedException e) {
            throw new RuntimeException(e);
        }
//        user = FirebaseAuth.getInstance().getUser(username);
    }
}
