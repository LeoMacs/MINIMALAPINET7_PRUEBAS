using System;
using System.Collections.Generic;

namespace PruebasMinimalApi.Models;

public partial class Empleado
{
    public int IdEmpleado { get; set; }

    public string NombreCompleto { get; set; } = null!;

    public int IdDepartamento { get; set; }

    public decimal Sueldo { get; set; }

    public DateTime FechaContrato { get; set; }
}
