using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using MovieWeb.Models;
using MovieWeb.Models.API;
using MovieWeb.Type;
using System.Data;
using Microsoft.Extensions.Configuration;

namespace WebPhimBTL.Controllers.APIController
{
    [Route("api/v1/[controller]")]
    [ApiController]
    public class CommentAPIController : ControllerBase
    {
        private readonly IConfiguration _configuration;

        public CommentAPIController(IConfiguration configuration)
        {
            _configuration = configuration;
        }

        MovieDbContext dbphimContext = new MovieDbContext();
        [HttpGet()]
        public IEnumerable<CommentAPI> Get([FromQuery] int maphim)
        {
            var listComment =
               (from cmt in dbphimContext.Comments
                join TaiKhoan in dbphimContext.TaiKhoans
                on cmt.MaTaiKhoan equals TaiKhoan.MaTaiKhoan
                where cmt.MaPhim == maphim && TaiKhoan.IsDeleted == 0
                select new CommentAPI(cmt.MaComment, TaiKhoan.MaTaiKhoan, TaiKhoan.TenTaiKhoan, TaiKhoan.Anh, cmt.NoiDung, cmt.ThoiGianCmt)).ToList();

            return listComment;
        }
        [HttpPost]
        public CommentType Post([FromBody] CommentType cmt)
        {
            DataTable table = new DataTable();
            table.Columns.Add("MaPhim", typeof(int));
            table.Columns.Add("MaTaiKhoan", typeof(int));
            table.Columns.Add("NoiDung", typeof(string));
            table.Columns.Add("ThoiGianCmt", typeof(DateTime));

            DataRow row1 = table.NewRow();

            row1["MaPhim"] = cmt.MaPhim;
            row1["MaTaiKhoan"] = cmt.MaTaiKhoan;
            row1["NoiDung"] = cmt.NoiDung;
            row1["ThoiGianCmt"] = cmt.ThoiGianCmt;

            table.Rows.Add(row1);

            SqlParameter param = new SqlParameter("@udtCommentType", SqlDbType.Structured);
            param.Value = table;
            param.TypeName = "udtCommentType";

            string connectionString = _configuration.GetConnectionString("MovieDbContext");
            using (var dbphimContext = new SqlConnection(connectionString))
            {
                dbphimContext.Open();
                using (var command = new SqlCommand("EXEC insertComment @udtCommentType", dbphimContext))
                {
                    command.Parameters.Add(param);
                    command.ExecuteNonQuery();
                }
            }

            return cmt;
        }
        [HttpPut]
        public StringResult Put([FromBody] StringResult content, [FromQuery] int cmtCode)
        {
            string connectionString = _configuration.GetConnectionString("MovieDbContext");

            using (SqlConnection sql = new SqlConnection(connectionString))
            {
                sql.Open();
                using (SqlCommand sqlCommand = new SqlCommand("putcomment", sql))
                {
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.Parameters.AddWithValue("@content", content.Result);
                    sqlCommand.Parameters.AddWithValue("@cmtCode", cmtCode);
                    sqlCommand.ExecuteNonQuery();
                }
            }

            return content;
        }
        [HttpDelete]
        public StringResult Delete([FromQuery] int cmtCode)
        {
            string connectionString = _configuration.GetConnectionString("MovieDbContext");

            SqlConnection sql = new SqlConnection(connectionString);
            sql.Open();
            SqlCommand sqlCommand = new SqlCommand("Deletecomment", sql);
            sqlCommand.CommandType = CommandType.StoredProcedure;
            sqlCommand.Parameters.AddWithValue("@cmtCode", cmtCode);
            sqlCommand.ExecuteNonQuery();
            return new StringResult(cmtCode.ToString());
        }
        [HttpGet("numcmt")]
        public async Task<StringResult> GetNumCmt([FromQuery] int maphim)
        {
            string connectionString = _configuration.GetConnectionString("MovieDbContext");

            SqlConnection sql = new SqlConnection(connectionString);
            sql.Open();
            SqlCommand sqlCommand = new SqlCommand("numcomment", sql);
            sqlCommand.CommandType = CommandType.StoredProcedure;
            sqlCommand.Parameters.AddWithValue("@maphim", maphim);
            var num = await sqlCommand.ExecuteReaderAsync();
            int cmt = 0;
            if (num.HasRows)
            {
                num.Read();
                cmt = num.GetInt32(0);
            }
            return new StringResult(cmt.ToString());
        }
    }
}
