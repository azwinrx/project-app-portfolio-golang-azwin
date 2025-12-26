-- =====================================================
-- PORTFOLIO WEB APPLICATION DATABASE SCHEMA
-- PostgreSQL Database Schema
-- =====================================================

-- Drop tables if exists (untuk development)
DROP TABLE IF EXISTS contact_messages CASCADE;
DROP TABLE IF EXISTS blog_comments CASCADE;
DROP TABLE IF EXISTS blog_posts CASCADE;
DROP TABLE IF EXISTS testimonials CASCADE;
DROP TABLE IF EXISTS project_images CASCADE;
DROP TABLE IF EXISTS projects CASCADE;
DROP TABLE IF EXISTS services CASCADE;
DROP TABLE IF EXISTS skills CASCADE;
DROP TABLE IF EXISTS experiences CASCADE;
DROP TABLE IF EXISTS education CASCADE;
DROP TABLE IF EXISTS social_media CASCADE;
DROP TABLE IF EXISTS profile CASCADE;

-- =====================================================
-- TABLE: profile
-- Menyimpan informasi pribadi untuk halaman About
-- =====================================================
CREATE TABLE profile (
    id SERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    title VARCHAR(150) NOT NULL,  -- e.g., "Full Stack Developer"
    bio TEXT NOT NULL,
    profile_image VARCHAR(255),
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(20),
    address TEXT,
    date_of_birth DATE,
    website VARCHAR(255),
    resume_url VARCHAR(255),  -- Link ke file CV/Resume
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =====================================================
-- TABLE: social_media
-- Menyimpan link sosial media
-- =====================================================
CREATE TABLE social_media (
    id SERIAL PRIMARY KEY,
    profile_id INTEGER REFERENCES profile(id) ON DELETE CASCADE,
    platform VARCHAR(50) NOT NULL,  -- e.g., "Facebook", "Twitter", "LinkedIn", "GitHub"
    url VARCHAR(255) NOT NULL,
    icon_class VARCHAR(100),  -- e.g., "fa fa-facebook"
    display_order INTEGER DEFAULT 0,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =====================================================
-- TABLE: education
-- Menyimpan riwayat pendidikan
-- =====================================================
CREATE TABLE education (
    id SERIAL PRIMARY KEY,
    profile_id INTEGER REFERENCES profile(id) ON DELETE CASCADE,
    institution VARCHAR(200) NOT NULL,
    degree VARCHAR(100) NOT NULL,  -- e.g., "Bachelor of Computer Science"
    field_of_study VARCHAR(100),
    start_date DATE NOT NULL,
    end_date DATE,  -- NULL jika masih berjalan
    grade VARCHAR(20),  -- e.g., "GPA 3.8"
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =====================================================
-- TABLE: experiences
-- Menyimpan pengalaman kerja
-- =====================================================
CREATE TABLE experiences (
    id SERIAL PRIMARY KEY,
    profile_id INTEGER REFERENCES profile(id) ON DELETE CASCADE,
    company_name VARCHAR(200) NOT NULL,
    position VARCHAR(100) NOT NULL,
    location VARCHAR(150),
    start_date DATE NOT NULL,
    end_date DATE,  -- NULL jika masih bekerja
    is_current BOOLEAN DEFAULT FALSE,
    description TEXT,
    responsibilities TEXT[],  -- Array untuk list tanggung jawab
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =====================================================
-- TABLE: skills
-- Menyimpan keahlian teknis
-- =====================================================
CREATE TABLE skills (
    id SERIAL PRIMARY KEY,
    profile_id INTEGER REFERENCES profile(id) ON DELETE CASCADE,
    skill_name VARCHAR(100) NOT NULL,
    category VARCHAR(50),  -- e.g., "Programming", "Framework", "Tools", "Soft Skills"
    proficiency_level INTEGER CHECK (proficiency_level BETWEEN 1 AND 100),  -- 1-100%
    years_of_experience INTEGER,
    display_order INTEGER DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =====================================================
-- TABLE: services
-- Menyimpan layanan yang ditawarkan (untuk halaman Services)
-- =====================================================
CREATE TABLE services (
    id SERIAL PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    description TEXT NOT NULL,
    icon_class VARCHAR(100),  -- e.g., "fa fa-code"
    image_url VARCHAR(255),
    price_range VARCHAR(100),  -- e.g., "$500 - $1000" atau "Contact for price"
    is_active BOOLEAN DEFAULT TRUE,
    display_order INTEGER DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =====================================================
-- TABLE: projects
-- Menyimpan daftar project portfolio
-- =====================================================
CREATE TABLE projects (
    id SERIAL PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    description TEXT NOT NULL,
    detailed_description TEXT,
    category VARCHAR(100) NOT NULL,  -- e.g., "Web Development", "Mobile App", "Design"
    client_name VARCHAR(150),
    project_url VARCHAR(255),  -- Link ke live project
    github_url VARCHAR(255),  -- Link ke repository
    thumbnail_image VARCHAR(255),
    start_date DATE,
    end_date DATE,
    status VARCHAR(50) DEFAULT 'completed',  -- e.g., "completed", "in-progress", "on-hold"
    technologies TEXT[],  -- Array teknologi yang digunakan
    is_featured BOOLEAN DEFAULT FALSE,
    view_count INTEGER DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =====================================================
-- TABLE: project_images
-- Menyimpan multiple images untuk setiap project
-- =====================================================
CREATE TABLE project_images (
    id SERIAL PRIMARY KEY,
    project_id INTEGER REFERENCES projects(id) ON DELETE CASCADE,
    image_url VARCHAR(255) NOT NULL,
    caption VARCHAR(255),
    display_order INTEGER DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =====================================================
-- TABLE: testimonials
-- Menyimpan testimoni dari klien
-- =====================================================
CREATE TABLE testimonials (
    id SERIAL PRIMARY KEY,
    client_name VARCHAR(100) NOT NULL,
    client_position VARCHAR(150),
    client_company VARCHAR(150),
    client_image VARCHAR(255),
    testimonial_text TEXT NOT NULL,
    rating INTEGER CHECK (rating BETWEEN 1 AND 5),
    is_approved BOOLEAN DEFAULT FALSE,
    display_order INTEGER DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =====================================================
-- TABLE: blog_posts
-- Menyimpan artikel blog
-- =====================================================
CREATE TABLE blog_posts (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    slug VARCHAR(255) NOT NULL UNIQUE,  -- untuk URL friendly
    content TEXT NOT NULL,
    excerpt TEXT,  -- Ringkasan artikel
    featured_image VARCHAR(255),
    author_name VARCHAR(100) NOT NULL,
    category VARCHAR(100),
    tags TEXT[],  -- Array of tags
    is_published BOOLEAN DEFAULT FALSE,
    published_at TIMESTAMP,
    view_count INTEGER DEFAULT 0,
    reading_time INTEGER,  -- Estimasi waktu baca dalam menit
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =====================================================
-- TABLE: blog_comments
-- Menyimpan komentar pada blog post
-- =====================================================
CREATE TABLE blog_comments (
    id SERIAL PRIMARY KEY,
    blog_post_id INTEGER REFERENCES blog_posts(id) ON DELETE CASCADE,
    commenter_name VARCHAR(100) NOT NULL,
    commenter_email VARCHAR(100) NOT NULL,
    commenter_website VARCHAR(255),
    comment_text TEXT NOT NULL,
    is_approved BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =====================================================
-- TABLE: contact_messages
-- Menyimpan pesan dari contact form
-- =====================================================
CREATE TABLE contact_messages (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    subject VARCHAR(200),
    message TEXT NOT NULL,
    phone VARCHAR(20),
    is_read BOOLEAN DEFAULT FALSE,
    is_replied BOOLEAN DEFAULT FALSE,
    ip_address VARCHAR(45),  -- untuk tracking dan spam prevention
    user_agent TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =====================================================
-- CREATE INDEXES untuk optimasi query
-- =====================================================

-- Index untuk pencarian dan filtering
CREATE INDEX idx_projects_category ON projects(category);
CREATE INDEX idx_projects_status ON projects(status);
CREATE INDEX idx_projects_featured ON projects(is_featured);
CREATE INDEX idx_blog_posts_slug ON blog_posts(slug);
CREATE INDEX idx_blog_posts_published ON blog_posts(is_published);
CREATE INDEX idx_blog_posts_category ON blog_posts(category);
CREATE INDEX idx_contact_messages_read ON contact_messages(is_read);
CREATE INDEX idx_skills_category ON skills(category);

-- Index untuk foreign keys
CREATE INDEX idx_social_media_profile_id ON social_media(profile_id);
CREATE INDEX idx_education_profile_id ON education(profile_id);
CREATE INDEX idx_experiences_profile_id ON experiences(profile_id);
CREATE INDEX idx_skills_profile_id ON skills(profile_id);
CREATE INDEX idx_project_images_project_id ON project_images(project_id);
CREATE INDEX idx_blog_comments_post_id ON blog_comments(blog_post_id);

-- =====================================================
-- INSERT SAMPLE DATA untuk testing
-- =====================================================

-- Insert profile data
INSERT INTO profile (full_name, title, bio, email, phone, address, profile_image, website)
VALUES (
    'Azwin Developer',
    'Android & Full Stack Developer',
    'Passionate developer with experience in building scalable web and mobile applications. Skilled in Kotlin, JavaScript, Golang, and PostgreSQL.',
    'azwinrifai321@gmail.com',
    '+62 888-8888-8888',
    'Bekasi, Indonesia',
    '/public/img/profile.png',
    'https://azwin.dev'
);

-- Insert social media
INSERT INTO social_media (profile_id, platform, url, icon_class, display_order)
VALUES 
    (1, 'GitHub', 'https://github.com/azwin', 'fa fa-github', 1),
    (1, 'LinkedIn', 'https://linkedin.com/in/azwin', 'fa fa-linkedin', 2),
    (1, 'Twitter', 'https://twitter.com/azwin', 'fa fa-twitter', 3),
    (1, 'Instagram', 'https://instagram.com/azwin', 'fa fa-instagram', 4);

-- Insert skills
INSERT INTO skills (profile_id, skill_name, category, proficiency_level, display_order)
VALUES 
    (1, 'Kotlin', 'Programming Language', 90, 1),
    (1, 'JavaScript', 'Programming Language', 85, 2),
    (1, 'Golang', 'Programming Language', 85, 3),
    (1, 'PostgreSQL', 'Database', 80, 4),
    (1, 'React', 'Framework', 85, 5),
    (1, 'Docker', 'Tools', 75, 6),
    (1, 'Git', 'Tools', 90, 7);
-- Insert experience
INSERT INTO experiences (profile_id, company_name, position, location, start_date, is_current, description)
VALUES (
    1,
    'Tech Company Indonesia',
    'Senior Backend Developer',
    'Jakarta, Indonesia',
    '2022-01-01',
    TRUE,
    'Leading backend development team, building scalable microservices architecture using Golang and PostgreSQL.'
);

-- Insert education
INSERT INTO education (profile_id, institution, degree, field_of_study, start_date, end_date, grade)
VALUES (
    1,
    'Monster University',
    'Bachelor of Computer Science',
    'Computer Science',
    '2015-09-01',
    '2019-06-01',
    'GPA 3.75'
);

-- Insert services
INSERT INTO services (title, description, icon_class, display_order, is_active)
VALUES 
    ('Web Development', 'Building responsive and scalable web applications using modern technologies.', 'fa fa-laptop', 1, TRUE),
    ('API Development', 'Creating RESTful APIs and microservices with Golang.', 'fa fa-code', 2, TRUE),
    ('Database Design', 'Designing efficient and normalized database schemas.', 'fa fa-database', 3, TRUE),
    ('Consulting', 'Technical consulting for architecture and best practices.', 'fa fa-comments', 4, TRUE);

-- Insert sample projects
INSERT INTO projects (title, description, detailed_description, category, github_url, thumbnail_image, technologies, is_featured, status, project_url)
VALUES
    (
        'Productive-Heroes',
        'Todo List and Pomodoro Timer with Gamification',
        'Productive android app that combining an Pomodoro timer and To Do List with gamification things, i made this project to help my self for managing my task and a simple timer to help when i study',
        'Android Development',
        'https://github.com/azwinrx/Productive-Heroes',
        '/public/img/portfolio/project1.png',
        ARRAY['Kotlin','Jetpack Compose'],
        TRUE,
        'completed',
        'https://github.com/azwinrx/Productive-Heroes/releases/tag/v1.0'
    ),
    (
        'LogicBase',
        'Mini project platform for learning programming concepts',
        'LogicBase is a mini project platform for helping people to understand about basic of programming, learning the concept, and do some quiz',
        'Web Development',
        'https://github.com/azwinrx/LogicBase',
        '/public/img/portfolio/project2.png',
        ARRAY['JavaScript','Node.js', 'React','Tailwind CSS','Supabase'],
        TRUE,
        'completed',
        'https://logicbase-demo.netlify.app/'
    ),
    (
        'JantungIn',
        'Capstone project for detection risk of heart disease',
        'JantungIn is a web application that can help users to detect the risk of heart disease using machine learning model, this project is my capstone project in CodingCamp 2025 powered by DBS Indonesia and Dicoding',
        'Web Development',
        'https://github.com/azwinrx/JantungIn',
        '/public/img/portfolio/project3.png',
        ARRAY['JavaScript','Node.js', 'Vue', 'Vite','Tailwind CSS','Hapi.js','TensorFlow.js','PostgreSQL'],
        TRUE,
        'completed',
        'https://jantungin.netlify.app/'
    ),
    (
        'WinChat',
        'A simple global-chat anonymous application',
        'WinChat is a simple global-chat anonymous application that built with golang and react, this app made to practice real-time application with websocket technology',
        'Web Development',
        'https://github.com/azwinrx/winchat',
        '/public/img/portfolio/project4.png',
        ARRAY['JavaScript', 'Firebase'],
        TRUE,
        'completed',
        'https://winchat.vercel.app/'
    );;

-- Insert blog posts
INSERT INTO blog_posts (title, slug, content, excerpt, author_name, category, tags, is_published, published_at)
VALUES 
    ('Getting Started with Golang', 'getting-started-with-golang', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Full content here...', 'Learn the basics of Golang programming language', 'Azwin Developer', 'Programming', ARRAY['golang', 'programming', 'tutorial'], TRUE, CURRENT_TIMESTAMP),
    ('Building REST APIs with Golang', 'building-rest-apis-golang', 'Comprehensive guide to building RESTful APIs using Golang and Gin framework.', 'Step-by-step tutorial for creating robust REST APIs', 'Azwin Developer', 'Web Development', ARRAY['golang', 'api', 'rest'], TRUE, CURRENT_TIMESTAMP),
    ('Database Design Best Practices', 'database-design-best-practices', 'Learn about normalization, indexing, and optimization techniques for databases.', 'Essential principles for effective database design', 'Azwin Developer', 'Database', ARRAY['database', 'design', 'postgresql'], TRUE, CURRENT_TIMESTAMP);

-- Insert testimonials
INSERT INTO testimonials (client_name, client_position, client_company, testimonial_text, rating, is_approved)
VALUES 
    ('John Doe', 'CTO', 'Tech Startup Inc', 'Excellent work! The project was delivered on time and exceeded our expectations.', 5, TRUE),
    ('Sarah Johnson', 'Project Manager', 'Digital Solutions Ltd', 'Professional and reliable. Highly recommend for any development project.', 5, TRUE),
    ('Mike Chen', 'CEO', 'Innovate Corp', 'Great communication and quality code. Will definitely work together again.', 4, TRUE);

-- Insert blog comments
INSERT INTO blog_comments (blog_post_id, commenter_name, commenter_email, comment_text, is_approved)
VALUES 
    (1, 'Dev Enthusiast', 'dev@example.com', 'Great introduction to Golang! Very helpful for beginners.', TRUE),
    (2, 'API Developer', 'api.dev@email.com', 'Excellent guide on REST APIs. The examples are clear and practical.', TRUE),
    (3, 'Database Admin', 'dba@company.com', 'Good overview of database design principles. Would love to see more examples.', TRUE);

-- =====================================================
-- CREATE FUNCTIONS untuk auto-update timestamp
-- =====================================================

CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Apply trigger untuk semua tabel yang punya updated_at
CREATE TRIGGER update_profile_updated_at BEFORE UPDATE ON profile
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_education_updated_at BEFORE UPDATE ON education
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_experiences_updated_at BEFORE UPDATE ON experiences
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_skills_updated_at BEFORE UPDATE ON skills
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_services_updated_at BEFORE UPDATE ON services
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_projects_updated_at BEFORE UPDATE ON projects
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_testimonials_updated_at BEFORE UPDATE ON testimonials
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_blog_posts_updated_at BEFORE UPDATE ON blog_posts
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- =====================================================
-- END OF SCHEMA
-- =====================================================
