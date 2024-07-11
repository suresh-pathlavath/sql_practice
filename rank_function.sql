SELECT * FROM students;
SELECT name,score,  rank() OVER(ORDER BY score DESC) as topper from students;

/*
CREATE TABLE students (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    score INT
);

-- Insert some sample data
INSERT INTO students (name, score) VALUES
('Alice', 85),
('Bob', 90),
('Charlie', 78),
('David', 95),
('Emma', 82),
('Frank', 88),
('Grace', 79),
('Henry', 92);
*/