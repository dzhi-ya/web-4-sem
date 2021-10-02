-- house_material: table
CREATE TABLE `house_material`
(
    `id`       int         NOT NULL,
    `material` varchar(25) NOT NULL,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;

-- house_type: table
CREATE TABLE `house_type`
(
    `id`   int         NOT NULL,
    `type` varchar(25) NOT NULL,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;

-- the_property: table
CREATE TABLE `the_property`
(
    `id`          int          NOT NULL,
    `location`    varchar(250) NOT NULL,
    `description` varchar(2500) DEFAULT NULL,
    `house_area`  float        NOT NULL,
    `bedrooms`    int           DEFAULT NULL,
    `user_id`     int          NOT NULL,
    `material_id` int          NOT NULL,
    `type_id`     int          NOT NULL,
    `place_date`  timestamp    NOT NULL,
    `price`       int          NOT NULL,
    PRIMARY KEY (`id`),
    KEY `the_property_house_material_id_fk` (`material_id`),
    KEY `the_property_house_type_id_fk` (`type_id`),
    KEY `the_property_users_id_fk` (`user_id`),
    CONSTRAINT `the_property_house_material_id_fk` FOREIGN KEY (`material_id`) REFERENCES `house_material` (`id`),
    CONSTRAINT `the_property_house_type_id_fk` FOREIGN KEY (`type_id`) REFERENCES `house_type` (`id`),
    CONSTRAINT `the_property_users_id_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;

-- No native definition for element: the_property_house_material_id_fk (index)

-- No native definition for element: the_property_house_type_id_fk (index)

-- No native definition for element: the_property_users_id_fk (index)

-- users: table
CREATE TABLE `users`
(
    `id`               int         NOT NULL,
    `name`             varchar(30) NOT NULL,
    `surname`          varchar(50) NOT NULL,
    `shortname`        varchar(20) NOT NULL,
    `phone`            varchar(16) NOT NULL,
    `address`          varchar(100) DEFAULT NULL,
    `e-mail`           varchar(100) DEFAULT NULL,
    `registration`     date        NOT NULL,
    `verified_profile` tinyint(1)  NOT NULL,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;


