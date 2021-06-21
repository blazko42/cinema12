using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;

namespace Cinema12.Models
{
    public class TestingModule
    {
        public int NoOfThreads { get; set; }
        public int ScheduleId { get; set; }
        public string IsolationLevel { get; set; }
        public static List<string> IsolationLevels { get; set; }
        public static double ExecutionTime { get; set; }
        internal static String LockThreads = "";

        public static List<string> GetIsolationLevels()
        {
            IsolationLevels = new List<string>();
            IsolationLevels.Add("Read Uncommitted");
            IsolationLevels.Add("Read Committed");
            IsolationLevels.Add("Repeatable Read");
            IsolationLevels.Add("Snapshot");
            IsolationLevels.Add("Serializable");

            return IsolationLevels;
        }

        internal void ReadUncommitted()
        {
            try
            {

                SqlConnectionStringBuilder builder = new SqlConnectionStringBuilder(ConfigurationManager.ConnectionStrings["MultithreadingConnection"].ConnectionString);
                using (SqlConnection connection = new SqlConnection(builder.ToString()))
                {
                    SqlCommand cmd = new SqlCommand();
                    cmd.CommandTimeout = 0;
                    cmd.Connection = connection;
                    cmd.CommandText = "CINEMA.ReadUncommitted";
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("ScheduleId", ScheduleId);
                    cmd.Parameters.AddWithValue("Name", "David Dumitru");
                    cmd.Parameters.AddWithValue("Telephone", "0752145862");
                    cmd.Parameters.AddWithValue("NoOfSeats", 1);
                    connection.Open();
                    lock (LockThreads)
                    cmd.ExecuteNonQuery();
                }
            }
            catch(Exception ex)
            {
                throw ex;
            }
        }

        internal void ReadCommitted()
        {
            try
            {
                SqlConnectionStringBuilder builder = new SqlConnectionStringBuilder(ConfigurationManager.ConnectionStrings["MultithreadingConnection"].ConnectionString);
                using (SqlConnection connection = new SqlConnection(builder.ToString()))
                {
                    SqlCommand cmd = new SqlCommand();
                    cmd.CommandTimeout = 0;
                    cmd.Connection = connection;
                    cmd.CommandText = "CINEMA.ReadCommitted";
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("ScheduleId", ScheduleId);
                    cmd.Parameters.AddWithValue("Name", "David Dumitru");
                    cmd.Parameters.AddWithValue("Telephone", "0752145862");
                    cmd.Parameters.AddWithValue("NoOfSeats", 1);
                    connection.Open();
                    lock (LockThreads)
                    cmd.ExecuteNonQuery();
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        internal void RepeatableRead()
        {
            try
            {
                SqlConnectionStringBuilder builder = new SqlConnectionStringBuilder(ConfigurationManager.ConnectionStrings["MultithreadingConnection"].ConnectionString);
                using (SqlConnection connection = new SqlConnection(builder.ToString()))
                {
                    SqlCommand cmd = new SqlCommand();
                    cmd.CommandTimeout = 0;
                    cmd.Connection = connection;
                    cmd.CommandText = "CINEMA.RepeatableRead";
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("ScheduleId", ScheduleId);
                    cmd.Parameters.AddWithValue("Name", "David Dumitru");
                    cmd.Parameters.AddWithValue("Telephone", "0752145862");
                    cmd.Parameters.AddWithValue("NoOfSeats", 1);
                    connection.Open();
                    lock (LockThreads)
                    cmd.ExecuteNonQuery();
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        internal void Snapshot()
        {
            try
            {
                SqlConnectionStringBuilder builder = new SqlConnectionStringBuilder(ConfigurationManager.ConnectionStrings["MultithreadingConnection"].ConnectionString);
                using (SqlConnection connection = new SqlConnection(builder.ToString()))
                {
                    SqlCommand cmd = new SqlCommand();
                    cmd.CommandTimeout = 0;
                    cmd.Connection = connection;
                    cmd.CommandText = "CINEMA.Snapshot";
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("ScheduleId", ScheduleId);
                    cmd.Parameters.AddWithValue("Name", "David Dumitru");
                    cmd.Parameters.AddWithValue("Telephone", "0752145862");
                    cmd.Parameters.AddWithValue("NoOfSeats", 1);
                    connection.Open();
                    lock (LockThreads)
                    cmd.ExecuteNonQuery();
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        internal void Serializable()
        {
            try
            {
                SqlConnectionStringBuilder builder = new SqlConnectionStringBuilder(ConfigurationManager.ConnectionStrings["MultithreadingConnection"].ConnectionString);
                using (SqlConnection connection = new SqlConnection(builder.ToString()))
                {
                    SqlCommand cmd = new SqlCommand();
                    cmd.CommandTimeout = 0;
                    cmd.Connection = connection;
                    cmd.CommandText = "CINEMA.Serializable";
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("ScheduleId", ScheduleId);
                    cmd.Parameters.AddWithValue("Name", "David Dumitru");
                    cmd.Parameters.AddWithValue("Telephone", "0752145862");
                    cmd.Parameters.AddWithValue("NoOfSeats", 1);
                    connection.Open();
                    lock (LockThreads)
                    cmd.ExecuteNonQuery();
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}
