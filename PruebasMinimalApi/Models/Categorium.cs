using System;
using System.Collections.Generic;

namespace PruebasMinimalApi.Models;

public partial class Categorium
{
    public int Idcategoria { get; set; }

    public string? Codigo { get; set; }

    public string? Nombre { get; set; }

    public bool? Estado { get; set; }
}
