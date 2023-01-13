CREATE DATABASE Exam
GO
USE Exam 
GO 


--Tạo Bảng
CREATE TABLE Department(
	Departid INT PRIMARY KEY,
	DepartName VARCHAR(50) NOT NULL,
	Description VARCHAR(100) NOT NULL,
)
GO

CREATE TABLE Employee (
	EmpCode CHAR(6) PRIMARY KEY,
	FirstName VARCHAR(30) NOT NULL,
	LastName VARCHAR(30) NOT NULL,
	Birthday SMALLDATETIME NOT NULL,
	Gender BIT DEFAULT '1',
	Address VARCHAR(100),
	DepartID INT,
	Salary MONEY,
	CONSTRAINT fk FOREIGN KEY (DepartID) REFERENCES Department(Departid)
)
GO 


--Thêm Thông Tin 
INSERT INTO Department (Departid, DepartName, Description) 
	VALUES (1, 'IT', 'Công Nghệ Thông Tin');


INSERT INTO Department (Departid, DepartName, Description) 
	VALUES (2, 'HC', 'Hành Chính');


INSERT INTO Department (Departid, DepartName, Description) 
	VALUES (3, 'KT', 'Kế Toán');


INSERT INTO Employee (EmpCode, FirstName, LastName, Birthday, Gender, Address, DepartID, Salary) 
	VALUES ('E1', 'Ngọc Long', 'Lý', '0123456789', '15-05-1996', 1 , 'HÀ NỘI', 1,5000000);

INSERT INTO Employee (EmpCode, FirstName, LastName, Birthday, Gender, Address, DepartID, Salary) 
	VALUES ('E2', 'Huyền Ngọc', 'Đào', '9876543210', '16-02-2000', 0 , 'Hà Nội', 2, 5000000);

INSERT INTO Employee (EmpCode, FirstName, LastName, Birthday, Gender, Address, DepartID, Salary) 
	VALUES ('E3', 'Ngọc Sang', 'Nguyễn', '0123459876', '01-10-1996', 1, 'Hưng Yên', 1, 5000000);


--Tăng lương nhân viên 10%
UPDATE Employee SET Salary = Salary * 1.1;

--Thêm Check cho cột Salaty 
ALTER TABLE Employee ADD CHECK (Salary > 0);

--Tạo bảng View
SELECT Department.DepartName, Employee.Empcode, Employee.FirstName, Employee.LastName
	FROM Department INNER JOIN Employee ON Department.DepartID = Employee.DepartID;

--Tạo Unique 
CREATE UNIQUE INDEX namedIX_DepartmentName
	ON Department(DepartName)

CREATE PROCEDURE sp_getAllEmp (IN Departid INT)
	BEGIN 
		SELECT * FROM Employee
		WHERE DepartID = Departid;
	END;

--Tạo Trigger
CREATE TRIGGER tg_chkBirtday
On Employee AFTER INSERT, UPDATE AS
	BEGIN 
		IF EXISTS (SELECT 1 FROM inserted WHERE Birthday <=23)
			BEGIN 
				RAISERROR ('Value of birtday colum must be greater than 23', 16, 1);
				ROLLBACK TRANSACTION;
			END
	END
	

