namespace LibWebApi.DTO
{
    public class TopBorrowedBookDto
    {
        public long BookId { get; set; }
        public string Title { get; set; }
        public int BorrowCount { get; set; }
    }
}
