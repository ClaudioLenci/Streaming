using System.Data.SqlClient;

var builder = WebApplication.CreateBuilder(args);

var databaseUrl = builder.Configuration.GetValue<string>("DatabaseUrl");

// Add services to the container.
builder.Services.AddControllersWithViews();
builder.Services.AddSingleton(new SqlConnection(databaseUrl));

var app = builder.Build();

// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Home/Error");
}
app.UseStaticFiles();

app.UseRouting();

app.UseAuthorization();

app.MapControllerRoute(
    name: "default",
    pattern: "{controller=Home}/{action=Index}/{id?}");

app.Run();
