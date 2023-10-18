package com.aws.book.springboot.web;

import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.core.env.Environment;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Arrays;
import java.util.List;

@Slf4j
@RequiredArgsConstructor
@RestController
public class ProfileController {
    private final Environment env;

    @GetMapping
    public String profile() {
        List<String> profiles = Arrays.asList(env.getActiveProfiles());

        List<String> realProfiles = Arrays.asList("real", "real1", "real2");

        String defaultProfile = profiles.isEmpty() ? "default" : profiles.get(0);

        return profiles.stream()
                .filter(realProfiles::contains)
                .findAny()
                .orElse(defaultProfile);
    }
}
