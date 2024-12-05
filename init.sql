-- DROP EXISTING TABLES
DROP TABLE IF EXISTS incorrect_answers CASCADE;
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
                           description VARCHAR(500) NOT NULL,
                           status VARCHAR(50) CHECK (status IN ('description', 'benefice', 'consequence', 'learn', 'share', 'act')) NOT NULL,
                           correct_answer VARCHAR(500) NOT NULL,
                           organ_id BIGINT REFERENCES organs(id) ON DELETE CASCADE,
                           ocean_part_id BIGINT REFERENCES ocean_parts(id) ON DELETE CASCADE
);

-- TABLE: Incorrect Answers
CREATE TABLE incorrect_answers (
                                   id BIGSERIAL PRIMARY KEY,
                                   question_id BIGINT NOT NULL REFERENCES questions(id) ON DELETE CASCADE,
                                   answer VARCHAR(500) NOT NULL
);

-- Insert dans organs
INSERT INTO organs (name) VALUES
                              ('Heart'),
                              ('Brain'),
                              ('Lungs');

-- Insert dans ocean_parts
INSERT INTO ocean_parts (name) VALUES
                                   ('Coral Reef'),
                                   ('Deep Ocean'),
                                   ('Arctic Sea');

-- Insert dans points
INSERT INTO points (name, organ_id, ocean_part_id) VALUES
                                                       ('Heart Function', 1, 1),
                                                       ('Brain and Coral', 2, 2),
                                                       ('Lungs in the Arctic', 3, 3);

-- INSERT QUESTIONS FOR ORGAN
INSERT INTO questions (text, description, status, correct_answer, organ_id)
VALUES
    ('What is the primary role of the heart?', 'Understand the role of the heart in the circulatory system.', 'benefice', 'Pumping blood', 1),
    ('What happens if the heart stops functioning?', 'Identify the consequences of heart failure.', 'consequence', 'Reduced oxygen delivery', 1),
    ('Describe the heart.', 'Learn about the structure of the heart.', 'description', 'A muscular organ', 1),

    ('What is the primary function of the brain?', 'Explore the brain’s role in the nervous system.', 'benefice', 'Control of body functions', 2),
    ('What happens if the brain stops functioning?', 'Identify consequences of brain failure.', 'consequence', 'Loss of consciousness', 2),
    ('Describe the brain.', 'Understand the structure of the brain.', 'description', 'An organ of soft nervous tissue', 2),

    ('What is the primary role of the lungs?', 'Understand the role of the lungs in respiration.', 'benefice', 'Oxygen exchange', 3),
    ('What happens if the lungs fail?', 'Identify the consequences of lung failure.', 'consequence', 'Breathing difficulty', 3),
    ('Describe the lungs.', 'Learn about the structure of the lungs.', 'description', 'Organs for gas exchange', 3);

-- INSERT QUESTIONS FOR OCEAN_PARTS
INSERT INTO questions (text, description, status, correct_answer, ocean_part_id)
VALUES
    ('Why are coral reefs important?', 'Explore the benefits of coral reefs for marine biodiversity.', 'benefice', 'Support marine biodiversity', 1),
    ('What is a consequence of coral reef destruction?', 'Understand the impact of losing coral reefs.', 'consequence', 'Loss of marine species', 1),
    ('Describe coral reefs.', 'Learn about the structure of coral reefs.', 'description', 'Underwater ecosystems built by corals', 1),
    ('How can humans protect coral reefs?', 'Learn about actions to protect coral reefs.', 'act', 'Reducing pollution', 1),
    ('How do coral reefs help humans?', 'Share the benefits of coral reefs to humans.', 'share', 'Provide coastal protection', 1),
    ('What can we learn from coral reefs?', 'Understand scientific insights from coral reefs.', 'learn', 'Biodiversity hotspots', 1);

-- INSERT INCORRECT ANSWERS
INSERT INTO incorrect_answers (question_id, answer) VALUES
                                                        -- Heart
                                                        (1, 'Producing oxygen'), (1, 'Storing carbon dioxide'),
                                                        (2, 'Enhanced brain function'), (2, 'Improved digestion'),
                                                        (3, 'A bone'), (3, 'A gland'),

                                                        -- Brain
                                                        (4, 'Pumping blood'), (4, 'Producing insulin'),
                                                        (5, 'Enhanced vision'), (5, 'Improved balance'),
                                                        (6, 'A digestive organ'), (6, 'A bone'),

                                                        -- Lungs
                                                        (7, 'Producing hormones'), (7, 'Pumping blood'),
                                                        (8, 'Increased oxygen production'), (8, 'Improved digestion'),
                                                        (9, 'Muscular organs'), (9, 'Bone structures'),

                                                        -- Coral Reef
                                                        (10, 'Store oxygen'), (10, 'Produce carbon dioxide'),
                                                        (11, 'Increased oxygen production'), (11, 'Better water quality'),
                                                        (12, 'Mountains'), (12, 'Forests'),
                                                        (13, 'Increasing fishing'), (13, 'Building resorts'),
                                                        (14, 'Increase deforestation'), (14, 'Produce metals'),
                                                        (15, 'Water scarcity'), (15, 'Land preservation');

-- Podcasts
INSERT INTO podcasts (title, description, file_url) VALUES
                                                        ('Marine Biology 101', 'An introduction to marine biology and its importance.', 'https://example.com/podcasts/marine-biology-101.mp3'),
                                                        ('Saving Our Oceans', 'Discussion on efforts to save oceans from pollution.', 'https://example.com/podcasts/saving-our-oceans.mp3'),
                                                        ('The Human Heart', 'Insights into the workings of the human heart.', 'https://example.com/podcasts/human-heart.mp3');
