using System;
using System.Collections.Generic;
using System.Data.SqlClient;

namespace Cinema12.Models
{
    public class MovieRating
    {
        public int MovieRatingId { get; set; }
        public string Name { get; set; }
        public string Acronym { get; set; }
        public string Description { get; set; }

        public static List<MovieRating> GetMovieRatingsList()
        {
            List<MovieRating> movieRatings = new List<MovieRating>();

            using (SqlConnection connection = new SqlConnection(User.GetSessionUser().GetConnectionString()))
            {
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = connection;
                cmd.CommandText = "CINEMA.GetMovieRatings";
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                connection.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                while (reader.Read())
                    movieRatings.Add(new MovieRating()
                    {
                        MovieRatingId = Convert.ToInt32(reader["MovieRatingId"]),
                        Name = (string)reader["Name"],
                        Acronym = (string)reader["Acronym"],
                        Description = (string)reader["Description"]
                    });
                return movieRatings;
            }
        }
    }
}