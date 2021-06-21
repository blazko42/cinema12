using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Cinema12.Controllers
{
    public class AdminController : Controller
    {
        public ActionResult Index()
        {
            if (Models.User.GetSessionUser() == null || Models.User.GetSessionUser().IsAdmin() == false)
                Response.Redirect("/Home/Login");

            return View();
        }

        #region Manage Movies

        [HttpGet]
        public ActionResult Movies()
        {
            if (Models.User.GetSessionUser() == null || Models.User.GetSessionUser().IsAdmin() == false)
                Response.Redirect("/Home/Login");

            return View(Models.Movie.GetMoviesList());
        }

        [HttpGet]
        public ActionResult NewMovie(int? movieId)
        {
            if (Models.User.GetSessionUser() == null || Models.User.GetSessionUser().IsAdmin() == false)
                Response.Redirect("/Home/Login");

            if (movieId == null)
                return View(new Models.Movie());

            return View(Models.Movie.GetMovieEntry(movieId));
        }

        [HttpPost]
        public ActionResult NewMovie(Models.Movie movie)
        {
            if (Models.User.GetSessionUser() == null || Models.User.GetSessionUser().IsAdmin() == false)
                Response.Redirect("/Home/Login");

            if (Request.Files.Count > 0)
            {
                foreach (string fileName in Request.Files)
                {
                    HttpPostedFileBase file = Request.Files[fileName];

                    string fileExtension = fileName.Split('.').LastOrDefault();
                    int fileLength = file.ContentLength;
                    byte[] fileContent = new byte[fileLength];

                    using (Stream fileStream = file.InputStream)
                    {
                        fileStream.Read(fileContent, 0, fileLength);
                    }

                    movie.Poster = fileContent;
                }
            }

            if (movie.SaveMovie())
                return Redirect("Movies");

            return Redirect("Movies");
        }

        [HttpGet]
        public ActionResult DeleteMovie(int? movieId)
        {
            if (Models.User.GetSessionUser() == null || Models.User.GetSessionUser().IsAdmin() == false)
                Response.Redirect("/Home/Login");

            Models.Movie.DeleteMovie(movieId);

            return Redirect(Request.UrlReferrer.PathAndQuery);
        }

        public FileResult DisplayPoster(int movieId)
        {
            if (Models.User.GetSessionUser() == null)
                Response.Redirect("/Home/Login");

            string contentType = "image/png";
            byte[] poster = Models.Movie.GetPoster(movieId);
            return new FileStreamResult(new MemoryStream(poster), contentType);
        }

        #endregion

        #region Manage Schedules
        
        public ActionResult ScheduleMovie(int? movieId)
        {
            if (Models.User.GetSessionUser() == null || Models.User.GetSessionUser().IsAdmin() == false)
                Response.Redirect("/Home/Login");

            return View(Models.Schedule.GetMovieSchedule(movieId));
        }

        [HttpGet]
        public ActionResult NewSchedule(int? movieId, int? scheduleId)
        {
            if (Models.User.GetSessionUser() == null || Models.User.GetSessionUser().IsAdmin() == false)
                Response.Redirect("/Home/Login");

            if (scheduleId == null)
                return View(new Models.Schedule());

            return View(Models.Schedule.GetScheduleEntry(scheduleId));
        }

        [HttpPost]
        public ActionResult NewSchedule(Models.Schedule schedule)
        {
            if (Models.User.GetSessionUser() == null || Models.User.GetSessionUser().IsAdmin() == false)
                Response.Redirect("/Home/Login");

            if (schedule.SaveSchedule())
                return RedirectToAction("ScheduleMovie", new { movieId = schedule.MovieId });

            return RedirectToAction("ScheduleMovie", new { movieId = schedule.MovieId });
        }

        [HttpGet]
        public ActionResult DeleteSchedule(int? scheduleId)
        {
            if (Models.User.GetSessionUser() == null || Models.User.GetSessionUser().IsAdmin() == false)
                Response.Redirect("/Home/Login");

            Models.Schedule.DeleteSchedule(scheduleId);

            return Redirect(Request.UrlReferrer.PathAndQuery);
        }

        #endregion

        #region Manage Reservations

        [HttpGet]
        public ActionResult Reservations()
        {
            if (Models.User.GetSessionUser() == null || Models.User.GetSessionUser().IsAdmin() == false)
                Response.Redirect("/Home/Login");

            return View(Models.Reservation.GetReservationsList());
        }

        [HttpGet]
        public ActionResult DeleteReservation(int? reservationId)
        {
            if (Models.User.GetSessionUser() == null || Models.User.GetSessionUser().IsAdmin() == false)
                Response.Redirect("/Home/Login");

            Models.Reservation.DeleteReservation(reservationId);

            return Redirect(Request.UrlReferrer.PathAndQuery);
        }

        #endregion
    }
}