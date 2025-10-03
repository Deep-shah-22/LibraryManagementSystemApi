namespace LibWebApi.DTO
{
    public class OverdueBookDto
    {
        public string Title { get; set; }
        public string BorrowedBy { get; set; }
        public string? Phone { get; set; }
        public string? Email { get; set; }
        public DateTime BorrowedOn { get; set; }
        public string Status { get; set; } // e.g., "Not Returned"
        public string OverDue { get; set; } // e.g., "5 Days"
    }
}
