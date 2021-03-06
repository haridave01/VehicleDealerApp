USE [master]
GO
/****** Object:  Database [VehicleDealerDB]    Script Date: 27/10/2020 8:15:31 am ******/
CREATE DATABASE [VehicleDealerDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'VehicleDealerDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\VehicleDealerDB.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'VehicleDealerDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\VehicleDealerDB_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [VehicleDealerDB] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [VehicleDealerDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [VehicleDealerDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [VehicleDealerDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [VehicleDealerDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [VehicleDealerDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [VehicleDealerDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [VehicleDealerDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [VehicleDealerDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [VehicleDealerDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [VehicleDealerDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [VehicleDealerDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [VehicleDealerDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [VehicleDealerDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [VehicleDealerDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [VehicleDealerDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [VehicleDealerDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [VehicleDealerDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [VehicleDealerDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [VehicleDealerDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [VehicleDealerDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [VehicleDealerDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [VehicleDealerDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [VehicleDealerDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [VehicleDealerDB] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [VehicleDealerDB] SET  MULTI_USER 
GO
ALTER DATABASE [VehicleDealerDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [VehicleDealerDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [VehicleDealerDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [VehicleDealerDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [VehicleDealerDB] SET DELAYED_DURABILITY = DISABLED 
GO
USE [VehicleDealerDB]
GO
/****** Object:  Table [dbo].[CarWeights]    Script Date: 27/10/2020 8:15:31 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CarWeights](
	[CarWeight_Name] [varchar](20) NULL,
	[Carweight_MinWeight] [int] NULL,
	[CarWeight_MaxWeight] [int] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Features]    Script Date: 27/10/2020 8:15:31 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Features](
	[Id] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Features] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ImageFiles]    Script Date: 27/10/2020 8:15:31 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ImageFiles](
	[Id] [uniqueidentifier] NOT NULL,
	[FileName] [nvarchar](255) NOT NULL,
	[VehicleId] [uniqueidentifier] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_ImageFiles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Makes]    Script Date: 27/10/2020 8:15:31 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Makes](
	[Id] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Makes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Models]    Script Date: 27/10/2020 8:15:31 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Models](
	[Id] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[MakeId] [uniqueidentifier] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Models] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[VehicleFeatures]    Script Date: 27/10/2020 8:15:31 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VehicleFeatures](
	[Id] [uniqueidentifier] NOT NULL,
	[VehicleId] [uniqueidentifier] NOT NULL,
	[FeatureId] [uniqueidentifier] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_VehicleFeatures] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Vehicles]    Script Date: 27/10/2020 8:15:31 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Vehicles](
	[Id] [uniqueidentifier] NOT NULL,
	[ContactName] [nvarchar](255) NOT NULL,
	[ContactEmail] [nvarchar](255) NULL,
	[ContactPhone] [nvarchar](255) NOT NULL,
	[ModelId] [uniqueidentifier] NOT NULL,
	[IsRegistered] [bit] NOT NULL,
	[LastUpdate] [datetime2](7) NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Vehicles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Index [IX_ImageFiles_VehicleId]    Script Date: 27/10/2020 8:15:31 am ******/
CREATE NONCLUSTERED INDEX [IX_ImageFiles_VehicleId] ON [dbo].[ImageFiles]
(
	[VehicleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Models_MakeId]    Script Date: 27/10/2020 8:15:31 am ******/
CREATE NONCLUSTERED INDEX [IX_Models_MakeId] ON [dbo].[Models]
(
	[MakeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_VehicleFeatures_FeatureId]    Script Date: 27/10/2020 8:15:31 am ******/
CREATE NONCLUSTERED INDEX [IX_VehicleFeatures_FeatureId] ON [dbo].[VehicleFeatures]
(
	[FeatureId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_VehicleFeatures_VehicleId_FeatureId]    Script Date: 27/10/2020 8:15:31 am ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_VehicleFeatures_VehicleId_FeatureId] ON [dbo].[VehicleFeatures]
(
	[VehicleId] ASC,
	[FeatureId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Vehicles_ModelId]    Script Date: 27/10/2020 8:15:31 am ******/
CREATE NONCLUSTERED INDEX [IX_Vehicles_ModelId] ON [dbo].[Vehicles]
(
	[ModelId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ImageFiles]  WITH CHECK ADD  CONSTRAINT [FK_ImageFiles_Vehicles_VehicleId] FOREIGN KEY([VehicleId])
REFERENCES [dbo].[Vehicles] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ImageFiles] CHECK CONSTRAINT [FK_ImageFiles_Vehicles_VehicleId]
GO
ALTER TABLE [dbo].[Models]  WITH CHECK ADD  CONSTRAINT [FK_Models_Makes_MakeId] FOREIGN KEY([MakeId])
REFERENCES [dbo].[Makes] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Models] CHECK CONSTRAINT [FK_Models_Makes_MakeId]
GO
ALTER TABLE [dbo].[VehicleFeatures]  WITH CHECK ADD  CONSTRAINT [FK_VehicleFeatures_Features_FeatureId] FOREIGN KEY([FeatureId])
REFERENCES [dbo].[Features] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[VehicleFeatures] CHECK CONSTRAINT [FK_VehicleFeatures_Features_FeatureId]
GO
ALTER TABLE [dbo].[VehicleFeatures]  WITH CHECK ADD  CONSTRAINT [FK_VehicleFeatures_Vehicles_VehicleId] FOREIGN KEY([VehicleId])
REFERENCES [dbo].[Vehicles] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[VehicleFeatures] CHECK CONSTRAINT [FK_VehicleFeatures_Vehicles_VehicleId]
GO
ALTER TABLE [dbo].[Vehicles]  WITH CHECK ADD  CONSTRAINT [FK_Vehicles_Models_ModelId] FOREIGN KEY([ModelId])
REFERENCES [dbo].[Models] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Vehicles] CHECK CONSTRAINT [FK_Vehicles_Models_ModelId]
GO
USE [master]
GO
ALTER DATABASE [VehicleDealerDB] SET  READ_WRITE 
GO
