using System;
using System.Collections.Generic;
using System.Data.SqlClient;

namespace Cinema12.Models
{
    public class Movie
    {
        public int MovieId { get; set; }
        public string Title { get; set; }
        public int? Duration { get; set; }
        public int Genre { get; set; }
        public int Rating { get; set; }
        public string Distribution { get; set; }
        public string Description { get; set; }
        public byte[] Poster { get; set; }
        public string Trailer { get; set; }
        public DateTime StartDate { get; set; }
        public DateTime EndDate { get; set; }

        public static List<Movie> GetMoviesList()
        {
            List<Movie> movies = new List<Movie>();

            using (SqlConnection connection = new SqlConnection(User.GetSessionUser().GetConnectionString()))
            {
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = connection;
                cmd.CommandText = "CINEMA.GetMovies";
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                connection.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                while (reader.Read())
                    movies.Add(new Movie()
                    {
                        MovieId = Convert.ToInt32(reader["MovieId"]),
                        Title = (string)reader["Title"],
                        Duration = Convert.ToInt32(reader["Duration"]),
                        Genre = Convert.ToInt32(reader["Genre"]),
                        Rating = Convert.ToInt32(reader["Rating"]),
                        Distribution = (string)reader["Distribution"],
                        Description = (string)reader["Description"],
                        Poster = (byte[])reader["Poster"],
                        Trailer = (string)reader["Trailer"],
                        StartDate = (DateTime)reader["StartDate"],
                        EndDate = (DateTime)reader["EndDate"]
                    });
                return movies;
            }
        }

        internal static Movie GetMovieEntry(int? movieId)
        {
            using (SqlConnection connection = new SqlConnection(User.GetSessionUser().GetConnectionString()))
            {
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = connection;
                cmd.CommandText = "CINEMA.GetMovieEntry";
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("MovieId", movieId);
                connection.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                while (reader.Read())
                    return new Movie()
                    {
                        MovieId = Convert.ToInt32(reader["MovieId"]),
                        Title = (string)reader["Title"],
                        Duration = Convert.ToInt32(reader["Duration"]),
                        Genre = Convert.ToInt32(reader["Genre"]),
                        Rating = Convert.ToInt32(reader["Rating"]),
                        Distribution = (string)reader["Distribution"],
                        Description = (string)reader["Description"],
                        Poster = (byte[])reader["Poster"],
                        Trailer = (string)reader["Trailer"],
                        StartDate = (DateTime)reader["StartDate"],
                        EndDate = (DateTime)reader["EndDate"]
                    };
                return null;
            }
        }

        public static byte[] GetPoster(int movieId)
        {
            using (SqlConnection connection = new SqlConnection(User.GetSessionUser().GetConnectionString()))
            {
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = connection;
                cmd.CommandText = "CINEMA.GetPoster";
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("MovieId", movieId);
                connection.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    return (byte[])reader["Poster"];
                }
            }

            return null;
        }

        internal static void DeleteMovie(int? movieId)
        {
            using (SqlConnection connection = new SqlConnection(User.GetSessionUser().GetConnectionString()))
            {
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = connection;
                cmd.CommandText = "CINEMA.DeleteMovie";
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("MovieId", movieId);
                connection.Open();
                cmd.ExecuteNonQuery();
            }
        }

        internal bool SaveMovie()
        {
            using (SqlConnection connection = new SqlConnection(User.GetSessionUser().GetConnectionString()))
            {
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = connection;
                cmd.CommandText = "CINEMA.SaveMovie";
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("MovieId", MovieId);
                cmd.Parameters.AddWithValue("Title", Title);
                cmd.Parameters.AddWithValue("Duration", Duration);
                cmd.Parameters.AddWithValue("Genre", Genre);
                cmd.Parameters.AddWithValue("Rating", Rating);
                cmd.Parameters.AddWithValue("Distribution", Distribution);
                cmd.Parameters.AddWithValue("Description", Description);
                cmd.Parameters.AddWithValue("Poster", Poster);
                cmd.Parameters.AddWithValue("Trailer", Trailer);
                cmd.Parameters.AddWithValue("StartDate", StartDate);
                cmd.Parameters.AddWithValue("EndDate", EndDate);
                connection.Open();
                cmd.ExecuteNonQuery();

                return true;
            }
        }
    }
}