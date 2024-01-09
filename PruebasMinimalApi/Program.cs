using Microsoft.EntityFrameworkCore;
using PruebasMinimalApi;
using PruebasMinimalApi.Modelo;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

//Add dbContext, here you can we are using In-memory database.
builder.Services.AddDbContext<BeerDb>(opt => opt.UseInMemoryDatabase("Beer")); //mismo nombre de la clase Beer

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

//---------------EJEMPLO SIMPLE------------------------------------------
app.MapGet("/", () => "Hello World");

//-----------------------------------------------------------------------
//---------------EJEMPLO CRUD CON BD VOLATIL=> NUGGETS: EFC.INMEMORY / EFC.DIAGNOSTICS-----------------------------
app.MapPost("/beer", async (Beer beers, BeerDb db) =>
{
    db.beers.Add(beers);
    await db.SaveChangesAsync();
    return Results.Created($"/beer/{beers.beerId}", beers);
});
//----------------------------------------------------------
app.MapGet("/beers", async (BeerDb db) =>
await db.beers.ToListAsync());
//----------------------------------------------------------
app.MapPut("/beer/{id}", async (int id, Beer beerinput, BeerDb db) =>
{
    var beer = await db.beers.FindAsync(id);
    if (beer is null) return Results.NotFound();
    beer.Name = beerinput.Name;
    await db.SaveChangesAsync();
    return Results.NoContent();
});
//----------------------------------------------------------
app.MapDelete("/beer/{id}", async (int id,  BeerDb db) =>
{
    if(await db.beers.FindAsync(id) is Beer beer)
    { 
        db.beers.Remove(beer);
        await db.SaveChangesAsync();
        return Results.Ok(beer);
    }
    return Results.NotFound();
});

//-----------------------------------------------------------------------
//---------------EJEMPLO POR DEFECTO SWAGER-----------------------------
var summaries = new[]
{
    "Freezing", "Bracing", "Chilly", "Cool", "Mild", "Warm", "Balmy", "Hot", "Sweltering", "Scorching"
};

app.MapGet("/weatherforecast", () =>
{
    var forecast = Enumerable.Range(1, 5).Select(index =>
        new WeatherForecast
        (
            DateOnly.FromDateTime(DateTime.Now.AddDays(index)),
            Random.Shared.Next(-20, 55),
            summaries[Random.Shared.Next(summaries.Length)]
        ))
        .ToArray();
    return forecast;
})
.WithName("GetWeatherForecast")
.WithOpenApi();
//-----------------EJECUTA LA APLICACIÓN--------------------------------------
app.Run();
//-----------------------------------------------------------------------
internal record WeatherForecast(DateOnly Date, int TemperatureC, string? Summary)
{
    public int TemperatureF => 32 + (int)(TemperatureC / 0.5556);
}
