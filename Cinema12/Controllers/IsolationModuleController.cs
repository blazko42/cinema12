using System.Diagnostics;
using System.Threading;
using System.Web.Mvc;

namespace Cinema12.Controllers
{
    public class IsolationModuleController : Controller
    {
        [HttpGet]
        public ActionResult MovieList()
        {
            if (Models.User.GetSessionUser() == null || Models.User.GetSessionUser().IsAdmin() == false)
                Response.Redirect("/Home/Login");

            return View(Models.Movie.GetMoviesList());
        }

        [HttpGet]
        public ActionResult TestModule()
        {
            if (Models.User.GetSessionUser() == null || Models.User.GetSessionUser().IsAdmin() == false)
                Response.Redirect("/Home/Login");

            return View(new Models.TestingModule());
        }

        [HttpPost]
        public ActionResult TestModule(Models.TestingModule module)
        {
            if (Models.User.GetSessionUser() == null || Models.User.GetSessionUser().IsAdmin() == false)
                Response.Redirect("/Home/Login");

            Stopwatch timer = Stopwatch.StartNew();

            lock (Models.TestingModule.LockThreads)
            {
                if (module.IsolationLevel == "Read Uncommitted")
                {
                    for (int th = 0; th < module.NoOfThreads; th++)
                    {
                        Thread thread = new Thread(new ThreadStart(module.ReadUncommitted));
                        thread.Start();
                    }
                }

                if (module.IsolationLevel == "Read Committed")
                {
                    for (int th = 0; th < module.NoOfThreads; th++)
                    {
                        Thread thread = new Thread(new ThreadStart(module.ReadCommitted));
                        thread.Start();
                    }
                }

                if (module.IsolationLevel == "Repeatable Read")
                {
                    for (int th = 0; th < module.NoOfThreads; th++)
                    {
                        Thread thread = new Thread(new ThreadStart(module.RepeatableRead));
                        thread.Start();
                    }
                }

                if (module.IsolationLevel == "Snapshot")
                {
                    for (int th = 0; th < module.NoOfThreads; th++)
                    {
                        Thread thread = new Thread(new ThreadStart(module.Snapshot));
                        thread.Start();
                    }
                }

                if (module.IsolationLevel == "Serializable")
                {
                    for (int th = 0; th < module.NoOfThreads; th++)
                    {
                        Thread thread = new Thread(new ThreadStart(module.Serializable));
                        thread.Start();
                    }
                }
            }

            timer.Stop();
            Models.TestingModule.ExecutionTime = (double)(timer.ElapsedMilliseconds) * 0.001;

           return RedirectToAction("Reservations", "Admin", Models.Reservation.GetReservationsList());
        }
    }
}