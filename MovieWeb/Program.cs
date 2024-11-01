using Microsoft.EntityFrameworkCore;
using MovieWeb.Models;
using MovieWeb.Repository;

var builder = WebApplication.CreateBuilder(args);
var ConnectString = builder.Configuration.GetConnectionString("MovieDbContext");
builder.Services.AddDbContext<MovieDbContext>(x => x.UseSqlServer(ConnectString));
builder.Services.AddScoped<IPhimRepository, PhimRepository>();
builder.Services.AddScoped<ITheLoaiRespository, TheLoaiRespository>();

// Register IHttpContextAccessor
builder.Services.AddHttpContextAccessor();

// Add services to the container.
builder.Services.AddControllersWithViews();
builder.Services.AddSession();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Home/Error");
    // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
    app.UseHsts();
}

app.UseHttpsRedirection();
app.UseStaticFiles();

app.UseRouting();

app.UseAuthorization();

app.UseSession();

app.MapControllerRoute(
    name: "default",
    pattern: "{controller=Home}/{action=Index}/{id?}");

app.Run();
