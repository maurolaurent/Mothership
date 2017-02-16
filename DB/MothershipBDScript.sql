/****** Object:  Database [Mothership]    Script Date: 1/26/2017 12:58:49 PM ******/
CREATE DATABASE [Mothership]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Mothership', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\Mothership.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Mothership_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\Mothership_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [Mothership] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Mothership].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Mothership] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Mothership] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Mothership] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Mothership] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Mothership] SET ARITHABORT OFF 
GO
ALTER DATABASE [Mothership] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Mothership] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [Mothership] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Mothership] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Mothership] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Mothership] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Mothership] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Mothership] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Mothership] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Mothership] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Mothership] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Mothership] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Mothership] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Mothership] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Mothership] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Mothership] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Mothership] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Mothership] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Mothership] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Mothership] SET  MULTI_USER 
GO
ALTER DATABASE [Mothership] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Mothership] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Mothership] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Mothership] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
/****** Object:  Table [dbo].[Audit]    Script Date: 1/26/2017 12:58:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Audit](
	[Id] [uniqueidentifier] NOT NULL,
	[EventTime] [datetime] NOT NULL,
	[Message] [nvarchar](max) NOT NULL,
	[Details] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Client]    Script Date: 1/26/2017 12:58:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Client](
	[Id] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_Client] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Client_Comm]    Script Date: 1/26/2017 12:58:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Client_Comm](
	[Id] [uniqueidentifier] NOT NULL,
	[Date] [datetime] NOT NULL,
	[Client] [uniqueidentifier] NOT NULL,
	[Type] [int] NOT NULL,
 CONSTRAINT [PK_Client_Comm] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Client_Comm_Line]    Script Date: 1/26/2017 12:58:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Client_Comm_Line](
	[CommId] [uniqueidentifier] NOT NULL,
	[Line] [int] NOT NULL,
	[Text] [nvarchar](max) NOT NULL,
	[Id] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_Client_Comm_Line] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Client_Handshake]    Script Date: 1/26/2017 12:58:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Client_Handshake](
	[Id] [uniqueidentifier] NOT NULL,
	[Time] [datetime] NOT NULL,
	[Client] [uniqueidentifier] NOT NULL,
	[Status] [nvarchar](100) NOT NULL,
	[Details] [nvarchar](max) NULL,
 CONSTRAINT [PK_Client_Handshake] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Client_Info]    Script Date: 1/26/2017 12:58:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Client_Info](
	[ClientId] [uniqueidentifier] NOT NULL,
	[InfoType] [int] NOT NULL,
	[InfoDetail] [nvarchar](2000) NOT NULL,
	[Id] [uniqueidentifier] NOT NULL,
	[PreferredConnection] [bit] NOT NULL,
 CONSTRAINT [PK_Client_Info_1] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Command]    Script Date: 1/26/2017 12:58:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Command](
	[Id] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Command] [nvarchar](150) NOT NULL,
	[Type] [int] NOT NULL,
 CONSTRAINT [PK_Command] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Job]    Script Date: 1/26/2017 12:58:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Job](
	[Id] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Created] [datetime] NOT NULL,
	[ToExecute] [datetime] NOT NULL,
	[Executed] [datetime] NULL,
	[Client] [uniqueidentifier] NOT NULL,
	[Command] [varchar](5000) NOT NULL,
	[Response] [text] NULL,
	[Status] [int] NOT NULL,
 CONSTRAINT [PK_Job] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[Client] ([Id], [Name]) VALUES (N'49533218-b324-4ea8-84d4-681eb4a5acf3', N'MAURO-LAPTOP')
GO
INSERT [dbo].[Client_Comm] ([Id], [Date], [Client], [Type]) VALUES (N'f3394501-6cda-4796-8f8c-1774b02c36c4', CAST(0x0000A70700D030CC AS DateTime), N'49533218-b324-4ea8-84d4-681eb4a5acf3', 0)
GO
INSERT [dbo].[Client_Comm] ([Id], [Date], [Client], [Type]) VALUES (N'18ef057c-4b34-495b-8741-3269d6814c6e', CAST(0x0000A70700A93258 AS DateTime), N'49533218-b324-4ea8-84d4-681eb4a5acf3', 0)
GO
INSERT [dbo].[Client_Comm] ([Id], [Date], [Client], [Type]) VALUES (N'fb95971e-9f68-41ed-a5dc-5c2444ed59c3', CAST(0x0000A707008740BA AS DateTime), N'49533218-b324-4ea8-84d4-681eb4a5acf3', 0)
GO
INSERT [dbo].[Client_Comm] ([Id], [Date], [Client], [Type]) VALUES (N'c88ba098-aa02-4ce5-ab75-62e7d545ad2d', CAST(0x0000A70700D2E16A AS DateTime), N'49533218-b324-4ea8-84d4-681eb4a5acf3', 0)
GO
INSERT [dbo].[Client_Comm] ([Id], [Date], [Client], [Type]) VALUES (N'ada045fb-7556-452b-831b-92b90b29e3cd', CAST(0x0000A70700D0D4CE AS DateTime), N'49533218-b324-4ea8-84d4-681eb4a5acf3', 0)
GO
INSERT [dbo].[Client_Comm] ([Id], [Date], [Client], [Type]) VALUES (N'c41ee984-b5c4-4968-8dca-9eb6b2706a93', CAST(0x0000A70700D2EF09 AS DateTime), N'49533218-b324-4ea8-84d4-681eb4a5acf3', 0)
GO
INSERT [dbo].[Client_Comm] ([Id], [Date], [Client], [Type]) VALUES (N'd564d905-fb5e-4e9a-89f8-a7df44a6cc8b', CAST(0x0000A70700D26F4C AS DateTime), N'49533218-b324-4ea8-84d4-681eb4a5acf3', 0)
GO
INSERT [dbo].[Client_Comm] ([Id], [Date], [Client], [Type]) VALUES (N'82fd4189-5751-47e4-944b-d12ba2ece175', CAST(0x0000A70700D075FF AS DateTime), N'49533218-b324-4ea8-84d4-681eb4a5acf3', 0)
GO
INSERT [dbo].[Client_Comm] ([Id], [Date], [Client], [Type]) VALUES (N'fe442d2c-1546-4642-8427-fc145059d9ab', CAST(0x0000A70700D0496D AS DateTime), N'49533218-b324-4ea8-84d4-681eb4a5acf3', 0)
GO
INSERT [dbo].[Client_Comm_Line] ([CommId], [Line], [Text], [Id]) VALUES (N'ada045fb-7556-452b-831b-92b90b29e3cd', 3, N'CommComputerOS:Microsoft Windows NT 6.3.9600.0', N'f58fde2c-d00e-41f8-b585-029343a340f5')
GO
INSERT [dbo].[Client_Comm_Line] ([CommId], [Line], [Text], [Id]) VALUES (N'c41ee984-b5c4-4968-8dca-9eb6b2706a93', 0, N'Tier1MothershipCommunicationMessageT1MSCOMM.CommType:100', N'd5743f5c-3bff-4ff8-a911-08266f33963f')
GO
INSERT [dbo].[Client_Comm_Line] ([CommId], [Line], [Text], [Id]) VALUES (N'f3394501-6cda-4796-8f8c-1774b02c36c4', 0, N'Tier1MothershipCommunicationMessageT1MSCOMM.CommType:100', N'5d04138b-1152-4071-aa5a-111f8019299c')
GO
INSERT [dbo].[Client_Comm_Line] ([CommId], [Line], [Text], [Id]) VALUES (N'18ef057c-4b34-495b-8741-3269d6814c6e', 5, N'CommWireless80211Ip:192.168.0.3', N'dc83d017-68a6-40ef-8890-1a3ceecf5021')
GO
INSERT [dbo].[Client_Comm_Line] ([CommId], [Line], [Text], [Id]) VALUES (N'c41ee984-b5c4-4968-8dca-9eb6b2706a93', 5, N'CommWireless80211Ip:192.168.0.3', N'5cb0bef2-d19f-43ff-bfb4-1afdf03ba28e')
GO
INSERT [dbo].[Client_Comm_Line] ([CommId], [Line], [Text], [Id]) VALUES (N'c41ee984-b5c4-4968-8dca-9eb6b2706a93', 4, N'CommEthernetIp:', N'331014ec-03c9-4ab3-a576-1c109ef39cf3')
GO
INSERT [dbo].[Client_Comm_Line] ([CommId], [Line], [Text], [Id]) VALUES (N'd564d905-fb5e-4e9a-89f8-a7df44a6cc8b', 3, N'CommComputerOS:Microsoft Windows NT 6.3.9600.0', N'89e54bd5-d440-44f6-a3d5-2afe199504c5')
GO
INSERT [dbo].[Client_Comm_Line] ([CommId], [Line], [Text], [Id]) VALUES (N'd564d905-fb5e-4e9a-89f8-a7df44a6cc8b', 4, N'CommEthernetIp:', N'3fd76f7d-533c-4303-8d7c-2d545973badb')
GO
INSERT [dbo].[Client_Comm_Line] ([CommId], [Line], [Text], [Id]) VALUES (N'f3394501-6cda-4796-8f8c-1774b02c36c4', 4, N'CommEthernetIp:', N'80f870ec-eb3b-45e1-a165-39774c30f4e0')
GO
INSERT [dbo].[Client_Comm_Line] ([CommId], [Line], [Text], [Id]) VALUES (N'18ef057c-4b34-495b-8741-3269d6814c6e', 3, N'CommComputerOS:Microsoft Windows NT 6.2.9200.0', N'6db64e86-148c-46d2-8609-3e96982e3cff')
GO
INSERT [dbo].[Client_Comm_Line] ([CommId], [Line], [Text], [Id]) VALUES (N'fe442d2c-1546-4642-8427-fc145059d9ab', 3, N'CommComputerOS:Microsoft Windows NT 6.3.9600.0', N'83fed391-5ab3-43ac-93cb-40cc3add0cc4')
GO
INSERT [dbo].[Client_Comm_Line] ([CommId], [Line], [Text], [Id]) VALUES (N'fe442d2c-1546-4642-8427-fc145059d9ab', 1, N'CommHostName:Mauro-Laptop', N'9c184fa6-af41-439d-b98d-475aeeb536ee')
GO
INSERT [dbo].[Client_Comm_Line] ([CommId], [Line], [Text], [Id]) VALUES (N'82fd4189-5751-47e4-944b-d12ba2ece175', 0, N'Tier1MothershipCommunicationMessageT1MSCOMM.CommType:100', N'340d8097-75f8-4d7e-80a1-57f30d49282f')
GO
INSERT [dbo].[Client_Comm_Line] ([CommId], [Line], [Text], [Id]) VALUES (N'18ef057c-4b34-495b-8741-3269d6814c6e', 4, N'CommEthernetIp:', N'349a140c-517a-449b-a56a-5b7b8a1fd860')
GO
INSERT [dbo].[Client_Comm_Line] ([CommId], [Line], [Text], [Id]) VALUES (N'82fd4189-5751-47e4-944b-d12ba2ece175', 3, N'CommComputerOS:Microsoft Windows NT 6.3.9600.0', N'7e51ccf3-256c-4fdc-b0da-659a13f8d83c')
GO
INSERT [dbo].[Client_Comm_Line] ([CommId], [Line], [Text], [Id]) VALUES (N'18ef057c-4b34-495b-8741-3269d6814c6e', 1, N'CommHostName:Mauro-Laptop', N'd994fe98-3d35-4a62-a422-6f2df87a1f59')
GO
INSERT [dbo].[Client_Comm_Line] ([CommId], [Line], [Text], [Id]) VALUES (N'ada045fb-7556-452b-831b-92b90b29e3cd', 2, N'CommComputerName:MAURO-LAPTOP', N'3ad78c2d-42ef-46fa-a00b-70f464ca1274')
GO
INSERT [dbo].[Client_Comm_Line] ([CommId], [Line], [Text], [Id]) VALUES (N'82fd4189-5751-47e4-944b-d12ba2ece175', 1, N'CommHostName:Mauro-Laptop', N'00f1fd44-7c0b-4dbc-b57c-83fbebced802')
GO
INSERT [dbo].[Client_Comm_Line] ([CommId], [Line], [Text], [Id]) VALUES (N'c88ba098-aa02-4ce5-ab75-62e7d545ad2d', 0, N'Tier1MothershipCommunicationMessageT1MSCOMM.CommType:100', N'2c84574c-d403-4c11-840b-857bee168196')
GO
INSERT [dbo].[Client_Comm_Line] ([CommId], [Line], [Text], [Id]) VALUES (N'fb95971e-9f68-41ed-a5dc-5c2444ed59c3', 0, N'Tier1MothershipCommunicationMessageT1MSCOMM.CommType:100', N'b0932150-f444-43f6-aba1-891937c073f0')
GO
INSERT [dbo].[Client_Comm_Line] ([CommId], [Line], [Text], [Id]) VALUES (N'18ef057c-4b34-495b-8741-3269d6814c6e', 0, N'Tier1MothershipCommunicationMessageT1MSCOMM.CommType:100', N'77f9f190-4e03-409b-b9c6-8f2b63fbdb42')
GO
INSERT [dbo].[Client_Comm_Line] ([CommId], [Line], [Text], [Id]) VALUES (N'fb95971e-9f68-41ed-a5dc-5c2444ed59c3', 2, N'CommComputerName:MAURO-LAPTOP', N'5985f503-8356-408a-afe0-9149ba49eb6e')
GO
INSERT [dbo].[Client_Comm_Line] ([CommId], [Line], [Text], [Id]) VALUES (N'c88ba098-aa02-4ce5-ab75-62e7d545ad2d', 3, N'CommComputerOS:Microsoft Windows NT 6.2.9200.0', N'71612873-1f29-411a-af52-92d5d41bb297')
GO
INSERT [dbo].[Client_Comm_Line] ([CommId], [Line], [Text], [Id]) VALUES (N'c88ba098-aa02-4ce5-ab75-62e7d545ad2d', 1, N'CommHostName:Mauro-Laptop', N'a3d5b4f3-af3b-4e6f-b801-a57785b7b84f')
GO
INSERT [dbo].[Client_Comm_Line] ([CommId], [Line], [Text], [Id]) VALUES (N'd564d905-fb5e-4e9a-89f8-a7df44a6cc8b', 5, N'CommWireless80211Ip:192.168.0.3', N'd31a9d22-20cc-4452-8014-a7f424f015dd')
GO
INSERT [dbo].[Client_Comm_Line] ([CommId], [Line], [Text], [Id]) VALUES (N'c41ee984-b5c4-4968-8dca-9eb6b2706a93', 3, N'CommComputerOS:Microsoft Windows NT 6.3.9600.0', N'92b4dc61-24f0-4459-9f59-ad95588877a9')
GO
INSERT [dbo].[Client_Comm_Line] ([CommId], [Line], [Text], [Id]) VALUES (N'f3394501-6cda-4796-8f8c-1774b02c36c4', 2, N'CommComputerName:MAURO-LAPTOP', N'f1409a8e-0a73-402c-a393-b8295fbee0dd')
GO
INSERT [dbo].[Client_Comm_Line] ([CommId], [Line], [Text], [Id]) VALUES (N'ada045fb-7556-452b-831b-92b90b29e3cd', 1, N'CommHostName:Mauro-Laptop', N'9fdf51be-0baa-471c-88c9-bea547faa65d')
GO
INSERT [dbo].[Client_Comm_Line] ([CommId], [Line], [Text], [Id]) VALUES (N'ada045fb-7556-452b-831b-92b90b29e3cd', 0, N'Tier1MothershipCommunicationMessageT1MSCOMM.CommType:100', N'4412bf0b-cd3e-46cf-a0ff-bf1ce32cc0a9')
GO
INSERT [dbo].[Client_Comm_Line] ([CommId], [Line], [Text], [Id]) VALUES (N'fe442d2c-1546-4642-8427-fc145059d9ab', 5, N'CommWireless80211Ip:192.168.0.3', N'e1a46235-3492-4b6e-bf6b-c342e25f7448')
GO
INSERT [dbo].[Client_Comm_Line] ([CommId], [Line], [Text], [Id]) VALUES (N'ada045fb-7556-452b-831b-92b90b29e3cd', 5, N'CommWireless80211Ip:192.168.0.3', N'7140f561-7068-440e-ac9c-c3ad9fb2e5ca')
GO
INSERT [dbo].[Client_Comm_Line] ([CommId], [Line], [Text], [Id]) VALUES (N'd564d905-fb5e-4e9a-89f8-a7df44a6cc8b', 1, N'CommHostName:Mauro-Laptop', N'8f242208-f1a3-42a1-84b4-c3fb63dd0b9d')
GO
INSERT [dbo].[Client_Comm_Line] ([CommId], [Line], [Text], [Id]) VALUES (N'fb95971e-9f68-41ed-a5dc-5c2444ed59c3', 3, N'CommComputerOS:Microsoft Windows NT 6.2.9200.0', N'57615bfc-9817-4d79-af5f-cb20342a22da')
GO
INSERT [dbo].[Client_Comm_Line] ([CommId], [Line], [Text], [Id]) VALUES (N'ada045fb-7556-452b-831b-92b90b29e3cd', 4, N'CommEthernetIp:', N'9597daff-25d0-4275-a7d7-cda4e0c3a581')
GO
INSERT [dbo].[Client_Comm_Line] ([CommId], [Line], [Text], [Id]) VALUES (N'fb95971e-9f68-41ed-a5dc-5c2444ed59c3', 5, N'CommWireless80211Ip:192.168.0.3', N'd6de9472-d0e5-494c-8399-cdfaa5e24192')
GO
INSERT [dbo].[Client_Comm_Line] ([CommId], [Line], [Text], [Id]) VALUES (N'fe442d2c-1546-4642-8427-fc145059d9ab', 4, N'CommEthernetIp:', N'10764e4a-249e-41f2-ba1f-d06967429969')
GO
INSERT [dbo].[Client_Comm_Line] ([CommId], [Line], [Text], [Id]) VALUES (N'd564d905-fb5e-4e9a-89f8-a7df44a6cc8b', 2, N'CommComputerName:MAURO-LAPTOP', N'9ac78517-cfc4-4b62-a3ed-d096df0da0b0')
GO
INSERT [dbo].[Client_Comm_Line] ([CommId], [Line], [Text], [Id]) VALUES (N'fb95971e-9f68-41ed-a5dc-5c2444ed59c3', 1, N'CommHostName:Mauro-Laptop', N'344e3b8d-4eb3-4a38-a2c6-d50d2702c4b4')
GO
INSERT [dbo].[Client_Comm_Line] ([CommId], [Line], [Text], [Id]) VALUES (N'82fd4189-5751-47e4-944b-d12ba2ece175', 2, N'CommComputerName:MAURO-LAPTOP', N'6c2282a1-970c-4dc6-916a-d569166428bd')
GO
INSERT [dbo].[Client_Comm_Line] ([CommId], [Line], [Text], [Id]) VALUES (N'82fd4189-5751-47e4-944b-d12ba2ece175', 4, N'CommEthernetIp:', N'56bd472e-364d-4328-bfc4-d802120df1a6')
GO
INSERT [dbo].[Client_Comm_Line] ([CommId], [Line], [Text], [Id]) VALUES (N'c88ba098-aa02-4ce5-ab75-62e7d545ad2d', 5, N'CommWireless80211Ip:192.168.0.3', N'718caf1b-4f08-4adf-87b7-d8636cff26fc')
GO
INSERT [dbo].[Client_Comm_Line] ([CommId], [Line], [Text], [Id]) VALUES (N'18ef057c-4b34-495b-8741-3269d6814c6e', 2, N'CommComputerName:MAURO-LAPTOP', N'f61f8fba-83f9-4796-8c6b-d8c539599ede')
GO
INSERT [dbo].[Client_Comm_Line] ([CommId], [Line], [Text], [Id]) VALUES (N'f3394501-6cda-4796-8f8c-1774b02c36c4', 1, N'CommHostName:Mauro-Laptop', N'a01e0c6b-2cc0-4e1e-98d5-dc74e954e51d')
GO
INSERT [dbo].[Client_Comm_Line] ([CommId], [Line], [Text], [Id]) VALUES (N'c88ba098-aa02-4ce5-ab75-62e7d545ad2d', 4, N'CommEthernetIp:', N'efd53b37-febb-49b9-9b1e-e2b898c4a989')
GO
INSERT [dbo].[Client_Comm_Line] ([CommId], [Line], [Text], [Id]) VALUES (N'f3394501-6cda-4796-8f8c-1774b02c36c4', 5, N'CommWireless80211Ip:192.168.0.3', N'6ca5d0ef-4041-4215-8742-e714531863a8')
GO
INSERT [dbo].[Client_Comm_Line] ([CommId], [Line], [Text], [Id]) VALUES (N'c41ee984-b5c4-4968-8dca-9eb6b2706a93', 2, N'CommComputerName:MAURO-LAPTOP', N'2b37ed74-fd56-4ef0-97ba-e8a976c3d954')
GO
INSERT [dbo].[Client_Comm_Line] ([CommId], [Line], [Text], [Id]) VALUES (N'f3394501-6cda-4796-8f8c-1774b02c36c4', 3, N'CommComputerOS:Microsoft Windows NT 6.3.9600.0', N'93d5f162-8752-4cac-880b-eb67d909597d')
GO
INSERT [dbo].[Client_Comm_Line] ([CommId], [Line], [Text], [Id]) VALUES (N'82fd4189-5751-47e4-944b-d12ba2ece175', 5, N'CommWireless80211Ip:192.168.0.3', N'ed0a23ea-7f89-4526-922e-ebbcc113b0de')
GO
INSERT [dbo].[Client_Comm_Line] ([CommId], [Line], [Text], [Id]) VALUES (N'c88ba098-aa02-4ce5-ab75-62e7d545ad2d', 2, N'CommComputerName:MAURO-LAPTOP', N'cb551062-3c6f-4161-ad2f-f4f9656c0f73')
GO
INSERT [dbo].[Client_Comm_Line] ([CommId], [Line], [Text], [Id]) VALUES (N'fe442d2c-1546-4642-8427-fc145059d9ab', 0, N'Tier1MothershipCommunicationMessageT1MSCOMM.CommType:100', N'8e1e5dbb-1516-4320-b175-f5171fb9cd1f')
GO
INSERT [dbo].[Client_Comm_Line] ([CommId], [Line], [Text], [Id]) VALUES (N'c41ee984-b5c4-4968-8dca-9eb6b2706a93', 1, N'CommHostName:Mauro-Laptop', N'14074952-2313-4515-93c6-f92528f49a19')
GO
INSERT [dbo].[Client_Comm_Line] ([CommId], [Line], [Text], [Id]) VALUES (N'fe442d2c-1546-4642-8427-fc145059d9ab', 2, N'CommComputerName:MAURO-LAPTOP', N'0872f264-30dc-4795-9419-f9537b2cd23f')
GO
INSERT [dbo].[Client_Comm_Line] ([CommId], [Line], [Text], [Id]) VALUES (N'fb95971e-9f68-41ed-a5dc-5c2444ed59c3', 4, N'CommEthernetIp:', N'10dc272c-ec0d-4782-b1c0-f97c74f088dd')
GO
INSERT [dbo].[Client_Comm_Line] ([CommId], [Line], [Text], [Id]) VALUES (N'd564d905-fb5e-4e9a-89f8-a7df44a6cc8b', 0, N'Tier1MothershipCommunicationMessageT1MSCOMM.CommType:100', N'756baddf-64c3-4b73-bccb-fc681cf7e708')
GO
INSERT [dbo].[Client_Info] ([ClientId], [InfoType], [InfoDetail], [Id], [PreferredConnection]) VALUES (N'49533218-b324-4ea8-84d4-681eb4a5acf3', 4, N'', N'71be8428-51c9-4aab-987e-5598b56a9c1c', 1)
GO
INSERT [dbo].[Client_Info] ([ClientId], [InfoType], [InfoDetail], [Id], [PreferredConnection]) VALUES (N'49533218-b324-4ea8-84d4-681eb4a5acf3', 5, N'192.168.0.3', N'0cd35b72-c6ae-4f6a-93f0-62447fa125f4', 1)
GO
INSERT [dbo].[Client_Info] ([ClientId], [InfoType], [InfoDetail], [Id], [PreferredConnection]) VALUES (N'49533218-b324-4ea8-84d4-681eb4a5acf3', 1, N'Mauro-Laptop', N'd442c3a0-0d59-4f22-928f-6915bb37bb6a', 0)
GO
INSERT [dbo].[Client_Info] ([ClientId], [InfoType], [InfoDetail], [Id], [PreferredConnection]) VALUES (N'49533218-b324-4ea8-84d4-681eb4a5acf3', 3, N'Microsoft Windows NT 6.2.9200.0', N'a20e4748-a546-4764-a139-d39911754236', 0)
GO
INSERT [dbo].[Client_Info] ([ClientId], [InfoType], [InfoDetail], [Id], [PreferredConnection]) VALUES (N'49533218-b324-4ea8-84d4-681eb4a5acf3', 0, N'100', N'1e5691c0-f870-4393-b152-f7577e64492a', 0)
GO
INSERT [dbo].[Client_Info] ([ClientId], [InfoType], [InfoDetail], [Id], [PreferredConnection]) VALUES (N'49533218-b324-4ea8-84d4-681eb4a5acf3', 2, N'MAURO-LAPTOP', N'c80e7fff-46fb-4a29-b27a-fa80fc814d57', 0)
GO
INSERT [dbo].[Job] ([Id], [Name], [Created], [ToExecute], [Executed], [Client], [Command], [Response], [Status]) VALUES (N'd33aaa4b-5f3f-43af-8533-0e17b4b95a67', N'assoc', CAST(0x0000A70700D39DE7 AS DateTime), CAST(0x0000A70700D3C2F0 AS DateTime), CAST(0x0000A70700D3C76E AS DateTime), N'49533218-b324-4ea8-84d4-681eb4a5acf3', N'assoc', N'
-----------------------------------------
Response message from Minion service
Time: Thursday, January 26, 2017
-----------------------------------------
Microsoft Windows [Version 10.0.14393]
(c) 2016 Microsoft Corporation. All rights reserved.

C:\WINDOWS\system32>assoc
.386=vxdfile
.3fr=Photoshop.3FRFile.90
.3g2=VLC.3g2
.3ga=VLC.3ga
.3gp=VLC.3gp
.3gp2=VLC.3gp2
.3GPP=VLC.3gpp
.669=VLC.669
.7z=WinRAR
.8ba=Photoshop.PlugIn
.8bc=Photoshop.PlugIn
.8be=Photoshop.PlugIn
.8bf=Adobe.Photoshop.Plugin
.8bi=Adobe.Photoshop.Plugin
.8bp=Photoshop.PlugIn
.8bs=Photoshop.PlugIn
.8bx=Photoshop.PlugIn
.8by=Photoshop.PlugIn
.8li=Photoshop.PlugIn
.a2s=asquared.Scanner.Settings
.a52=VLC.a52
.aac=VLC.aac
.abkprj=ashampoo.BackupProject.Document
.abr=Photoshop.BrushesFile
.ac3=VLC.ac3
.acb=Adobe.Illustrator.ColorBook
.acbl=Adobe.Illustrator.ColorBook
.accessor=VisualStudio.accessor.12.0
.accountpicture-ms=accountpicturefile
.ace=WinRAR
.acf=Photoshop.CustomFilterKernel
.acl=ACLFile
.aco=Photoshop.SwatchesFile
.act=Photoshop.ColorTableFile
.acv=Photoshop.CurvesFile
.AddIn=VisualStudio.AddIn.10.0
.ado=Photoshop.DuotoneSettingsFile
.adt=VLC.adt
.adts=VLC.adts
.ahs=Photoshop.HalftoneScreens
.ahu=Photoshop.HueSatFile
.ai=Adobe.Illustrator.19
.aia=Adobe.Illustrator.Action
.AIF=VLC.aif
.AIFC=VLC.aifc
.AIFF=VLC.aiff
.aip=Adobe.Illustrator.Plugin
.air=AIR.InstallerPackage
.ait=Adobe.Illustrator.Template
.alv=Photoshop.LevelsFile
.amp=Photoshop.ArbitraryMapFile
.amr=VLC.amr
.ams=Photoshop.MonitorSetupFile
.amv=VLC.amv
.ani=anifile
.aob=VLC.aob
.ape=VLC.ape
.api=Photoshop.PrintingInksFile
.apl=Photoshop.AdobePlugIn
.appcontent-ms=ApplicationContent
.application=Application.Manifest
.appref-ms=Application.Reference
.appxmanifest=VisualStudio.appxmanifest.12.0
.arj=WinRAR
.asa=aspfile
.asax=VisualStudio.asax.10.0
.ascx=VisualStudio.ascx.10.0
.asdatabase=AnalysisServices.Deployment.Database
.ase=Adobe.Illustrator.SwatchExchange
.ASF=VLC.asf
.ashbak=ashampoo.BackupArchive.Document
.ashdisc=burningstudio.Image.Document
.ashprj=burningstudio.Project.Document
.ashx=VisualStudio.ashx.10.0
.asl=Photoshop.Styles
.asm=VisualStudio.asm.12.0
.asmx=VisualStudio.asmx.10.0
.asp=aspfile
.asproj=AnalysisServices.Project
.aspx=VisualStudio.aspx.10.0
.assecurityinformation=AnalysisServices.Deployment.SecurityInformation
.ast=Photoshop.SepTablesFile
.asv=Photoshop.ASVColAdjFile
.ASX=VLC.asx
.atf=Photoshop.TransferFunctionsFile
.atn=Photoshop.ActionsFile
.AU=VLC.au
.ava=Photoshop.VariationsFile
.avastconfig=avastconfigfile
.avastlic=avastlicfile
.avastsounds=avastsoundsfile
.avasttheme=avastthemefile
.avastvpn=avastvpnfile
.avi=VLC.avi
.aw=AWFile
.axt=Photoshop.AXTAdjColFile
.b4s=VLC.b4s
.b5t=DAEMON.Tools.Lite
.b6t=DAEMON.Tools.Lite
.bat=batfile
.bcp=SqlServerReplication.Bcp
.bik=VLC.bik
.bim=AnalysisServices.BIMFile
.bin=VLC.bin
.blg=Diagnostic.Perfmon.Document
.blw=Photoshop.BWPresets
.bmp=Paint.Picture
.bsc=VisualStudio.bsc.12.0
.bwt=DAEMON.Tools.Lite
.bz=WinRAR
.bz2=WinRAR
.c=VisualStudio.c.12.0
.cab=WinRAR
.caf=VLC.caf
.camp=campfile
.cat=CATFile
.cc=VisualStudio.cc.12.0
.ccd=DAEMON.Tools.Lite
.ccf=JDownloader2 2
.cd=VisualStudio.cd.12.0
.CDA=VLC.cda
.cdi=DAEMON.Tools.Lite
.cdmp=cdmpfile
.cdr=CorelDraw.Graphic.18
.cdt=CorelDraw.Graphic.18
.cdx=aspfile
.cdxml=Microsoft.PowerShellCmdletDefinitionXML.1
.cer=CERFile
.cfproj=VisualStudio.Launcher.cfproj.12.0
.cha=Photoshop.CHAFile
.chk=chkfile
.chm=chm.file
.cin=Photoshop.CINFile.90
.CLK=CorelDraw.Graphic.18
.cmd=cmdfile
.cmx=CorelDRAW.CMX.18
.cod=VisualStudio.cod.12.0
.coffee=VisualStudio.coffee.12.0
.com=comfile
.compositefont=Windows.CompositeFont
.config=VisualStudio.config.10.0
.configsettings=AnalysisServices.Deployment.ConfigurationSettings
.contact=contact_wab_auto_file
.corelextension=zcf.corelextension
.coverage=VisualStudio.coverage.12.0
.coveragexml=VisualStudio.coveragexml.12.0
.cpl=cplfile
.cpp=VisualStudio.cpp.12.0
.cpt=CorelPHOTOPAINT.Image.18
.crl=CRLFile
.crt=CERFile
.crtx=CRTXFile
.cs=VisualStudio.cs.10.0
.csf=Adobe.Illustrator.ColorSettings
.csh=Photoshop.CustomShapes
.cshtml=VisualStudio.cshtml.10.0
.csl=CorelDraw.Graphic.18
.csp=Corel.SBProfile
.csproj=VisualStudio.Launcher.csproj.10.0
.css=CSSfile
.csv=Excel.CSV
.cube=AnalysisServices.Cube
.cue=VLC.cue
.cur=VisualStudio.cur.10.0
.cxx=VisualStudio.cxx.12.0
.dacpac=ssms.dacpac.11.0
.database=AnalysisServices.Database
.datasource=VisualStudio.datasource.10.0
.db=dbfile
.dbml=VisualStudio.ORDesigner.12.0
.dcp=Photoshop.DNGCameraProfile.90
.dcpr=Photoshop.DNGCameraProfileRecipe.90
.dcr=Photoshop.CameraRawFileKodak.90
.dct=Adobe.Illustrator.Dictionary
.dctx=IMEDictionaryCompiler
.dctxc=IMEDictionaryCompiler
.dds=VisualStudio.dds.12.0
.def=VisualStudio.def.12.0
.deploymentoptions=AnalysisServices.Deployment.DeploymentOptions
.deploymenttargets=AnalysisServices.Deployment.Targets
.der=CERFile
.DES=CorelDESIGNER.Graphic.18
.desklink=CLSID\{9E56BE61-C50F-11CF-9A2C-00A0C90A90CE}
.deskthemepack=desktopthemepackfile
.dfproj=DVDFlick
.dgml=VisualStudio.dgml.12.0
.dgsl=VisualStudio.dgsl.12.0
.diagcab=Diagnostic.Cabinet
.diagcfg=Diagnostic.Config
.diagpkg=Diagnostic.Document
.diagsession=VisualStudio.diagsession.12.0
.dib=Paint.Picture
.dic=txtfile
.diff=unified_diff_file
.dim=AnalysisServices.Dimension
.disco=VisualStudio.disco.10.0
.divx=VLC.divx
.dlc=JDownloader2
.dll=dllfile
.dmm=AnalysisServices.MiningStructure
.dmp=VisualStudio.dmp.10.0
.dmx=ssms.dmx.11.0
.dng=Photoshop.CameraRawFileDigital.90
.doc=Word.Document.8
.dochtml=wordhtmlfile
.docm=Word.DocumentMacroEnabled.12
.docmhtml=wordmhtmlfile
.docx=Word.Document.12
.docxml=wordxmlfile
.dot=Word.Template.8
.dothtml=wordhtmltemplate
.dotm=Word.TemplateMacroEnabled.12
.dotx=Word.Template.12
.dqy=dqyfile
.drc=VLC.drc
.dri=SqlServerReplication.Dri
.drv=drvfile
.ds=AnalysisServices.DataSource
.dsn=MSDASQL
.dsp=VisualStudio.dsp.12.0
.dsv=AnalysisServices.DataSourceView
.dsw=VisualStudio.dsw.12.0
.dtd=VisualStudio.dtd.10.0
.dtproj=IntegrationServices.Project.110
.dts=VLC.dts
.dtsConfig=IntegrationServices.Configuration.110
.dtsx=IntegrationServices.Package.110
.dv=VLC.dv
.dwfx=Windows.XPSReachViewer
.dwproj=AnalysisServices.Project
.dxjsproj=VisualStudio.dxjsproj.12.0
.dxsample=dxsample_runner
.eap=Photoshop.ExposureAdjustment
.easmx=Windows.XPSReachViewer
.edmx=VisualStudio.edmx.12.0
.edrwx=Windows.XPSReachViewer
.elm=ELMFile
.emf=emffile
.eml=Microsoft Email Message
.eprtx=Windows.XPSReachViewer
.eps=Adobe.Illustrator.EPS
.etl=wpa.etl_file
.evt=evtfile
.evtx=evtxfile
.exc=txtfile
.exe=exefile
.exp=VisualStudio.exp.12.0
.exr=Photoshop.OpenEXRFile.90
.f4v=VLC.f4v
.fbx=VisualStudio.fbx.12.0
.fdf=FoxitPhantomPDF.FDFDoc
.feedback=Expression.SketchFlow.feedback.12.0
.fff=Photoshop.FFFFile.90
.ffo=Photoshop.FileInfo
.fill=zcf.fillfile
.filters=VisualStudio.vcxproj.filters.12.0
.fl3=Photoshop.FL3FileType.90
.flac=VLC.flac
.flow=Expression.SketchFlow.flow.12.0
.flt=Adobe.Illustrator.Filter
.flv=VLC.flv
.fon=fonfile
.fs=VisualStudio.fs.12.0
.fsi=VisualStudio.fsi.12.0
.fsproj=VisualStudio.Launcher.fsproj.12.0
.fsscript=VisualStudio.fsscript.12.0
.fsx=VisualStudio.fsx.12.0
.ftx=SqlServerReplication.Ftx
.fx=VisualStudio.fx.12.0
.fxg=Adobe.Illustrator.fxg
.gcsx=GCSXFile
.gfe=GU.Encrypted
.gfs=GU.Splitted
.gif=giffile
.glox=GLOXFile
.gmmp=gmmpfile
.gqsx=GQSXFile
.gra=MSGraph.Chart.8
.grd=Photoshop.Gradients
.greenshot=Greenshot
.group=group_wab_auto_file
.grp=MSProgramGroup
.gvi=VLC.gvi
.gxf=VLC.gxf
.gz=WinRAR
.h=VisualStudio.h.12.0
.hdd=progId_VirtualBox.Shell.hdd
.hdmp=VisualStudio.hdmp.10.0
.hdr=Photoshop.PortableBitMapFile.90
.hh=VisualStudio.hh.12.0
.hlp=hlpfile
.hlsl=VisualStudio.hlsl.12.0
.hlsli=VisualStudio.hlsli.12.0
.hpp=VisualStudio.hpp.12.0
.hta=htafile
.htm=OperaStable
.html=OperaStable
.hxa=MSHelp.hxa.2.5
.hxc=MSHelp.hxc.2.5
.hxd=MSHelp.hxd.2.5
.hxe=MSHelp.hxe.2.5
.hxf=MSHelp.hxf.2.5
.hxh=MSHelp.hxh.2.5
.hxi=MSHelp.hxi.2.5
.hxk=MSHelp.hxk.2.5
.hxq=MSHelp.hxq.2.5
.hxr=MSHelp.hxr.2.5
.hxs=MSHelp.hxs.2.5
.hxt=MSHelp.hxt.2.5
.hxv=MSHelp.hxv.2.5
.hxw=MSHelp.hxa.2.5
.hxx=VisualStudio.hxx.12.0
.hyp=Adobe.Illustrator.Hyphen
.i=VisualStudio.i.12.0
.icc=icmfile
.icl=IconLibraryFile
.icm=icmfile
.ico=icofile
.idb=VisualStudio.idb.12.0
.idea=Adobe.Illustrator.idea
.idl=VisualStudio.idl.12.0
.idx=SqlServerReplication.Idx
.ifo=VLC.ifo
.igp=Intel.GraphicsControlPanel.igp.1
.IIQ=Photoshop.IIQFile.90
.ilk=VisualStudio.ilk.12.0
.imesx=imesxfile
.img=Windows.IsoFile
.inc=VisualStudio.inc.12.0
.inf=inffile
.ini=inifile
.inl=VisualStudio.inl.12.0
.iqy=iqyfile
.iros=Photoshop.IRSettings
.irs=Photoshop.IRSettings
.iso=DAEMON.Tools.Lite
.ispac=IntegrationServices.ProjectDeploymentFile.110
.isz=DAEMON.Tools.Lite
.it=VLC.it
.iTrace=VisualStudio.itrace.12.0
.jar=jarfile
.jdc=JDownloader2 1
.jfif=pjpegfile
.jfr=jfrfile
.jnlp=JNLPFile
.Job=JobObject
.jod=Microsoft.Jet.OLEDB.4.0
.jpe=jpegfile
.jpeg=jpegfile
.jpg=jpegfile
.js=JSFile
.JSE=JSEFile
.json=VisualStudio.json.12.0
.jsproj=VisualStudio.Launcher.jsproj.12.0
.jtx=Windows.XPSReachViewer
.jxr=wdpfile
.kmz=Photoshop.KMZFileType.90
.kys=Photoshop.KYSFile.90
.label=Label
.ldf=SQLServer.Engine.LogFile
.less=VisualStudio.less.12.0
.lex=LEXFile
.lha=WinRAR
.lib=VisualStudio.lib.12.0
.library-ms=LibraryFolder
.lic=VisualStudio.lic.12.0
.lnk=lnkfile
.log=txtfile
.lst=VisualStudio.lst.12.0
.lzh=WinRAR
.M1V=VLC.m1v
.M2T=VLC.m2t
.M2TS=VLC.m2ts
.M2V=VLC.m2v
.M3U=VLC.m3u
.m3u8=VLC.m3u8
.M4A=VLC.m4a
.m4p=VLC.m4p
.M4V=VLC.m4v
.mak=VisualStudio.mak.12.0
.map=VisualStudio.map.12.0
.mapimail=CLSID\{9E56BE60-C50F-11CF-9A2C-00A0C90A90CE}
.master=VisualStudio.master.10.0
.mdf=SQLServer.Engine.PrimaryDataFile
.mdmp=VisualStudio.mdmp.10.0
.mdp=VisualStudio.mdp.12.0
.mds=DAEMON.Tools.Lite
.mdx=ssms.mdx.11.0
.mef=Photoshop.MEFFile.90
.metalink=JDownloader2 4
.mfcribbon-ms=VisualStudio.mfcribbon-ms.10.0
.mfw=Photoshop.MFWFile.90
.mht=mhtmlfile
.mhtml=mhtmlfile
.MID=VLC.mid
.MIDI=WMP11.AssocFile.MIDI
.mk=VisualStudio.mk.12.0
.MK3D=WMP11.AssocFile.MK3D
.MKA=VLC.mka
.MKV=VLC.mkv
.mlc=LpkSetup.1
.mlp=VLC.mlp
.mnu=Photoshop.MenuCustomizationFile.90
.MOD=VLC.mod
.mos=Photoshop.CameraRawFileLeaf.90
.MOV=VLC.mov
.mp1=VLC.mp1
.MP2=VLC.mp2
.MP2V=VLC.mp2v
.mp3=VLC.mp3
.MP4=VLC.mp4
.MP4V=VLC.mp4v
.mpa=VLC.mpa
.mpc=VLC.mpc
.MPE=VLC.mpe
.MPEG=VLC.mpeg
.mpeg1=VLC.mpeg1
.mpeg2=VLC.mpeg2
.mpeg4=VLC.mpeg4
.MPG=VLC.mpg
.mpga=VLC.mpga
.MPV2=VLC.mpv2
.ms-windows-store-license=WindowsStore.License
.msc=MSCFile
.msi=Msi.Package
.msp=Msi.Patch
.msrcincident=RemoteAssistance.1
.msstyles=msstylesfile
.msu=Microsoft.System.Update.1
.mtl=Photoshop.MTLFileType.90
.MTS=VLC.mts
.mtv=VLC.mtv
.mxf=VLC.mxf
.mydocs=CLSID\{ECF03A32-103D-11d2-854D-006008059367}
.ncb=VisualStudio.ncb.12.0
.ndf=SQLServer.Engine.SecondaryDataFile
.nex=OperaStable
.nfo=MSInfoFile
.nrg=DAEMON.Tools.Lite
.nsv=VLC.nsv
.nuv=VLC.nuv
.nvram=VMware.VMBios
.obj=VisualStudio.obj.12.0
.ocx=ocxfile
.odc=odcfile
.odccubefile=odccubefile
.odcdatabasefile=odcdatabasefile
.odcnewfile=odcnewfile
.odctablecollectionfile=odctablecollectionfile
.odctablefile=odctablefile
.odh=VisualStudio.odh.12.0
.odl=VisualStudio.odl.12.0
.odp=PowerPoint.OpenDocumentPresentation.12
.ods=Excel.OpenDocumentSpreadsheet.12
.odt=Word.OpenDocumentText.12
.oex=SafeZoneStable.Extension
.oga=VLC.oga
.ogg=VLC.ogg
.ogm=VLC.ogm
.ogv=VLC.ogv
.ogx=VLC.ogx
.oma=VLC.oma
.opc=OPCFile
.opus=VLC.opus
.oqy=oqyfile
.orderedtest=VisualStudio.orderedtest.12.0
.osdx=opensearchdescription
.otf=otffile
.ova=progId_VirtualBox.Shell.ova
.ovf=progId_VirtualBox.Shell.ovf
.ovpn=OpenVPNFile
.oxps=Windows.OXPSConverter
.p10=P10File
.p12=PFXFile
.p3l=Photoshop.P3LFileType.90
.p3m=Photoshop.P3MFileType.90
.p3r=Photoshop.P3RFileType.90
.p7b=SPCFile
.p7c=certificate_wab_auto_file
.p7m=P7MFile
.p7r=P7RFile
.p7s=P7SFile
.pal=VisualStudio.pal.12.0
.pano=Panoramic File
.partial=IE.AssocFile.PARTIAL
.partitions=AnalysisServices.Partitions
.pat=CorelDraw.Graphic.18
.patch=unified_diff_file
.pbk=pbkfile
.pbm=Photoshop.RadianceFile.90
.pcb=PCBFile
.pcd=Photoshop.PCDFile.90
.pch=VisualStudio.pch.12.0
.pcx=Photoshop.PCXFile.90
.pdb=VisualStudio.pdb.12.0
.pdd=Photoshop.PDDFile.90
.pdf=FoxitPhantomPDF.Document
.pdp=Photoshop.PDPFile.90
.perfmoncfg=Diagnostic.Perfmon.Config
.pfm=pfmfile
.pfx=PFXFile
.pif=piffile
.pkgdef=VisualStudio.pkgdef.10.0
.pkgundef=VisualStudio.pkgundef.10.0
.pko=PKOFile
.ple=Photoshop.PLEFileType.90
.pls=VLC.pls
.pnf=pnffile
.png=pngfile
.pot=PowerPoint.Template.8
.pothtml=powerpointhtmltemplate
.potm=PowerPoint.TemplateMacroEnabled.12
.potx=PowerPoint.Template.12
.ppa=PowerPoint.Addin.8
.ppam=PowerPoint.Addin.12
.ppkg=Microsoft.ProvTool.Provisioning.1
.pps=PowerPoint.SlideShow.8
.ppsm=PowerPoint.SlideShowMacroEnabled.12
.ppsx=PowerPoint.SlideShow.12
.ppt=PowerPoint.Show.8
.ppthtml=powerpointhtmlfile
.pptm=PowerPoint.ShowMacroEnabled.12
.pptmhtml=powerpointmhtmlfile
.pptx=PowerPoint.Show.12
.pptxml=powerpointxmlfile
.prc=SqlServerReplication.Prc
.pre=SqlServerReplication.Pre
.prf=prffile
.printerExport=brmFile
.props=VisualStudio.props.12.0
.prs=Corel.PrintStyle
.ps1=Microsoft.PowerShellScript.1
.ps1xml=Microsoft.PowerShellXMLData.1
.psb=Photoshop.PSBFile.90
.psc1=Microsoft.PowerShellConsole.1
.psd=Photoshop.Image.16
.psd1=Microsoft.PowerShellData.1
.psess=VisualStudio.psess.8.0
.psf=Photoshop.ProofSetup
.psm1=Microsoft.PowerShellModule.1
.psp=Photoshop.PreferencesFile
.pssc=Microsoft.PowerShellSessionConfiguration.1
.publishproj=VisualStudio.publishproj.12.0
.pubxml=VisualStudio.pubxml.12.0
.pwz=PowerPoint.Wizard.8
.pxr=Photoshop.PXRFile.90
.qcp=VLC.qcp
.qds=SavedDsQuery
.r00=WinRAR
.r01=WinRAR
.r02=WinRAR
.r03=WinRAR
.r04=WinRAR
.r05=WinRAR
.r06=WinRAR
.r07=WinRAR
.r08=WinRAR
.r09=WinRAR
.r10=WinRAR
.r11=WinRAR
.r12=WinRAR
.r13=WinRAR
.r14=WinRAR
.r15=WinRAR
.r16=WinRAR
.r17=WinRAR
.r18=WinRAR
.r19=WinRAR
.r20=WinRAR
.r21=WinRAR
.r22=WinRAR
.r23=WinRAR
.r24=WinRAR
.r25=WinRAR
.r26=WinRAR
.r27=WinRAR
.r28=WinRAR
.r29=WinRAR
.ra=VLC.ra
.ram=VLC.ram
.rar=WinRAR
.rat=ratfile
.rc=VisualStudio.rc.10.0
.rc2=VisualStudio.rc2.10.0
.rct=VisualStudio.rct.10.0
.rdl=SQLServer.ReportingServices.Designer.ReportDefinition
.rdlc=VisualStudio.rdlc.10.0
.RDP=RDP.File
.rec=VLC.rec
.reg=regfile
.rels=xmlfile
.res=VisualStudio.res.10.0
.resjson=VisualStudio.resjson.12.0
.resmoncfg=Diagnostic.Resmon.Config
.resw=VisualStudio.resw.12.0
.resx=VisualStudio.resx.10.0
.rev=WinRAR.REV
.rgs=VisualStudio.rgs.12.0
.rle=rlefile
.rll=dllfile
.rm=VLC.rm
.RMI=VLC.rmi
.rmvb=VLC.rmvb
.role=AnalysisServices.Role
.rpl=VLC.rpl
.rptproj=SQLServer.ReportingServices.Designer.ProjectFile
.rqy=rqyfile
.rsdf=JDownloader2 3
.rtf=Word.RTF.8
.ruleset=VisualStudio.ruleset.12.0
.s=VisualStudio.s.12.0
.s3m=VLC.s3m
.saz=Fiddler.ArchiveZip
.sbr=VisualStudio.sbr.12.0
.sbx=Adobe.Illustrator.Tsume
.sc2map=Blizzard.SC2Map
.sc2replay=Blizzard.SC2Replay
.sc2save=Blizzard.SC2Save
.scf=SHCmdFile
.sch=SqlServerReplication.Sch
.scm=StarEdit.Scenario
.scp=txtfile
.scr=scrfile
.scss=VisualStudio.scss.12.0
.sct=Photoshop.SCTFile.90
.scx=StarEdit.BWScenario
.sdf=Microsoft SQL Server Compact Edition Database File
.sdl=VisualStudio.sdl.10.0
.sdp=VLC.sdp
.search-ms=SearchFolder
.searchConnector-ms=SearchConnectorFolder
.settingcontent-ms=SettingContent
.settings=VisualStudio.settings.10.0
.sfcache=RDBFileProperties.1
.shc=Photoshop.ShapeCurves
.shh=Photoshop.SHHFile.90
.shproj=VisualStudio.Launcher.shproj.12.0
.shtml=OperaStable
.sitemap=VisualStudio.sitemap.10.0
.skin=VisualStudio.skin.10.0
.skype=Skype.Content
.sld=XnView.Slide
.sldm=PowerPoint.SlideMacroEnabled.12
.sldx=PowerPoint.Slide.12
.slk=Excel.SLK
.sln=VisualStudio.Launcher.sln
.smproj=AnalysisServices.BISMProject
.smrd=Adobe.Illustrator.Filter
.SND=VLC.snd
.snippet=VisualStudio.snippet.10.0
.snk=VisualStudio.snk.10.0
.spc=SPCFile
.spl=ShockwaveFlash.ShockwaveFlash
.spx=VLC.spx
.sql=ssms.sql.11.0
.SQLPlan=ssms.SQLPlan.11.0
.sqlproj=VisualStudio.Launcher.sqlproj.12.0
.srf=Photoshop.CameraRawFileSony.90
.SSISDeploymentManifest=IntegrationServices.DeploymentManifest.110
.ssmsasproj=ssms.ssmsasproj.11.0
.ssmssln=ssms.ssmssln.11.0
.ssmssqlproj=ssms.ssmssqlproj.11.0
.sst=CertificateStoreFile
.sta=Photoshop.STAFile.90
.StormReplay=Blizzard.StormReplay
.stvproj=VisualStudio.StvProj.10
.suo=VisualStudio.Launcher.suo
.svc=VisualStudio.svc.10.0
.svclog=VisualStudio.SvcLog.10
.svg=svgfile
.swf=ShockwaveFlash.ShockwaveFlash
.symlink=.symlink
.sync=VisualStudio.Sync.10.0
.sys=sysfile
.tar=WinRAR
.taz=WinRAR
.tbz=WinRAR
.tbz2=WinRAR
.tc=TrueCryptVolume
.template=AWSCloudFormationTemplate.File
.testrunconfig=VisualStudio.testrunconfig.12.0
.testsettings=VisualStudio.testsettings.12.0
.tgz=WinRAR
.theme=themefile
.themepack=themepackfile
.thmx=OfficeTheme.12
.thp=VLC.thp
.tif=TIFImage.Document
.tiff=TIFImage.Document
.tlh=VisualStudio.tlh.12.0
.tli=VisualStudio.tli.12.0
.tod=VLC.tod
.tpl=Photoshop.ToolPresets
.tray=CorelCONNECT.Tray.5
.trg=SqlServerReplication.Trg
.trn=SqlServerLogShipping.Trn
.trx=VisualStudio.trx.12.0
.TS=VLC.ts
.tsql=ssms.tsql.11.0
.tt=VisualStudio.TextTemplating.10.0
.tta=VLC.tta
.ttc=ttcfile
.ttf=ttffile
.TTS=VLC.tts
.tvc=TeamViewerConfiguration
.tvlink=InternetShortcut
.tvs=TeamViewerSession
.txt=txtfile
.txz=WinRAR
.u3d=Photoshop.U3DFileType.90
.UDL=MSDASC
.url=InternetShortcut
.user=VisualStudio.user.10.0
.uu=WinRAR
.uue=WinRAR
.uxdc=UXDCFILE
.vb=VisualStudio.vb.10.0
.VBE=VBEFile
.vbhtml=VisualStudio.vbhtml.10.0
.vbox=progId_VirtualBox.Shell.vbox
.vbox-extpack=progId_VirtualBox.Shell.vbox-extpack
.vbproj=VisualStudio.Launcher.vbproj.10.0
.vbs=VBSFile
.vcf=vcard_wab_auto_file
.vcp=VisualStudio.vcp.12.0
.vcproj=VisualStudio.Launcher.vcproj.12.0
.vcw=VisualStudio.vcw.12.0
.vcxproj=VisualStudio.Launcher.vcxproj.12.0
.vdi=progId_VirtualBox.Shell.vdi
.vhd=progId_VirtualBox.Shell.vhd
.vhdx=Windows.VhdFile
.vlc=VLC.vlc
.vmac=VMware.Document
.vmba=VMware.Document
.vmdk=progId_VirtualBox.Shell.vmdk
.vmpl=VMware.VMPolicy
.vmsd=VMware.SnapshotMetadata
.vmsn=VMware.Snapshot
.vmss=VMware.SuspendState
.vmt=VMware.Document
.vmtm=VMware.TeamConfiguration
.vmx=VMware.Document
.vmxf=VMware.VMTeamMember
.vob=VLC.vob
.voc=VLC.voc
.vqf=VLC.vqf
.vro=VLC.vro
.vscontent=VisualStudio.ContentInstaller.vscontent
.vsct=VisualStudio.vsct.10.0
.vsglog=VisualStudio.vsglog.12.0
.vsi=VisualStudio.ContentInstaller.vsi
.vsix=VisualStudio.Launcher.vsix
.vsixlangpack=VisualStudio.vsixlangpack.10.0
.vsixmanifest=VisualStudio.vsixmanifest.10.0
.vsmdi=VisualStudio.vsmdi.12.0
.vsp=VisualStudio.vsp.8.0
.vspf=VisualStudio.vspf.8.0
.vsprops=VisualStudio.vsprops.12.0
.vsps=VisualStudio.vsps.8.0
.vspscc=VisualStudio.vspscc.10.0
.vspx=VisualStudio.vspx.8.0
.vsscc=VisualStudio.vsscc.10.0
.vssettings=VisualStudio.vssettings.10.0
.vssscc=VisualStudio.vssscc.10.0
.vstemplate=VisualStudio.vstemplate.10.0
.vsto=bootstrap.vsto.1
.vsz=VisualStudio.vsz.12.0
.vxd=vxdfile
.w64=VLC.w64
.wab=wab_auto_file
.wav=VLC.wav
.WAX=WMP11.AssocFile.WAX
.wbcat=wbcatfile
.wbk=Word.Backup.8
.wcx=wcxfile
.wdp=wdpfile
.webm=VLC.webm
.webpnp=webpnpFile
.website=Microsoft.Website
.wgssl=WatchGuardMobileVPNwithSSL
.win=Adobe CMS Extension
.wiq=VisualStudio.wiq.12.0
.wiz=Word.Wizard.8
.wll=Word.Addin.8
.WM=WMP11.AssocFile.ASF
.WMA=VLC.wma
.WMD=WMP11.AssocFile.WMD
.wmdb=WMP.WMDBFile
.wmf=wmffile
.WMS=WMP11.AssocFile.WMS
.WMV=VLC.wmv
.WMX=WMP11.AssocFile.ASX
.WMZ=WMP11.AssocFile.WMZ
.wpa=wpa.wpa_file
.WPL=WMP11.AssocFile.WPL
.wrk=SqlServerLogShipping.Wrk
.wsc=scriptletfile
.wsdl=VisualStudio.wsdl.10.0
.WSF=WSFFile
.WSH=WSHFile
.wtx=txtfile
.wv=VLC.wv
.WVX=VLC.wvx
.x3f=Photoshop.CameraRawFileFoveon.90
.xa=VLC.xa
.xaml=Windows.XamlDocument
.xamlx=VisualStudio.xamlx.12.0
.xbap=Windows.Xbap
.xdl=ssms.xdl.11.0
.xdr=VisualStudio.xdr.10.0
.xej=Expression.Encoder.XEJ
.xel=Expression.Encoder.XEL
.xesc=VLC.xesc
.xevgenxml=XEV.GenericApp
.xht=OperaStable
.xhtml=OperaStable
.xla=Excel.Addin
.xlam=Excel.AddInMacroEnabled
.xld=Excel.Dialog
.xlk=Excel.Backup
.xll=Excel.XLL
.xlm=Excel.Macrosheet
.xls=Excel.Sheet.8
.xlsb=Excel.SheetBinaryMacroEnabled.12
.xlshtml=Excelhtmlfile
.xlsm=Excel.SheetMacroEnabled.12
.xlsmhtml=excelmhtmlfile
.xlsx=Excel.Sheet.12
.xlt=Excel.Template.8
.xlthtml=Excelhtmltemplate
.xltm=Excel.TemplateMacroEnabled
.xltx=Excel.Template
.xlw=Excel.Workspace
.xlxml=Excelxmlss
.xm=VLC.xm
.xml=xmlfile
.xmla=ssms.xmla.11.0
.XOML=VisualStudio.xoml.12.0
.xpp=SqlServerReplication.Xpp
.xps=Windows.XPSReachViewer
.xrm-ms=MSSppLicenseFile
.xsc=VisualStudio.xsc.10.0
.xsd=VisualStudio.xsd.10.0
.xsl=VisualStudio.xsl.10.0
.xslt=VisualStudio.xslt.10.0
.xspf=VLC.xspf
.xss=VisualStudio.xss.10.0
.xvm=VMware.Console.Config
.xxe=WinRAR
.xz=WinRAR
.z=WinRAR
.ZFSendToTarget=CLSID\{888DCA60-FC0A-11CF-8F0F-00C04FD7D062}
.zip=WinRAR.ZIP
._sln=VisualStudio.Launcher._sln
._sln100=VisualStudio.Launcher._sln100
._sln110=VisualStudio.Launcher._sln110
._sln120=VisualStudio.Launcher._sln120
._sln60=VisualStudio.Launcher._sln60
._sln70=VisualStudio.Launcher._sln70
._sln71=VisualStudio.Launcher._sln71
._sln80=VisualStudio.Launcher._sln80
._sln90=VisualStudio.Launcher._sln90
._vbxsln100=VisualStudio.Launcher._vbxsln100
._vbxsln110=VisualStudio.Launcher._vbxsln110
._vbxsln80=VisualStudio.Launcher._vbxsln80
._vbxsln90=VisualStudio.Launcher._vbxsln90
._vcppxsln100=VisualStudio.Launcher._vcppxsln100
._vcppxsln110=VisualStudio.Launcher._vcppxsln110
._vcppxsln80=VisualStudio.Launcher._vcppxsln80
._vcppxsln90=VisualStudio.Launcher._vcppxsln90
._vcsxsln100=VisualStudio.Launcher._vcsxsln100
._vcsxsln110=VisualStudio.Launcher._vcsxsln110
._vcsxsln80=VisualStudio.Launcher._vcsxsln80
._vcsxsln90=VisualStudio.Launcher._vcsxsln90
._vjsxsln80=VisualStudio.Launcher._vjsxsln80
._vpdxsln100=VisualStudio.Launcher._vpdxsln100
._vpdxsln110=VisualStudio.Launcher._vpdxsln110
._vpdxsln120=VisualStudio.Launcher._vpdxsln120
._vw8xsln110=VisualStudio.Launcher._vw8xsln110
._vwdxsln100=VisualStudio.Launcher._vwdxsln100
._vwdxsln110=VisualStudio.Launcher._vwdxsln110
._vwdxsln120=VisualStudio.Launcher._vwdxsln120
._vwdxsln80=VisualStudio.Launcher._vwdxsln80
._vwdxsln90=VisualStudio.Launcher._vwdxsln90
._vwinxsln120=VisualStudio.Launcher._vwinxsln120
._wdxsln110=VisualStudio.Launcher._wdxsln110
._wdxsln120=VisualStudio.Launcher._wdxsln120

C:\WINDOWS\system32>exit


', 1)
GO
INSERT [dbo].[Job] ([Id], [Name], [Created], [ToExecute], [Executed], [Client], [Command], [Response], [Status]) VALUES (N'e11c5aa8-4a8c-4e92-85cf-3b3c32df28bf', N'ipconfig immediate', CAST(0x0000A70700D35639 AS DateTime), CAST(0x0000A70700D37CA0 AS DateTime), CAST(0x0000A70700D37E76 AS DateTime), N'49533218-b324-4ea8-84d4-681eb4a5acf3', N'ipconfig /all', N'
-----------------------------------------
Response message from Minion service
Time: Thursday, January 26, 2017
-----------------------------------------
Microsoft Windows [Version 10.0.14393]
(c) 2016 Microsoft Corporation. All rights reserved.

C:\WINDOWS\system32>ipconfig /all

Windows IP Configuration

   Host Name . . . . . . . . . . . . : Mauro-Laptop
   Primary Dns Suffix  . . . . . . . : 
   Node Type . . . . . . . . . . . . : Hybrid
   IP Routing Enabled. . . . . . . . : No
   WINS Proxy Enabled. . . . . . . . : No

Wireless LAN adapter Local Area Connection* 16:

   Media State . . . . . . . . . . . : Media disconnected
   Connection-specific DNS Suffix  . : 
   Description . . . . . . . . . . . : Microsoft Wi-Fi Direct Virtual Adapter #2
   Physical Address. . . . . . . . . : 76-29-AF-1A-58-A9
   DHCP Enabled. . . . . . . . . . . : Yes
   Autoconfiguration Enabled . . . . : Yes

Wireless LAN adapter Wi-Fi:

   Connection-specific DNS Suffix  . : 
   Description . . . . . . . . . . . : Realtek RTL8723BE 802.11 bgn Wi-Fi Adapter
   Physical Address. . . . . . . . . : 74-29-AF-1A-58-A9
   DHCP Enabled. . . . . . . . . . . : Yes
   Autoconfiguration Enabled . . . . : Yes
   Link-local IPv6 Address . . . . . : fe80::e467:6924:60fa:ac4e%26(Preferred) 
   IPv4 Address. . . . . . . . . . . : 192.168.0.3(Preferred) 
   Subnet Mask . . . . . . . . . . . : 255.255.255.0
   Lease Obtained. . . . . . . . . . : Thursday, January 26, 2017 8:01:03 AM
   Lease Expires . . . . . . . . . . : Thursday, January 26, 2017 1:31:17 PM
   Default Gateway . . . . . . . . . : 192.168.0.1
   DHCP Server . . . . . . . . . . . : 192.168.0.1
   DHCPv6 IAID . . . . . . . . . . . : 175385007
   DHCPv6 Client DUID. . . . . . . . : 00-01-00-01-1B-F1-D0-62-38-63-BB-E3-7C-3F
   DNS Servers . . . . . . . . . . . : 186.177.65.4
                                       186.176.224.4
   NetBIOS over Tcpip. . . . . . . . : Enabled

Tunnel adapter Local Area Connection* 14:

   Connection-specific DNS Suffix  . : 
   Description . . . . . . . . . . . : Microsoft Teredo Tunneling Adapter
   Physical Address. . . . . . . . . : 00-00-00-00-00-00-00-E0
   DHCP Enabled. . . . . . . . . . . : No
   Autoconfiguration Enabled . . . . : Yes
   IPv6 Address. . . . . . . . . . . : 2001:0:1760:e3e7:3847:3b77:45df:267c(Preferred) 
   Link-local IPv6 Address . . . . . : fe80::3847:3b77:45df:267c%25(Preferred) 
   Default Gateway . . . . . . . . . : ::
   DHCPv6 IAID . . . . . . . . . . . : 419430400
   DHCPv6 Client DUID. . . . . . . . : 00-01-00-01-1B-F1-D0-62-38-63-BB-E3-7C-3F
   NetBIOS over Tcpip. . . . . . . . : Disabled

Tunnel adapter isatap.{DC9E04CF-6A43-4879-A0C8-DCC32AFFB57E}:

   Media State . . . . . . . . . . . : Media disconnected
   Connection-specific DNS Suffix  . : 
   Description . . . . . . . . . . . : Microsoft ISATAP Adapter #2
   Physical Address. . . . . . . . . : 00-00-00-00-00-00-00-E0
   DHCP Enabled. . . . . . . . . . . : No
   Autoconfiguration Enabled . . . . : Yes

C:\WINDOWS\system32>exit


', 1)
GO
INSERT [dbo].[Job] ([Id], [Name], [Created], [ToExecute], [Executed], [Client], [Command], [Response], [Status]) VALUES (N'52e23b50-f05f-4493-8597-61537b44de0f', N'ipconfig immediate', CAST(0x0000A70700D33A25 AS DateTime), CAST(0x0000A70700D33A25 AS DateTime), CAST(0x0000A70700D33A4D AS DateTime), N'49533218-b324-4ea8-84d4-681eb4a5acf3', N'ipconfig /all', N'
-----------------------------------------
Response message from Minion service
Time: Thursday, January 26, 2017
-----------------------------------------
Microsoft Windows [Version 10.0.14393]
(c) 2016 Microsoft Corporation. All rights reserved.

C:\WINDOWS\system32>ipconfig /all

Windows IP Configuration

   Host Name . . . . . . . . . . . . : Mauro-Laptop
   Primary Dns Suffix  . . . . . . . : 
   Node Type . . . . . . . . . . . . : Hybrid
   IP Routing Enabled. . . . . . . . : No
   WINS Proxy Enabled. . . . . . . . : No

Wireless LAN adapter Local Area Connection* 16:

   Media State . . . . . . . . . . . : Media disconnected
   Connection-specific DNS Suffix  . : 
   Description . . . . . . . . . . . : Microsoft Wi-Fi Direct Virtual Adapter #2
   Physical Address. . . . . . . . . : 76-29-AF-1A-58-A9
   DHCP Enabled. . . . . . . . . . . : Yes
   Autoconfiguration Enabled . . . . : Yes

Wireless LAN adapter Wi-Fi:

   Connection-specific DNS Suffix  . : 
   Description . . . . . . . . . . . : Realtek RTL8723BE 802.11 bgn Wi-Fi Adapter
   Physical Address. . . . . . . . . : 74-29-AF-1A-58-A9
   DHCP Enabled. . . . . . . . . . . : Yes
   Autoconfiguration Enabled . . . . : Yes
   Link-local IPv6 Address . . . . . : fe80::e467:6924:60fa:ac4e%26(Preferred) 
   IPv4 Address. . . . . . . . . . . : 192.168.0.3(Preferred) 
   Subnet Mask . . . . . . . . . . . : 255.255.255.0
   Lease Obtained. . . . . . . . . . : Thursday, January 26, 2017 8:01:03 AM
   Lease Expires . . . . . . . . . . : Thursday, January 26, 2017 1:31:17 PM
   Default Gateway . . . . . . . . . : 192.168.0.1
   DHCP Server . . . . . . . . . . . : 192.168.0.1
   DHCPv6 IAID . . . . . . . . . . . : 175385007
   DHCPv6 Client DUID. . . . . . . . : 00-01-00-01-1B-F1-D0-62-38-63-BB-E3-7C-3F
   DNS Servers . . . . . . . . . . . : 186.177.65.4
                                       186.176.224.4
   NetBIOS over Tcpip. . . . . . . . : Enabled

Tunnel adapter Local Area Connection* 14:

   Connection-specific DNS Suffix  . : 
   Description . . . . . . . . . . . : Microsoft Teredo Tunneling Adapter
   Physical Address. . . . . . . . . : 00-00-00-00-00-00-00-E0
   DHCP Enabled. . . . . . . . . . . : No
   Autoconfiguration Enabled . . . . : Yes
   IPv6 Address. . . . . . . . . . . : 2001:0:1760:e3e7:3847:3b77:45df:267c(Preferred) 
   Link-local IPv6 Address . . . . . : fe80::3847:3b77:45df:267c%25(Preferred) 
   Default Gateway . . . . . . . . . : ::
   DHCPv6 IAID . . . . . . . . . . . : 419430400
   DHCPv6 Client DUID. . . . . . . . : 00-01-00-01-1B-F1-D0-62-38-63-BB-E3-7C-3F
   NetBIOS over Tcpip. . . . . . . . : Disabled

Tunnel adapter isatap.{DC9E04CF-6A43-4879-A0C8-DCC32AFFB57E}:

   Media State . . . . . . . . . . . : Media disconnected
   Connection-specific DNS Suffix  . : 
   Description . . . . . . . . . . . : Microsoft ISATAP Adapter #2
   Physical Address. . . . . . . . . : 00-00-00-00-00-00-00-E0
   DHCP Enabled. . . . . . . . . . . : No
   Autoconfiguration Enabled . . . . : Yes

C:\WINDOWS\system32>exit


', 1)
GO
INSERT [dbo].[Job] ([Id], [Name], [Created], [ToExecute], [Executed], [Client], [Command], [Response], [Status]) VALUES (N'0bdcd0cf-228c-402a-8602-be44affb1d5a', N'ipconfig immediate', CAST(0x0000A70700D34B1E AS DateTime), CAST(0x0000A70700D34B1E AS DateTime), CAST(0x0000A70700D34B36 AS DateTime), N'49533218-b324-4ea8-84d4-681eb4a5acf3', N'ipconfig /all', N'
-----------------------------------------
Response message from Minion service
Time: Thursday, January 26, 2017
-----------------------------------------
Microsoft Windows [Version 10.0.14393]
(c) 2016 Microsoft Corporation. All rights reserved.

C:\WINDOWS\system32>ipconfig /all

Windows IP Configuration

   Host Name . . . . . . . . . . . . : Mauro-Laptop
   Primary Dns Suffix  . . . . . . . : 
   Node Type . . . . . . . . . . . . : Hybrid
   IP Routing Enabled. . . . . . . . : No
   WINS Proxy Enabled. . . . . . . . : No

Wireless LAN adapter Local Area Connection* 16:

   Media State . . . . . . . . . . . : Media disconnected
   Connection-specific DNS Suffix  . : 
   Description . . . . . . . . . . . : Microsoft Wi-Fi Direct Virtual Adapter #2
   Physical Address. . . . . . . . . : 76-29-AF-1A-58-A9
   DHCP Enabled. . . . . . . . . . . : Yes
   Autoconfiguration Enabled . . . . : Yes

Wireless LAN adapter Wi-Fi:

   Connection-specific DNS Suffix  . : 
   Description . . . . . . . . . . . : Realtek RTL8723BE 802.11 bgn Wi-Fi Adapter
   Physical Address. . . . . . . . . : 74-29-AF-1A-58-A9
   DHCP Enabled. . . . . . . . . . . : Yes
   Autoconfiguration Enabled . . . . : Yes
   Link-local IPv6 Address . . . . . : fe80::e467:6924:60fa:ac4e%26(Preferred) 
   IPv4 Address. . . . . . . . . . . : 192.168.0.3(Preferred) 
   Subnet Mask . . . . . . . . . . . : 255.255.255.0
   Lease Obtained. . . . . . . . . . : Thursday, January 26, 2017 8:01:03 AM
   Lease Expires . . . . . . . . . . : Thursday, January 26, 2017 1:31:17 PM
   Default Gateway . . . . . . . . . : 192.168.0.1
   DHCP Server . . . . . . . . . . . : 192.168.0.1
   DHCPv6 IAID . . . . . . . . . . . : 175385007
   DHCPv6 Client DUID. . . . . . . . : 00-01-00-01-1B-F1-D0-62-38-63-BB-E3-7C-3F
   DNS Servers . . . . . . . . . . . : 186.177.65.4
                                       186.176.224.4
   NetBIOS over Tcpip. . . . . . . . : Enabled

Tunnel adapter Local Area Connection* 14:

   Connection-specific DNS Suffix  . : 
   Description . . . . . . . . . . . : Microsoft Teredo Tunneling Adapter
   Physical Address. . . . . . . . . : 00-00-00-00-00-00-00-E0
   DHCP Enabled. . . . . . . . . . . : No
   Autoconfiguration Enabled . . . . : Yes
   IPv6 Address. . . . . . . . . . . : 2001:0:1760:e3e7:3847:3b77:45df:267c(Preferred) 
   Link-local IPv6 Address . . . . . : fe80::3847:3b77:45df:267c%25(Preferred) 
   Default Gateway . . . . . . . . . : ::
   DHCPv6 IAID . . . . . . . . . . . : 419430400
   DHCPv6 Client DUID. . . . . . . . : 00-01-00-01-1B-F1-D0-62-38-63-BB-E3-7C-3F
   NetBIOS over Tcpip. . . . . . . . : Disabled

Tunnel adapter isatap.{DC9E04CF-6A43-4879-A0C8-DCC32AFFB57E}:

   Media State . . . . . . . . . . . : Media disconnected
   Connection-specific DNS Suffix  . : 
   Description . . . . . . . . . . . : Microsoft ISATAP Adapter #2
   Physical Address. . . . . . . . . : 00-00-00-00-00-00-00-E0
   DHCP Enabled. . . . . . . . . . . : No
   Autoconfiguration Enabled . . . . : Yes

C:\WINDOWS\system32>exit


', 1)
GO
ALTER TABLE [dbo].[Client_Comm]  WITH CHECK ADD  CONSTRAINT [FK_Client_Comm_Client] FOREIGN KEY([Client])
REFERENCES [dbo].[Client] ([Id])
GO
ALTER TABLE [dbo].[Client_Comm] CHECK CONSTRAINT [FK_Client_Comm_Client]
GO
ALTER TABLE [dbo].[Client_Comm_Line]  WITH CHECK ADD  CONSTRAINT [FK_Client_Comm_Line_Client_Comm] FOREIGN KEY([CommId])
REFERENCES [dbo].[Client_Comm] ([Id])
GO
ALTER TABLE [dbo].[Client_Comm_Line] CHECK CONSTRAINT [FK_Client_Comm_Line_Client_Comm]
GO
ALTER TABLE [dbo].[Client_Handshake]  WITH CHECK ADD  CONSTRAINT [FK_Client_Handshake_Client] FOREIGN KEY([Client])
REFERENCES [dbo].[Client] ([Id])
GO
ALTER TABLE [dbo].[Client_Handshake] CHECK CONSTRAINT [FK_Client_Handshake_Client]
GO
ALTER TABLE [dbo].[Client_Info]  WITH CHECK ADD  CONSTRAINT [FK_Client_Info_Client] FOREIGN KEY([ClientId])
REFERENCES [dbo].[Client] ([Id])
GO
ALTER TABLE [dbo].[Client_Info] CHECK CONSTRAINT [FK_Client_Info_Client]
GO
ALTER TABLE [dbo].[Job]  WITH CHECK ADD  CONSTRAINT [FK_Job_Client] FOREIGN KEY([Client])
REFERENCES [dbo].[Client] ([Id])
GO
ALTER TABLE [dbo].[Job] CHECK CONSTRAINT [FK_Job_Client]
GO
ALTER DATABASE [Mothership] SET  READ_WRITE 
GO
