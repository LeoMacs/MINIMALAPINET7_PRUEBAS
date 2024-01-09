using System;
using System.Collections.Generic;

namespace PruebasMinimalApi.Models;

public partial class Canal
{
    public int Idcanal { get; set; }

    public string Descripcion { get; set; } = null!;

    public int BActivo { get; set; }
}
