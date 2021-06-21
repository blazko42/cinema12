using System;
using System.Collections.Generic;
using System.Data.SqlClient;

namespace Cinema12.Models
{
    public class Theatre
    {
        public int TheatreId { get; set; }
        public string Name { get; set; }

        public static List<Theatre> GetTheatreName()
        {
            List<Theatre> theatres = new List<Theatre>();

            using (SqlConnection connection = new SqlConnection(User.GetSessionUser().GetConnectionString()))
            {
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = connection;
                cmd.CommandText = "CINEMA.GetTheatreName";
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                connection.Open();

                SqlDataReader reader = cmd.ExecuteReader();
                while (reader.Read())
                    theatres.Add(new Theatre()
                    {
                        TheatreId = Convert.ToInt32(reader["TheatreId"]),
                        Name = (string)reader["Name"]
                    });
                return theatres;
            }
        }
    }
}