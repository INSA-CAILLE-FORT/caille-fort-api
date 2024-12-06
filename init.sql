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
                        name VARCHAR(1024) NOT NULL
);

-- TABLE: Ocean Parts
CREATE TABLE ocean_parts (
                             id BIGSERIAL PRIMARY KEY,
                             name VARCHAR(1024) NOT NULL
);

-- TABLE: Podcasts
CREATE TABLE podcasts (
                          id BIGSERIAL PRIMARY KEY,
                          title VARCHAR(1024) NOT NULL,
                          description TEXT NOT NULL,
                          file_url VARCHAR(1024) NOT NULL
);

-- TABLE: Points
CREATE TABLE points (
                        id BIGSERIAL PRIMARY KEY,
                        name VARCHAR(1024) NOT NULL,
                        organ_id BIGINT NOT NULL REFERENCES organs(id) ON DELETE CASCADE,
                        ocean_part_id BIGINT NOT NULL REFERENCES ocean_parts(id) ON DELETE CASCADE
);

-- TABLE: Questions
CREATE TABLE questions (
                           id BIGSERIAL PRIMARY KEY,
                           text VARCHAR(1024) NOT NULL,
                           description VARCHAR(1024) NOT NULL,
                           status VARCHAR(1024) CHECK (status IN ('description', 'benefice', 'consequence', 'learn', 'share', 'act')) NOT NULL,
                           correct_answer VARCHAR(1024) NOT NULL,
                           organ_id BIGINT REFERENCES organs(id) ON DELETE CASCADE,
                           ocean_part_id BIGINT REFERENCES ocean_parts(id) ON DELETE CASCADE
);

-- TABLE: Incorrect Answers
CREATE TABLE incorrect_answers (
                                   id BIGSERIAL PRIMARY KEY,
                                   question_id BIGINT NOT NULL REFERENCES questions(id) ON DELETE CASCADE,
                                   answer VARCHAR(1024) NOT NULL
);

-- Insérer les organes
INSERT INTO organs (name) VALUES
                              ('Système circulatoire'),
                              ('Système immunitaire'),
                              ('Foie'),
                              ('Microbiote intestinal'),
                              ('Température corporelle'),
                              ('Reins'),
                              ('Système lymphatique');

-- Insérer les parties de l'océan
INSERT INTO ocean_parts (name) VALUES
    ('Colonne d’eau'),
    ('Récif corallien'),
    ('Oiseaux marins'),
    ('Platisphère marine'),
    ('Régulation de la température marine'),
    ('Filtrage des coraux'),
    ('Filtrage de l’eau par le processus de collecte des microplastiques');

-- Insérer les points
INSERT INTO points (name, organ_id, ocean_part_id) VALUES
    ('Colonne d’eau dans les Bermudes', 1, 1),
    ('Récif Corallien à Cuba', 2, 2),
    ('Les oiseaux marins sur les côtes chiliennes', 3, 3),
    ('Platisphère en Polynésie Française', 4, 4),
    ('Régulation de la température en Tonga Fidji', 5, 5),
    ('Des métaux et microplastiques en Nouvelle Calédonie', 6, 6),
    ('Échantillonnage de microplastiques dans les eaux de surface au Japon', 7, 7);

