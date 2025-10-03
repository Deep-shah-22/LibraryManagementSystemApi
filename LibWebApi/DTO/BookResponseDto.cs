namespace LibWebApi.DTO
{
    public class BookResponseDto
    {
        public long BookId { get; set; }
        public string Title { get; set; }
        public string? Author { get; set; }
        public string? Isbn { get; set; }
        public DateTime? PublishedYear { get; set; }
        public int? AvailableCopies { get; set; }
        public string? AvailabilityStatus { get; set; }
    }
}
