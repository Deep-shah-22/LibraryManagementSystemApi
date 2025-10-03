USE LibDB
Go

CREATE TABLE Books (
    BookId BIGINT PRIMARY KEY IDENTITY(1,1) ,
    Title NVARCHAR(50),
    Author NVARCHAR(50),
    ISBN NVARCHAR(13) NOT NULL UNIQUE,
    PublishedYear DATETIME,
    AvailableCopies INT
);

CREATE TABLE Members (
    MemberId BIGINT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(50),
    Email NVARCHAR(50) NOT NULL UNIQUE,
    Phone NVARCHAR(15),
    DateJoined DATETIME
);

CREATE TABLE BorrowRecords (
    BorrowId BIGINT PRIMARY KEY IDENTITY(1,1),
    MemberId BIGINT,
    BookId BIGINT,
    BorrowDate DATETIME,
    ReturnDate DATETIME,
    IsReturned BIT
);

INSERT INTO Books (Title, Author, ISBN, PublishedYear, AvailableCopies) VALUES
('The Silent Patient', 'Alex Michaelides', '9781250301697', '2019-02-05', 5),
('Educated', 'Tara Westover', '9780399590504', '2018-02-20', 3),
('Where the Crawdads Sing', 'Delia Owens', '9780735219106', '2018-08-14', 0),
('Atomic Habits', 'James Clear', '9780735211292', '2018-10-16', 10),
('Becoming', 'Michelle Obama', '9781524763138', '2018-11-13', 4),
('The Midnight Library', 'Matt Haig', '9780525559474', '2020-09-29', 6),
('The Alchemist', 'Paulo Coelho', '9780061122415', '1993-05-01', 8),
('1984', 'George Orwell', '9780451524935', '1950-07-01', 12),
('The Book Thief', 'Markus Zusak', '9780375842207', '2005-03-14', 2),
('Sapiens', 'Yuval Noah Harari', '9780062316097', '2015-02-10', 9);

INSERT INTO Members (Name, Email, Phone, DateJoined) VALUES
('Alice Johnson', 'alice.johnson@example.com', '555-123-4567', '2022-01-15'),
('Bob Smith', 'bob.smith@example.com', '555-234-5678', '2022-02-20'),
('Charlie Brown', 'charlie.brown@example.com', '555-345-6789', '2022-03-10'),
('Diana Prince', 'diana.prince@example.com', '555-456-7890', '2022-04-05'),
('Ethan Hunt', 'ethan.hunt@example.com', '555-567-8901', '2022-05-25'),
('Fiona Gallagher', 'fiona.gallagher@example.com', '555-678-9012', '2022-06-30'),
('George Miller', 'george.miller@example.com', '555-789-0123', '2022-07-18'),
('Hannah Lee', 'hannah.lee@example.com', '555-890-1234', '2022-08-22'),
('Isaac Newton', 'isaac.newton@example.com', '555-901-2345', '2022-09-14'),
('Jenny Thomas', 'jenny.thomas@example.com', '555-012-3456', '2022-10-10');

