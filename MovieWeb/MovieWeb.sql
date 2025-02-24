USE [MovieDB1]
GO
/****** Object:  FullTextCatalog [search]    Script Date: 01/11/2024 17:33:20 ******/
CREATE FULLTEXT CATALOG [search] WITH ACCENT_SENSITIVITY = OFF
AS DEFAULT
GO
/****** Object:  UserDefinedTableType [dbo].[udtCommentType]    Script Date: 01/11/2024 17:33:20 ******/
CREATE TYPE [dbo].[udtCommentType] AS TABLE(
	[MaPhim] [int] NULL,
	[TenTaiKhoan] [int] NULL,
	[NoiDung] [nvarchar](max) NULL,
	[ThoiGianCMT] [datetime] NULL
)
GO
/****** Object:  Table [dbo].[Episode]    Script Date: 01/11/2024 17:33:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Episode](
	[MaTapPhim] [int] IDENTITY(1,1) NOT NULL,
	[MaPhim] [int] NULL,
	[SoTapPhim] [int] NULL,
	[Duonglink] [nvarchar](500) NULL,
	[LuotXem] [int] NULL,
 CONSTRAINT [PK_Episode] PRIMARY KEY CLUSTERED 
(
	[MaTapPhim] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tPhim]    Script Date: 01/11/2024 17:33:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tPhim](
	[MaPhim] [int] IDENTITY(1,1) NOT NULL,
	[TenPhim] [nvarchar](100) NULL,
	[MaTheLoai] [int] NULL,
	[Anh] [nvarchar](max) NULL,
	[NgayKhoiChieu] [datetime] NULL,
	[MaTrangThai] [int] NULL,
	[MoTa] [nvarchar](max) NULL,
	[QuocGia] [nvarchar](50) NULL,
	[MaHinhThuc] [int] NULL,
	[GioiHanDoTuoi] [int] NULL,
 CONSTRAINT [PK_tPhim] PRIMARY KEY CLUSTERED 
(
	[MaPhim] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[Top5MovieByView]    Script Date: 01/11/2024 17:33:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   view [dbo].[Top5MovieByView]
AS
    select top 5 tPhim.MaPhim, tenphim,quocgia,anh,sum(luotxem) as viewfilm  from tPhim join Episode on tPhim.MaPhim = Episode.MaPhim 
	group  by tPhim.MaPhim,tenphim,quocgia,anh
	order by sum(luotxem) desc
GO
/****** Object:  View [dbo].[moviewnew]    Script Date: 01/11/2024 17:33:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   view [dbo].[moviewnew]
AS
    select top 10 tPhim.MaPhim, tenphim,quocgia,anh,sum(luotxem) as viewfilm from tPhim join Episode on tPhim.MaPhim = Episode.MaPhim 
	group  by tPhim.MaPhim,tenphim,quocgia,NgayKhoiChieu,anh
	order by NgayKhoiChieu desc
GO
/****** Object:  Table [dbo].[Comment]    Script Date: 01/11/2024 17:33:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Comment](
	[MaComment] [int] IDENTITY(1,1) NOT NULL,
	[MaPhim] [int] NULL,
	[MaTaiKhoan] [int] NULL,
	[NoiDung] [nvarchar](max) NULL,
	[ThoiGianCMT] [datetime] NULL,
 CONSTRAINT [PK_Comment] PRIMARY KEY CLUSTERED 
(
	[MaComment] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DanhGiaChung]    Script Date: 01/11/2024 17:33:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DanhGiaChung](
	[MaTaiKhoan] [int] NOT NULL,
	[MaPhim] [int] NOT NULL,
	[DanhGia] [int] NULL,
 CONSTRAINT [PK_DanhGiaChung] PRIMARY KEY CLUSTERED 
(
	[MaTaiKhoan] ASC,
	[MaPhim] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HinhThuc]    Script Date: 01/11/2024 17:33:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HinhThuc](
	[MaHinhThuc] [int] IDENTITY(1,1) NOT NULL,
	[TenHinhThuc] [nvarchar](50) NULL,
 CONSTRAINT [PK_HinhThuc] PRIMARY KEY CLUSTERED 
(
	[MaHinhThuc] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TaiKhoan]    Script Date: 01/11/2024 17:33:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TaiKhoan](
	[MaTaiKhoan] [int] IDENTITY(1,1) NOT NULL,
	[TenTaiKhoan] [nvarchar](50) NULL,
	[PassWord] [nvarchar](50) NULL,
	[Email] [nvarchar](50) NULL,
	[SoDT] [nvarchar](50) NULL,
	[Anh] [nvarchar](max) NULL,
	[DateUpdate] [datetime] NULL,
	[PhanQuyen] [int] NULL,
	[isDeleted] [int] NULL,
 CONSTRAINT [PK_TaiKhoan] PRIMARY KEY CLUSTERED 
(
	[MaTaiKhoan] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TheLoai]    Script Date: 01/11/2024 17:33:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TheLoai](
	[MaTheLoai] [int] IDENTITY(1,1) NOT NULL,
	[TenTheLoai] [nvarchar](50) NULL,
 CONSTRAINT [PK_TheLoai] PRIMARY KEY CLUSTERED 
(
	[MaTheLoai] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ThoiLuongDaXem]    Script Date: 01/11/2024 17:33:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ThoiLuongDaXem](
	[MaTaiKhoan] [int] NOT NULL,
	[MaTapPhim] [int] NOT NULL,
	[ThoiGianDaXem] [int] NULL,
 CONSTRAINT [PK_ThoiLuongDaXem] PRIMARY KEY CLUSTERED 
(
	[MaTaiKhoan] ASC,
	[MaTapPhim] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TrangThai]    Script Date: 01/11/2024 17:33:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TrangThai](
	[MaTrangThai] [int] IDENTITY(1,1) NOT NULL,
	[TenTrangThai] [nvarchar](50) NULL,
 CONSTRAINT [PK_TrangThai] PRIMARY KEY CLUSTERED 
(
	[MaTrangThai] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Comment] ON 

INSERT [dbo].[Comment] ([MaComment], [MaPhim], [MaTaiKhoan], [NoiDung], [ThoiGianCMT]) VALUES (1, 1, 3, N'I feel bad watching the violent scene, it is so scary ', CAST(N'2022-10-21T00:00:00.000' AS DateTime))
INSERT [dbo].[Comment] ([MaComment], [MaPhim], [MaTaiKhoan], [NoiDung], [ThoiGianCMT]) VALUES (2, 2, 1, N' I feel bad watching the violent scene, it is so scary', CAST(N'2022-10-21T00:00:00.000' AS DateTime))
INSERT [dbo].[Comment] ([MaComment], [MaPhim], [MaTaiKhoan], [NoiDung], [ThoiGianCMT]) VALUES (3, 2, 2, N'Good story line, excellent actors, captivating viewers ', CAST(N'2022-10-21T00:00:00.000' AS DateTime))
INSERT [dbo].[Comment] ([MaComment], [MaPhim], [MaTaiKhoan], [NoiDung], [ThoiGianCMT]) VALUES (4, 3, 1, N'The movie is great, it is worth watching, I am excited to see it ', CAST(N'2022-10-21T00:00:00.000' AS DateTime))
INSERT [dbo].[Comment] ([MaComment], [MaPhim], [MaTaiKhoan], [NoiDung], [ThoiGianCMT]) VALUES (5, 3, 2, N'I feel bad watching the violent scene, it is so scary ', CAST(N'2022-10-21T00:00:00.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[Comment] OFF
GO
INSERT [dbo].[DanhGiaChung] ([MaTaiKhoan], [MaPhim], [DanhGia]) VALUES (1, 1, 1)
INSERT [dbo].[DanhGiaChung] ([MaTaiKhoan], [MaPhim], [DanhGia]) VALUES (1, 2, 0)
INSERT [dbo].[DanhGiaChung] ([MaTaiKhoan], [MaPhim], [DanhGia]) VALUES (1, 3, 1)
INSERT [dbo].[DanhGiaChung] ([MaTaiKhoan], [MaPhim], [DanhGia]) VALUES (2, 1, 1)
INSERT [dbo].[DanhGiaChung] ([MaTaiKhoan], [MaPhim], [DanhGia]) VALUES (2, 2, 1)
INSERT [dbo].[DanhGiaChung] ([MaTaiKhoan], [MaPhim], [DanhGia]) VALUES (4, 1, 1)
INSERT [dbo].[DanhGiaChung] ([MaTaiKhoan], [MaPhim], [DanhGia]) VALUES (5, 1, 0)
INSERT [dbo].[DanhGiaChung] ([MaTaiKhoan], [MaPhim], [DanhGia]) VALUES (5, 3, 0)
INSERT [dbo].[DanhGiaChung] ([MaTaiKhoan], [MaPhim], [DanhGia]) VALUES (6, 1, 0)
INSERT [dbo].[DanhGiaChung] ([MaTaiKhoan], [MaPhim], [DanhGia]) VALUES (6, 2, 0)
INSERT [dbo].[DanhGiaChung] ([MaTaiKhoan], [MaPhim], [DanhGia]) VALUES (6, 3, 0)
GO
SET IDENTITY_INSERT [dbo].[Episode] ON 

INSERT [dbo].[Episode] ([MaTapPhim], [MaPhim], [SoTapPhim], [Duonglink], [LuotXem]) VALUES (1, 1, 1, N'https://www.youtube.com/watch?v=Q9GLCcJ27TA', 14)
INSERT [dbo].[Episode] ([MaTapPhim], [MaPhim], [SoTapPhim], [Duonglink], [LuotXem]) VALUES (2, 1, 2, N'https://www.youtube.com/watch?v=b8u2GPYFeSA', 17)
INSERT [dbo].[Episode] ([MaTapPhim], [MaPhim], [SoTapPhim], [Duonglink], [LuotXem]) VALUES (3, 1, 3, N'https://www.youtube.com/watch?v=t0Q2otsqC4I', 34)
INSERT [dbo].[Episode] ([MaTapPhim], [MaPhim], [SoTapPhim], [Duonglink], [LuotXem]) VALUES (4, 1, 4, N'https://www.youtube.com/watch?v=t-Nw9oz-U6M', 23)
INSERT [dbo].[Episode] ([MaTapPhim], [MaPhim], [SoTapPhim], [Duonglink], [LuotXem]) VALUES (5, 2, 1, N'https://www.youtube.com/watch?v=yCJy9roIv8Q', 14)
INSERT [dbo].[Episode] ([MaTapPhim], [MaPhim], [SoTapPhim], [Duonglink], [LuotXem]) VALUES (6, 3, 1, N'https://www.youtube.com/watch?v=cMaCHa7RDfc', 5)
INSERT [dbo].[Episode] ([MaTapPhim], [MaPhim], [SoTapPhim], [Duonglink], [LuotXem]) VALUES (7, 4, 1, N'https://www.youtube.com/watch?v=ecywu3WnQcc', 234)
INSERT [dbo].[Episode] ([MaTapPhim], [MaPhim], [SoTapPhim], [Duonglink], [LuotXem]) VALUES (8, 4, 2, N'https://www.youtube.com/watch?v=mgqwfJkrGak', 23)
INSERT [dbo].[Episode] ([MaTapPhim], [MaPhim], [SoTapPhim], [Duonglink], [LuotXem]) VALUES (9, 5, 1, N'https://www.youtube.com/watch?v=t0Q2otsqC4I', 78)
INSERT [dbo].[Episode] ([MaTapPhim], [MaPhim], [SoTapPhim], [Duonglink], [LuotXem]) VALUES (10, 5, 3, N'https://www.youtube.com/watch?v=t0Q2otsqC4I', 17)
INSERT [dbo].[Episode] ([MaTapPhim], [MaPhim], [SoTapPhim], [Duonglink], [LuotXem]) VALUES (11, 5, 2, N'https://www.youtube.com/watch?v=t0Q2otsqC4I', 10)
INSERT [dbo].[Episode] ([MaTapPhim], [MaPhim], [SoTapPhim], [Duonglink], [LuotXem]) VALUES (12, 6, 1, N'https://www.youtube.com/watch?v=t0Q2otsqC4I', 5)
INSERT [dbo].[Episode] ([MaTapPhim], [MaPhim], [SoTapPhim], [Duonglink], [LuotXem]) VALUES (13, 7, 1, N'https://www.youtube.com/watch?v=t0Q2otsqC4I', 4)
INSERT [dbo].[Episode] ([MaTapPhim], [MaPhim], [SoTapPhim], [Duonglink], [LuotXem]) VALUES (14, 8, 1, N'https://www.youtube.com/watch?v=t0Q2otsqC4I', 3)
INSERT [dbo].[Episode] ([MaTapPhim], [MaPhim], [SoTapPhim], [Duonglink], [LuotXem]) VALUES (15, 9, 1, N'https://www.youtube.com/watch?v=t0Q2otsqC4I', 2)
INSERT [dbo].[Episode] ([MaTapPhim], [MaPhim], [SoTapPhim], [Duonglink], [LuotXem]) VALUES (16, 10, 1, N'https://www.youtube.com/watch?v=t0Q2otsqC4I', 2)
INSERT [dbo].[Episode] ([MaTapPhim], [MaPhim], [SoTapPhim], [Duonglink], [LuotXem]) VALUES (17, 11, 1, N'https://www.youtube.com/watch?v=t0Q2otsqC4I', 0)
SET IDENTITY_INSERT [dbo].[Episode] OFF
GO
SET IDENTITY_INSERT [dbo].[HinhThuc] ON 

INSERT [dbo].[HinhThuc] ([MaHinhThuc], [TenHinhThuc]) VALUES (1, N'Phim bộ')
INSERT [dbo].[HinhThuc] ([MaHinhThuc], [TenHinhThuc]) VALUES (2, N'Phim lẻ')
SET IDENTITY_INSERT [dbo].[HinhThuc] OFF
GO
SET IDENTITY_INSERT [dbo].[TaiKhoan] ON 

INSERT [dbo].[TaiKhoan] ([MaTaiKhoan], [TenTaiKhoan], [PassWord], [Email], [SoDT], [Anh], [DateUpdate], [PhanQuyen], [isDeleted]) VALUES (1, N'Thu Huong', N'thanhtam12011986', N'thanhtam86@gmail.com', N'0979657676', N'https://kynguyenlamdep.com/wp-content/uploads/2022/08/hinh-dai-dien-nam-deo-khau-trang-ngau.jpg', NULL, 1, 0)
INSERT [dbo].[TaiKhoan] ([MaTaiKhoan], [TenTaiKhoan], [PassWord], [Email], [SoDT], [Anh], [DateUpdate], [PhanQuyen], [isDeleted]) VALUES (2, N'Huong', N'120', N'minh89@gmail.com', N'0968145689', N'https://haycafe.vn/wp-content/uploads/2022/12/hinh-anh-avatar-dep-nam-ngau-chat.jpg', NULL, 2, 0)
INSERT [dbo].[TaiKhoan] ([MaTaiKhoan], [TenTaiKhoan], [PassWord], [Email], [SoDT], [Anh], [DateUpdate], [PhanQuyen], [isDeleted]) VALUES (3, N'quang01', N'6373ddf3790c9b95', NULL, NULL, N'https://antimatter.vn/wp-content/uploads/2022/11/anh-avatar-trang-fb-mac-dinh.jpg', CAST(N'2023-04-24T01:41:07.100' AS DateTime), 1, 1)
INSERT [dbo].[TaiKhoan] ([MaTaiKhoan], [TenTaiKhoan], [PassWord], [Email], [SoDT], [Anh], [DateUpdate], [PhanQuyen], [isDeleted]) VALUES (4, N'ManhQuang', N'6373ddf3790c9b95', NULL, NULL, N'https://antimatter.vn/wp-content/uploads/2022/11/anh-avatar-trang-fb-mac-dinh.jpg', NULL, 2, 0)
INSERT [dbo].[TaiKhoan] ([MaTaiKhoan], [TenTaiKhoan], [PassWord], [Email], [SoDT], [Anh], [DateUpdate], [PhanQuyen], [isDeleted]) VALUES (5, N'Manh', N'0cc175b9c0f1b6a8', NULL, NULL, N'https://antimatter.vn/wp-content/uploads/2022/11/anh-avatar-trang-fb-mac-dinh.jpg', NULL, 1, 0)
INSERT [dbo].[TaiKhoan] ([MaTaiKhoan], [TenTaiKhoan], [PassWord], [Email], [SoDT], [Anh], [DateUpdate], [PhanQuyen], [isDeleted]) VALUES (6, N'DaoQuang', N'6373ddf3790c9b95', NULL, NULL, N'https://antimatter.vn/wp-content/uploads/2022/11/anh-avatar-trang-fb-mac-dinh.jpg', NULL, 1, 0)
INSERT [dbo].[TaiKhoan] ([MaTaiKhoan], [TenTaiKhoan], [PassWord], [Email], [SoDT], [Anh], [DateUpdate], [PhanQuyen], [isDeleted]) VALUES (7, N'admin', N'751cb3f4aa17c361', NULL, NULL, N'https://antimatter.vn/wp-content/uploads/2022/11/anh-avatar-trang-fb-mac-dinh.jpg', NULL, 2, 0)
INSERT [dbo].[TaiKhoan] ([MaTaiKhoan], [TenTaiKhoan], [PassWord], [Email], [SoDT], [Anh], [DateUpdate], [PhanQuyen], [isDeleted]) VALUES (8, N'user', N'6edf26f6e0badff1', NULL, NULL, N'https://antimatter.vn/wp-content/uploads/2022/11/anh-avatar-trang-fb-mac-dinh.jpg', NULL, 1, 0)
SET IDENTITY_INSERT [dbo].[TaiKhoan] OFF
GO
SET IDENTITY_INSERT [dbo].[TheLoai] ON 

INSERT [dbo].[TheLoai] ([MaTheLoai], [TenTheLoai]) VALUES (1, N'Trung Quốc')
INSERT [dbo].[TheLoai] ([MaTheLoai], [TenTheLoai]) VALUES (2, N'Anime')
INSERT [dbo].[TheLoai] ([MaTheLoai], [TenTheLoai]) VALUES (3, N'Khác')
SET IDENTITY_INSERT [dbo].[TheLoai] OFF
GO
INSERT [dbo].[ThoiLuongDaXem] ([MaTaiKhoan], [MaTapPhim], [ThoiGianDaXem]) VALUES (1, 1, 12)
INSERT [dbo].[ThoiLuongDaXem] ([MaTaiKhoan], [MaTapPhim], [ThoiGianDaXem]) VALUES (2, 4, 20)
INSERT [dbo].[ThoiLuongDaXem] ([MaTaiKhoan], [MaTapPhim], [ThoiGianDaXem]) VALUES (3, 2, 35)
GO
SET IDENTITY_INSERT [dbo].[tPhim] ON 

INSERT [dbo].[tPhim] ([MaPhim], [TenPhim], [MaTheLoai], [Anh], [NgayKhoiChieu], [MaTrangThai], [MoTa], [QuocGia], [MaHinhThuc], [GioiHanDoTuoi]) VALUES (1, N'TOM & JERRY', 3, N'https://thuonghieuvaphapluat.vn/Images/Hanhnm/2021/01/14/2021-Tom-va-Jerry%20(7).jpg', CAST(N'2023-04-06T00:00:00.000' AS DateTime), 2, N' Sau nhiều năm chành chọe, nay cặp kỳ phùng địch thủ nổi tiếng nhất thế giới Tom và Jerry đã làm hòa, khăn gói rời khỏi mái nhà chung, và bắt đầu hành trình của riêng mình. Chuột Jerry nay trú ngụ tại một khách sạn sang trọng, nơi chuẩn bị tổ chức một đám cưới Thế kỷ. Cô nhân viên mới Kayla được giao cho nhiệm vụ đuổi Jerry đi nên mang về một chàng mèo “mình đầy kinh nghiệm” đối phó với chuột, không ai khác chính là Tom. Và thế là cuộc chiến mèo - chuột lại nổ ra, kéo theo loạt rắc rối cho khách sạn, và biết bao tình huống dở khóc dở cười.', N' Mỹ', 1, 6)
INSERT [dbo].[tPhim] ([MaPhim], [TenPhim], [MaTheLoai], [Anh], [NgayKhoiChieu], [MaTrangThai], [MoTa], [QuocGia], [MaHinhThuc], [GioiHanDoTuoi]) VALUES (2, N'natra chi ma đồng giáng thế ', 1, N'https://avatar-ex-swe.nixcdn.com/playlist/2019/10/06/1/6/4/7/1570376553113_500.jpg', CAST(N'2023-02-10T00:00:00.000' AS DateTime), 1, N'Tác phẩm hoạt hình làm nên kỳ tích này xoay quanh Na Tra - nhân vật thần thoại vốn đã rất quen thuộc với khán giả Trung Quốc và cả châu Á. Chuyện kể rằng thuở hồng hoang, tinh hoa đất trời hội tụ thành một viên ngọc chứa đựng năng lượng khổng lồ. Nguyên Thủy Thiên Tôn đã phân tách viên ngọc này thành 1 viên Linh Châu và 1 viên Ma Hoàn. Viên Linh Châu sẽ đầu thai thành một anh hùng cứu thế, phò trợ nhà Chu. Trong khi đó, Ma Hoàn sẽ tạo ra một Ma Vương tàn sát thiên hạ. Viên Ma Hoàn đã sinh ra Na Tra-con trai vị tướng biên ải Lý Tịnh, còn Linh Châu sinh ra Ngao Bính-Tam thái tử gánh trọng trách phục hưng long tộc của Đông Hải Long Vương', N'Trung Quốc', 2, 13)
INSERT [dbo].[tPhim] ([MaPhim], [TenPhim], [MaTheLoai], [Anh], [NgayKhoiChieu], [MaTrangThai], [MoTa], [QuocGia], [MaHinhThuc], [GioiHanDoTuoi]) VALUES (3, N'Spirited Away ', 2, N'https://avatar-ex-swe.nixcdn.com/playlist/2019/10/06/1/6/4/7/1570376553113_500.jpg', CAST(N'2023-02-10T00:00:00.000' AS DateTime), 1, N'Đây là bộ phim kể về cô bé bướng bỉnh tên là Chihiro và câu chuyện về gia đình cô bé phải chuyển từ thành phố về quê sinh sống và Chihiro không thích thú với sự thay đổi này. Bố của Chihiro có trí nhớ kém và tay lái yếu nên đã vô tình lái xe bị lạc nên đã đến một thành phố bỏ hoang không ai sinh sống. Tuy nhiên, thức ăn nơi đây có mùi thơm đặc trưng và bố mẹ cô nàng không thể kiềm chế được nên đã thưởng thức và kết quả lại biến thành con heo mập. Kỳ lạ thay, thành phố này về đêm bỗng nhiên xuất hiện những bóng ma bắt đầu xuất hiện và hoạt động. Cô bé bướng bỉnh Chihiro phải làm gì để cứu bố mẹ mình và thoát khỏi đây?', N' Nhật Bản', 2, 13)
INSERT [dbo].[tPhim] ([MaPhim], [TenPhim], [MaTheLoai], [Anh], [NgayKhoiChieu], [MaTrangThai], [MoTa], [QuocGia], [MaHinhThuc], [GioiHanDoTuoi]) VALUES (4, N'Đấu phá thương khung  ', 1, N'https://i.imgur.com/nMWPZqi.jpg', CAST(N'2023-02-10T00:00:00.000' AS DateTime), 2, N'Tác phẩm hoạt hình làm nên kỳ tích này xoay quanh Na Tra - nhân vật thần thoại vốn đã rất quen thuộc với khán giả Trung Quốc và cả châu Á. Chuyện kể rằng thuở hồng hoang, tinh hoa đất trời hội tụ thành một viên ngọc chứa đựng năng lượng khổng lồ. Nguyên Thủy Thiên Tôn đã phân tách viên ngọc này thành 1 viên Linh Châu và 1 viên Ma Hoàn. Viên Linh Châu sẽ đầu thai thành một anh hùng cứu thế, phò trợ nhà Chu. Trong khi đó, Ma Hoàn sẽ tạo ra một Ma Vương tàn sát thiên hạ. Viên Ma Hoàn đã sinh ra Na Tra-con trai vị tướng biên ải Lý Tịnh, còn Linh Châu sinh ra Ngao Bính-Tam thái tử gánh trọng trách phục hưng long tộc của Đông Hải Long Vương', N'Trung Quốc', 2, 13)
INSERT [dbo].[tPhim] ([MaPhim], [TenPhim], [MaTheLoai], [Anh], [NgayKhoiChieu], [MaTrangThai], [MoTa], [QuocGia], [MaHinhThuc], [GioiHanDoTuoi]) VALUES (5, N'Naruto  ', 1, N'https://www.shutterstock.com/shutterstock/photos/2505463083/display_1500/stock-photo-naruto-themed-wallpaper-detailed-vibrant-colors-dynamic-composition-photorealistic-style-2505463083.jpg', CAST(N'2023-02-10T00:00:00.000' AS DateTime), 2, N'Tác phẩm hoạt hình làm nên kỳ tích này xoay quanh Na Tra - nhân vật thần thoại vốn đã rất quen thuộc với khán giả Trung Quốc và cả châu Á. Chuyện kể rằng thuở hồng hoang, tinh hoa đất trời hội tụ thành một viên ngọc chứa đựng năng lượng khổng lồ. Nguyên Thủy Thiên Tôn đã phân tách viên ngọc này thành 1 viên Linh Châu và 1 viên Ma Hoàn. Viên Linh Châu sẽ đầu thai thành một anh hùng cứu thế, phò trợ nhà Chu. Trong khi đó, Ma Hoàn sẽ tạo ra một Ma Vương tàn sát thiên hạ. Viên Ma Hoàn đã sinh ra Na Tra-con trai vị tướng biên ải Lý Tịnh, còn Linh Châu sinh ra Ngao Bính-Tam thái tử gánh trọng trách phục hưng long tộc của Đông Hải Long Vương', N'Trung Quốc', 2, 13)
INSERT [dbo].[tPhim] ([MaPhim], [TenPhim], [MaTheLoai], [Anh], [NgayKhoiChieu], [MaTrangThai], [MoTa], [QuocGia], [MaHinhThuc], [GioiHanDoTuoi]) VALUES (6, N'Dragon Ball  ', 1, N'https://assets-prd.ignimgs.com/2023/10/12/dragon-ball-daima-button-1697147664709.jpg', CAST(N'2023-02-10T00:00:00.000' AS DateTime), 2, N'Tác phẩm hoạt hình làm nên kỳ tích này xoay quanh Na Tra - nhân vật thần thoại vốn đã rất quen thuộc với khán giả Trung Quốc và cả châu Á. Chuyện kể rằng thuở hồng hoang, tinh hoa đất trời hội tụ thành một viên ngọc chứa đựng năng lượng khổng lồ. Nguyên Thủy Thiên Tôn đã phân tách viên ngọc này thành 1 viên Linh Châu và 1 viên Ma Hoàn. Viên Linh Châu sẽ đầu thai thành một anh hùng cứu thế, phò trợ nhà Chu. Trong khi đó, Ma Hoàn sẽ tạo ra một Ma Vương tàn sát thiên hạ. Viên Ma Hoàn đã sinh ra Na Tra-con trai vị tướng biên ải Lý Tịnh, còn Linh Châu sinh ra Ngao Bính-Tam thái tử gánh trọng trách phục hưng long tộc của Đông Hải Long Vương', N'Nhật Bản', 2, 13)
INSERT [dbo].[tPhim] ([MaPhim], [TenPhim], [MaTheLoai], [Anh], [NgayKhoiChieu], [MaTrangThai], [MoTa], [QuocGia], [MaHinhThuc], [GioiHanDoTuoi]) VALUES (7, N'One piece  ', 1, N'https://platform.polygon.com/wp-content/uploads/sites/2/chorus/uploads/chorus_asset/file/23612838/5265_SeriesHeaders_OP_2000x800_wm.jpg?quality=90&strip=all&crop=18.85%2C0%2C60%2C100&w=1200', CAST(N'2023-02-10T00:00:00.000' AS DateTime), 2, N'Tác phẩm hoạt hình làm nên kỳ tích này xoay quanh Na Tra - nhân vật thần thoại vốn đã rất quen thuộc với khán giả Trung Quốc và cả châu Á. Chuyện kể rằng thuở hồng hoang, tinh hoa đất trời hội tụ thành một viên ngọc chứa đựng năng lượng khổng lồ. Nguyên Thủy Thiên Tôn đã phân tách viên ngọc này thành 1 viên Linh Châu và 1 viên Ma Hoàn. Viên Linh Châu sẽ đầu thai thành một anh hùng cứu thế, phò trợ nhà Chu. Trong khi đó, Ma Hoàn sẽ tạo ra một Ma Vương tàn sát thiên hạ. Viên Ma Hoàn đã sinh ra Na Tra-con trai vị tướng biên ải Lý Tịnh, còn Linh Châu sinh ra Ngao Bính-Tam thái tử gánh trọng trách phục hưng long tộc của Đông Hải Long Vương', N'Nhật Bản', 2, 13)
INSERT [dbo].[tPhim] ([MaPhim], [TenPhim], [MaTheLoai], [Anh], [NgayKhoiChieu], [MaTrangThai], [MoTa], [QuocGia], [MaHinhThuc], [GioiHanDoTuoi]) VALUES (8, N'Thế giới hoàn mỹ', 1, N'https://i.imgur.com/D6EBjy4.png', CAST(N'2023-02-10T00:00:00.000' AS DateTime), 2, N'Tác phẩm hoạt hình làm nên kỳ tích này xoay quanh Na Tra - nhân vật thần thoại vốn đã rất quen thuộc với khán giả Trung Quốc và cả châu Á. Chuyện kể rằng thuở hồng hoang, tinh hoa đất trời hội tụ thành một viên ngọc chứa đựng năng lượng khổng lồ. Nguyên Thủy Thiên Tôn đã phân tách viên ngọc này thành 1 viên Linh Châu và 1 viên Ma Hoàn. Viên Linh Châu sẽ đầu thai thành một anh hùng cứu thế, phò trợ nhà Chu. Trong khi đó, Ma Hoàn sẽ tạo ra một Ma Vương tàn sát thiên hạ. Viên Ma Hoàn đã sinh ra Na Tra-con trai vị tướng biên ải Lý Tịnh, còn Linh Châu sinh ra Ngao Bính-Tam thái tử gánh trọng trách phục hưng long tộc của Đông Hải Long Vương', N'Nhật Bản', 2, 13)
INSERT [dbo].[tPhim] ([MaPhim], [TenPhim], [MaTheLoai], [Anh], [NgayKhoiChieu], [MaTrangThai], [MoTa], [QuocGia], [MaHinhThuc], [GioiHanDoTuoi]) VALUES (9, N'Bách luyện thành thần ', 1, N'https://hhninja.xyz/assets/upload/CEfMoPSf26xntHa1681526523.jpeg', CAST(N'2023-02-10T00:00:00.000' AS DateTime), 2, N'Tác phẩm hoạt hình làm nên kỳ tích này xoay quanh Na Tra - nhân vật thần thoại vốn đã rất quen thuộc với khán giả Trung Quốc và cả châu Á. Chuyện kể rằng thuở hồng hoang, tinh hoa đất trời hội tụ thành một viên ngọc chứa đựng năng lượng khổng lồ. Nguyên Thủy Thiên Tôn đã phân tách viên ngọc này thành 1 viên Linh Châu và 1 viên Ma Hoàn. Viên Linh Châu sẽ đầu thai thành một anh hùng cứu thế, phò trợ nhà Chu. Trong khi đó, Ma Hoàn sẽ tạo ra một Ma Vương tàn sát thiên hạ. Viên Ma Hoàn đã sinh ra Na Tra-con trai vị tướng biên ải Lý Tịnh, còn Linh Châu sinh ra Ngao Bính-Tam thái tử gánh trọng trách phục hưng long tộc của Đông Hải Long Vương', N'Trung Quốc', 1, 13)
INSERT [dbo].[tPhim] ([MaPhim], [TenPhim], [MaTheLoai], [Anh], [NgayKhoiChieu], [MaTrangThai], [MoTa], [QuocGia], [MaHinhThuc], [GioiHanDoTuoi]) VALUES (10, N'Nguyên long', 1, N'https://i.pinimg.com/170x/97/ae/61/97ae6100c5394a6043e4a65b9d5262ba.jpg', CAST(N'2023-02-10T00:00:00.000' AS DateTime), 2, N'Tác phẩm hoạt hình làm nên kỳ tích này xoay quanh Na Tra - nhân vật thần thoại vốn đã rất quen thuộc với khán giả Trung Quốc và cả châu Á. Chuyện kể rằng thuở hồng hoang, tinh hoa đất trời hội tụ thành một viên ngọc chứa đựng năng lượng khổng lồ. Nguyên Thủy Thiên Tôn đã phân tách viên ngọc này thành 1 viên Linh Châu và 1 viên Ma Hoàn. Viên Linh Châu sẽ đầu thai thành một anh hùng cứu thế, phò trợ nhà Chu. Trong khi đó, Ma Hoàn sẽ tạo ra một Ma Vương tàn sát thiên hạ. Viên Ma Hoàn đã sinh ra Na Tra-con trai vị tướng biên ải Lý Tịnh, còn Linh Châu sinh ra Ngao Bính-Tam thái tử gánh trọng trách phục hưng long tộc của Đông Hải Long Vương', N'Trung Quốc', 2, 13)
INSERT [dbo].[tPhim] ([MaPhim], [TenPhim], [MaTheLoai], [Anh], [NgayKhoiChieu], [MaTrangThai], [MoTa], [QuocGia], [MaHinhThuc], [GioiHanDoTuoi]) VALUES (11, N'Thiếu niên ca hành', 1, N'https://i.imgur.com/rwjuIya.png', CAST(N'2023-02-10T00:00:00.000' AS DateTime), 2, N'Tác phẩm hoạt hình làm nên kỳ tích này xoay quanh Na Tra - nhân vật thần thoại vốn đã rất quen thuộc với khán giả Trung Quốc và cả châu Á. Chuyện kể rằng thuở hồng hoang, tinh hoa đất trời hội tụ thành một viên ngọc chứa đựng năng lượng khổng lồ. Nguyên Thủy Thiên Tôn đã phân tách viên ngọc này thành 1 viên Linh Châu và 1 viên Ma Hoàn. Viên Linh Châu sẽ đầu thai thành một anh hùng cứu thế, phò trợ nhà Chu. Trong khi đó, Ma Hoàn sẽ tạo ra một Ma Vương tàn sát thiên hạ. Viên Ma Hoàn đã sinh ra Na Tra-con trai vị tướng biên ải Lý Tịnh, còn Linh Châu sinh ra Ngao Bính-Tam thái tử gánh trọng trách phục hưng long tộc của Đông Hải Long Vương', N'Trung Quốc', 2, 13)
SET IDENTITY_INSERT [dbo].[tPhim] OFF
GO
SET IDENTITY_INSERT [dbo].[TrangThai] ON 

INSERT [dbo].[TrangThai] ([MaTrangThai], [TenTrangThai]) VALUES (1, N'Hoàn thành')
INSERT [dbo].[TrangThai] ([MaTrangThai], [TenTrangThai]) VALUES (2, N'Chưa hoàn thành')
INSERT [dbo].[TrangThai] ([MaTrangThai], [TenTrangThai]) VALUES (3, N'Sắp chiếu')
SET IDENTITY_INSERT [dbo].[TrangThai] OFF
GO
ALTER TABLE [dbo].[Comment]  WITH CHECK ADD  CONSTRAINT [FK_Comment_TaiKhoan] FOREIGN KEY([MaTaiKhoan])
REFERENCES [dbo].[TaiKhoan] ([MaTaiKhoan])
GO
ALTER TABLE [dbo].[Comment] CHECK CONSTRAINT [FK_Comment_TaiKhoan]
GO
ALTER TABLE [dbo].[Comment]  WITH CHECK ADD  CONSTRAINT [FK_Comment_tPhim] FOREIGN KEY([MaPhim])
REFERENCES [dbo].[tPhim] ([MaPhim])
GO
ALTER TABLE [dbo].[Comment] CHECK CONSTRAINT [FK_Comment_tPhim]
GO
ALTER TABLE [dbo].[DanhGiaChung]  WITH CHECK ADD  CONSTRAINT [FK_DanhGiaChung_TaiKhoan] FOREIGN KEY([MaTaiKhoan])
REFERENCES [dbo].[TaiKhoan] ([MaTaiKhoan])
GO
ALTER TABLE [dbo].[DanhGiaChung] CHECK CONSTRAINT [FK_DanhGiaChung_TaiKhoan]
GO
ALTER TABLE [dbo].[DanhGiaChung]  WITH CHECK ADD  CONSTRAINT [FK_DanhGiaChung_tPhim] FOREIGN KEY([MaPhim])
REFERENCES [dbo].[tPhim] ([MaPhim])
GO
ALTER TABLE [dbo].[DanhGiaChung] CHECK CONSTRAINT [FK_DanhGiaChung_tPhim]
GO
ALTER TABLE [dbo].[ThoiLuongDaXem]  WITH CHECK ADD  CONSTRAINT [FK_ThoiLuongDaXem_Episode] FOREIGN KEY([MaTapPhim])
REFERENCES [dbo].[Episode] ([MaTapPhim])
GO
ALTER TABLE [dbo].[ThoiLuongDaXem] CHECK CONSTRAINT [FK_ThoiLuongDaXem_Episode]
GO
ALTER TABLE [dbo].[ThoiLuongDaXem]  WITH CHECK ADD  CONSTRAINT [FK_ThoiLuongDaXem_TaiKhoan] FOREIGN KEY([MaTaiKhoan])
REFERENCES [dbo].[TaiKhoan] ([MaTaiKhoan])
GO
ALTER TABLE [dbo].[ThoiLuongDaXem] CHECK CONSTRAINT [FK_ThoiLuongDaXem_TaiKhoan]
GO
ALTER TABLE [dbo].[tPhim]  WITH CHECK ADD  CONSTRAINT [FK_tPhim_HinhThuc] FOREIGN KEY([MaHinhThuc])
REFERENCES [dbo].[HinhThuc] ([MaHinhThuc])
GO
ALTER TABLE [dbo].[tPhim] CHECK CONSTRAINT [FK_tPhim_HinhThuc]
GO
ALTER TABLE [dbo].[tPhim]  WITH CHECK ADD  CONSTRAINT [FK_tPhim_TheLoai] FOREIGN KEY([MaTheLoai])
REFERENCES [dbo].[TheLoai] ([MaTheLoai])
GO
ALTER TABLE [dbo].[tPhim] CHECK CONSTRAINT [FK_tPhim_TheLoai]
GO
ALTER TABLE [dbo].[tPhim]  WITH CHECK ADD  CONSTRAINT [FK_tPhim_TrangThai] FOREIGN KEY([MaTrangThai])
REFERENCES [dbo].[TrangThai] ([MaTrangThai])
GO
ALTER TABLE [dbo].[tPhim] CHECK CONSTRAINT [FK_tPhim_TrangThai]
GO
/****** Object:  StoredProcedure [dbo].[Deletecomment]    Script Date: 01/11/2024 17:33:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   proc [dbo].[Deletecomment] 
@cmtCode int
as
begin
 delete from Comment where macomment=@cmtCode
end
GO
/****** Object:  StoredProcedure [dbo].[insertComment]    Script Date: 01/11/2024 17:33:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   proc [dbo].[insertComment]  
@udtCommentType dbo.udtCommentType READONLY
as
BEGIN

    -- Do something with the UDTT parameters
    insert into Comment 
	select * from @udtCommentType
	
END
GO
/****** Object:  StoredProcedure [dbo].[numcomment]    Script Date: 01/11/2024 17:33:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create    PROCEDURE [dbo].[numcomment] 
	@maphim int
AS
BEGIN
	select count(macomment)
	from Comment a join  TaiKhoan b on a.MaTaiKhoan=b.MaTaiKhoan  
	where MaPhim=@maphim and isDeleted=0
END
GO
/****** Object:  StoredProcedure [dbo].[numVote]    Script Date: 01/11/2024 17:33:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create    PROCEDURE [dbo].[numVote] 
	@maphim int
AS
BEGIN
	select sum(DanhGia)
	from DanhGiaChung   
	where MaPhim=@maphim 
END
GO
/****** Object:  StoredProcedure [dbo].[numVoteUser]    Script Date: 01/11/2024 17:33:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create    PROCEDURE [dbo].[numVoteUser] 
	@maphim int,@mauser int
AS
BEGIN
	select DanhGia
	from DanhGiaChung   
	where MaPhim=@maphim and MaTaiKhoan=@mauser
END
GO
/****** Object:  StoredProcedure [dbo].[putcomment]    Script Date: 01/11/2024 17:33:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create   proc [dbo].[putcomment] 
@content nvarchar(max) ,@cmtCode int
as
begin
 update Comment set noidung=@content where macomment=@cmtCode
end
GO
/****** Object:  StoredProcedure [dbo].[searchMovie]    Script Date: 4/25/2023 1:39:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create or alter   PROCEDURE [dbo].[searchMovie] 
	@name nvarchar(400)
AS
BEGIN
	SET NOCOUNT ON;
	declare @dataSearch nvarchar(400)
	set @dataSearch='"*'+@name+'*"'
	select * from tPhim where  CONTAINS(TenPhim,@dataSearch) 
END
GO
/****** Object:  StoredProcedure [dbo].[updateVoteUser]    Script Date: 01/11/2024 17:33:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create    PROCEDURE [dbo].[updateVoteUser] 
	@maphim int,@mauser int,@data int
AS
BEGIN
	update DanhGiaChung set danhgia=@data  
	where MaPhim=@maphim and MaTaiKhoan=@mauser
END
GO
/****** Object:  StoredProcedure [dbo].[UpView]    Script Date: 01/11/2024 17:33:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create    PROCEDURE [dbo].[UpView] 
	@matapphim int
AS
BEGIN
	update Episode  set LuotXem=LuotXem+1 
	where MaTapPhim=@matapphim 
END
GO
/****** Object:  StoredProcedure [dbo].[ViewMovie]    Script Date: 01/11/2024 17:33:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create    PROCEDURE [dbo].[ViewMovie] 
	@maphim int
AS
BEGIN
	select sum(LuotXem)
	from Episode   
	where MaPhim=@maphim 
END
GO
create proc autodelete
as
begin
update TaiKhoan set isDeleted=0 where datediff(day,DateUpdate,GETDATE()) >= 30
end