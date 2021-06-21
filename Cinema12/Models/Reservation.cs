using System;
using System.Collections.Generic;
using System.Data.SqlClient;

namespace Cinema12.Models
{
    public class Reservation
    {
        public int ReservationId { get; set; }
        public int ScheduleId { get; set; }
        public int TicketsLeft { get; set; }
        public DateTime FromDate { get; set; }
        public DateTime ToDate { get; set; }
        public int MovieId { get; set; }
        public string MovieName { get; set; }
        public int TheatreId { get; set; }
        public string TheatreName { get; set; }
        public int SeatId { get; set; }
        public List<Seat> Seats { get; set; }
        public string ClientName { get; set; }
        public string ClientTelephone { get; set; }
        public int NoOfSeats { get; set; } = 1;

        public static List<Reservation> GetReservationsList()
        {
            List<Reservation> reservations = new List<Reservation>();
            Reservation r;

            using (SqlConnection connection = new SqlConnection(User.GetSessionUser().GetConnectionString()))
            {
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = connection;
                cmd.CommandText = "CINEMA.GetReservationsList";
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                connection.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    r = new Reservation()
                    {
                        ReservationId = Convert.ToInt32(reader["ReservationId"]),
                        ScheduleId = Convert.ToInt32(reader["ScheduleId"]),
                        TicketsLeft = Convert.ToInt32(reader["TicketsLeft"]),
                        FromDate = (DateTime)reader["FromDate"],
                        ToDate = (DateTime)reader["ToDate"],
                        MovieId = Convert.ToInt32(reader["MovieId"]),
                        MovieName = (string)reader["MovieName"],
                        TheatreId = Convert.ToInt32(reader["TheatreId"]),
                        TheatreName = (string)reader["TheatreName"],
                        ClientName = (string)reader["ClientName"],
                        ClientTelephone = (string)reader["ClientTelephone"],
                        NoOfSeats = Convert.ToInt32(reader["NoOfSeats"]),
                    };
                    r.GetReservedSeats(r.ReservationId);
                    reservations.Add(r);
                }

                return reservations;
            }
        }

        internal static void DeleteReservation(int? reservationId)
        {
            using (SqlConnection connection = new SqlConnection(User.GetSessionUser().GetConnectionString()))
            {
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = connection;
                cmd.CommandText = "CINEMA.DeleteReservation";
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("ReservationId", reservationId);
                connection.Open();
                cmd.ExecuteNonQuery();
            }
        }

        internal bool SaveReservation()
        {
            using (SqlConnection connection = new SqlConnection(User.GetSessionUser().GetConnectionString()))
            {
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = connection;
                cmd.CommandText = "CINEMA.SaveReservation";
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("ScheduleId", ScheduleId);
                cmd.Parameters.AddWithValue("Name", ClientName);
                cmd.Parameters.AddWithValue("Telephone", ClientTelephone);
                cmd.Parameters.AddWithValue("NoOfSeats", NoOfSeats);
                cmd.Parameters.AddWithValue("SeatId", SeatId);
                connection.Open();
                cmd.ExecuteNonQuery();
                return true;
            }

        }

        void GetReservedSeats(int? reservationId)
        {
            Seats = new List<Seat>();

            using (SqlConnection connection = new SqlConnection(User.GetSessionUser().GetConnectionString()))
            {
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = connection;
                cmd.CommandText = "CINEMA.GetReservedSeats";
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("ReservationId", reservationId);
                connection.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                while (reader.Read())
                    Seats.Add(new Seat()
                    {
                        SeatId = Convert.ToInt32(reader["SeatId"]),
                        RowLetter = (string)reader["RowLetter"],
                        SeatNumber = Convert.ToInt32(reader["SeatNumber"])
                    });
            }
        }
    }
}