INSERT INTO BorrowRecords (MemberId, BookId, BorrowDate, ReturnDate, IsReturned) VALUES
(1, 3, '2025-09-15', NULL, 0),
(2, 5, '2025-08-10', NULL, 0),
(3, 1, '2025-07-05', '2025-07-20', 1),
(4, 7, '2025-06-18', NULL, 0),
(5, 2, '2025-08-25', '2025-09-05', 1),
(6, 9, '2025-05-30', NULL, 0),
(7, 4, '2025-09-01', '2025-09-10', 1),
(8, 6, '2025-07-22', NULL, 0),
(9, 8, '2025-06-12', '2025-06-25', 1),
(10, 10, '2025-08-01', NULL, 0),
(4, 2, '2025-07-10', '2025-07-25', 1),
(3, 4, '2025-09-01', NULL, 0),
(6, 6, '2025-06-19', '2025-07-03', 1),
(2, 2, '2025-08-24', NULL, 0),
(8, 9, '2025-08-09', '2025-08-19', 1),
(9, 5, '2025-07-02', NULL, 0),
(10, 8, '2025-06-01', '2025-06-20', 1),
(1, 1, '2025-08-18', NULL, 0),
(3, 7, '2025-09-05', '2025-09-18', 1),
(7, 9, '2025-09-26', NULL, 0),
(5, 6, '2025-06-10', '2025-06-25', 1),
(6, 1, '2025-09-15', NULL, 0),
(2, 9, '2025-07-27', '2025-08-05', 1),
(7, 2, '2025-06-29', NULL, 0),
(4, 6, '2025-08-11', '2025-08-27', 1),
(8, 2, '2025-10-01', NULL, 0),
(9, 1, '2025-05-15', '2025-06-01', 1),
(10, 5, '2025-09-19', NULL, 0),
(1, 9, '2025-08-05', '2025-08-15', 1),
(2, 6, '2025-06-21', NULL, 0),
(3, 10, '2025-07-30', '2025-08-10', 1),
(4, 1, '2025-09-21', NULL, 0),
(5, 9, '2025-06-18', '2025-07-01', 1),
(6, 7, '2025-09-03', NULL, 0),
(7, 10, '2025-07-12', '2025-07-22', 1),
(8, 3, '2025-08-07', NULL, 0),
(9, 6, '2025-06-15', '2025-07-01', 1),
(10, 2, '2025-07-18', NULL, 0),
(1, 6, '2025-05-28', '2025-06-15', 1),
(2, 8, '2025-08-29', NULL, 0),
(3, 2, '2025-06-08', '2025-06-20', 1),
(4, 10, '2025-09-02', NULL, 0),
(5, 4, '2025-07-24', '2025-08-02', 1),
(6, 3, '2025-07-05', NULL, 0),
(7, 6, '2025-06-12', '2025-06-28', 1),
(8, 5, '2025-08-13', NULL, 0),
(9, 2, '2025-05-20', '2025-06-05', 1),
(10, 4, '2025-06-25', NULL, 0),
(1, 8, '2025-09-18', '2025-09-19', 1),
(2, 10, '2025-07-14', NULL, 0)


------- Top 5 most borrowed books

CREATE OR ALTER PROCEDURE usp_GetTop5MostBorrowedBooks
AS
BEGIN
	SELECT TOP 5 b.BookId, b.Title, Count(br.BookId) as BorrowCount FROM Books b INNER JOIN BorrowRecords br ON b.BookId = br.BookId GROUP BY b.BookId, b.Title ORDER BY BorrowCount DESC
END

------- members who borrowed more than 3 books in the last month

CREATE OR ALTER PROCEDURE usp_GetRecentFrequentBorrowers
AS
BEGIN
	SELECT m.MemberId,m.Name, COUNT(BookId) BorrowedBookCount FROM Members m 
	INNER JOIN BorrowRecords br ON m.MemberId = br.MemberId
	WHERE br.BorrowDate >= DATEADD(MONTH, -1, GETDATE()) 
	GROUP BY m.MemberId, m.Name HAVING (COUNT(br.BookId) > 3) 
END


------- SP to return books that are overdue (borrowdate + 14 days) and isreturned = 0

CREATE OR ALTER PROCEDURE usp_GetOverdueBooks
AS
BEGIN
	SELECT b.BookId, m.MemberId, br.BorrowId, b.Title, m.Name AS BorrowedBy, m.Phone, m.Email, BorrowDate AS BorrowedOn, 
	'Not Returned' AS Status, CAST(DATEDIFF(DAY, BorrowDate, GETDATE()) AS NVARCHAR) + ' Days' AS OverDue FROM BorrowRecords br 
	INNER JOIN Books b ON br.BookId = b.BookId
	INNER JOIN Members m ON br.MemberId = m.MemberId
	WHERE IsReturned = 0 AND DATEDIFF(DAY, BorrowDate, GETDATE()) >= 14
	ORDER BY m.Name
END

------- Get all books currently borrowed by a given member

CREATE OR ALTER PROCEDURE usp_GetAllBorrowedBooks_ByMemberId
@MemberId BIGINT
AS
BEGIN 
	SELECT b.BookId, br.BorrowId, b.Title FROM BorrowRecords br
	INNER JOIN Books b ON br.BookId = b.BookId
	WHERE br.MemberId = @MemberId AND IsReturned = 0
END

------------------ insert book sp

