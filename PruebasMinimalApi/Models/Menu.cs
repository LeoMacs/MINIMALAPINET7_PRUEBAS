using System;
using System.Collections.Generic;

namespace PruebasMinimalApi.Models;

public partial class Menu
{
    public int IdMenu { get; set; }

    public string Nombre { get; set; } = null!;

    public string? Icono { get; set; }

    public string? Url { get; set; }
}
