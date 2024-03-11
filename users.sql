CREATE TABLE IF NOT EXISTS `users` (
  `id` TEXT PRIMARY KEY,
  `json` TEXT,
  `hash` TEXT,
  `timestamp` DATETIME DEFAULT CURRENT_TIMESTAMP,

  `username` TEXT as (json_extract(`json`,'$.username')) STORED UNIQUE,
  `email` TEXT as (json_extract(`json`,'$.email')) STORED UNIQUE,
  `password` TEXT as (json_extract(`json`,'$.password')) STORED,
  `picture` TEXT as (json_extract(`json`,'$.picture')) STORED,
  `phone` TEXT as (json_extract(`json`,'$.phone')) STORED UNIQUE

);

-- Indexes for table `users`
CREATE INDEX IF NOT EXISTS `idx_hash` ON users(`hash`);
CREATE INDEX IF NOT EXISTS `idx_username` ON users(`username`);
CREATE INDEX IF NOT EXISTS `idx_email` ON users(`email`);

--

CREATE TABLE IF NOT EXISTS `users_log` (
  `id` TEXT PRIMARY KEY,
  `userId` TEXT,
  `json` TEXT,
  `hash` TEXT,
  `timestamp` DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Indexes for `users_log`
CREATE INDEX IF NOT EXISTS `idx_userId` ON users_log(`userId`);
CREATE INDEX IF NOT EXISTS `idx_hash` ON users_log(`hash`);
--

CREATE TABLE IF NOT EXISTS `auth` (
  `id` TEXT PRIMARY KEY,
  `userId` TEXT,
  `json` TEXT,
  `hash` TEXT,
  `timestamp` DATETIME DEFAULT CURRENT_TIMESTAMP,

  `token` TEXT as (json_extract(`json`,'$.token')) STORED UNIQUE,
  `validated` TEXT as (json_extract(`json`,'$.validated')) STORED,
  `emailCode` TEXT as (json_extract(`json`,'$.emailCode')) STORED,
  `phoneCode` TEXT as (json_extract(`json`,'$.phoneCode')) STORED,
  `device` TEXT as (json_extract(`json`,'$.device')) STORED,
  `ip` TEXT as (json_extract(`json`,'$.ip')) STORED,
  `location` TEXT as (json_extract(`json`,'$.location')) STORED

);

-- Indexes for `auth`
CREATE INDEX IF NOT EXISTS `idx_userId` ON auth(`userId`);
CREATE INDEX IF NOT EXISTS `idx_token` ON auth(`token`);
  
--

CREATE TABLE IF NOT EXISTS `auth_log` (
  `id` TEXT PRIMARY KEY,
  `userId` TEXT,
  `json` TEXT,
  `hash` TEXT,
  `timestamp` DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Indexes for `auth_log`
CREATE INDEX IF NOT EXISTS `idx_userId` ON auth_log(`userId`);
CREATE INDEX IF NOT EXISTS `idx_hash` ON auth_log(`hash`);

--
CREATE TABLE IF NOT EXISTS `refresh` (
  `id` TEXT PRIMARY KEY,
  `userId` TEXT,
  `authId` TEXT,
  `json` TEXT,
  `hash` TEXT,
  `timestamp` DATETIME DEFAULT CURRENT_TIMESTAMP,

  `token` TEXT UNIQUE,
  `validated` TEXT,
  `emailCode` TEXT,
  `phoneCode` TEXT,
  `device` TEXT,
  `ip` TEXT,
  `location` TEXT

);

-- Indexes for `refresh`
CREATE INDEX IF NOT EXISTS `idx_userId` ON refresh(`userId`);
CREATE INDEX IF NOT EXISTS `idx_token` ON refresh(`token`);
  
--

CREATE TABLE IF NOT EXISTS `refresh_log` (
  `id` TEXT PRIMARY KEY,
  `userId` TEXT,
  `json` TEXT,
  `hash` TEXT,
  `timestamp` DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Indexes for `refresh_log`
CREATE INDEX IF NOT EXISTS `idx_userId` ON refresh_log(`userId`);
CREATE INDEX IF NOT EXISTS `idx_hash` ON refresh_log(`hash`);
