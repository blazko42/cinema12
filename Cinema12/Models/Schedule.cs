using System;
using System.Collections.Generic;
using System.Data.SqlClient;

namespace Cinema12.Models
{
    public class Schedule
    {
        public int ScheduleId { get; set; }
        public int TheatreId { get; set; }
        public string TheatreName { get; set; }
        public int MovieId { get; set; }
        public string MovieName { get; set; }
        public DateTime StartDate { get; set; }
        public DateTime EndDate { get; set; }
        public int TicketsLeft { get; set; } = 1000;
        public DateTime FromDate { get; set; }
        public DateTime ToDate { get; set; }

        public static List<Schedule> GetMovieSchedule(int? movieId)
        {
            List<Schedule> schedule = new List<Schedule>();

            using (SqlConnection connection = new SqlConnection(User.GetSessionUser().GetConnectionString()))
            {
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = connection;
                cmd.CommandText = "CINEMA.GetMovieSchedule";
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("MovieId", movieId);
                connection.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                while (reader.Read())
                    schedule.Add(new Schedule()
                    {
                        ScheduleId = Convert.ToInt32(reader["ScheduleId"]),
                        TheatreId = Convert.ToInt32(reader["TheatreId"]),
                        TheatreName = (string)reader["TheatreName"],
                        MovieId = Convert.ToInt32(reader["MovieId"]),
                        MovieName = (string)reader["MovieName"],
                        StartDate = (DateTime)reader["StartDate"],
                        EndDate = (DateTime)reader["EndDate"],
                        TicketsLeft = Convert.ToInt32(reader["TicketsLeft"]),
                        FromDate = (DateTime)reader["FromDate"],
                        ToDate = (DateTime)reader["ToDate"]
                    });
                return schedule;
            }
        }

        internal static Schedule GetScheduleEntry(int? scheduleId)
        {
            using (SqlConnection connection = new SqlConnection(User.GetSessionUser().GetConnectionString()))
            {
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = connection;
                cmd.CommandText = "CINEMA.GetScheduleEntry";
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("ScheduleId", scheduleId);
                connection.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                while (reader.Read())
                    return new Schedule()
                    {
                        ScheduleId = Convert.ToInt32(reader["ScheduleId"]),
                        TheatreId = Convert.ToInt32(reader["TheatreId"]),
                        TheatreName = (string)reader["TheatreName"],
                        MovieId = Convert.ToInt32(reader["MovieId"]),
                        MovieName = (string)reader["MovieName"],
                        StartDate = (DateTime)reader["StartDate"],
                        EndDate = (DateTime)reader["EndDate"],
                        TicketsLeft = Convert.ToInt32(reader["TicketsLeft"]),
                        FromDate = (DateTime)reader["FromDate"],
                        ToDate = (DateTime)reader["ToDate"]
                    };
                return null;
            }
        }

        internal static void DeleteSchedule(int? scheduleId)
        {
            using (SqlConnection connection = new SqlConnection(User.GetSessionUser().GetConnectionString()))
            {
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = connection;
                cmd.CommandText = "CINEMA.DeleteSchedule";
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("ScheduleId", scheduleId);
                connection.Open();
                cmd.ExecuteNonQuery();
            }
        }

        internal bool SaveSchedule()
        {
            using (SqlConnection connection = new SqlConnection(User.GetSessionUser().GetConnectionString()))
            {
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = connection;
                cmd.CommandText = "CINEMA.SaveSchedule";
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("ScheduleId", ScheduleId);
                cmd.Parameters.AddWithValue("TheatreId", TheatreId);
                cmd.Parameters.AddWithValue("MovieId", MovieId);
                cmd.Parameters.AddWithValue("TicketsLeft", TicketsLeft);
                cmd.Parameters.AddWithValue("FromDate", FromDate);
                cmd.Parameters.AddWithValue("ToDate", ToDate);
                connection.Open();
                cmd.ExecuteNonQuery();

                return true;
            }
        }

    }
}