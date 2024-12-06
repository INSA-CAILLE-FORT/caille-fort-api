package com.caille_fort.api.Configuration;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.Customizer;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
public class SecurityConfig {

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http
                .authorizeHttpRequests(auth -> auth
                        // Autoriser Swagger sans authentification
                        .anyRequest().permitAll()
                )
                .httpBasic(Customizer.withDefaults()) // Authentification HTTP basique (désactivée pour Swagger)
                .csrf(csrf -> csrf.disable()); // Désactiver CSRF pour simplifier les tests
        return http.build();
    }
}