-- Insérer les questions avec leurs réponses correctes
INSERT INTO questions (text, description, status, correct_answer, organ_id, ocean_part_id) VALUES
    -- Colonne d'eau
    ('Une colonne d’eau en bon état contribue à la régulation climatique et à la santé des écosystèmes marins en absorbant le dioxyde de carbone et en transportant des nutriments essentiels.',
     'Lorsque la colonne d’eau fonctionne correctement, elle agit comme un mécanisme vital pour la planète. Elle favorise la biodiversité marine en distribuant les nutriments et en oxygénant les différentes couches de l’océan. En absorbant le dioxyde de carbone, elle joue un rôle essentiel dans la lutte contre le réchauffement climatique, tout en maintenant l’équilibre des écosystèmes.',
     'description', 'Vrai', NULL, 1),
     ('Une colonne d’eau bien fonctionnelle aide à réguler le pH des océans en limitant les effets de l’acidification grâce à son absorption de dioxyde de carbone.',
      'Bien que la colonne d’eau joue un rôle dans l’absorption du dioxyde de carbone, elle ne régule pas directement le pH de l’océan. L’acidification des océans est une conséquence de l’excès de CO₂ absorbé par l’eau, un phénomène qui dépasse la capacité naturelle de régulation des océans. Cependant, la colonne d’eau reste essentielle pour le transport de nutriments et la survie des écosystèmes marins.',
      'benefice', 'Faux', NULL, 1),
     ('Un dysfonctionnement de la colonne d’eau peut provoquer des zones mortes dans l’océan où la vie marine ne peut plus survivre.',
      'Lorsque la colonne d’eau est perturbée par la pollution ou les changements climatiques, l’oxygène devient insuffisant dans certaines zones, créant des "zones mortes". Ces régions ne peuvent plus soutenir la vie marine, perturbant les écosystèmes et réduisant la biodiversité. Ces dysfonctionnements affectent également la capacité des océans à réguler le climat.',
      'consequence', 'Vrai', NULL, 1),

        -- Système circulatoire
     ('Un système circulatoire en bonne santé permet une oxygénation optimale des tissus, une élimination des déchets métaboliques et un équilibre thermique essentiel pour le corps.',
      'Un système circulatoire efficace est crucial pour la santé. Il assure le transport de l’oxygène et des nutriments vers chaque cellule, facilite l’élimination des toxines et régule la température corporelle. Ce bon fonctionnement garantit l’énergie vitale nécessaire à la survie et à la défense contre les agressions extérieures, en maintenant l’équilibre global du corps humain.',
      'description', 'Vrai', 1, NULL),
     ('Un système circulatoire en bonne santé permet de protéger le corps contre certaines infections en favorisant le transport de globules blancs dans le sang.',
      'Le système circulatoire joue un rôle clé dans la défense immunitaire. Les globules blancs, transportés par le sang, sont essentiels pour détecter et combattre les infections. En assurant une circulation efficace, le corps peut réagir rapidement aux agressions extérieures et maintenir un équilibre biologique qui préserve la santé globale.',
      'benefice', 'Vrai', 1, NULL),
     ('Lorsque le système circulatoire est compromis, les organes peuvent compenser les déficiences en produisant eux-mêmes l’oxygène nécessaire à leur bon fonctionnement.',
      'Les organes ne peuvent pas produire leur propre oxygène. Ils dépendent entièrement du système circulatoire pour leur apport en oxygène et en nutriments. Un dysfonctionnement dans ce système entraîne des insuffisances graves, telles que des dommages aux organes ou des maladies chroniques, car les tissus ne peuvent pas survivre sans un approvisionnement constant.',
      'consequence', 'Faux', 1, NULL),

        -- Récif corallien
    ('Les récifs coralliens maintiennent un équilibre écologique grâce à une relation symbiotique entre les coraux et les algues microscopiques.',
        'Les coraux et les algues zooxanthelles partagent une relation unique et bénéfique pour les deux parties : les algues fournissent de l’énergie aux coraux via la photosynthèse, tandis que les coraux leur offrent un habitat et des nutriments. Cette collaboration est essentielle pour la biodiversité marine et la santé des écosystèmes océaniques.',
        'description', 'Vrai', NULL, 2),
    ('Le système immunitaire humain se limite à la production d''anticorps pour protéger le corps contre les infections.',
        'Le système immunitaire ne se limite pas à la production d''anticorps. Il utilise un réseau complexe de cellules, comme les lymphocytes, et d’organes, comme la rate et les ganglions lymphatiques, pour détecter et neutraliser les pathogènes. Il assure aussi l’homéostasie, aidant le corps à rester en équilibre face aux agressions internes et externes.',
        'benefice', 'Faux', NULL, 2),
    ('Les récifs coralliens en bonne santé protègent les côtes en réduisant l''impact des vagues et des tempêtes.',
        'Les récifs coralliens agissent comme des barrières naturelles, atténuant l’énergie des vagues avant qu’elles n’atteignent les côtes. Cela réduit l’érosion et protège les habitats côtiers. En plus de leur rôle protecteur, ces écosystèmes soutiennent une biodiversité marine exceptionnelle et contribuent à la régulation des cycles climatiques et carboniques.',
        'consequence', 'Vrai', NULL, 2),

        -- Système immunitaire
    ('Le système immunitaire humain se limite à la production d''anticorps pour protéger le corps contre les infections.',
     'Le système immunitaire ne se limite pas à la production d''anticorps. Il utilise un réseau complexe de cellules, comme les lymphocytes, et d’organes, comme la rate et les ganglions lymphatiques, pour détecter et neutraliser les pathogènes. Il assure aussi l’homéostasie, aidant le corps à rester en équilibre face aux agressions internes et externes.',
     'description', 'Faux', 2, NULL),
    ('Un système immunitaire fonctionnel favorise la régulation de l’inflammation dans le corps, ce qui aide à prévenir certaines maladies chroniques.',
     'Le système immunitaire ne se contente pas de protéger contre les infections : il joue également un rôle crucial dans la régulation de l’inflammation. Une inflammation bien contrôlée permet de prévenir des maladies chroniques comme l’arthrite ou le diabète, tout en aidant à la réparation des tissus et en maintenant l’équilibre global de l’organisme.',
     'benefice', 'Vrai', 2, NULL),
    ('Un système immunitaire affaibli peut augmenter la probabilité de maladies auto-immunes où le corps attaque ses propres tissus.',
     'Un système immunitaire affaibli ou dérégulé peut entraîner des réactions inappropriées, comme des maladies auto-immunes. Dans ces cas, le corps identifie par erreur ses propres cellules comme des menaces et les attaque, provoquant des inflammations chroniques et des dommages aux organes. Cela compromet gravement la santé et nécessite souvent une prise en charge médicale à long terme.',
     'consequence', 'Vrai', 2, NULL),

    -- Oiseaux marins
    ('Les oiseaux marins contribuent à la fertilisation des écosystèmes marins en dispersant des nutriments à travers leurs déjections.',
     'Les déjections des oiseaux marins, riches en nutriments comme l’azote et le phosphore, fertilisent les écosystèmes marins et terrestres à proximité. Ce processus favorise la croissance du phytoplancton et d''autres organismes, soutenant ainsi les chaînes alimentaires marines et l’équilibre des écosystèmes.',
     'description', 'Vrai', NULL, 3),
    ('Les oiseaux marins contribuent à prévenir les déséquilibres dans les écosystèmes marins en contrôlant la prolifération de certaines espèces et en dispersant des nutriments.',
     'En consommant des organismes marins comme les poissons ou le plancton, les oiseaux marins aident à réguler les populations de ces espèces. Par leurs déjections riches en nutriments, ils fertilisent les environnements marins et terrestres, soutenant ainsi la biodiversité et les cycles naturels essentiels à la santé des océans.',
     'benefice', 'Vrai', NULL, 3),
    ('Un déclin important des populations d’oiseaux marins pourrait provoquer des déséquilibres dans les écosystèmes marins, comme une prolifération incontrôlée de certaines espèces et une diminution des nutriments disponibles.',
     'Lorsque les oiseaux marins disparaissent ou perdent leur rôle écologique, les écosystèmes marins subissent des perturbations. Les espèces qu’ils consomment peuvent proliférer de manière excessive, tandis que la dispersion des nutriments provenant de leurs déjections diminue, affectant ainsi la chaîne alimentaire et l’équilibre biologique des océans.',
     'consequence', 'Vrai', NULL, 3),

    -- Foie humain
    ('Le foie est responsable de la production de bile, qui permet la décomposition et l’absorption des protéines.',
     'Le foie produit de la bile, mais celle-ci est essentielle à la décomposition et à l’absorption des graisses, pas des protéines. Ce rôle clé dans la digestion et la détoxification aide à maintenir l’équilibre métabolique et à protéger le corps contre les substances nocives.',
     'description', 'Faux', 3, NULL),
    ('Un foie en bonne santé est essentiel pour maintenir des niveaux de glucose stables et éviter les carences en nutriments.',
     'Le système immunitaire ne se contente pas de protéger contre les infections : il joue également un rôle crucial dans la régulation de l’inflammation. Une inflammation bien contrôlée permet de prévenir des maladies chroniques comme l’arthrite ou le diabète, tout en aidant à la réparation des tissus et en maintenant l’équilibre global de l’organisme.',
     'benefice', 'Vrai', 3, NULL),
    ('Un foie en mauvais état peut encore maintenir un équilibre métabolique suffisant pour éviter les complications majeures.',
     'Un foie malade perd sa capacité à détoxifier le sang et à réguler les nutriments essentiels, entraînant une accumulation de toxines et des déséquilibres métaboliques. Ces dysfonctionnements peuvent provoquer des maladies graves, comme des insuffisances hépatiques, menaçant directement la santé et la survie de l’organisme.',
     'consequence', 'Faux', 3, NULL),

    -- Platisphère marines
    ('La plastisphère marine agit comme un écosystème stable qui aide à maintenir l’équilibre des cycles biologiques marins et des chaînes alimentaires.',
     'Bien que la plastisphère puisse créer un habitat pour certaines espèces, elle perturbe réellement les écosystèmes marins en modifiant les flux de nutriments et en introduisant des micro-organismes qui ne devraient pas être présents dans l’environnement marin naturel. Elle perturbe les chaînes alimentaires et peut nuire à la biodiversité océanique.',
     'description', 'Faux', NULL, 4),
    ('Lorsque la plastisphère marine fonctionne de manière stable, elle aide arins comme les poissons ou le plancton, les oiseaux marins aident à réguler les populations de cesà décomposer la matière organique et soutient la biodiversité marine en servant de nourriture à des organismes marins microscopiques.',
     'La plastisphère peut avoir un impact indirectement positif en dégradant certaines matières organiques et en fournissant une source de nourriture pour les micro-organismes marins. Cependant, cela ne compense pas les effets négatifs de la pollution plastique dans les océans, qui perturbe largement l''écosystème marin.',
     'benefice', 'Vrai', NULL, 4),
    ('Si la plastisphère devient déséquilibrée, elle peut introduire des pathogènes marins dans les chaînes alimentaires et favoriser des espèces invasives, ce qui perturbe la santé des océans et impacte les organismes marins, y compris l’être humain.',
     'Un déséquilibre dans la plastisphère peut effectivement créer des conditions favorables pour les pathogènes marins et les espèces invasives, perturbant les chaînes alimentaires et les écosystèmes marins. Cela peut avoir des effets néfastes sur les océans et sur les organismes, y compris les humains, qui dépendent de la santé marine.',
     'consequence', 'Vrai', NULL, 4),

    -- Microbiote intestinal
    ('Le microbiote intestinal joue un rôle clé dans le maintien de la santé globale en facilitant la décomposition des aliments et en produisant des nutriments essentiels pour l’organisme.',
     'Le microbiote intestinal est fondamental pour le bien-être humain. Il décompose les aliments, produit des nutriments essentiels comme les vitamines et aide à réguler le système immunitaire. Un microbiote en bonne santé favorise une digestion efficace et soutient l’équilibre global du corps humain.',
     'description', 'Vrai', 4, NULL),
    ('Le microbiote intestinal contribue au bien-être global en facilitant la digestion, en produisant des nutriments essentiels comme les vitamines, et en renforçant le système immunitaire pour protéger l’organisme.',
     'Le microbiote intestinal joue un rôle central dans la santé humaine. Il décompose les aliments en nutriments facilement absorbables, produit des vitamines essentielles (comme la vitamine K et certaines vitamines B), et soutient le système immunitaire en empêchant la prolifération d’agents pathogènes. Un microbiote équilibré est indispensable au maintien de la digestion, à la prévention des maladies, et au bien-être général de l’organisme.',
     'benefice', 'Vrai', 4, NULL),
    ('Un microbiote intestinal déséquilibré, ou dysbiose, peut entraîner des troubles digestifs, des inflammations chroniques et des maladies métaboliques comme le diabète, affectant la santé générale de l’organisme.',
     'Un microbiote intestinal déséquilibré peut entraîner divers problèmes de santé, y compris des troubles digestifs, des inflammations et des maladies métaboliques. Cela montre l''importance cruciale de l''équilibre du microbiote pour maintenir un bien-être général et une bonne santé.',
     'consequence', 'Vrai', 4, NULL),

    -- Régulation de la température marine
    ('L’océan agit comme un régulateur thermique pour la planète, redistribuant la chaleur des zones équatoriales vers les régions polaires, et contribuant à maintenir un climat stable, tout en influençant les climats terrestres adjacents.',
     'L''océan joue un rôle crucial dans la régulation thermique de la planète. Les courants marins redistribuent la chaleur, réduisant les extrêmes climatiques et maintenant un climat global plus stable, ce qui est essentiel pour la vie marine et terrestre.',
     'description', 'Vrai', NULL, 5),
    ('Une régulation thermique efficace dans l’océan favorise la stabilité des écosystèmes marins, soutient les habitats de nombreuses espèces, et contribue à la régulation du cycle de l’eau et du climat mondial, ce qui est essentiel pour les populations humaines qui dépendent des ressources marines et d''un climat stable.',
     'Une régulation thermique adéquate dans les océans aide à maintenir l''équilibre des écosystèmes marins, en garantissant des conditions climatiques et biologiques stables. Cela est crucial pour les espèces marines et pour les humains, qui dépendent de ces ressources et d''un climat prévisible.',
     'benefice', 'Vrai', NULL, 5),
    ('Lorsque la régulation thermique de l’océan est perturbée, comme avec le réchauffement climatique ou la pollution par les microplastiques, cela peut entraîner des vagues de chaleur océaniques, affectant les coraux, les habitats marins et les migrations des espèces, et perturber l’équilibre climatique mondial.',
     'Un mauvais fonctionnement de la régulation thermique océanique peut entraîner des phénomènes graves comme les vagues de chaleur, qui perturbent les écosystèmes marins et l’équilibre climatique global. Ces changements ont des impacts sur les espèces marines et peuvent accélérer le réchauffement de la planète..',
     'consequence', 'Vrai', NULL, 5),

    -- Régulation de la température corporelle
    ('Dans le corps humain, l’hypothalamus régule la température en ajustant la chaleur interne, soit par la transpiration pour refroidir le corps, soit par les frissons pour le réchauffer, maintenant ainsi une température corporelle stable autour de 37°C.',
     'L''hypothalamus agit comme un thermostat interne, ajustant la température corporelle à l''aide de mécanismes comme la transpiration et les frissons. Ce processus permet de maintenir la température corporelle autour de 37°C, condition essentielle pour le bon fonctionnement des fonctions biologiques.',
     'description', 'Vrai', 5, NULL),
    ('Une régulation efficace de la température corporelle permet de maintenir un environnement interne stable, ce qui optimise le fonctionnement des enzymes et des systèmes biologiques, préservant ainsi l''énergie et la santé générale du corps humain.',
     'La régulation de la température corporelle garantit un environnement optimal pour les fonctions biologiques, permettant aux systèmes du corps humain de travailler efficacement. Cela aide à maintenir la santé, à économiser de l''énergie et à soutenir la performance globale du corps.',
     'benefice', 'Vrai', 5, NULL),
    ('Un dysfonctionnement de la thermorégulation peut provoquer des conditions graves telles que l’hyperthermie, l’hypothermie ou les coups de chaleur, mettant en danger les fonctions vitales et pouvant entraîner des dommages cellulaires ou la mort si la température corporelle ne revient pas rapidement à un niveau normal.',
     'Un mauvais contrôle de la température corporelle peut causer des troubles comme l’hyperthermie ou l’hypothermie, des conditions potentiellement fatales si elles ne sont pas corrigées rapidement. Ces dysfonctionnements affectent la santé et la survie de l’organisme, tout comme un dysfonctionnement thermique dans les océans impacte l''équilibre écologique.',
     'consequence', 'Vrai', 5, NULL),

    -- Filtrage des coraux pour la planète
    ('Les coraux jouent un rôle crucial dans l''équilibre des écosystèmes marins en filtrant l''eau de mer, en absorbant des particules en suspension, des nutriments et des polluants comme les microplastiques et les métaux lourds. Ce processus aide à maintenir l''eau claire et soutient la photosynthèse des algues symbiotiques, garantissant ainsi la santé des récifs coralliens et de la biodiversité marine.',
     'Les coraux, en filtrant l''eau de mer, contribuent à l''équilibre de l''écosystème marin en nettoyant l''eau, ce qui est essentiel pour la survie de la biodiversité. Ce processus aide à préserver les récifs coralliens, en maintenant une eau claire et en soutenant la photosynthèse des algues symbiotiques qui vivent avec eux.',
     'description', 'Vrai', NULL, 6),
    ('Le bon fonctionnement des coraux permet de maintenir une eau claire et équilibrée, essentielle pour la croissance des organismes marins. En filtrant l''eau, les coraux soutiennent la biodiversité marine et contribuent à la régulation du climat en fixant du carbone. Un océan en bonne santé est ainsi plus résilient face aux changements environnementaux et aux pressions humaines.',
     'Les coraux, en filtrant l''eau, contribuent à maintenir un écosystème marin sain, ce qui favorise la croissance des organismes marins et soutient la biodiversité. De plus, leur capacité à fixer du carbone aide à réguler le climat et à renforcer la résilience de l''océan face aux changements environnementaux.',
     'benefice', 'Vrai', NULL, 6),
    ('Le dysfonctionnement du filtrage par les coraux, causé par la pollution (microplastiques, métaux) ou le réchauffement des océans, entraîne une dégradation de la qualité de l''eau. Cela perturbe la chaîne alimentaire marine, affecte les écosystèmes côtiers et réduit la biodiversité, menaçant ainsi l''équilibre écologique et les ressources humaines dépendantes de la mer.',
     'Lorsque les coraux ne filtrent plus correctement l''eau en raison de la pollution ou du réchauffement, cela nuit à l''écosystème marin. La dégradation de l''eau et la perte de biodiversité ont des répercussions sur la chaîne alimentaire marine, affectant ainsi les écosystèmes côtiers et les ressources humaines qui dépendent de la mer.',
     'consequence', 'Vrai', NULL, 6),

    -- Filtrage des reins
    ('Les reins jouent un rôle vital en filtrant les déchets métaboliques, l''excès de sels, d''eau et d''autres substances du sang, garantissant ainsi une composition chimique stable dans le corps. Ce processus aide à maintenir l''équilibre hydrique et électrolytique, essentiel à la survie de l''organisme.',
     'Les reins, en filtrant le sang, jouent un rôle crucial pour éliminer les déchets et maintenir un équilibre chimique interne. Cela garantit la stabilité des niveaux d''eau et d''électrolytes dans le corps, ce qui est vital pour le bon fonctionnement des organes et la santé générale de l''individu.',
     'description', 'Vrai', 6, NULL),
    ('Lorsque les reins fonctionnent correctement, ils assurent l''élimination efficace des toxines et l''équilibre des fluides corporels, prévenant ainsi des troubles comme l''hypertension, les déséquilibres électrolytiques et les accumulations de déchets. Cela permet de maintenir un environnement interne stable, essentiel pour les fonctions corporelles.',
     'Les reins, en filtrant les déchets et en régulant l''équilibre des fluides, jouent un rôle crucial dans le maintien de l''homéostasie corporelle. Leur bon fonctionnement prévient des problèmes comme l''hypertension et les déséquilibres électrolytiques, garantissant un environnement interne optimal pour la santé.',
     'benefice', 'Vrai', 6, NULL),
    ('Lorsque les reins ne fonctionnent plus correctement, les déchets et les toxines s''accumulent dans le corps, provoquant des déséquilibres chimiques, de l''hypertension et des problèmes rénaux graves. Un dysfonctionnement rénal prolongé peut mener à une insuffisance rénale, compromettant la santé générale de l''organisme et nécessitant des traitements lourds comme la dialyse.',
     'Un mauvais fonctionnement des reins entraîne l''accumulation de toxines et de déchets dans le corps, ce qui provoque des déséquilibres chimiques, de l''hypertension et d''autres complications. Si ce dysfonctionnement persiste, il peut conduire à une insuffisance rénale, nécessitant des traitements comme la dialyse pour maintenir la santé du corps.',
     'consequence', 'Vrai', 6, NULL),

    -- Filtrage de l'eau par le processus de collecte des microplastiques
    ('Dans l''océan, le filtrage des microplastiques est un processus essentiel pour maintenir la santé des écosystèmes marins. À l''aide de filets spécifiques, comme les filets manta, les chercheurs collectent les microplastiques à la surface de l''eau. Ce processus permet de capturer les particules de plastique et autres polluants, contribuant ainsi à la purification des eaux océaniques et à la réduction de la pollution plastique.',
     'Le filtrage des microplastiques dans l''océan est crucial pour préserver la santé des écosystèmes marins. En utilisant des filets spécialisés, les chercheurs peuvent capturer ces particules polluantes et ainsi aider à réduire la pollution plastique dans les océans, améliorant la qualité de l''eau et soutenant la biodiversité marine.',
     'description', 'Vrai', NULL, 7),
    ('Lorsque ce processus de filtration fonctionne correctement, il permet de préserver la qualité de l''eau en éliminant les polluants. Cela protège les écosystèmes marins, maintient la biodiversité et contribue à la santé des récifs coralliens. En filtrant les microplastiques, l''océan peut mieux réguler son environnement, facilitant la photosynthèse et la circulation des nutriments nécessaires à la vie marine.',
     'Bien que la filtration des microplastiques soit importante pour la santé des océans, ce processus ne garantit pas à lui seul la régulation de l''environnement ou la circulation des nutriments. D''autres facteurs jouent également un rôle essentiel dans la préservation de la biodiversité et la santé des récifs coralliens.',
     'benefice', 'Faux', NULL, 7),
    ('Lorsque le filtrage de l''eau échoue, les microplastiques et autres polluants s''accumulent dans l''océan, affectant gravement la vie marine. Les coraux et les espèces marines sont contaminés, perturbant la chaîne alimentaire et menaçant les ressources maritimes. La pollution plastique contribue également au changement climatique en perturbant les équilibres naturels de l''écosystème marin.',
     'L''échec du filtrage des microplastiques peut entraîner une accumulation de pollution dans l''océan, perturbant la biodiversité marine. Les coraux et d''autres espèces marines sont particulièrement vulnérables à ces contaminants, ce qui affecte la chaîne alimentaire et contribue aux déséquilibres environnementaux, incluant des impacts sur le climat.',
     'consequence', 'Vrai', NULL, 7),

    -- Filtrage de l'eau par le processus de collecte des microplastiques
    ('Le système lymphatique est un réseau de vaisseaux et de ganglions qui filtre les déchets, les toxines et les agents pathogènes du corps humain. Il joue un rôle crucial dans la défense immunitaire, en éliminant les substances étrangères et en contribuant à la gestion des liquides corporels. À travers la lymphe, les déchets sont transportés vers les organes d’élimination, assurant ainsi un environnement interne sain.',
     'Le système lymphatique est essentiel pour maintenir la santé de l''organisme. Il filtre les déchets, les toxines et les agents pathogènes, tout en soutenant le système immunitaire et en régulant l''équilibre des fluides corporels. Ce processus permet d''éliminer les substances nuisibles et d''assurer un environnement interne stable et sain.',
     'description', 'Vrai', 7, NULL),
    ('Un système lymphatique fonctionnel permet d''éliminer efficacement les toxines et autres substances indésirables du corps. Cela renforce l’immunité, prévient les infections et aide à maintenir un équilibre interne, en régulant les fluides corporels. Grâce à ce système, l''organisme reste en bonne santé et protégé contre les agents pathogènes et les déséquilibres chimiques.',
     'Le système lymphatique joue un rôle important dans la défense immunitaire, mais il ne garantit pas à lui seul l''équilibre interne. D''autres systèmes et mécanismes sont nécessaires pour maintenir la santé globale du corps humain, y compris la régulation des fluides corporels et l''élimination des toxines.',
     'benefice', 'Faux', 7, NULL),
    ('Un dysfonctionnement du système lymphatique empêche l’élimination des toxines et agents pathogènes, entraînant une accumulation de déchets dans l’organisme. Cela peut affaiblir le système immunitaire, provoquant des infections, des inflammations chroniques et même des maladies graves, comme des cancers ou des troubles de la circulation lymphatique.',
     'Lorsque le système lymphatique ne fonctionne pas correctement, l''élimination des toxines et des agents pathogènes est compromise. Cela peut affaiblir l''immunité, entraînant des infections, des inflammations chroniques et des maladies graves. Le rôle du système lymphatique est essentiel pour maintenir un environnement interne sain et prévenir les troubles graves de santé.',
     'consequence', 'Vrai', 7, NULL);

