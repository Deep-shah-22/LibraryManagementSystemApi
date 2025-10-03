using System.Text.RegularExpressions;
using LibWebApi.DTO;
using LibWebApi.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;

namespace LibWebApi.Controllers
{
    public class MemberController : Controller
    {
        private readonly LibDBContext _context;

        public MemberController(LibDBContext context)
        {
            _context = context;
        }

        [HttpPost("addmember")]
        public async Task<IActionResult> AddMember([FromBody] Member member)
        {
            string emailPattern = @"^[^@\s]+@[^@\s]+\.[^@\s]+$";
            if (!Regex.IsMatch(member.Email ?? "", emailPattern))
            {
                return BadRequest(new { Message = "Invalid email format" });
            }

            var errorParam = new SqlParameter
            {
                ParameterName = "@ErrorMessage",
                SqlDbType = System.Data.SqlDbType.NVarChar,
                Size = 100,
                Direction = System.Data.ParameterDirection.Output
            };

            try
            {
                await _context.Database.ExecuteSqlRawAsync(
                        "EXEC usp_AddMember @Name, @Email, @Phone, @DateJoined, @ErrorMessage OUTPUT",
                        new SqlParameter("@Name", member.Name),
                        new SqlParameter("@Email", member.Email),
                        new SqlParameter("@Phone", member.Phone),
                        new SqlParameter("@DateJoined", member.DateJoined ?? DateTime.Now),
                        errorParam
                );

                string errorMessage = errorParam.Value as string;

                if (!string.IsNullOrEmpty(errorMessage))
                    return BadRequest(new { Message = errorMessage });

                return Ok(new { Message = "Member added successfully" });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { Message = "Internal server error", Details = ex.Message });
            }
        }

        [HttpPut("editmember/{id}")]
        public async Task<IActionResult> EditMember(long id, [FromBody] Member updatedMember)
        {
            string emailPattern = @"^[^@\s]+@[^@\s]+\.[^@\s]+$";
            if (!Regex.IsMatch(updatedMember.Email ?? "", emailPattern))
                return BadRequest(new { Message = "Invalid email format" });

            var member = await _context.Members.FindAsync(id);

            if (member != null)
            {
                member.Name = updatedMember.Name;
                member.Email = updatedMember.Email;
                member.Phone = updatedMember.Phone;
                member.DateJoined = updatedMember.DateJoined ?? member.DateJoined;
            }

            try
            {
                await _context.SaveChangesAsync();
                return Ok(new { Message = "Member updated successfully" });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { Message = "Internal server error", Details = ex.Message });
            }
        }


        [HttpPost("borrowbook")]
        public async Task<IActionResult> BorrowBook([FromBody] BorrowRecord br)
        {
            var errorParam = new SqlParameter
            {
                ParameterName = "@ErrorMessage",
                SqlDbType = System.Data.SqlDbType.NVarChar,
                Size = 100,
                Direction = System.Data.ParameterDirection.Output
            };

            try
            {
                await _context.Database.ExecuteSqlRawAsync(
                        "EXEC usp_BookIssued @MemberId, @BookId, @ErrorMessage OUTPUT",
                        new SqlParameter("@MemberId", br.MemberId),
                        new SqlParameter("@BookId", br.BookId),
                        errorParam
                );

                string errorMessage = (string)errorParam.Value;

                if (!string.IsNullOrEmpty(errorMessage))
                    return BadRequest(new { Message = errorMessage });

                return Ok(new { Message = "Book Issued successfully" });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { Message = "Internal server error", Details = ex.Message });
            }
        }

        [HttpPost("returnbook")]
        public async Task<IActionResult> ReturnBook([FromBody] BorrowRecord br)
        {
            var errorParam = new SqlParameter
            {
                ParameterName = "@ErrorMessage",
                SqlDbType = System.Data.SqlDbType.NVarChar,
                Size = 100,
                Direction = System.Data.ParameterDirection.Output
            };

            try
            {
                await _context.Database.ExecuteSqlRawAsync(
                        "EXEC usp_ReturnBook @BorrowId, @BookId, @ErrorMessage OUTPUT",
                        new SqlParameter("@BorrowId", br.BorrowId),
                        new SqlParameter("@BookId", br.BookId),
                        errorParam
                );

                string errorMessage = (string)errorParam.Value;

                if (!string.IsNullOrEmpty(errorMessage))
                    return BadRequest(new { Message = errorMessage });

                return Ok(new { Message = "Book returned successfully" });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { Message = "Internal server error", Details = ex.Message });
            }
        }

        [HttpGet("getfrequentMembers")]
        public async Task<IActionResult> GetFrequentMembers()
        {
            try
            {
                List<FrequentBorrowerDto> books = await _context.Database
                    .SqlQuery<FrequentBorrowerDto>($"EXEC usp_GetRecentFrequentBorrowers")
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
