using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;

namespace PruebasMinimalApi.Models;

public partial class BdTestContext : DbContext
{
    protected readonly IConfiguration Configuration;


    public BdTestContext(IConfiguration configuration)
    {
        Configuration = configuration;
    }

    //public BdTestContext(DbContextOptions<BdTestContext> options)
    //    : base(options)
    //{
    //}

    public virtual DbSet<Beer> Beers { get; set; }

    public virtual DbSet<Canal> Canals { get; set; }

    public virtual DbSet<Categorium> Categoria { get; set; }

    public virtual DbSet<Cerveza> Cervezas { get; set; }

    public virtual DbSet<Departamento> Departamentos { get; set; }

    public virtual DbSet<Empleado> Empleados { get; set; }

    public virtual DbSet<Menu> Menus { get; set; }

    public virtual DbSet<MenuRol> MenuRols { get; set; }

    public virtual DbSet<Producto> Productos { get; set; }

    public virtual DbSet<Rol> Rols { get; set; }

    public virtual DbSet<Usuario> Usuarios { get; set; }

    #warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see http://go.microsoft.com/fwlink/?LinkId=723263.
    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
    {
        optionsBuilder.UseSqlServer(Configuration.GetConnectionString("BackendConexion"));
    }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        //modelBuilder.Entity<Beer>(entity =>
        //{
        //    entity.ToTable("beers");
        //});

        modelBuilder.Entity<Canal>(entity =>
        {
            entity
                .HasNoKey()
                .ToTable("canal");

            entity.Property(e => e.BActivo)
                .HasDefaultValueSql("((1))")
                .HasColumnName("bActivo");
            entity.Property(e => e.Descripcion)
                .HasMaxLength(100)
                .IsUnicode(false)
                .HasColumnName("descripcion");
            entity.Property(e => e.Idcanal)
                .ValueGeneratedOnAdd()
                .HasColumnName("idcanal");
        });

        modelBuilder.Entity<Categorium>(entity =>
        {
            entity.HasKey(e => e.Idcategoria);

            entity.Property(e => e.Idcategoria).HasColumnName("IDCategoria");
            entity.Property(e => e.Codigo)
                .HasMaxLength(50)
                .IsUnicode(false);
            entity.Property(e => e.Nombre)
                .HasMaxLength(50)
                .IsUnicode(false);
        });

        modelBuilder.Entity<Cerveza>(entity =>
        {
            entity.ToTable("cerveza");

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.Marca)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("marca");
            entity.Property(e => e.Nombre)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("nombre");
        });

        modelBuilder.Entity<Departamento>(entity =>
        {
            entity.HasKey(e => e.IdDepartamento);

            entity.ToTable("Departamento");

            entity.Property(e => e.Nombre)
                .HasMaxLength(50)
                .IsUnicode(false);
        });

        modelBuilder.Entity<Empleado>(entity =>
        {
            entity.HasKey(e => e.IdEmpleado);

            entity.ToTable("Empleado");

            entity.Property(e => e.FechaContrato).HasColumnType("date");
            entity.Property(e => e.NombreCompleto)
                .HasMaxLength(50)
                .IsUnicode(false);
            entity.Property(e => e.Sueldo).HasColumnType("decimal(10, 2)");
        });

        modelBuilder.Entity<Menu>(entity =>
        {
            entity
                .HasNoKey()
                .ToTable("Menu");

            entity.Property(e => e.Icono)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("icono");
            entity.Property(e => e.IdMenu)
                .ValueGeneratedOnAdd()
                .HasColumnName("idMenu");
            entity.Property(e => e.Nombre)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("nombre");
            entity.Property(e => e.Url)
                .HasMaxLength(100)
                .IsUnicode(false)
                .HasColumnName("url");
        });

        modelBuilder.Entity<MenuRol>(entity =>
        {
            entity
                .HasNoKey()
                .ToTable("MenuRol");

            entity.Property(e => e.IdMenu).HasColumnName("idMenu");
            entity.Property(e => e.IdMenuRol)
                .ValueGeneratedOnAdd()
                .HasColumnName("idMenuRol");
            entity.Property(e => e.IdRol).HasColumnName("idRol");
        });

        modelBuilder.Entity<Producto>(entity =>
        {
            entity.HasKey(e => e.Idproducto);

            entity.ToTable("Producto");

            entity.Property(e => e.Idproducto).HasColumnName("IDProducto");
            entity.Property(e => e.Idcategoria).HasColumnName("IDCategoria");
            entity.Property(e => e.Nombre)
                .HasMaxLength(50)
                .IsUnicode(false);
            entity.Property(e => e.Precio).HasColumnType("decimal(18, 2)");
        });

        modelBuilder.Entity<Rol>(entity =>
        {
            entity
                .HasNoKey()
                .ToTable("Rol");

            entity.Property(e => e.FechaRegistro)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime")
                .HasColumnName("fechaRegistro");
            entity.Property(e => e.IdRol)
                .ValueGeneratedOnAdd()
                .HasColumnName("idRol");
            entity.Property(e => e.Nombre)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("nombre");
        });

        modelBuilder.Entity<Usuario>(entity =>
        {
            entity
                .HasNoKey()
                .ToTable("usuario");

            entity.Property(e => e.BActivo)
                .IsRequired()
                .HasDefaultValueSql("((1))")
                .HasColumnName("bActivo");
            entity.Property(e => e.Clave)
                .HasMaxLength(40)
                .IsUnicode(false)
                .HasColumnName("clave");
            entity.Property(e => e.Correo)
                .HasMaxLength(40)
                .IsUnicode(false)
                .HasColumnName("correo");
            entity.Property(e => e.FechaRegistro)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime")
                .HasColumnName("fechaRegistro");
            entity.Property(e => e.IdRol).HasColumnName("idRol");
            entity.Property(e => e.IdUsuario)
                .ValueGeneratedOnAdd()
                .HasColumnName("idUsuario");
            entity.Property(e => e.NombreCompleto)
                .HasMaxLength(100)
                .IsUnicode(false)
                .HasColumnName("nombreCompleto");
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
