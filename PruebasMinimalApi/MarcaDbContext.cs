using Microsoft.EntityFrameworkCore;
using PruebasMinimalApi.Models;

namespace PruebasMinimalApi
{
    public class MarcaDbContext : DbContext
    {
        protected readonly IConfiguration Configuration;

        public MarcaDbContext(IConfiguration configuration)
        {
            Configuration = configuration;
        }

        protected override void OnConfiguring(DbContextOptionsBuilder options)
        {
            options.UseSqlServer(Configuration.GetConnectionString("ConexionDB_azure"));
        }

        public DbSet<Marca> Marca { get; set; }
    }
}
