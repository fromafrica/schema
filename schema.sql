-- Host: MySQL
-- Server version: 8.3.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

--

CREATE TABLE `users` (
  `id` varchar(255),
  `json` json,
  `hash` varchar(64) GENERATED ALWAYS AS (sha2(`json`,256)) STORED,
  `timestamp` datetime DEFAULT CURRENT_TIMESTAMP

  `username` varchar(255) GENERATED ALWAYS AS (json_unquote(json_extract(`json`,'$.username'))) STORED,
  `email` varchar(255) GENERATED ALWAYS AS (json_unquote(json_extract(`json`,'$.email'))) STORED,
  `password` varchar(255) GENERATED ALWAYS AS (json_unquote(json_extract(`json`,'$.password'))) STORED,
  `picture` varchar(128) GENERATED ALWAYS AS (json_unquote(json_extract(`json`,'$.picture'))) STORED,
  `phone` varchar(128) GENERATED ALWAYS AS (json_unquote(json_extract(`json`,'$.phone'))) STORED,

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Indexes for table `users`
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `idx_hash` (`hash`),
  ADD KEY `idx_username` (`username`),
  ADD KEY `idx_email` (`email`);

--

CREATE TABLE `users_log` (
  `id` varchar(255),
  `userId` varchar(255),
  `json` json,
  `hash` varchar(64) GENERATED ALWAYS AS (sha2(`json`,256)) STORED,
  `timestamp` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Indexes for `users_log`
ALTER TABLE `users_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_userId` (`userId`),
  ADD KEY `idx_hash` (`hash`);
--

CREATE TABLE `auth` (
  `id` varchar(255),
  `userId` varchar(255),
  `json` json,
  `hash` varchar(64) GENERATED ALWAYS AS (sha2(`json`,256)) STORED,
  `timestamp` datetime DEFAULT CURRENT_TIMESTAMP

  `token` int,
  `validated` tinyint(1) DEFAULT '0',
  `emailCode` varchar(255),
  `phoneCode` varchar(255),
  `device` varchar(255),
  `ip` varchar(255),
  `location` varchar(255),

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Indexes for `auth`
ALTER TABLE `auth`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `token` (`token`),
  ADD KEY `idx_userId` (`userId`),
  ADD KEY `idx_token` (`token`);
  
--

CREATE TABLE `auth_log` (
  `id` varchar(255),
  `userId` varchar(255),
  `json` json,
  `hash` varchar(64) GENERATED ALWAYS AS (sha2(`json`,256)) STORED,
  `timestamp` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Indexes for `auth_log`
ALTER TABLE `auth_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_userId` (`userId`),
  ADD KEY `idx_hash` (`hash`);

--
CREATE TABLE `refresh` (
  `id` varchar(255),
  `userId` varchar(255),
  `authId` varchar(255),
  `json` json,
  `hash` varchar(64) GENERATED ALWAYS AS (sha2(`json`,256)) STORED,
  `timestamp` datetime DEFAULT CURRENT_TIMESTAMP

  `token` int,
  `validated` tinyint(1) DEFAULT '0',
  `emailCode` varchar(255),
  `phoneCode` varchar(255),
  `device` varchar(255),
  `ip` varchar(255),
  `location` varchar(255),

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Indexes for `refresh`
ALTER TABLE `refresh`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `token` (`token`),
  ADD KEY `idx_userId` (`userId`),
  ADD KEY `idx_token` (`token`);
  
--

CREATE TABLE `refresh_log` (
  `id` varchar(255),
  `userId` varchar(255),
  `json` json,
  `hash` varchar(64) GENERATED ALWAYS AS (sha2(`json`,256)) STORED,
  `timestamp` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Indexes for `refresh_log`
ALTER TABLE `refresh_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_userId` (`userId`),
  ADD KEY `idx_hash` (`hash`);

-- END Txn
COMMIT;
