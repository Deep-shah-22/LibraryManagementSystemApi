using LibWebApi.DTO;
using LibWebApi.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;

namespace LibWebApi.Controllers
{
    public class BooksController : Controller
    {
        private readonly LibDBContext _context;

        public BooksController(LibDBContext context)
        {
            _context = context;
        }

        [HttpPost("addbook")]
        public async Task<IActionResult> AddBook([FromBody] Book book)
        {
            var errorParam = new SqlParameter{
                ParameterName = "@ErrorMessage",
                SqlDbType = System.Data.SqlDbType.NVarChar,
                Size = 100,
                Direction = System.Data.ParameterDirection.Output
            };

            await _context.Database.ExecuteSqlRawAsync(
                "EXEC usp_AddBook @Title, @Author, @ISBN, @PublishedYear, @AvailableCopies, @ErrorMessage OUTPUT",
                new SqlParameter("@Title", book.Title),
                new SqlParameter("@Author", book.Author),
                new SqlParameter("@ISBN", book.Isbn),
                new SqlParameter("@PublishedYear", book.PublishedYear),
                new SqlParameter("@AvailableCopies", book.AvailableCopies),
                errorParam
            );

            string errorMessage = (string)errorParam.Value;

            if (!string.IsNullOrEmpty(errorMessage))
            {
                if (errorMessage.Contains("already exists", StringComparison.OrdinalIgnoreCase))
                    return Conflict(new { Message = errorMessage });
                return BadRequest(new { Message = errorMessage });
            }

            return Ok(new { Message = "Book added successfully" });
        }

        [HttpPut("edit/{id}")]
        public async Task<IActionResult> EditBook(long id, [FromBody] Book updatedBook)
        {
            var book = await _context.Books.FindAsync(id);

            if (book != null)
            {
                book.Title = updatedBook.Title;
                book.Author = updatedBook.Author;
                book.Isbn = updatedBook.Isbn;
                book.PublishedYear = updatedBook.PublishedYear;
                book.AvailableCopies = updatedBook.AvailableCopies;
            }

            try
            {
                await _context.SaveChangesAsync();
                return Ok(new { Message = "Book updated successfully" });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { Message = "Internal server error", Details = ex.Message });
            }
        }

        [HttpGet("getall")]
        public async Task<IActionResult> GetAll()
        {
            try
            {
                List<BookResponseDto> books = await _context.Database
                    .SqlQuery<BookResponseDto>($"EXEC usp_GetAllBooks")
                    .ToListAsync();

                return Ok(books);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { Message = "Internal server error", Details = ex.Message });
            }
        }

        [HttpGet("getallbymember/{memberId}")]
        public async Task<IActionResult> GetAllByMemberId(long memberId)
        {
            try
            {
                var books = await _context.Database
                    .SqlQuery<BorrowedBookDto>($"EXEC usp_GetAllBorrowedBooks_ByMemberId @MemberId={memberId}")
                    .ToListAsync();

                return Ok(books);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { Message = "Internal server error", Details = ex.Message });
            }
        }

    }
}
