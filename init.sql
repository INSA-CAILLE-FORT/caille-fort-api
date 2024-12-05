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

-- INSERT DATA INTO TABLES
-- Organs
INSERT INTO organs (name) VALUES
                              ('Heart'),
                              ('Liver'),
                              ('Lungs'),
                              ('Brain');

-- Ocean Parts
INSERT INTO ocean_parts (name) VALUES
                                   ('Coral Reef'),
                                   ('Deep Sea'),
                                   ('Estuary'),
                                   ('Mangroves');

-- Podcasts
INSERT INTO podcasts (title, description, file_url) VALUES
                                                        ('Marine Biology 101', 'An introduction to marine biology and its importance.', 'https://example.com/podcasts/marine-biology-101.mp3'),
                                                        ('Saving Our Oceans', 'Discussion on efforts to save oceans from pollution.', 'https://example.com/podcasts/saving-our-oceans.mp3'),
                                                        ('The Human Heart', 'Insights into the workings of the human heart.', 'https://example.com/podcasts/human-heart.mp3');

-- Points
INSERT INTO points (name, organ_id, ocean_part_id) VALUES
                                                       ('Point A', 1, 1), -- Heart & Coral Reef
                                                       ('Point B', 2, 2), -- Liver & Deep Sea
                                                       ('Point C', 3, 3), -- Lungs & Estuary
                                                       ('Point D', 4, 4); -- Brain & Mangroves

-- Questions
INSERT INTO questions (text, status, correct_answer, incorrect_answers, organ_id, ocean_part_id) VALUES
                                                                                                     ('What is the primary function of the heart?', 'learn', 'Pumping blood', '["Storing oxygen", "Producing hormones"]', 1, NULL),
                                                                                                     ('Why are coral reefs important?', 'benefice', 'They support marine life', '["They are tourist attractions", "They are waste dumps"]', NULL, 1),
                                                                                                     ('What can cause liver damage?', 'consequence', 'Alcohol abuse', '["Exercising too much", "Eating vegetables"]', 2, NULL),
                                                                                                     ('What is the biggest threat to mangroves?', 'share', 'Deforestation', '["Overfishing", "Hurricanes"]', NULL, 4);