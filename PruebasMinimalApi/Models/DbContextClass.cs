using Microsoft.EntityFrameworkCore;

namespace PruebasMinimalApi.Models
{
    public class DbContextClass : DbContext
    {
        protected readonly IConfiguration Configuration;

        public DbContextClass(IConfiguration configuration)
        {
            Configuration = configuration;
        }

        protected override void OnConfiguring(DbContextOptionsBuilder options)
        {
            options.UseSqlServer(Configuration.GetConnectionString("BackendConexion"));
        }

        public DbSet<Canal> Canal { get; set; }
    }
}
