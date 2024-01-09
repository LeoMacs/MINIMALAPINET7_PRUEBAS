using System;
using System.Collections.Generic;

namespace PruebasMinimalApi.Models;

public partial class Rol
{
    public int IdRol { get; set; }

    public string Nombre { get; set; } = null!;

    public DateTime FechaRegistro { get; set; }
}
