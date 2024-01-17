using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace PruebasMinimalApi.Models;

public partial class Departamento
{
    [Key]
    public int IdDepartamento { get; set; }

    public string Nombre { get; set; } = null!;
}
