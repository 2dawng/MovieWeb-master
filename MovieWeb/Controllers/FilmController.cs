using Microsoft.AspNetCore.Mvc;
using MovieWeb.Models;
using MovieWeb.ViewModels;
using MovieWeb.Models.Authentication; // Update this line

namespace WebPhimBTL.Controllers
{
    public class FilmController : Controller
    {
        private readonly MovieDbContext _dbphimContext = new MovieDbContext();
        [HttpGet]
        public IActionResult InfoFilm(int filmCode)
        {
            int id = 0;
            string name = "";
            string anhdaidien = "";
            if (HttpContext.Session.GetString("UserName") != null)
            {
                id = (int)HttpContext.Session.GetInt32("id");
                anhdaidien = HttpContext.Session.GetString("AnhDaiDien");
                name = HttpContext.Session.GetString("UserName");
            }
            else if (HttpContext.Session.GetString("Admin") != null)
            {
                id = (int)HttpContext.Session.GetInt32("id");
                name = HttpContext.Session.GetString("Admin");
                anhdaidien = HttpContext.Session.GetString("AnhDaiDien");
            }

            var film1 = _dbphimContext.TPhims.Find(filmCode);
            var episodeList = _dbphimContext.Episodes.Where(x => x.MaPhim == filmCode)
                .OrderBy(x => x.SoTapPhim).ToList();
            ViewBag.Anh = anhdaidien;
            ViewBag.Name = name;
            ViewBag.ID = id;
            InfoFilm film = new InfoFilm()
            {
                film = (TPhim)film1,
                episodeList = episodeList
            };
            return View(film);
        }
    }
}