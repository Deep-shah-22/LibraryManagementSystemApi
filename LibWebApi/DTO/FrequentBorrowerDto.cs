namespace LibWebApi.DTO
{
    public class FrequentBorrowerDto
    {
        public long MemberId { get; set; }
        public string Name { get; set; }
        public int BorrowedBookCount { get; set; }
    }
}
