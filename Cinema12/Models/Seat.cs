using System;
using System.Collections.Generic;
using System.Data.SqlClient;

namespace Cinema12.Models
{
    public class Seat
    {
        public int SeatId { get; set; }
        public string RowLetter { get; set; }
        public int SeatNumber { get; set; }

        public static List<Seat> GetSeatsList()
        {
            List<Seat> seats = new List<Seat>();

            using (SqlConnection connection = new SqlConnection(User.GetSessionUser().GetConnectionString()))
            {
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = connection;
                cmd.CommandText = "CINEMA.GetSeatsList";
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                connection.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                while (reader.Read())
                    seats.Add(new Seat()
                    {
                        SeatId = Convert.ToInt32(reader["SeatId"]),
                        RowLetter = (string)reader["RowLetter"],
                        SeatNumber = Convert.ToInt32(reader["SeatNumber"])
                    });
                return seats;
            }
        }

    }
}