INSERT INTO podcasts (title, description, file_url) VALUES
                                                        ('Marine Biology 101', 'An introduction to marine biology and its importance.', 'https://example.com/podcasts/marine-biology-101.mp3'),
                                                        ('Saving Our Oceans', 'Discussion on efforts to save oceans from pollution.', 'https://example.com/podcasts/saving-our-oceans.mp3'),
                                                        ('The Human Heart', 'Insights into the workings of the human heart.', 'https://example.com/podcasts/human-heart.mp3');




-- Podcasts
INSERT INTO questions (text, description, status, correct_answer, organ_id, ocean_part_id) VALUES

                                                       ('Pour mieux comprendre l’importance de la colonne d’eau dans l’océan et du système circulatoire dans le corps humain, en suivant le pilier LEARN (enquêter sur le terrain auprès des experts scientifiques), quelle démarche serait la plus appropriée ?',
                                                        'Le pilier LEARN encourage l’enquête sur le terrain auprès des experts scientifiques. Pour comprendre les liens entre la colonne d’eau et le système circulatoire, il est essentiel de consulter des chercheurs, d’étudier directement sur place et d’analyser des données fiables. Cette approche permet d’obtenir des informations précises et crédibles, améliorant ainsi notre compréhension globale des écosystèmes marins et de la physiologie humaine.',
                                                        'LEARN', 'Rencontrer des chercheurs spécialisés, mener des études de terrain et analyser leurs données.', NULL, 7),

                                                       ('Comment le pilier SHARE peut-il contribuer à améliorer les processus de filtrage des microplastiques et à sensibiliser à l''importance du système lymphatique humain ?',
                                                        'Le pilier SHARE joue un rôle clé en alertant les décideurs politiques sur les enjeux environnementaux, en sensibilisant le grand public à l''importance de ces processus de filtration, et en éduquant les jeunes générations. Cette démarche renforce la compréhension et l''engagement collectif pour protéger les océans et soutenir la santé humaine.',
                                                        'SHARE', 'En alertant les décideurs, sensibilisant le public et éduquant les jeunes générations sur leur importance.', NULL, 7),
                                                           -- Colonne d'eau
                                                       ('Selon le pilier ACT, qui vise à promouvoir des solutions aux impacts économiques, environnementaux et sociaux durables, quelle démarche contribue à la fois à préserver l’équilibre de la colonne d’eau des océans et la santé du système circulatoire humain ?',
                                                        'La démarche promue par le pilier ACT consiste à adopter des solutions responsables tenant compte de l’environnement, de l’économie et du bien-être social. En réduisant la pollution, en protégeant la biodiversité marine et en favorisant une alimentation et un mode de vie équilibrés, nous soutenons la stabilité de la colonne d’eau dans les océans tout comme la santé du système circulatoire chez l’humain.',
                                                        'ACT', 'Encourager la réduction des pollutions et une gestion responsable des ressources, afin de maintenir la qualité de l’eau et une circulation sanguine saine.', NULL, 7),



                                                       ('Selon le pilier LEARN (enquêter sur le terrain auprès des experts scientifiques), quelle démarche est la plus appropriée pour approfondir notre compréhension du lien entre le filtrage des coraux dans l’océan et le filtrage des reins dans le corps humain ?',
                                                        'L’approche LEARN implique de s’appuyer sur l’expertise de scientifiques et sur des observations de terrain. En allant directement rencontrer des chercheurs, en examinant des échantillons de récifs coralliens et en étudiant des données fiables, vous pourrez saisir les liens subtils qui unissent le rôle filtrant des coraux dans l’océan et celui des reins dans le corps humain.',
                                                        'LEARN', 'Interroger des chercheurs spécialisés en biologie marine et en physiologie, observer directement des récifs coralliens sur le terrain et analyser des données scientifiques fiables.', NULL, 6),

                                                       ('En comprenant l’importance du filtrage des coraux dans l’océan et des reins dans le corps humain, comment le pilier SHARE peut-il aider à agir efficacement ?',
                                                        'Le pilier SHARE vise à mobiliser une action collective : alerter les responsables politiques pour qu’ils prennent des mesures, sensibiliser le grand public afin de modifier les comportements, et éduquer les jeunes générations pour assurer une compréhension durable des enjeux. Cette approche globale permet de préserver l’équilibre des écosystèmes marins, tout comme la bonne santé de l’organisme, en mettant en lumière les similitudes entre le rôle filtrant des coraux et celui des reins.',
                                                        'SHARE', 'Alerter les décideurs, sensibiliser le grand public et éduquer les jeunes générations.', NULL, 6),
                                                       -- Colonne d'eau
                                                       ('En lien avec le pilier ACT, qui vise à promouvoir des solutions aux impacts économiques, environnementaux et sociaux durables, quelle approche serait la plus appropriée pour soutenir le rôle filtrant des coraux dans l’océan et, par analogie, encourager la préservation du filtrage assuré par les reins dans le corps humain ?',
                                                        'Le pilier ACT met en avant la nécessité de promouvoir des solutions durables pour faire face aux défis environnementaux, économiques et sociaux. En réduisant les déchets plastiques, améliorant la filtration de l’eau et sensibilisant les communautés, on préserve la capacité naturelle des coraux à maintenir la santé des écosystèmes marins. Parallèlement, cette approche reflète l’importance de maintenir un environnement interne stable pour le corps humain, comme le font les reins, assurant un équilibre bénéfique à tous les niveaux.',
                                                        'ACT', 'Mettre en place des politiques de réduction des déchets plastiques, investir dans des technologies de traitement des eaux et sensibiliser les populations à une consommation responsable.', NULL, 6),



                                                       ('Dans une démarche LEARN (enquêter sur le terrain auprès des experts scientifiques), quelle serait la meilleure façon d’approfondir notre compréhension du lien entre la régulation de la température dans l’océan et la régulation de la température corporelle chez l’être humain ?',
                                                        'Le pilier LEARN consiste à mener une véritable enquête scientifique : rencontrer des experts, recueillir des données fiables directement sur le terrain et étudier des sources crédibles. Cette approche permet d’obtenir une compréhension précise des mécanismes de régulation thermique, qu’il s’agisse de l’équilibre climatique mondial assuré par l’océan ou du maintien d’une température corporelle stable chez l’homme.',
                                                        'LEARN', 'Interroger des océanographes et des physiologistes, analyser les données recueillies sur le terrain et étudier les études scientifiques disponibles.', NULL, 5),

                                                       ('Pour appliquer le pilier SHARE (Alerter les décideurs, Sensibiliser le grand public et Éduquer les jeunes générations) afin de faire comprendre les similitudes entre la régulation de la température dans l’océan et la régulation de la température corporelle chez l’humain, quelle action serait la plus pertinente ?',
                                                        'Le pilier SHARE implique une action globale : alerter les décideurs politiques pour encourager des politiques protectrices, sensibiliser le grand public à l’importance des régulations thermiques, et éduquer les jeunes générations pour assurer une compréhension durable. En rendant ces informations accessibles et en formant les citoyens de demain, on soutient la préservation des écosystèmes marins comme la stabilité de la température corporelle, deux facteurs clés pour le maintien de la vie.',
                                                        'SHARE', 'Communiquer auprès des décideurs politiques, informer le grand public par le biais de campagnes médiatiques, et intégrer l’éducation sur ces mécanismes dans les programmes scolaires.', NULL, 5),
                                                       -- Colonne d'eau
                                                       ('Dans le cadre du pilier ACT, qui vise à promouvoir des solutions durables aux impacts économiques, environnementaux et sociaux, quelle action serait la plus adaptée pour préserver la régulation thermique à la fois dans l’océan et dans le corps humain ?',
                                                        'Adopter des solutions durables et responsables – comme la réduction de la pollution, l’efficacité énergétique ou la préservation des ressources – permet de limiter les perturbations climatiques. Ainsi, en protégeant la régulation thermique des océans, on contribue également à un environnement sain, favorisant indirectement la stabilité du corps humain. Les approches durables, soutenues par le pilier ACT, participent à la fois à l’équilibre écologique et au bien-être global.',
                                                        'ACT', 'Soutenir des politiques réduisant la pollution et le gaspillage énergétique, tout en encourageant des pratiques durables pour maintenir la stabilité du climat et la santé des populations.', NULL, 6),
                                                       ('Comment le pilier SHARE peut-il contribuer à protéger la colonne d’eau des océans et le système circulatoire humain ?',
                                                        'Le pilier SHARE est essentiel pour protéger ces systèmes vitaux. En alertant les décideurs sur les menaces pesant sur la colonne d’eau et le système circulatoire, en sensibilisant le public à leur importance et en éduquant les jeunes générations, il est possible d’encourager des actions concrètes pour préserver les écosystèmes marins et la santé humaine.',
                                                        'SHARE', 'En alertant les décideurs sur les menaces, sensibilisant le public et éduquant les jeunes générations à leur importance.', NULL, 1),

                                                       ('Comment le pilier LEARN peut-il aider à mieux comprendre l’importance de la colonne d’eau et du système circulatoire humain ?',
                                                        'Le pilier LEARN encourage une enquête approfondie auprès des experts pour comprendre les processus complexes de la colonne d’eau et du système circulatoire humain. Ces études permettent de mieux appréhender leur importance dans l’équilibre écologique et biologique, et de sensibiliser à leur préservation.',
                                                        'LEARN', 'En enquêtant auprès des experts pour mieux comprendre leurs fonctions et leurs impacts sur l’environnement et la santé.', NULL, 1),

                                                       ('Comment le pilier ACT peut-il contribuer à préserver la colonne d’eau et le système circulatoire humain ?',
                                                        'Le pilier ACT vise à promouvoir des solutions durables pour protéger les écosystèmes marins et la santé humaine. En soutenant des initiatives qui préservent la colonne d’eau (comme la lutte contre la pollution des océans) et encouragent une meilleure santé cardiovasculaire (comme des modes de vie sains), il contribue à un impact économique, environnemental et social positif.',
                                                        'ACT', 'En soutenant des initiatives durables qui protègent les océans et encouragent une meilleure santé cardiovasculaire.', NULL, 1),

                                                       ('Comment le pilier ACT peut-il encourager la préservation de la colonne d’eau et du système circulatoire humain ?',
                                                        'Le pilier ACT se concentre sur la promotion de solutions durables, comme la lutte contre la pollution et la conservation des courants marins, pour préserver la colonne d’eau. De même, il encourage des pratiques de santé publique et des modes de vie équilibrés pour maintenir un système circulatoire sain, contribuant à des bénéfices économiques, environnementaux et sociaux durables.',
                                                        'ACT', 'En promouvant des actions durables qui protègent les océans et encouragent des modes de vie favorables à la santé cardiovasculaire.', NULL, 2),

                                                       ('Comment le pilier SHARE peut-il contribuer à protéger la colonne d’eau et le système circulatoire humain ?',
                                                        'Le pilier SHARE joue un rôle clé en alertant les décideurs sur l''importance de la colonne d’eau et du système circulatoire, en sensibilisant le grand public à leur fonctionnement essentiel et en éduquant les jeunes générations. Ces actions encouragent des décisions et comportements visant à préserver les écosystèmes marins et la santé humaine.',
                                                        'SHARE', 'En alertant les décideurs, sensibilisant le grand public et éduquant les jeunes générations sur leur importance et leur fonctionnement.', NULL, 2),

                                                       ('Comment le pilier LEARN peut-il contribuer à approfondir notre compréhension de la colonne d’eau et du système circulatoire humain ?',
                                                        'Le pilier LEARN encourage à enquêter auprès des experts scientifiques pour mieux comprendre les mécanismes complexes de la colonne d’eau et du système circulatoire humain. Ces recherches permettent d’approfondir notre connaissance de leur rôle essentiel dans la régulation de l’oxygène et des nutriments, ainsi que dans la préservation de la vie marine et humaine.',
                                                        'LEARN', 'En enquêtant auprès des experts scientifiques pour comprendre leurs rôles dans la régulation de l’oxygène et des nutriments.', NULL, 2),

                                                       ('Comment le pilier LEARN peut-il aider à comprendre et prévenir les dysfonctionnements de la colonne d’eau et du système circulatoire humain ?',
                                                        'Le pilier LEARN met en avant l’importance d’enquêter auprès des experts scientifiques pour comprendre les causes des dysfonctionnements, qu’il s’agisse de la colonne d’eau ou du système circulatoire humain. Ces recherches approfondies permettent d’identifier des solutions pour restaurer les équilibres écologiques et biologiques, contribuant ainsi à la protection des écosystèmes marins et à la santé humaine.',
                                                        'LEARN', 'En enquêtant auprès des experts pour identifier les causes des dysfonctionnements et proposer des solutions pour restaurer l’équilibre écologique et biologique.', NULL, 3),

                                                       ('Comment le pilier SHARE peut-il contribuer à sensibiliser sur les dysfonctionnements de la colonne d’eau et du système circulatoire humain ?',
                                                        'Le pilier SHARE joue un rôle essentiel en alertant les décideurs sur les conséquences des dysfonctionnements de la colonne d’eau et du système circulatoire, tout en sensibilisant le grand public et en éduquant les jeunes générations. Ces actions permettent de promouvoir une prise de conscience collective pour protéger les écosystèmes marins et la santé humaine.',
                                                        'SHARE', 'En alertant les décideurs et le grand public sur les impacts des perturbations écologiques et biologiques.', NULL, 3),

                                                       ('Comment le pilier ACT peut-il contribuer à réduire les impacts des dysfonctionnements de la colonne d’eau et du système circulatoire humain ?',
                                                        'Le pilier ACT vise à promouvoir des solutions durables pour réduire les impacts environnementaux et sociaux. En soutenant des initiatives pour lutter contre la pollution océanique et en encourageant des modes de vie sains pour préserver la santé circulatoire, ce pilier contribue à un équilibre économique, environnemental et social durable.',
                                                        'ACT', 'En soutenant des initiatives durables qui réduisent la pollution océanique et encouragent des modes de vie sains pour prévenir les maladies cardiovasculaires.', NULL, 3),

                                                       ('Comment le pilier ACT peut-il contribuer à protéger les récifs coralliens et renforcer le système immunitaire humain ?',
                                                        'Le pilier ACT encourage des actions durables qui réduisent la pollution, protègent les récifs coralliens et préservent la biodiversité marine. Simultanément, il promeut des modes de vie sains qui renforcent le système immunitaire humain, contribuant ainsi à un impact économique, environnemental et social équilibré et durable.',
                                                        'ACT', 'En promouvant des solutions durables, comme la réduction de la pollution et des modes de vie sains, pour préserver les récifs et renforcer l’immunité humaine.', NULL, 4),

                                                       ('Comment le pilier SHARE peut-il aider à protéger les récifs coralliens et sensibiliser à l’importance du système immunitaire humain ?',
                                                        'Le pilier SHARE est essentiel pour alerter les décideurs sur les dangers qui menacent les récifs coralliens et le système immunitaire humain. Il sensibilise le public à leur rôle vital et éduque les jeunes générations, créant ainsi une prise de conscience collective pour protéger les écosystèmes marins et la santé humaine.',
                                                        'SHARE', 'En alertant les décideurs sur les menaces, sensibilisant le public à leur rôle crucial, et éduquant les jeunes générations sur leur importance.', NULL, 4),

                                                       ('Comment le pilier LEARN peut-il aider à mieux comprendre le rôle des récifs coralliens et du système immunitaire humain ?',
                                                        'Le pilier LEARN met en avant l''importance de collaborer avec les experts scientifiques pour explorer les interactions complexes entre les récifs coralliens et les algues, ainsi que les mécanismes internes du système immunitaire humain. Ces investigations approfondies aident à mieux comprendre comment ces systèmes maintiennent l''équilibre écologique et biologique, essentiel à la vie marine et humaine.',
                                                        'LEARN', 'En enquêtant auprès des experts scientifiques pour étudier les interactions écologiques et biologiques qui permettent de maintenir un équilibre vital.', NULL, 4);


