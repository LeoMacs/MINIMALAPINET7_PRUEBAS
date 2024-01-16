using Microsoft.EntityFrameworkCore;
using PruebasMinimalApi;
using PruebasMinimalApi.Models;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

//Add dbContext, here you can we are using In-memory database volatil.
builder.Services.AddDbContext<BeerDb>(opt => opt.UseInMemoryDatabase("Beer")); //mismo nombre de la clase Beer

//Add dbContext, here you can we are using  database local .
builder.Services.AddDbContext<BdTestContext>();
builder.Services.AddDbContext<DbContextClass>();
builder.Services.AddDbContext<MarcaDbContext>();




var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

//---------------EJEMPLO SIMPLE DE MINIMAL API------------------------------------------
app.MapGet("/", () => "Hello World");

//-----------------------------------------------------------------------
//---------------EJEMPLO CRUD CON BD VOLATIL=> NUGGETS: EFC.INMEMORY / EFC.DIAGNOSTICS-----------------------------
app.MapPost("/beer", async (Beer beers, BeerDb db) =>
{
    db.beers.Add(beers);
    await db.SaveChangesAsync();
    return Results.Created($"/beer/{beers.BeerId}", beers);
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
//---------------EJEMPLO CRUD CON BD SERVIDOR LOCAL=> NUGGETS: EFC.TOOLS / EFC.SQLSERVER-----------------------------
//get canales
//funciona
//app.MapGet("/Canal", async (BdTestContext dbContext) =>
//{
//    var canales = await dbContext.Canals.ToListAsync();
//    if (canales == null)
//    {
//        return Results.NoContent();
//    }
//    return Results.Ok(canales);


//app.MapGet("/Canal", async (DbContextClass dbContext) =>
//{
//    var canales = await dbContext.Canal.ToListAsync();
//    if (canales == null)
//    {
//        return Results.NoContent();
//    }
//    return Results.Ok(canales);
//});

////get canal by id
//app.MapGet("/Canal/{id}", async (int id, BdTestContext dbContext) =>
//{
//    var canal = await dbContext.Canals.FindAsync(id);
//    return canal != null ? Results.Ok(canal) : Results.NotFound();
//});

//get canal by id
//app.MapGet("/CanalbyId/{id}", async (int idcanal, BdTestContext dbContext) =>
//{
//    var canal = await dbContext.Canals.FindAsync(idcanal);
//    if (canal == null)
//    {
//        return Results.NotFound();
//    }
//    return Results.Ok(canal);
//});

////create a new canal
//app.MapPost("/createCanal", async (Canal canal, BdTestContext dbContext) =>
//{
//    var result = dbContext.Canals.Add(canal);
//    await dbContext.SaveChangesAsync();
//    return Results.Ok(result.Entity);
//});

////update the canal
//app.MapPut("/updateCanal", async (Canal canal, BdTestContext dbContext) =>
//{
//    var canalDetail = await dbContext.Canals.FindAsync(canal.Idcanal);
//    if (canal == null)
//    {
//        return Results.NotFound();
//    }
//    canalDetail.Descripcion = canal.Descripcion;
//    canalDetail.BActivo = canal.BActivo;


//    await dbContext.SaveChangesAsync();
//    return Results.Ok(canalDetail);
//});

////delete the canal by id
//app.MapDelete("/deleteCanal/{id}", async (int id, BdTestContext dbContext) =>
//{
//    var canal = await dbContext.Canals.FindAsync(id);
//    if (canal == null)
//    {
//        return Results.NoContent();
//    }
//    dbContext.Canals.Remove(canal);
//    await dbContext.SaveChangesAsync();
//    return Results.Ok();
//});

//-----------------------------------------------------------------------
//---------------EJEMPLO CON CONEXION DE BD EN AZURE-----------------------------
app.MapGet("/Marca", async (MarcaDbContext dbContext) =>
{
    var marcas = await dbContext.Marca.ToListAsync();
    if (marcas == null)
    {
        return Results.NoContent();
    }
    return Results.Ok(marcas);
});


app.MapGet("/Canal", async (DbContextClass dbContext) =>
{
    var canales = await dbContext.Canal.ToListAsync();
    if (canales == null)
    {
        return Results.NoContent();
    }
    return Results.Ok(canales);
});

//get canal by id
app.MapGet("/Canal/{id}", async (int id, DbContextClass dbContext) =>
{
    var canal = await dbContext.Canal.FindAsync(id);
    return canal != null ? Results.Ok(canal) : Results.NotFound();
});



//create a new canal
app.MapPost("/createCanal", async (Canal canal, DbContextClass dbContext) =>
{
    var result = dbContext.Canal.Add(canal);
    await dbContext.SaveChangesAsync();
    return Results.Ok(result.Entity);
});

//update the canal
app.MapPut("/updateCanal", async (Canal canal, DbContextClass dbContext) =>
{
    var canalDetail = await dbContext.Canal.FindAsync(canal.Idcanal);
    if (canal == null)
    {
        return Results.NotFound();
    }

    canalDetail.Descripcion = canal.Descripcion;
    canalDetail.BActivo = canal.BActivo;


    await dbContext.SaveChangesAsync();
    return Results.Ok(canalDetail);
});

//delete the canal by id
app.MapDelete("/deleteCanal/{id}", async (int id, DbContextClass dbContext) =>
{
    var canal = await dbContext.Canal.FindAsync(id);
    if (canal == null)
    {
        return Results.NoContent();
    }
    dbContext.Canal.Remove(canal);
    await dbContext.SaveChangesAsync();
    return Results.Ok();
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
