using Microsoft.EntityFrameworkCore;
using PruebasMinimalApi.Models;

namespace PruebasMinimalApi
{
    public class BeerDb: DbContext
    {
        public BeerDb(DbContextOptions<BeerDb> options ):base(options) { }

        public DbSet<Beer> beers => Set<Beer>(); 

    }
}
