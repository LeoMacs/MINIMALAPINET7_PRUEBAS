using System;
using System.Collections.Generic;

namespace PruebasMinimalApi.Models;

public partial class Producto
{
    public int Idproducto { get; set; }

    public int? Idcategoria { get; set; }

    public string? Nombre { get; set; }

    public decimal? Precio { get; set; }
}