CREATE OR ALTER PROCEDURE usp_AddBook(
@Title NVARCHAR(50),
@Author NVARCHAR(50),
@ISBN NVARCHAR(13),
@PublishedYear DATETIME,
@AvailableCopies INT,
@ErrorMessage NVARCHAR(100) OUTPUT
)
AS
BEGIN
SET @ErrorMessage = '';
	BEGIN TRY
		IF NOT EXISTS(SELECT 1 FROM Books WHERE ISBN = @ISBN)
		BEGIN
			INSERT INTO Books (Title, Author, ISBN, PublishedYear, AvailableCopies) VALUES
			(@Title,@Author,@ISBN,@PublishedYear,@AvailableCopies)
		END
		ELSE
		BEGIN
			SET @ErrorMessage = 'Book Already Exists'
		END
	END TRY
	BEGIN CATCH
		SET @ErrorMessage = 'Error Occured While Adding New Book: ' + ERROR_MESSAGE();
	END CATCH
END

------- insert members sp

CREATE OR ALTER PROCEDURE usp_AddMember
@Name NVARCHAR(50),
@Email NVARCHAR(50),
@Phone NVARCHAR(15),
@DateJoined DATETIME,
@ErrorMessage NVARCHAR(100) OUTPUT
AS
BEGIN
    SET @ErrorMessage = '';

    BEGIN TRY
        IF NOT EXISTS(SELECT 1 FROM Members WHERE Email = @Email)
        BEGIN
            INSERT INTO Members(Name, Email, Phone, DateJoined)
            VALUES (@Name, @Email, @Phone, @DateJoined);
        END
        ELSE
        BEGIN
            SET @ErrorMessage = 'Member Already Exists';
        END
    END TRY
    BEGIN CATCH
        SET @ErrorMessage = 'Error Occurred While Adding New Member: ' + ERROR_MESSAGE();
    END CATCH
END

------- insert issued book entry sp

CREATE OR ALTER PROCEDURE usp_BookIssued(
    @MemberId BIGINT,
    @BookId BIGINT,
    @ErrorMessage NVARCHAR(100) OUTPUT
)
AS
BEGIN
    SET @ErrorMessage = '';

    BEGIN TRY
        BEGIN TRANSACTION;

        IF EXISTS(SELECT 1 FROM Books WHERE BookId = @BookId AND AvailableCopies <> 0)
        BEGIN
            INSERT INTO BorrowRecords(MemberId, BookId, BorrowDate, IsReturned) 
            VALUES (@MemberId, @BookId, GETDATE(), 0);

            UPDATE Books 
            SET AvailableCopies = AvailableCopies - 1 
            WHERE BookId = @BookId;

            COMMIT TRANSACTION;
        END
        ELSE
        BEGIN
            SET @ErrorMessage = 'Book Unavailable';
            ROLLBACK TRANSACTION;
        END
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
        SET @ErrorMessage = 'Error Occurred While Issuing Book: ' + ERROR_MESSAGE();
    END CATCH
END

------ Get all books with availability status

CREATE OR ALTER PROCEDURE usp_GetAllBooks
AS
BEGIN
	SELECT BookId, Title, Author, ISBN, PublishedYear, AvailableCopies, 
	CASE WHEN Coalesce(AvailableCopies, 0) <> 0 THEN 'Available'
	ELSE 'Unavailable' END AS AvailabilityStatus
	FROM Books
END

------Return borrowed book

CREATE OR ALTER PROCEDURE usp_ReturnBook
@BorrowId BIGINT,
@BookId BIGINT,
@ErrorMessage NVARCHAR(100) OUTPUT
AS
BEGIN
SET @ErrorMessage = '';
	BEGIN TRY
		BEGIN TRANSACTION;
			IF EXISTS (SELECT 1 FROM BorrowRecords WHERE IsReturned = 0 AND BorrowId = @BorrowId AND BookId = @BookId)
			BEGIN
				UPDATE BorrowRecords Set ReturnDate = GETDATE(), IsReturned = 1 WHERE BorrowId = @BorrowId
				UPDATE Books set AvailableCopies = (AvailableCopies + 1) WHERE BookId = @BookId
			COMMIT;
			END
			ELSE
			BEGIN
				SET @ErrorMessage = 'Invalid attempt'
			END
	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
		SET @ErrorMessage = 'Error Occured While Returning the Book: ' + ERROR_MESSAGE();
	END CATCH
END