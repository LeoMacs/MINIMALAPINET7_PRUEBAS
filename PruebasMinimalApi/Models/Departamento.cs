﻿using System;
using System.Collections.Generic;

namespace PruebasMinimalApi.Models;

public partial class Departamento
{
    public int IdDepartamento { get; set; }

    public string Nombre { get; set; } = null!;
}
