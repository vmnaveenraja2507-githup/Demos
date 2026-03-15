-- Create Database
CREATE DATABASE IF NOT EXISTS internship_management;
USE internship_management;

-- =========================
-- STUDENT TABLE
-- =========================
CREATE TABLE student (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    department VARCHAR(50) NOT NULL,
    year INT NOT NULL CHECK (year BETWEEN 1 AND 5),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =========================
-- ADMIN TABLE
-- =========================
CREATE TABLE admin (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =========================
-- INTERNSHIP TABLE
-- =========================
CREATE TABLE internship (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    company VARCHAR(100) NOT NULL,
    location VARCHAR(100),
    duration VARCHAR(50),
    stipend VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =========================
-- SKILLS TABLE
-- =========================
CREATE TABLE skills (
    id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    skill_name VARCHAR(100) NOT NULL,
    skill_level ENUM('Beginner','Intermediate','Advanced') DEFAULT 'Beginner',

    CONSTRAINT fk_skill_student
    FOREIGN KEY (student_id)
    REFERENCES student(id)
    ON DELETE CASCADE
);

-- =========================
-- APPLICATION TABLE
-- =========================
CREATE TABLE application (
    id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    internship_id INT NOT NULL,
    status ENUM('Applied','Shortlisted','Selected','Rejected') DEFAULT 'Applied',
    applied_date DATE DEFAULT (CURRENT_DATE),

    CONSTRAINT fk_application_student
    FOREIGN KEY (student_id)
    REFERENCES student(id)
    ON DELETE CASCADE,

    CONSTRAINT fk_application_internship
    FOREIGN KEY (internship_id)
    REFERENCES internship(id)
    ON DELETE CASCADE,

    UNIQUE(student_id, internship_id)
);

-- =========================
-- NOTIFICATION TABLE
-- =========================
CREATE TABLE notification (
    id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    message TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_notification_student
    FOREIGN KEY (student_id)
    REFERENCES student(id)
    ON DELETE CASCADE
);

-- =========================
-- INDEXES FOR PERFORMANCE
-- =========================
CREATE INDEX idx_student_email ON student(email);
CREATE INDEX idx_application_status ON application(status);
