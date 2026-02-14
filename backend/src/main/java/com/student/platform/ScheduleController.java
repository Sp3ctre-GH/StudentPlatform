package com.student.platform;

import org.springframework.web.bind.annotation.*;
import java.util.*;

@RestController
@RequestMapping("/api")
@CrossOrigin(origins = "*")
public class ScheduleController {

    @GetMapping("/schedule")
    public List<Map<String, String>> getSchedule() {
        return List.of(
                Map.of("subject", "Програмування Java", "time", "08:30", "room", "101"),
                Map.of("subject", "Бази Даних", "time", "10:10", "room", "202"),
                Map.of("subject", "Фізкультура (онлайн)", "time", "12:00", "room", "Zoom")
        );
    }
}