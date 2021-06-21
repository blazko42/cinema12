using System;
using System.Collections.Generic;
using System.Data.SqlClient;

namespace Cinema12.Models
{
    public class MovieGenre
    {
        public int MovieGenreId { get; set; }
        public string Name { get; set; }

        public static List<MovieGenre> GetMovieGenresList()
        {
            List<MovieGenre> movieGenres = new List<MovieGenre>();


            using (SqlConnection connection = new SqlConnection(User.GetSessionUser().GetConnectionString()))
            {
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = connection;
                cmd.CommandText = "CINEMA.GetMovieGenres";
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                connection.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                while (reader.Read())
                    movieGenres.Add(new MovieGenre()
                    {
                        MovieGenreId = Convert.ToInt32(reader["MovieGenreId"]),
                        Name = (string)reader["Name"]
                    });
                return movieGenres;
            }
        }
    }
}