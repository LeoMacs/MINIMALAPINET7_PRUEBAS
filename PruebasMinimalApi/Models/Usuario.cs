using System;
using System.Collections.Generic;

namespace PruebasMinimalApi.Models;

public partial class Usuario
{
    public int IdUsuario { get; set; }

    public string NombreCompleto { get; set; } = null!;

    public string Correo { get; set; } = null!;

    public int IdRol { get; set; }

    public string Clave { get; set; } = null!;

    public bool? BActivo { get; set; }

    public DateTime FechaRegistro { get; set; }
}
