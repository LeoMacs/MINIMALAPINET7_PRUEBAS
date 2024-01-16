USE [master]
GO
/****** Object:  Database [BD_TEST]    Script Date: 16/01/2024 10:44:08 ******/
CREATE DATABASE [BD_TEST]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'BD_TEST', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS_2012\MSSQL\DATA\BD_TEST.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'BD_TEST_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS_2012\MSSQL\DATA\BD_TEST_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [BD_TEST] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [BD_TEST].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [BD_TEST] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [BD_TEST] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [BD_TEST] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [BD_TEST] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [BD_TEST] SET ARITHABORT OFF 
GO
ALTER DATABASE [BD_TEST] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [BD_TEST] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [BD_TEST] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [BD_TEST] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [BD_TEST] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [BD_TEST] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [BD_TEST] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [BD_TEST] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [BD_TEST] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [BD_TEST] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [BD_TEST] SET  DISABLE_BROKER 
GO
ALTER DATABASE [BD_TEST] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [BD_TEST] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [BD_TEST] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [BD_TEST] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [BD_TEST] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [BD_TEST] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [BD_TEST] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [BD_TEST] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [BD_TEST] SET  MULTI_USER 
GO
ALTER DATABASE [BD_TEST] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [BD_TEST] SET DB_CHAINING OFF 
GO
ALTER DATABASE [BD_TEST] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [BD_TEST] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [BD_TEST]
GO
/****** Object:  StoredProcedure [dbo].[Categoria_Listar]    Script Date: 16/01/2024 10:44:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Categoria_Listar]
(
	@Estado int
)
as
begin
	select *
	from Categoria
	where Estado = @Estado
end

GO
/****** Object:  StoredProcedure [dbo].[Producto_Listar]    Script Date: 16/01/2024 10:44:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[Producto_Listar]
as
begin
	select *
	from Producto
end

GO
/****** Object:  StoredProcedure [dbo].[sp_del_canal]    Script Date: 16/01/2024 10:44:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[sp_del_canal]
@id int=0,
@nResultado int OUTPUT

AS

	select  @nResultado=0

BEGIN TRANSACTION

		update canal set bActivo=0 where idcanal=@id
		select @nResultado=1
	
COMMIT TRANSACTION	
GO
/****** Object:  StoredProcedure [dbo].[sp_get_canalbyID]    Script Date: 16/01/2024 10:44:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_get_canalbyID]
@id int=0
AS
		begin
			select 
			idcanal,
			descripcion,
			bActivo,
			(case when  bActivo =1 then 'ACTIVO' else 'INACTIVO' end)  as Estado
			from canal
			where idcanal=@id 
		end
			
RETURN 0

GO
/****** Object:  StoredProcedure [dbo].[sp_get_canales]    Script Date: 16/01/2024 10:44:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_get_canales]
AS
	begin
			select 
			idcanal,
			descripcion,
			bActivo,
			(case when  bActivo =1 then 'ACTIVO' else 'INACTIVO' end)  as Estado
			from canal
			order by descripcion
			
end
 

GO
/****** Object:  StoredProcedure [dbo].[sp_ins_canal]    Script Date: 16/01/2024 10:44:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[sp_ins_canal]
@descripcion varchar(100)='',
@nResultado int OUTPUT
AS

BEGIN TRANSACTION
	insert into canal(descripcion) 
	values (@descripcion) 

		select @nResultado=1
	
COMMIT TRANSACTION	
GO
/****** Object:  StoredProcedure [dbo].[sp_upd_canal]    Script Date: 16/01/2024 10:44:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[sp_upd_canal]
@id int=0,
@descripcion varchar(100)='',
@bactivo int=0,
@nResultado int OUTPUT

AS
 
 set @nResultado=0;
BEGIN TRANSACTION

		update canal set descripcion= @descripcion,bActivo=@bactivo  
		 where idcanal=@id
		
		select @nResultado=1
	
COMMIT TRANSACTION	
GO
/****** Object:  Table [dbo].[__EFMigrationsHistory]    Script Date: 16/01/2024 10:44:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[__EFMigrationsHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[beers]    Script Date: 16/01/2024 10:44:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[beers](
	[BeerId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_beers] PRIMARY KEY CLUSTERED 
(
	[BeerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[canal]    Script Date: 16/01/2024 10:44:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[canal](
	[idcanal] [int] IDENTITY(1,1) NOT NULL,
	[descripcion] [varchar](100) NOT NULL,
	[bActivo] [int] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Categoria]    Script Date: 16/01/2024 10:44:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Categoria](
	[IDCategoria] [int] IDENTITY(1,1) NOT NULL,
	[Codigo] [varchar](50) NULL,
	[Nombre] [varchar](50) NULL,
	[Estado] [bit] NULL,
 CONSTRAINT [PK_Categoria] PRIMARY KEY CLUSTERED 
(
	[IDCategoria] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[cerveza]    Script Date: 16/01/2024 10:44:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[cerveza](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](50) NOT NULL,
	[marca] [varchar](50) NOT NULL,
 CONSTRAINT [PK_cerveza] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Departamento]    Script Date: 16/01/2024 10:44:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Departamento](
	[IdDepartamento] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Departamento] PRIMARY KEY CLUSTERED 
(
	[IdDepartamento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Empleado]    Script Date: 16/01/2024 10:44:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Empleado](
	[IdEmpleado] [int] IDENTITY(1,1) NOT NULL,
	[NombreCompleto] [varchar](50) NOT NULL,
	[IdDepartamento] [int] NOT NULL,
	[Sueldo] [decimal](10, 2) NOT NULL,
	[FechaContrato] [date] NOT NULL,
 CONSTRAINT [PK_Empleado] PRIMARY KEY CLUSTERED 
(
	[IdEmpleado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Menu]    Script Date: 16/01/2024 10:44:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Menu](
	[idMenu] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](50) NOT NULL,
	[icono] [varchar](50) NULL,
	[url] [varchar](100) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[MenuRol]    Script Date: 16/01/2024 10:44:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MenuRol](
	[idMenuRol] [int] IDENTITY(1,1) NOT NULL,
	[idMenu] [int] NOT NULL,
	[idRol] [int] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Producto]    Script Date: 16/01/2024 10:44:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Producto](
	[IDProducto] [int] IDENTITY(1,1) NOT NULL,
	[IDCategoria] [int] NULL,
	[Nombre] [varchar](50) NULL,
	[Precio] [decimal](18, 2) NULL,
 CONSTRAINT [PK_Producto] PRIMARY KEY CLUSTERED 
(
	[IDProducto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Rol]    Script Date: 16/01/2024 10:44:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Rol](
	[idRol] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](50) NOT NULL,
	[fechaRegistro] [datetime] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[usuario]    Script Date: 16/01/2024 10:44:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[usuario](
	[idUsuario] [int] IDENTITY(1,1) NOT NULL,
	[nombreCompleto] [varchar](100) NOT NULL,
	[correo] [varchar](40) NOT NULL,
	[idRol] [int] NOT NULL,
	[clave] [varchar](40) NOT NULL,
	[bActivo] [bit] NOT NULL,
	[fechaRegistro] [datetime] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20231225202733_InitDB', N'7.0.0')
SET IDENTITY_INSERT [dbo].[beers] ON 

INSERT [dbo].[beers] ([BeerId], [Name]) VALUES (1, N'PILSEN')
INSERT [dbo].[beers] ([BeerId], [Name]) VALUES (2, N'CUZQUEÑA')
INSERT [dbo].[beers] ([BeerId], [Name]) VALUES (3, N'CORONA')
SET IDENTITY_INSERT [dbo].[beers] OFF
SET IDENTITY_INSERT [dbo].[canal] ON 

INSERT [dbo].[canal] ([idcanal], [descripcion], [bActivo]) VALUES (1, N'TELEVISION', 0)
INSERT [dbo].[canal] ([idcanal], [descripcion], [bActivo]) VALUES (2, N'RADIO', 1)
INSERT [dbo].[canal] ([idcanal], [descripcion], [bActivo]) VALUES (3, N'TIKTOK', 1)
INSERT [dbo].[canal] ([idcanal], [descripcion], [bActivo]) VALUES (4, N'YOUTUBE', 1)
INSERT [dbo].[canal] ([idcanal], [descripcion], [bActivo]) VALUES (1002, N'FACEBOOK', 1)
SET IDENTITY_INSERT [dbo].[canal] OFF
SET IDENTITY_INSERT [dbo].[Categoria] ON 

INSERT [dbo].[Categoria] ([IDCategoria], [Codigo], [Nombre], [Estado]) VALUES (1, N'TEC', N'TECLADO', 1)
INSERT [dbo].[Categoria] ([IDCategoria], [Codigo], [Nombre], [Estado]) VALUES (2, N'MOU', N'MOUSE', 1)
INSERT [dbo].[Categoria] ([IDCategoria], [Codigo], [Nombre], [Estado]) VALUES (3, N'COM', N'COMPUTADORA', 1)
SET IDENTITY_INSERT [dbo].[Categoria] OFF
SET IDENTITY_INSERT [dbo].[cerveza] ON 

INSERT [dbo].[cerveza] ([id], [nombre], [marca]) VALUES (1, N'RED', N'Delirium')
INSERT [dbo].[cerveza] ([id], [nombre], [marca]) VALUES (3, N'PILSEN CALLAO', N'BACKUS')
SET IDENTITY_INSERT [dbo].[cerveza] OFF
SET IDENTITY_INSERT [dbo].[Departamento] ON 

INSERT [dbo].[Departamento] ([IdDepartamento], [Nombre]) VALUES (1, N'Administración')
INSERT [dbo].[Departamento] ([IdDepartamento], [Nombre]) VALUES (2, N'Marketing')
INSERT [dbo].[Departamento] ([IdDepartamento], [Nombre]) VALUES (3, N'Ventas')
INSERT [dbo].[Departamento] ([IdDepartamento], [Nombre]) VALUES (4, N'Comercio')
SET IDENTITY_INSERT [dbo].[Departamento] OFF
SET IDENTITY_INSERT [dbo].[Empleado] ON 

INSERT [dbo].[Empleado] ([IdEmpleado], [NombreCompleto], [IdDepartamento], [Sueldo], [FechaContrato]) VALUES (1, N'Franco Hernandez', 1, CAST(1400.00 AS Decimal(10, 2)), CAST(N'2023-07-10' AS Date))
SET IDENTITY_INSERT [dbo].[Empleado] OFF
SET IDENTITY_INSERT [dbo].[Menu] ON 

INSERT [dbo].[Menu] ([idMenu], [nombre], [icono], [url]) VALUES (1, N'DashBoard', N'dashboard', N'/pages/dashboard')
INSERT [dbo].[Menu] ([idMenu], [nombre], [icono], [url]) VALUES (2, N'Usuarios', N'group', N'/pages/usuarios')
INSERT [dbo].[Menu] ([idMenu], [nombre], [icono], [url]) VALUES (3, N'Productos', N'collections_bookmark', N'/pages/productos')
INSERT [dbo].[Menu] ([idMenu], [nombre], [icono], [url]) VALUES (4, N'Venta', N'currency_exchange', N'/pages/venta')
INSERT [dbo].[Menu] ([idMenu], [nombre], [icono], [url]) VALUES (5, N'Historial Ventas', N'edit_note', N'/pages/historial_venta')
INSERT [dbo].[Menu] ([idMenu], [nombre], [icono], [url]) VALUES (6, N'Reportes', N'receipt', N'/pages/reportes')
SET IDENTITY_INSERT [dbo].[Menu] OFF
SET IDENTITY_INSERT [dbo].[Producto] ON 

INSERT [dbo].[Producto] ([IDProducto], [IDCategoria], [Nombre], [Precio]) VALUES (1, 1, N'TECLADO XYZ', CAST(35.00 AS Decimal(18, 2)))
INSERT [dbo].[Producto] ([IDProducto], [IDCategoria], [Nombre], [Precio]) VALUES (2, 2, N'MOUSE PHP 254', CAST(75.00 AS Decimal(18, 2)))
INSERT [dbo].[Producto] ([IDProducto], [IDCategoria], [Nombre], [Precio]) VALUES (3, 3, N'PC GAMER XYZ', CAST(2546.00 AS Decimal(18, 2)))
SET IDENTITY_INSERT [dbo].[Producto] OFF
SET IDENTITY_INSERT [dbo].[Rol] ON 

INSERT [dbo].[Rol] ([idRol], [nombre], [fechaRegistro]) VALUES (1, N'Administrador', CAST(N'2023-12-30 04:21:19.233' AS DateTime))
INSERT [dbo].[Rol] ([idRol], [nombre], [fechaRegistro]) VALUES (2, N'Empleado', CAST(N'2023-12-30 12:06:16.317' AS DateTime))
INSERT [dbo].[Rol] ([idRol], [nombre], [fechaRegistro]) VALUES (3, N'Supervisor', CAST(N'2023-12-30 12:06:21.837' AS DateTime))
SET IDENTITY_INSERT [dbo].[Rol] OFF
SET IDENTITY_INSERT [dbo].[usuario] ON 

INSERT [dbo].[usuario] ([idUsuario], [nombreCompleto], [correo], [idRol], [clave], [bActivo], [fechaRegistro]) VALUES (1, N'Marco Cueva', N'leomacs1009@gmail.com', 1, N'123', 1, CAST(N'2023-12-30 12:13:05.220' AS DateTime))
SET IDENTITY_INSERT [dbo].[usuario] OFF
ALTER TABLE [dbo].[canal] ADD  CONSTRAINT [DF_canal_bActivo]  DEFAULT ((1)) FOR [bActivo]
GO
ALTER TABLE [dbo].[Rol] ADD  CONSTRAINT [DF_Rol_fechaRegistro]  DEFAULT (getdate()) FOR [fechaRegistro]
GO
ALTER TABLE [dbo].[usuario] ADD  CONSTRAINT [DF_usuario_bActivo]  DEFAULT ((1)) FOR [bActivo]
GO
ALTER TABLE [dbo].[usuario] ADD  CONSTRAINT [DF_usuario_fechaRegistro]  DEFAULT (getdate()) FOR [fechaRegistro]
GO
USE [master]
GO
ALTER DATABASE [BD_TEST] SET  READ_WRITE 
GO
