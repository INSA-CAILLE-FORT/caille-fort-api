-- DROP EXISTING TABLES
DROP TABLE IF EXISTS questions CASCADE;
DROP TABLE IF EXISTS points CASCADE;
DROP TABLE IF EXISTS organs CASCADE;
DROP TABLE IF EXISTS ocean_parts CASCADE;
DROP TABLE IF EXISTS podcasts CASCADE;

-- TABLE: Organs
CREATE TABLE organs (
                        id BIGSERIAL PRIMARY KEY,
                        name VARCHAR(255) NOT NULL
);

-- TABLE: Ocean Parts
CREATE TABLE ocean_parts (
                             id BIGSERIAL PRIMARY KEY,
                             name VARCHAR(255) NOT NULL
);

-- TABLE: Podcasts
CREATE TABLE podcasts (
                          id BIGSERIAL PRIMARY KEY,
                          title VARCHAR(255) NOT NULL,
                          description TEXT NOT NULL,
                          file_url VARCHAR(500) NOT NULL
);

-- TABLE: Points
CREATE TABLE points (
                        id BIGSERIAL PRIMARY KEY,
                        name VARCHAR(255) NOT NULL,
                        organ_id BIGINT NOT NULL REFERENCES organs(id) ON DELETE CASCADE,
                        ocean_part_id BIGINT NOT NULL REFERENCES ocean_parts(id) ON DELETE CASCADE
);

-- TABLE: Questions
CREATE TABLE questions (
                           id BIGSERIAL PRIMARY KEY,
                           text VARCHAR(500) NOT NULL,
                           status VARCHAR(50) CHECK (status IN ('benefice', 'consequence', 'learn', 'share', 'act')) NOT NULL,
                           correct_answer VARCHAR(500) NOT NULL,
                           incorrect_answers JSON NOT NULL,
                           organ_id BIGINT REFERENCES organs(id) ON DELETE CASCADE,
                           ocean_part_id BIGINT REFERENCES ocean_parts(id) ON DELETE CASCADE
);
