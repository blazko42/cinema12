using System.Web.Mvc;

namespace Cinema12.Controllers
{
    public class NowPlayingController : Controller
    {
        [HttpGet]
        public ActionResult Movies()
        {
            return View(Models.Movie.GetMoviesList());
        }

        #region Reservations

        [HttpGet]
        public ActionResult ReserveTicket(int? movieId)
        {
            return View(new Models.Reservation());
        }

        [HttpPost]
        public ActionResult ReserveTicket(Models.Reservation reservation)
        {
            if (reservation.SaveReservation())
                return RedirectToAction("Movies");

            return Redirect(Request.UrlReferrer.PathAndQuery);
        }

        #endregion
    }
}