INSERT INTO incorrect_answers (question_id, answer) VALUES
                                                        (1, 'Faux'),
                                                        (2, 'Vrai'),
                                                        (3, 'Faux'),
                                                        (4, 'Faux'),
                                                        (5, 'Faux'),
                                                        (6, 'Vrai'),
                                                        (7, 'Faux'),
                                                        (8, 'Vrai'),
                                                        (9, 'Faux'),
                                                        (10, 'Vrai'),
                                                        (11, 'Faux'),
                                                        (12, 'Faux'),
                                                        (13, 'Faux'),
                                                        (14, 'Faux'),
                                                        (15, 'Faux'),
                                                        (16, 'Vrai'),
                                                        (17, 'Faux'),
                                                        (18, 'Vrai'),
                                                        (16, 'Vrai'),
                                                        (17, 'Faux'),
                                                        (18, 'Faux'),
                                                        (19, 'Faux'),
                                                        (20, 'Faux'),
                                                        (21, 'Faux'),
                                                        (22, 'Faux'),
                                                        (23, 'Faux'),
                                                        (24, 'Faux'),
                                                        (25, 'Faux'),
                                                        (26, 'Faux'),
                                                        (27, 'Faux'),
                                                        (28, 'Faux'),
                                                        (29, 'Faux'),
                                                        (30, 'Faux'),
                                                        (31, 'Faux'),
                                                        (32, 'Faux'),
                                                        (33, 'Faux'),
                                                        (34, 'Faux'),
                                                        (35, 'Vrai'),
                                                        (36, 'Faux'),
                                                        (37, 'Faux'),
                                                        (38, 'Vrai'),
                                                        (39, 'Faux'),
                                                        (40, 'Faux'),
                                                        (41, 'Vrai'),
                                                        (42, 'Faux'),
                                                        (43, 'Ignorer les enjeux environnementaux, en comptant sur la régulation naturelle.'),
                                                        (43, 'Sensibiliser uniquement les décideurs, sans éduquer le grand public.'),
                                                        (43, 'Se limiter à des actions ponctuelles sans informer ni éduquer.'),
                                                        (44, 'Augmenter sans limite l’exploitation des ressources marines pour stimuler l’économie'),
                                                        (44, 'Ignorer les déséquilibres écologiques et physiologiques tant qu’il n’y a pas de conséquence immédiate'),
                                                        (44, 'Développer des aliments transformés sans considération pour leur impact sur l’environnement ou la santé'),
                                                        (45, 'Se fier uniquement aux informations trouvées sur les réseaux sociaux.'),
                                                        (45, 'Observer l’océan et le corps humain sans aucune mesure scientifique.'),
                                                        (45, 'Faire appel à des intuitions personnelles sans validation extérieure.'),
                                                        (46, 'Se contenter de lire des articles de presse généralistes sans vérification.'),
                                                        (46, 'Se fier uniquement à des documentaires télévisés populaires.'),
                                                        (46, 'Comparer des images trouvées au hasard sur Internet.'),
                                                        (47, 'Se fier uniquement aux témoignages d’amateurs sur les réseaux sociaux.'),
                                                        (47, 'Consulter des documents internes d’entreprises pétrolières non vérifiés.'),
                                                        (47, 'Déduire les principes de régulation thermique à partir de simples observations visuelles, sans outils de mesure ni avis spécialisé.'),
                                                        (48, 'Garder ces informations pour soi, sans les communiquer.'),
                                                        (48, 'Informer uniquement quelques spécialistes.'),
                                                        (48, 'Diffuser ces informations uniquement par des supports complexes et peu accessibles.'),
                                                        (49, 'Diffuser ces informations uniquement au sein de laboratoires de recherche spécialisés.'),
                                                        (49, 'Se limiter à une discussion informelle entre quelques amis sans relais vers les institutions ni le public.'),
                                                        (49, 'Développer des documents techniques complexes, non accessibles au grand public et sans contact avec les instances décisionnelles.'),
                                                        (50, 'Augmenter les émissions de gaz à effet de serre afin de stimuler les courants marins.'),
                                                        (50, 'Laisser la régulation de la température mondiale aux seules fluctuations naturelles sans intervention humaine.'),
                                                        (50, 'Miser sur l’extraction intensive de ressources marines pour stimuler l’économie, sans égard aux conséquences environnementales.'),
                                                        (51,'En augmentant la production de nutriments pour compenser les perturbations.'),
                                                        (51,'En développant des technologies pour remplacer les courants marins et le cœur.'),
                                                        (51,'En concentrant les efforts uniquement sur les fonds marins et en ignorant les autres strates.'),
                                                        (52,'En remplaçant les courants marins et le cœur par des mécanismes artificiels.'),
                                                        (52,'En étudiant les interactions entre les courants marins et les veines humaines.'),
                                                        (52,'En développant des campagnes pour limiter l’utilisation des courants marins et réduire l’activité du cœur.'),
                                                        (53,'En promouvant des solutions technologiques pour remplacer les courants marins et le cœur.'),
                                                        (53,'En limitant les activités humaines pour éviter tout impact sur les courants marins et le système circulatoire.'),
                                                        (53,'En diminuant la sensibilisation publique pour réduire les attentes en matière de conservation et de santé.'),
                                                        (54,'En développant des solutions qui limitent la circulation des courants marins et réduisent le flux sanguin.'),
                                                        (54,'En remplaçant les courants marins par des systèmes artificiels pour mieux réguler le climat.'),
                                                        (54,'En concentrant les efforts uniquement sur les effets climatiques de la colonne d’eau, sans inclure les impacts humains.'),
                                                        (55,'En développant des campagnes pour réduire les échanges gazeux dans les océans et le flux sanguin dans le corps humain.'),
                                                        (55,'En remplaçant les courants marins et les artères par des technologies artificielles pour améliorer leur efficacité.'),
                                                        (55,'En concentrant les efforts sur l’étude des fonds marins et des organes internes sans sensibiliser les populations.'),
                                                        (56,'En étudiant comment les courants marins peuvent être contrôlés artificiellement.'),
                                                        (56,'En remplaçant les courants marins et les vaisseaux sanguins par des systèmes mécaniques pour améliorer leur efficacité.'),
                                                        (56,'En observant uniquement les impacts des perturbations sur les écosystèmes marins sans prendre en compte les implications humaines.'),
                                                        (57,'En étudiant les interactions entre la pollution marine et les pathologies humaines causées par des troubles circulatoires.'),
                                                        (57,'En remplaçant les courants marins et les artères humaines par des structures artificielles plus résistantes.'),
                                                        (57,'En concentrant les recherches uniquement sur les impacts visibles des dysfonctionnements, sans explorer leurs causes profondes.'),
                                                        (58,'En développant des technologies artificielles pour remplacer les courants marins et les artères humaines.'),
                                                        (58,'En éduquant uniquement les jeunes générations sur le fonctionnement des écosystèmes marins.'),
                                                        (58,'En limitant la sensibilisation aux seules zones marines affectées par la pollution plastique.'),
                                                        (59,'En promouvant des solutions technologiques pour remplacer les courants marins et les artères humaines par des systèmes artificiels.'),
                                                        (59,'En limitant les activités humaines dans les zones marines et les efforts médicaux pour soigner les troubles circulatoires.'),
                                                        (59,'En concentrant les efforts uniquement sur les impacts économiques des dysfonctionnements, sans considérer les effets environnementaux ou sociaux.'),
                                                        (60,'En remplaçant les coraux par des structures artificielles pour maintenir les écosystèmes marins.'),
                                                        (60,'En limitant la sensibilisation publique sur les récifs coralliens et le système immunitaire pour éviter des attentes irréalistes.'),
                                                        (60,'En concentrant les efforts uniquement sur la restauration des coraux, sans considérer leur lien avec l’écosystème.'),
                                                        (61,'En promouvant des solutions technologiques pour remplacer les coraux et les ganglions lymphatiques.'),
                                                        (61,'En concentrant les efforts uniquement sur les récifs coralliens, en ignorant les enjeux liés au système immunitaire.'),
                                                        (61,'En réduisant les actions publiques pour se concentrer uniquement sur les avancées scientifiques.'),
                                                        (62,'En remplaçant les récifs coralliens par des structures artificielles et les ganglions lymphatiques par des implants.'),
                                                        (62,'En concentrant les recherches uniquement sur la photosynthèse des algues et le rôle des globules blancs.'),
                                                        (62,'En observant uniquement les impacts visibles de leur dégradation sans explorer leurs mécanismes internes.');
