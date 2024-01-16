using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace PruebasMinimalApi.Models;

public  class Canal
{
    [Key]
    public int Idcanal { get; set; }

    public string Descripcion { get; set; } = null!;

    public int BActivo { get; set; }
}
