using LibWebApi.DTO;
using LibWebApi.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace LibWebApi.Controllers
{
    public class InventoryController : Controller
    {
        private readonly LibDBContext _context;

        public InventoryController(LibDBContext context)
        {
            _context = context;
        }

        [HttpGet("gettopborrowedbooks")]
        public async Task<IActionResult> GetTopBorrowedBooks()
        {
            try
            {
                List<TopBorrowedBookDto> books = await _context.Database
                    .SqlQuery<TopBorrowedBookDto>($"EXEC usp_GetTop5MostBorrowedBooks")
                    .ToListAsync();

                return Ok(books);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { Message = "Internal server error", Details = ex.Message });
            }
        }

        [HttpGet("getoverduelist")]
        public async Task<IActionResult> GetOverdueList()
        {
            try
            {
                List<OverdueBookDto> books = await _context.Database
                    .SqlQuery<OverdueBookDto>($"EXEC usp_GetOverdueBooks")
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
