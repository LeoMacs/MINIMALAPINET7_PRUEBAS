using System;
using System.Collections.Generic;

namespace PruebasMinimalApi.Models;

public partial class Beer
{
    public int BeerId { get; set; }

    public string Name { get; set; } = null!;
}
