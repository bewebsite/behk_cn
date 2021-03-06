
CREATE procedure [dbo].[P_Stores]
(
@ID int,
@Name nvarchar(200),
@AddTime datetime,
@PermissionID nvarchar(4000),
@Result int output
)
as
begin
    declare @Count int,@i int,@ModuleID int,@Permission bigint
    set @Count=0;
    set @i=1;
    if @ID<1
    begin
        insert into TB_Stores values (@Name,@AddTime);
        select @Result=@@identity
    end
    else
    begin
        update TB_Stores set Name=@Name,AddTime=@AddTime where ID=@ID
        set @Result=@ID
    end
    delete from TB_TPermission where RoleID=@ID
    if @PermissionID!=''
    begin
        set @Count=dbo.GetSplitLength(@PermissionID,',');
    	while @i<=@Count
        begin
	    set @ModuleID=convert(int,dbo.GetSplitOfIndex(dbo.GetSplitOfIndex(@PermissionID,',',@i),'_',1));
	    set @Permission=convert(bigint,dbo.GetSplitOfIndex(dbo.GetSplitOfIndex(@PermissionID,',',@i),'_',2));
	    insert into TB_TPermission values (@ModuleID,@ID,@Permission)
	    set @i=@i+1;
        end
    end
end



GO
/****** Object:  StoredProcedure [dbo].[SP_pagination]    Script Date: 2015/8/1 1:11:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_pagination]
(
@sqlstr nvarchar(4000),   --查询字符串
@pageindex int,--第N页
@pagesize int--每页行数
)
as
set nocount on      
declare  
@P1 int,   --P1是游标的id      
@rowcount int
if(@pageindex<1)
begin
    set @pageindex=1
end
exec sp_cursoropen @P1 output,@sqlstr,@scrollopt=1,@ccopt=1,@rowcount=@rowcount output      
select @rowcount as [Count],ceiling(1.0*@rowcount/@pagesize) as [PageCount],@pageindex as PageIndex      
set @pageindex=(@pageindex-1)*@pagesize+1      
exec sp_cursorfetch @P1,16,@pageindex,@pagesize          
exec sp_cursorclose @P1

GO
/****** Object:  UserDefinedFunction [dbo].[GetSplitLength]    Script Date: 2015/8/1 1:11:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---获取数组长度
create function [dbo].[GetSplitLength]
(
  @String nvarchar(4000),  --要分割的字符串
  @Split nvarchar(10)  --分隔符号
)
returns int
as
begin
  declare @location int
  declare @start int
  declare @length int
 
  set @String=ltrim(rtrim(@String))
  set @location=charindex(@split,@String)
  set @length=1
  while @location<>0
  begin
    set @start=@location+1
    set @location=charindex(@split,@String,@start)
    set @length=@length+1
  end
  return @length
end

GO
/****** Object:  UserDefinedFunction [dbo].[GetSplitOfIndex]    Script Date: 2015/8/1 1:11:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---获取数组指定位置元素
create function [dbo].[GetSplitOfIndex]
(
  @String nvarchar(4000),  --要分割的字符串
  @split nvarchar(10),  --分隔符号
  @index int --取第几个元素
)
returns nvarchar(1024)
as
begin
  declare @location int
  declare @start int
  declare @next int
  declare @seed int
 
  set @String=ltrim(rtrim(@String))
  set @start=1
  set @next=1
  set @seed=len(@split)
  
  set @location=charindex(@split,@String)
  while @location<>0 and @index>@next
  begin
    set @start=@location+@seed
    set @location=charindex(@split,@String,@start)
    set @next=@next+1
  end
  if @location =0 select @location =len(@String)+1 
  
  return substring(@String,@start,@location-@start)
end

GO
/****** Object:  Table [dbo].[TB_Admin]    Script Date: 2015/8/1 1:11:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TB_Admin](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[RoleID] [int] NULL,
	[Username] [nvarchar](200) NULL,
	[Password] [nvarchar](200) NULL,
	[Lastloginip] [nvarchar](50) NULL,
	[Lastlogintime] [datetime] NOT NULL,
	[Logincount] [int] NOT NULL,
	[Realname] [nvarchar](200) NULL,
	[Email] [nvarchar](200) NULL,
	[IsPass] [bit] NOT NULL,
	[AddTime] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TB_AdminLog]    Script Date: 2015/8/1 1:11:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TB_AdminLog](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[OperationTypes] [int] NULL,
	[ODescription] [nvarchar](500) NULL,
	[UserName] [nvarchar](200) NULL,
	[IP] [nvarchar](50) NULL,
	[AddTime] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TB_AppointmentComment]    Script Date: 2015/8/1 1:11:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TB_AppointmentComment](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](20) NULL,
	[Mobile] [nvarchar](11) NULL,
	[City] [nvarchar](30) NULL,
	[Age] [nvarchar](20) NULL,
	[Grade] [nvarchar](20) NULL,
	[AbroadTime] [nvarchar](50) NULL,
	[DesireSchool1] [nvarchar](50) NULL,
	[DesireSchool2] [nvarchar](50) NULL,
	[InterviewPlace] [nvarchar](20) NULL,
	[GuestNum] [nvarchar](20) NULL,
	[Comment] [nvarchar](100) NULL,
	[AddTime] [datetime] NULL,
	[IsReached] [bit] NULL,
 CONSTRAINT [PK__TB_Appoi__3214EC273DF3F073] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TB_Country]    Script Date: 2015/8/1 1:11:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TB_Country](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[CNName] [nvarchar](200) NOT NULL,
	[ENName] [nvarchar](200) NOT NULL,
	[Uid] [int] NULL,
 CONSTRAINT [PK__TB_Count__3214EC2754C8D4E2] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TB_GuideGuest]    Script Date: 2015/8/1 1:11:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TB_GuideGuest](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Image] [nvarchar](100) NULL,
	[Position] [nvarchar](100) NOT NULL,
	[Introduction] [nvarchar](1000) NOT NULL,
	[Highlights] [nvarchar](2000) NOT NULL,
	[Sort] [int] NOT NULL,
	[IsPass] [bit] NULL,
	[AddTime] [datetime] NOT NULL,
 CONSTRAINT [PK__TB_Guide__3214EC276A26EED5] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TB_News]    Script Date: 2015/8/1 1:11:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TB_News](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[HtmlName] [nvarchar](50) NOT NULL,
	[PageTitle] [nvarchar](200) NULL,
	[PageKey] [nvarchar](200) NULL,
	[PageDes] [nvarchar](500) NULL,
	[Title] [nvarchar](100) NOT NULL,
	[Image] [nvarchar](100) NULL,
	[Kind] [int] NOT NULL,
	[RelevantSchool] [nvarchar](300) NULL,
	[Lead] [nvarchar](1000) NULL,
	[SourceName] [nvarchar](100) NOT NULL,
	[SourePosition] [nvarchar](100) NULL,
	[SourePhone] [nvarchar](100) NULL,
	[SoureIntor] [nvarchar](1000) NULL,
	[SoureLink] [nvarchar](300) NULL,
	[IsPass] [bit] NULL,
	[Sort] [int] NOT NULL,
	[Click] [int] NULL,
	[AddTime] [datetime] NOT NULL,
 CONSTRAINT [PK__TB_News__3214EC2741FA1472] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TB_NewsIntor]    Script Date: 2015/8/1 1:11:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TB_NewsIntor](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[NewsId] [int] NULL,
	[Title] [nvarchar](100) NULL,
	[Image] [nvarchar](100) NULL,
	[ImageAlt] [nvarchar](100) NULL,
	[Intor] [nvarchar](4000) NULL,
	[Link] [nvarchar](300) NULL,
	[Remarks] [nvarchar](2000) NULL,
	[Sort] [int] NULL,
 CONSTRAINT [PK__TB_NewsI__3214EC27CA096CA9] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TB_NewsType]    Script Date: 2015/8/1 1:11:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TB_NewsType](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[HtmlName] [nvarchar](50) NOT NULL,
	[PageTitle] [nvarchar](200) NULL,
	[PageKey] [nvarchar](200) NULL,
	[PageDes] [nvarchar](500) NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Sort] [int] NOT NULL,
	[IsPass] [bit] NULL,
	[AddTime] [datetime] NOT NULL,
 CONSTRAINT [PK__TB_NewsT__3214EC27D053ED31] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TB_Schools]    Script Date: 2015/8/1 1:11:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TB_Schools](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[HtmlName] [nvarchar](50) NOT NULL,
	[PageTitle] [nvarchar](200) NULL,
	[PageKey] [nvarchar](200) NULL,
	[PageDes] [nvarchar](1000) NULL,
	[CNName] [nvarchar](50) NOT NULL,
	[ENName] [nvarchar](50) NOT NULL,
	[LOGO] [nvarchar](100) NULL,
	[Image] [nvarchar](100) NULL,
	[FoundingTime] [nvarchar](20) NOT NULL,
	[Country] [nvarchar](50) NOT NULL,
	[SchoolType] [nvarchar](20) NOT NULL,
	[AreaSize] [int] NOT NULL,
	[AgeStart] [int] NOT NULL,
	[AgeEnd] [int] NOT NULL,
	[Website] [nvarchar](300) NULL,
	[Followers] [int] NOT NULL,
	[OfficerCNName] [nvarchar](50) NOT NULL,
	[OfficerENName] [nvarchar](50) NOT NULL,
	[OfficerTitle] [nvarchar](100) NOT NULL,
	[OfficerPhone] [nvarchar](100) NULL,
	[OfficerProfile] [nvarchar](1000) NULL,
	[RecommendedReason] [nvarchar](1000) NULL,
	[ApplicationAdvice] [nvarchar](1000) NULL,
	[SchoolIntroduction] [nvarchar](1000) NULL,
	[SchoolTravel] [nvarchar](500) NULL,
	[SchoolEnvironment] [nvarchar](1000) NULL,
	[SouthLatitude] [nvarchar](50) NULL,
	[NorthLatitude] [nvarchar](50) NULL,
	[Location_X] [nvarchar](50) NULL,
	[Location_Y] [nvarchar](50) NULL,
	[ZipCode] [nvarchar](20) NULL,
	[StudentNumber] [int] NOT NULL,
	[PeopleRatio] [nvarchar](20) NULL,
	[BoardingStudent] [nvarchar](50) NULL,
	[BoardingProportion] [int] NOT NULL,
	[InternationalStudent] [int] NOT NULL,
	[InternationalProportion] [int] NOT NULL,
	[ChineseStudent] [int] NOT NULL,
	[SchoolSettings] [nvarchar](1000) NULL,
	[ClassSize] [nvarchar](1000) NULL,
	[MeanScore] [nvarchar](100) NULL,
	[AdmissionRate] [int] NOT NULL,
	[AnnualCost] [decimal](10, 0) NOT NULL,
	[Highlights] [nvarchar](1000) NULL,
	[SchoolMotto] [nvarchar](1000) NULL,
	[EntranceRequirements] [nvarchar](1000) NULL,
	[TeacherStrength] [nvarchar](1000) NULL,
	[StudentCaring] [nvarchar](1000) NULL,
	[AcademicUnits] [nvarchar](1000) NULL,
	[AcademicCourses] [nvarchar](1000) NULL,
	[SpecialCourses] [nvarchar](1000) NULL,
	[SchoolSports] [nvarchar](1000) NULL,
	[SchoolIT] [nvarchar](1000) NULL,
	[SchoolArts] [nvarchar](1000) NULL,
	[Extracurriculum] [nvarchar](1000) NULL,
	[LanguageCourses] [nvarchar](1000) NULL,
	[GraduateAchievement] [nvarchar](1000) NULL,
	[GraduateDestination] [nvarchar](1000) NULL,
	[AcademicFacility] [nvarchar](1000) NULL,
	[SportsFacility] [nvarchar](1000) NULL,
	[ITFacility] [nvarchar](1000) NULL,
	[ArtFacility] [nvarchar](1000) NULL,
	[Accommodation] [nvarchar](1000) NULL,
	[Catering] [nvarchar](1000) NULL,
	[Library] [nvarchar](1000) NULL,
	[RepresentativeCNName] [nvarchar](50) NULL,
	[RepresentativeENName] [nvarchar](50) NULL,
	[RepresentativePhone] [nvarchar](100) NULL,
	[RepresentativeAchievement] [nvarchar](1000) NULL,
	[RepresentativeOther] [nvarchar](1000) NULL,
	[Sort] [int] NOT NULL,
	[IsPass] [bit] NULL,
	[Click] [int] NOT NULL,
	[AddTime] [datetime] NOT NULL,
 CONSTRAINT [PK__TB_Schoo__3214EC27598E63BC] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TB_SchoolsConsultant]    Script Date: 2015/8/1 1:11:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_SchoolsConsultant](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[SchoolId] [int] NULL,
	[CNName] [nvarchar](50) NULL,
	[ENName] [nvarchar](50) NULL,
	[Phone] [varchar](100) NULL,
	[Title] [nvarchar](100) NULL,
	[Comment] [nvarchar](1000) NULL,
	[Sort] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TB_SchoolsImage]    Script Date: 2015/8/1 1:11:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TB_SchoolsImage](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[SchoolId] [int] NULL,
	[Image] [nvarchar](100) NULL,
	[Sort] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TB_SchoolsVoide]    Script Date: 2015/8/1 1:11:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TB_SchoolsVoide](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[SchoolId] [int] NULL,
	[Title] [nvarchar](50) NULL,
	[VoideUrl] [nvarchar](400) NULL,
	[Sort] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TB_Stores]    Script Date: 2015/8/1 1:11:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TB_Stores](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](200) NULL,
	[AddTime] [datetime] NULL,
 CONSTRAINT [PK__TB_Store__3214EC270ED0F014] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TB_Territorial]    Script Date: 2015/8/1 1:11:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TB_Territorial](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](200) NULL,
	[SpellName] [nvarchar](200) NULL,
	[EnglisName] [nvarchar](200) NULL,
	[Kind] [int] NULL,
	[ParentID] [int] NULL,
	[IsPass] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TB_TPermission]    Script Date: 2015/8/1 1:11:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TB_TPermission](
	[FormID] [int] NOT NULL,
	[RoleID] [int] NOT NULL,
	[Permission] [bigint] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TB_Urls]    Script Date: 2015/8/1 1:11:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TB_Urls](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[HtmlUrl] [nvarchar](200) NULL,
	[Url] [nvarchar](200) NULL,
	[AddTime] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  View [dbo].[V_AdminLog]    Script Date: 2015/8/1 1:11:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---操作日志试图
create view [dbo].[V_AdminLog]
as
select ID,OperationTypes,case OperationTypes
	when 0 then '登录'
	when 1 then '添加'
	when 2 then '编辑'
	when 3 then '删除' end as OperationTypesName
,ODescription,UserName,IP,AddTime from TB_AdminLog

GO
/****** Object:  View [dbo].[V_TerritorialOne]    Script Date: 2015/8/1 1:11:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[V_TerritorialOne]
as

select ID,Name,SpellName,EnglisName from TB_Territorial where Kind=1 and IsPass=1
GO
/****** Object:  View [dbo].[V_TerritorialThree]    Script Date: 2015/8/1 1:11:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[V_TerritorialThree]
as

select ID,Name,SpellName,EnglisName,ParentID from TB_Territorial where Kind=3 and IsPass=1
GO
/****** Object:  View [dbo].[V_TerritorialTwo]    Script Date: 2015/8/1 1:11:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[V_TerritorialTwo]
as

select ID,Name,SpellName,EnglisName,ParentID from TB_Territorial where Kind=2 and IsPass=1
GO
SET IDENTITY_INSERT [dbo].[TB_Admin] ON 

GO
INSERT [dbo].[TB_Admin] ([ID], [RoleID], [Username], [Password], [Lastloginip], [Lastlogintime], [Logincount], [Realname], [Email], [IsPass], [AddTime]) VALUES (1, 1, N'admin', N'eyoung2015', N'192.168.1.4', CAST(0x0000A4E700014A4B AS DateTime), 332, N'admin', N'', 1, CAST(0x00009FB400974DFC AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[TB_Admin] OFF
GO
SET IDENTITY_INSERT [dbo].[TB_AdminLog] ON 

GO
INSERT [dbo].[TB_AdminLog] ([ID], [OperationTypes], [ODescription], [UserName], [IP], [AddTime]) VALUES (264, 0, N'登录成功', N'admin', N'192.168.5.150', CAST(0x0000A4E3009DA206 AS DateTime))
GO
INSERT [dbo].[TB_AdminLog] ([ID], [OperationTypes], [ODescription], [UserName], [IP], [AddTime]) VALUES (265, 2, N'职位修改，ID为：1', N'admin', N'192.168.5.150', CAST(0x0000A4E300A645AB AS DateTime))
GO
INSERT [dbo].[TB_AdminLog] ([ID], [OperationTypes], [ODescription], [UserName], [IP], [AddTime]) VALUES (266, 2, N'职位修改，ID为：1', N'admin', N'192.168.5.150', CAST(0x0000A4E300D7A4AE AS DateTime))
GO
INSERT [dbo].[TB_AdminLog] ([ID], [OperationTypes], [ODescription], [UserName], [IP], [AddTime]) VALUES (267, 0, N'登录成功', N'admin', N'192.168.5.150', CAST(0x0000A4E500B416CB AS DateTime))
GO
INSERT [dbo].[TB_AdminLog] ([ID], [OperationTypes], [ODescription], [UserName], [IP], [AddTime]) VALUES (268, 2, N'职位修改，ID为：1', N'admin', N'192.168.5.150', CAST(0x0000A4E500BE657C AS DateTime))
GO
INSERT [dbo].[TB_AdminLog] ([ID], [OperationTypes], [ODescription], [UserName], [IP], [AddTime]) VALUES (269, 1, N'重磅嘉宾添加，ID为：1', N'admin', N'192.168.5.150', CAST(0x0000A4E500C8FB6E AS DateTime))
GO
INSERT [dbo].[TB_AdminLog] ([ID], [OperationTypes], [ODescription], [UserName], [IP], [AddTime]) VALUES (270, 3, N'重磅嘉宾管理ID：1', N'admin', N'192.168.5.150', CAST(0x0000A4E500C8FFC9 AS DateTime))
GO
INSERT [dbo].[TB_AdminLog] ([ID], [OperationTypes], [ODescription], [UserName], [IP], [AddTime]) VALUES (271, 1, N'重磅嘉宾添加，ID为：2', N'admin', N'192.168.5.150', CAST(0x0000A4E500C9EC79 AS DateTime))
GO
INSERT [dbo].[TB_AdminLog] ([ID], [OperationTypes], [ODescription], [UserName], [IP], [AddTime]) VALUES (272, 2, N'重磅嘉宾修改，ID为：2', N'admin', N'192.168.5.150', CAST(0x0000A4E500CA177A AS DateTime))
GO
INSERT [dbo].[TB_AdminLog] ([ID], [OperationTypes], [ODescription], [UserName], [IP], [AddTime]) VALUES (273, 2, N'重磅嘉宾修改，ID为：2', N'admin', N'192.168.5.150', CAST(0x0000A4E500CA5681 AS DateTime))
GO
INSERT [dbo].[TB_AdminLog] ([ID], [OperationTypes], [ODescription], [UserName], [IP], [AddTime]) VALUES (274, 2, N'重磅嘉宾修改，ID为：2', N'admin', N'192.168.5.150', CAST(0x0000A4E500CA6909 AS DateTime))
GO
INSERT [dbo].[TB_AdminLog] ([ID], [OperationTypes], [ODescription], [UserName], [IP], [AddTime]) VALUES (275, 2, N'重磅嘉宾修改，ID为：2', N'admin', N'192.168.5.150', CAST(0x0000A4E500CA8403 AS DateTime))
GO
INSERT [dbo].[TB_AdminLog] ([ID], [OperationTypes], [ODescription], [UserName], [IP], [AddTime]) VALUES (276, 2, N'重磅嘉宾修改，ID为：2', N'admin', N'192.168.5.150', CAST(0x0000A4E500CAA695 AS DateTime))
GO
INSERT [dbo].[TB_AdminLog] ([ID], [OperationTypes], [ODescription], [UserName], [IP], [AddTime]) VALUES (277, 2, N'重磅嘉宾修改，ID为：2', N'admin', N'192.168.5.150', CAST(0x0000A4E500CAC9C6 AS DateTime))
GO
INSERT [dbo].[TB_AdminLog] ([ID], [OperationTypes], [ODescription], [UserName], [IP], [AddTime]) VALUES (278, 2, N'重磅嘉宾修改，ID为：2', N'admin', N'192.168.5.150', CAST(0x0000A4E500CEB0E6 AS DateTime))
GO
INSERT [dbo].[TB_AdminLog] ([ID], [OperationTypes], [ODescription], [UserName], [IP], [AddTime]) VALUES (279, 2, N'重磅嘉宾修改，ID为：2', N'admin', N'192.168.5.150', CAST(0x0000A4E500CEEDB8 AS DateTime))
GO
INSERT [dbo].[TB_AdminLog] ([ID], [OperationTypes], [ODescription], [UserName], [IP], [AddTime]) VALUES (280, 2, N'重磅嘉宾修改，ID为：2', N'admin', N'192.168.5.150', CAST(0x0000A4E500CF0A9D AS DateTime))
GO
INSERT [dbo].[TB_AdminLog] ([ID], [OperationTypes], [ODescription], [UserName], [IP], [AddTime]) VALUES (281, 2, N'重磅嘉宾修改，ID为：2', N'admin', N'192.168.5.150', CAST(0x0000A4E500CF1270 AS DateTime))
GO
INSERT [dbo].[TB_AdminLog] ([ID], [OperationTypes], [ODescription], [UserName], [IP], [AddTime]) VALUES (282, 2, N'重磅嘉宾重新排序', N'admin', N'192.168.5.150', CAST(0x0000A4E500CF4282 AS DateTime))
GO
INSERT [dbo].[TB_AdminLog] ([ID], [OperationTypes], [ODescription], [UserName], [IP], [AddTime]) VALUES (283, 2, N'重磅嘉宾修改，ID为：2', N'admin', N'192.168.5.150', CAST(0x0000A4E500D96B83 AS DateTime))
GO
INSERT [dbo].[TB_AdminLog] ([ID], [OperationTypes], [ODescription], [UserName], [IP], [AddTime]) VALUES (284, 1, N'重磅嘉宾添加，ID为：3', N'admin', N'192.168.5.150', CAST(0x0000A4E500D9BAB8 AS DateTime))
GO
INSERT [dbo].[TB_AdminLog] ([ID], [OperationTypes], [ODescription], [UserName], [IP], [AddTime]) VALUES (285, 1, N'重磅嘉宾添加，ID为：4', N'admin', N'192.168.5.150', CAST(0x0000A4E500D9BDC8 AS DateTime))
GO
INSERT [dbo].[TB_AdminLog] ([ID], [OperationTypes], [ODescription], [UserName], [IP], [AddTime]) VALUES (286, 2, N'重磅嘉宾修改，ID为：2', N'admin', N'192.168.5.150', CAST(0x0000A4E500D9CBC2 AS DateTime))
GO
INSERT [dbo].[TB_AdminLog] ([ID], [OperationTypes], [ODescription], [UserName], [IP], [AddTime]) VALUES (287, 2, N'重磅嘉宾修改，ID为：4', N'admin', N'192.168.5.150', CAST(0x0000A4E500D9DF28 AS DateTime))
GO
INSERT [dbo].[TB_AdminLog] ([ID], [OperationTypes], [ODescription], [UserName], [IP], [AddTime]) VALUES (288, 2, N'招生会报名修改，ID为：6', N'admin', N'192.168.5.150', CAST(0x0000A4E500DBE25C AS DateTime))
GO
INSERT [dbo].[TB_AdminLog] ([ID], [OperationTypes], [ODescription], [UserName], [IP], [AddTime]) VALUES (289, 2, N'SEO修改，ID：00fc913c-cd24-4a39-b038-9f6853bf020c', N'admin', N'192.168.5.150', CAST(0x0000A4E500E17C74 AS DateTime))
GO
INSERT [dbo].[TB_AdminLog] ([ID], [OperationTypes], [ODescription], [UserName], [IP], [AddTime]) VALUES (290, 2, N'SEO修改，ID：00fc913c-cd24-4a39-b038-9f6853bf020c', N'admin', N'192.168.5.150', CAST(0x0000A4E500E182E6 AS DateTime))
GO
INSERT [dbo].[TB_AdminLog] ([ID], [OperationTypes], [ODescription], [UserName], [IP], [AddTime]) VALUES (291, 2, N'取消显示重磅嘉宾ID：2,3', N'admin', N'192.168.5.150', CAST(0x0000A4E500E360A7 AS DateTime))
GO
INSERT [dbo].[TB_AdminLog] ([ID], [OperationTypes], [ODescription], [UserName], [IP], [AddTime]) VALUES (292, 2, N'显示通过重磅嘉宾ID：3', N'admin', N'192.168.5.150', CAST(0x0000A4E500E36DDD AS DateTime))
GO
INSERT [dbo].[TB_AdminLog] ([ID], [OperationTypes], [ODescription], [UserName], [IP], [AddTime]) VALUES (293, 3, N'招生会报名管理ID：6,5,4,3,2,1', N'admin', N'192.168.5.150', CAST(0x0000A4E5010FF9FE AS DateTime))
GO
INSERT [dbo].[TB_AdminLog] ([ID], [OperationTypes], [ODescription], [UserName], [IP], [AddTime]) VALUES (294, 2, N'重磅嘉宾修改，ID为：2', N'admin', N'192.168.5.150', CAST(0x0000A4E50116D2F3 AS DateTime))
GO
INSERT [dbo].[TB_AdminLog] ([ID], [OperationTypes], [ODescription], [UserName], [IP], [AddTime]) VALUES (295, 2, N'重磅嘉宾修改，ID为：2', N'admin', N'192.168.5.150', CAST(0x0000A4E50116DEA5 AS DateTime))
GO
INSERT [dbo].[TB_AdminLog] ([ID], [OperationTypes], [ODescription], [UserName], [IP], [AddTime]) VALUES (296, 1, N'新闻分类添加，ID为：1', N'admin', N'192.168.5.150', CAST(0x0000A4E501185A4C AS DateTime))
GO
INSERT [dbo].[TB_AdminLog] ([ID], [OperationTypes], [ODescription], [UserName], [IP], [AddTime]) VALUES (297, 3, N'系统关键词管理ID：eae28971-64ed-4688-b004-8c13e73ef5d0', N'admin', N'192.168.5.150', CAST(0x0000A4E50122E06A AS DateTime))
GO
INSERT [dbo].[TB_AdminLog] ([ID], [OperationTypes], [ODescription], [UserName], [IP], [AddTime]) VALUES (298, 0, N'登录成功', N'admin', N'192.168.5.150', CAST(0x0000A4E600ACFDB2 AS DateTime))
GO
INSERT [dbo].[TB_AdminLog] ([ID], [OperationTypes], [ODescription], [UserName], [IP], [AddTime]) VALUES (299, 0, N'登录成功', N'admin', N'192.168.5.150', CAST(0x0000A4E600BD5D6C AS DateTime))
GO
INSERT [dbo].[TB_AdminLog] ([ID], [OperationTypes], [ODescription], [UserName], [IP], [AddTime]) VALUES (300, 1, N'新闻添加，ID为：1', N'admin', N'192.168.5.150', CAST(0x0000A4E600C19BBC AS DateTime))
GO
INSERT [dbo].[TB_AdminLog] ([ID], [OperationTypes], [ODescription], [UserName], [IP], [AddTime]) VALUES (301, 2, N'新闻分类修改，ID为：1', N'admin', N'192.168.5.150', CAST(0x0000A4E600C20C05 AS DateTime))
GO
INSERT [dbo].[TB_AdminLog] ([ID], [OperationTypes], [ODescription], [UserName], [IP], [AddTime]) VALUES (302, 0, N'登录成功', N'admin', N'192.168.5.150', CAST(0x0000A4E600D3D2FC AS DateTime))
GO
INSERT [dbo].[TB_AdminLog] ([ID], [OperationTypes], [ODescription], [UserName], [IP], [AddTime]) VALUES (303, 2, N'新闻修改，ID为：1', N'admin', N'192.168.5.150', CAST(0x0000A4E600DF29B4 AS DateTime))
GO
INSERT [dbo].[TB_AdminLog] ([ID], [OperationTypes], [ODescription], [UserName], [IP], [AddTime]) VALUES (304, 2, N'新闻修改，ID为：1', N'admin', N'192.168.5.150', CAST(0x0000A4E600DF3481 AS DateTime))
GO
INSERT [dbo].[TB_AdminLog] ([ID], [OperationTypes], [ODescription], [UserName], [IP], [AddTime]) VALUES (305, 2, N'新闻修改，ID为：1', N'admin', N'192.168.5.150', CAST(0x0000A4E600DF3D3A AS DateTime))
GO
INSERT [dbo].[TB_AdminLog] ([ID], [OperationTypes], [ODescription], [UserName], [IP], [AddTime]) VALUES (306, 2, N'新闻修改，ID为：1', N'admin', N'192.168.5.150', CAST(0x0000A4E600DF4E80 AS DateTime))
GO
INSERT [dbo].[TB_AdminLog] ([ID], [OperationTypes], [ODescription], [UserName], [IP], [AddTime]) VALUES (307, 2, N'新闻修改，ID为：1', N'admin', N'192.168.5.150', CAST(0x0000A4E600E45FD0 AS DateTime))
GO
INSERT [dbo].[TB_AdminLog] ([ID], [OperationTypes], [ODescription], [UserName], [IP], [AddTime]) VALUES (308, 2, N'新闻修改，ID为：1', N'admin', N'192.168.5.150', CAST(0x0000A4E600E48760 AS DateTime))
GO
INSERT [dbo].[TB_AdminLog] ([ID], [OperationTypes], [ODescription], [UserName], [IP], [AddTime]) VALUES (309, 2, N'新闻修改，ID为：1', N'admin', N'192.168.5.150', CAST(0x0000A4E600E4B832 AS DateTime))
GO
INSERT [dbo].[TB_AdminLog] ([ID], [OperationTypes], [ODescription], [UserName], [IP], [AddTime]) VALUES (310, 2, N'新闻修改，ID为：1', N'admin', N'192.168.5.150', CAST(0x0000A4E600E4C35D AS DateTime))
GO
INSERT [dbo].[TB_AdminLog] ([ID], [OperationTypes], [ODescription], [UserName], [IP], [AddTime]) VALUES (311, 2, N'新闻修改，ID为：1', N'admin', N'192.168.5.150', CAST(0x0000A4E600E4CD62 AS DateTime))
GO
INSERT [dbo].[TB_AdminLog] ([ID], [OperationTypes], [ODescription], [UserName], [IP], [AddTime]) VALUES (312, 2, N'新闻修改，ID为：1', N'admin', N'192.168.5.150', CAST(0x0000A4E600E4E6A6 AS DateTime))
GO
INSERT [dbo].[TB_AdminLog] ([ID], [OperationTypes], [ODescription], [UserName], [IP], [AddTime]) VALUES (313, 3, N'新闻管理ID：1', N'admin', N'192.168.5.150', CAST(0x0000A4E600E53C0B AS DateTime))
GO
INSERT [dbo].[TB_AdminLog] ([ID], [OperationTypes], [ODescription], [UserName], [IP], [AddTime]) VALUES (314, 1, N'新闻添加，ID为：2', N'admin', N'192.168.5.150', CAST(0x0000A4E600E5D5CB AS DateTime))
GO
INSERT [dbo].[TB_AdminLog] ([ID], [OperationTypes], [ODescription], [UserName], [IP], [AddTime]) VALUES (315, 2, N'新闻修改，ID为：2', N'admin', N'192.168.5.150', CAST(0x0000A4E600E76B5A AS DateTime))
GO
INSERT [dbo].[TB_AdminLog] ([ID], [OperationTypes], [ODescription], [UserName], [IP], [AddTime]) VALUES (316, 2, N'新闻修改，ID为：2', N'admin', N'192.168.5.150', CAST(0x0000A4E600E77693 AS DateTime))
GO
INSERT [dbo].[TB_AdminLog] ([ID], [OperationTypes], [ODescription], [UserName], [IP], [AddTime]) VALUES (317, 2, N'新闻重新排序', N'admin', N'192.168.5.150', CAST(0x0000A4E600E791A7 AS DateTime))
GO
INSERT [dbo].[TB_AdminLog] ([ID], [OperationTypes], [ODescription], [UserName], [IP], [AddTime]) VALUES (318, 2, N'新闻修改，ID为：2', N'admin', N'192.168.5.150', CAST(0x0000A4E600EBA653 AS DateTime))
GO
INSERT [dbo].[TB_AdminLog] ([ID], [OperationTypes], [ODescription], [UserName], [IP], [AddTime]) VALUES (319, 0, N'登录成功', N'admin', N'192.168.5.150', CAST(0x0000A4E60116869F AS DateTime))
GO
INSERT [dbo].[TB_AdminLog] ([ID], [OperationTypes], [ODescription], [UserName], [IP], [AddTime]) VALUES (320, 2, N'职位修改，ID为：1', N'admin', N'192.168.5.150', CAST(0x0000A4E601169EE1 AS DateTime))
GO
INSERT [dbo].[TB_AdminLog] ([ID], [OperationTypes], [ODescription], [UserName], [IP], [AddTime]) VALUES (321, 0, N'登录成功', N'admin', N'192.168.1.4', CAST(0x0000A4E7000149F1 AS DateTime))
GO
INSERT [dbo].[TB_AdminLog] ([ID], [OperationTypes], [ODescription], [UserName], [IP], [AddTime]) VALUES (322, 2, N'取消显示重磅嘉宾ID：3', N'admin', N'192.168.1.4', CAST(0x0000A4E70001532C AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[TB_AdminLog] OFF
GO
SET IDENTITY_INSERT [dbo].[TB_Country] ON 

GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (1, N'蒙古', N'Mongolia', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (2, N'朝鲜', N'DPRK', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (3, N'韩国', N'Korea', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (4, N'日本', N'Japan', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (5, N'菲律宾', N'Philippines', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (6, N'越南', N'Vietnam', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (7, N'老挝', N'Laos', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (8, N'柬埔寨', N'Cambodia', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (9, N'缅甸', N'Myanmar', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (10, N'泰国', N'Thailand', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (11, N'马来西亚', N'Malaysia', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (12, N'文莱', N'Brunei', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (13, N'新加坡', N'Singapore', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (14, N'印度尼西亚', N'Indonesia', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (15, N'东帝汶', N'Timor-Leste', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (16, N'尼泊尔', N'Nepal', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (17, N'不丹', N'Bhutan', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (18, N'孟加拉国', N'Bangladesh', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (19, N'印度', N'India', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (20, N'巴基斯坦', N'Pakistan', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (21, N'斯里兰卡', N'Sri Lanka', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (22, N'马尔代夫', N'Maldives', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (23, N'哈萨克斯坦', N'Kazakhstan', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (24, N'吉尔吉斯斯坦', N'Kyrgyzstan', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (25, N'塔吉克斯坦', N'Tajikistan', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (26, N'乌兹别克斯坦', N'Uzbekistan', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (27, N'土库曼斯坦', N'Turkmenistan', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (28, N'阿富汗', N'Afghanistan', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (29, N'伊拉克', N'Iraq', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (30, N'伊朗', N'Iran', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (31, N'叙利亚', N'Syria', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (32, N'约旦', N'Jordan', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (33, N'黎巴嫩', N'Lebanon', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (34, N'以色列', N'Israel', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (35, N'巴勒斯坦', N'Palestine', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (36, N'沙特阿拉伯', N'Saudi Abrabia', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (37, N'巴林', N'Bahrain', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (38, N'卡塔尔', N'Qatar', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (39, N'科威特', N'Kuwait', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (40, N'阿拉伯联合酋长国', N'The United Arab Emirates', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (41, N'阿曼', N'Oman', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (42, N'也门', N'Yemen', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (43, N'格鲁吉亚', N'Georgia', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (44, N'亚美尼亚', N'Armenia', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (45, N'阿塞拜疆', N'Azerbaijan', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (46, N'土耳其', N'Turkey', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (47, N'塞浦路斯', N'Cyprus', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (48, N'芬兰', N'Finland', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (49, N'瑞典', N'Sweden', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (50, N'挪威', N'Norway', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (51, N'冰岛', N'Iceland', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (52, N'丹麦', N'Denmark', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (53, N'法罗群岛', N'Faroe Islands', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (54, N'爱沙尼亚', N'Estonia', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (55, N'拉脱维亚', N'Latvia', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (56, N'立陶宛', N'Lithuania', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (57, N'白俄罗斯', N'Belarus', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (58, N'俄罗斯', N'Russian', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (59, N'乌克兰', N'Ukraine', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (60, N'摩尔多瓦', N'Moldova', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (61, N'波兰', N'Polska', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (62, N'捷克', N'Czech', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (63, N'斯洛伐克', N'Slovakia', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (64, N'匈牙利', N'Hungary', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (65, N'德国', N'Germany', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (66, N'奥地利', N'Austria', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (67, N'瑞士', N'Swiss', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (68, N'列支敦士登', N'Liechtenstein', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (69, N'英国', N'UK', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (70, N'爱尔兰', N'Ireland', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (71, N'荷兰', N'Holland', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (72, N'比利时', N'Belgium', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (73, N'卢森堡', N'Luxembourg', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (74, N'法国', N'France', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (75, N'摩纳哥', N'Monaco', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (76, N'罗马尼亚', N'Romania', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (77, N'保加利亚', N'Bulgaria', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (78, N'塞尔维亚', N'Serbia', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (79, N'马其顿', N'Macedonia', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (80, N'阿尔巴尼亚', N'Albania', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (81, N'希腊', N'Republic', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (82, N'斯洛文尼亚', N'Slovenia', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (83, N'克罗地亚', N'Croatia', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (84, N'波斯尼亚和黑塞哥维那', N'Herzegovina', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (85, N'意大利', N'Italy', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (86, N'梵蒂冈', N'Vatican', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (87, N'圣马力诺', N'San Marino', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (88, N'马耳他', N'Malta', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (89, N'西班牙', N'Spain', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (90, N'葡萄牙', N'Portugal', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (91, N'安道尔', N'Andorra', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (92, N'黑山', N'Montenegro', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (93, N'埃及', N'Egypt', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (94, N'利比亚', N'Libya', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (95, N'苏丹', N'Sudan', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (96, N'南苏丹', N'South Sudan', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (97, N'突尼斯', N'Tunisia', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (98, N'阿尔及利亚', N'Algeria', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (99, N'摩洛哥', N'Morocco', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (100, N'亚速尔群岛', N'Azores Islands', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (101, N'马德拉群岛', N'Madeira Islands', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (102, N'埃塞俄比亚', N'Ethiopia', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (103, N'厄立特里亚', N'Eritrea', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (104, N'索马里', N'Somalia', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (105, N'吉布提', N'Djibouti', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (106, N'肯尼亚', N'Kenya', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (107, N'坦桑尼亚', N'Tanzania', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (108, N'乌干达', N'Uganda', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (109, N'卢旺达', N'Rwanda', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (110, N'布隆迪', N'Burundi', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (111, N'塞舌尔', N'Seychelles', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (112, N'乍得', N'Chad', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (113, N'中非', N'Central African Republic', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (114, N'喀麦隆', N'Cameroon', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (115, N'赤道几内亚', N'Equatorial Guinea', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (116, N'加蓬', N'Gabon', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (117, N'刚果共和国', N'Republic of Congo', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (118, N'刚果民主共和国', N'Democratic Republic Of Congo', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (119, N'圣多美及普林西比', N'Sao Tome and Principe', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (120, N'毛里塔尼亚', N'Mauritania', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (121, N'西撒哈拉', N'Sahara Occidental', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (122, N'塞内加尔', N'Senegal', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (123, N'冈比亚', N'Gambia', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (124, N'马里', N'Mali', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (125, N'布基纳法索', N'Burkina Faso', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (126, N'几内亚', N'Guinea', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (127, N'几内亚比绍', N'Guinea-Bissau', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (128, N'佛得角', N'Cape Verde', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (129, N'塞拉利昂', N'Sierra Leone', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (130, N'利比里亚', N'Liberia', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (131, N'科特迪瓦', N'Coate d''Ivorie', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (132, N'加纳', N'Ghana', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (133, N'多哥', N'Togolaise', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (134, N'贝宁', N'Benin', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (135, N'尼日尔', N'Niger', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (136, N'加那利群岛', N'Canary Islands', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (137, N'赞比亚', N'Zambia', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (138, N'安哥拉', N'Angola', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (139, N'津巴布韦', N'Zimbabwe', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (140, N'马拉维', N'Malawi', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (141, N'莫桑比克', N'Mozambique', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (142, N'博茨瓦纳', N'Botswana', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (143, N'纳米比亚', N'Namibia', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (144, N'南非', N'Africa', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (145, N'斯威士兰', N'Swaziland', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (146, N'莱索托', N'Lesotho', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (147, N'马达加斯加', N'Madagascar', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (148, N'科摩罗', N'Comoros', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (149, N'毛里求斯', N'Mauritius', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (150, N'留尼汪岛', N'Reunion Island', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (151, N'圣赫勒拿岛', N'Saint Helena', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (152, N'阿森松岛', N'Ascension Island', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (153, N'澳大利亚', N'Australia', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (154, N'新西兰', N'New Zealand', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (155, N'巴布亚新几内亚', N'Papua New Guinea', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (156, N'所罗门群岛', N'Solomon Islands', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (157, N'瓦努阿图', N'Vanuatu', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (158, N'密克罗尼西亚', N'Micronesia', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (159, N'马绍尔群岛', N'arshall Island', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (160, N'帕劳', N'Belau', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (161, N'瑙鲁', N'Nauru', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (162, N'基里巴斯', N'Kiribati', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (163, N'图瓦卢', N'Tuvalu', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (164, N'萨摩亚', N'Samoa', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (165, N'斐济群岛', N'Fiji Islands', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (166, N'汤加', N'Tonga', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (167, N'库克群岛', N'Cook Islands', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (168, N'关岛', N'Guam', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (169, N'新喀里多尼亚', N'New Caledonia', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (170, N'法属波利尼西亚', N'French Polynesia', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (171, N'皮特凯恩岛', N'Pitcairn Islands', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (172, N'瓦利斯与富图纳', N'Wallis et Futuna', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (173, N'纽埃', N'Niue', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (174, N'托克劳', N'Tokelau Islands', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (175, N'美属萨摩亚', N'American Samoa', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (176, N'北马里亚纳', N'Northern Mariana Islands', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (177, N'加拿大', N'Canada', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (178, N'美国', N'USA', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (179, N'墨西哥', N'Mexico', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (180, N'格陵兰', N'Greenland', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (181, N'危地马拉', N'Guatemala', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (182, N'伯利兹', N'Belize', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (183, N'萨尔瓦多', N'Salvador', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (184, N'洪都拉斯', N'Honduras', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (185, N'尼加拉瓜', N'Nicaragua', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (186, N'哥斯达黎加', N'Costa Rica', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (187, N'巴拿马', N'Panama', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (188, N'巴哈马', N'Bahamas', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (189, N'古巴', N'Cuba', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (190, N'牙买加', N'Jamaica', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (191, N'海地', N'Haiti', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (192, N'多米尼加', N'Dominican Republic', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (193, N'安提瓜和巴布达', N'Antigua and Barbuda', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (194, N'圣基茨和尼维斯', N'St Kitts and Nevis', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (195, N'多米尼克', N'Dominica', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (196, N'圣卢西亚', N'Saint Lucia', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (197, N'圣文森特和格林纳丁斯', N'St. Vincent and The Grenadines', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (198, N'格林纳达', N'Grenada', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (199, N'巴巴多斯', N'Barbados', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (200, N'特立尼达和多巴哥', N'Trinidad and Tobago', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (201, N'波多黎各', N'Commonwealth of Puerto Rico', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (202, N'英属维尔京群岛', N'British Virgin Islands', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (203, N'美属维尔京群岛', N'United States Virgin Islands', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (204, N'安圭拉', N'Anguilla', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (205, N'蒙特塞拉特', N'Montserrat', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (206, N'瓜德罗普', N'Guadeloupe', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (207, N'马提尼克', N'Martinique', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (208, N'荷属安的列斯', N'Netherlands Antilles', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (209, N'阿鲁巴', N'Aruba', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (210, N'特克斯和凯科斯群岛', N'Turks and Caicos Islands', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (211, N'开曼群岛', N'Cayman Islands', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (212, N'百慕大三角', N'Bermuda Triangle', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (213, N'哥伦比亚', N'Columbia', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (214, N'委内瑞拉', N'Venezuela', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (215, N'圭亚那', N'Guyana', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (216, N'法属圭亚那', N'French Guiana', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (217, N'苏里南', N'Surinam', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (218, N'厄瓜多尔', N'Ecuador', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (219, N'秘鲁', N'Peru', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (220, N'玻利维亚', N'Bolivia', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (221, N'巴西', N'Brazil', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (222, N'智利', N'Chile', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (223, N'阿根廷', N'Argentina', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (224, N'乌拉圭', N'Uruguay', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (225, N'巴拉圭', N'Paraguay', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (226, N'尼日利亚', N'Nigeria', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (227, N'中国大陆', N'China Mainland', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (228, N'中国香港', N'China Hong Kong', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (229, N'中国台湾', N'Chian Taiwan', 0)
GO
INSERT [dbo].[TB_Country] ([ID], [CNName], [ENName], [Uid]) VALUES (230, N'中国澳门', N'China Macau', 0)
GO
SET IDENTITY_INSERT [dbo].[TB_Country] OFF
GO
SET IDENTITY_INSERT [dbo].[TB_GuideGuest] ON 

GO
INSERT [dbo].[TB_GuideGuest] ([ID], [Name], [Image], [Position], [Introduction], [Highlights], [Sort], [IsPass], [AddTime]) VALUES (2, N'William Vanbergen', N'/UploadImage/GuideGuests//20150730123355248.jpg', N'必益教育创始人兼执行总裁', N'必益教育创始人William Vanbergen先生毕业于英国曼彻斯特大学，于2003年在华创建了必益教育致力于帮助中国学生顺利进入国际顶尖名校。', N'一对一现场招生面试
高端国际教育讲座
免费家庭教育规划专家咨询', 20, 0, CAST(0x0000A4E500C9E0DC AS DateTime))
GO
INSERT [dbo].[TB_GuideGuest] ([ID], [Name], [Image], [Position], [Introduction], [Highlights], [Sort], [IsPass], [AddTime]) VALUES (3, N'William Vanbergen', N'/UploadImage/GuideGuests//20150730123355248.jpg', N'必益教育创始人兼执行总裁', N'必益教育创始人William Vanbergen先生毕业于英国曼彻斯特大学，于2003年在华创建了必益教育致力于帮助中国学生顺利进入国际顶尖名校。', N'一对一现场招生面试
高端国际教育讲座
免费家庭教育规划专家咨询', 20, 0, CAST(0x0000A4E500C9E0DC AS DateTime))
GO
INSERT [dbo].[TB_GuideGuest] ([ID], [Name], [Image], [Position], [Introduction], [Highlights], [Sort], [IsPass], [AddTime]) VALUES (4, N'William Vanbergen', N'/UploadImage/GuideGuests//20150730123355248.jpg', N'必益教育创始人兼执行总裁', N'必益教育创始人William Vanbergen先生毕业于英国曼彻斯特大学，于2003年在华创建了必益教育致力于帮助中国学生顺利进入国际顶尖名校。', N'一对一现场招生面试
高端国际教育讲座
免费家庭教育规划专家咨询', 20, 1, CAST(0x0000A4E500C9E0DC AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[TB_GuideGuest] OFF
GO
SET IDENTITY_INSERT [dbo].[TB_News] ON 

GO
INSERT [dbo].[TB_News] ([ID], [HtmlName], [PageTitle], [PageKey], [PageDes], [Title], [Image], [Kind], [RelevantSchool], [Lead], [SourceName], [SourePosition], [SourePhone], [SoureIntor], [SoureLink], [IsPass], [Sort], [Click], [AddTime]) VALUES (2, N'hehe', N'测试新闻测试新闻测试新闻测试新闻测试新闻测试新闻测试新闻', N'测试新闻测试新闻测试新闻测试新闻测试新闻测试新闻', N'测试新闻测试新闻测试新闻测试新闻测试新闻测试新闻测试新闻测试新闻测试新闻', N'测试新闻测试新闻测试新闻测试新闻测试新闻测试新闻', N'', 1, N'', N'测试新闻测试新闻测试新闻测试新闻测试新闻测试新闻新闻导语', N'测试新闻测试新闻测试新闻测试新闻来源名称', N'测试新闻测试新闻', N'', N'测试新闻测试新闻测试新闻测试新闻测试新闻测试新闻测试新闻', N'', 1, 10, 0, CAST(0x0000A4E600E570B8 AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[TB_News] OFF
GO
SET IDENTITY_INSERT [dbo].[TB_NewsIntor] ON 

GO
INSERT [dbo].[TB_NewsIntor] ([ID], [NewsId], [Title], [Image], [ImageAlt], [Intor], [Link], [Remarks], [Sort]) VALUES (1003, 2, N'章节标题章节标题章节标题章节标题', N'', N'图片说明图片说明图片说明', N'详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容
详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容
详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容', N'参考连接参考连接参考连接', N'备注信息备注信息备注信息备注信息备注信息备注信息
备注信息备注信息备注信息备注信息备注信息备注信息备注信息备注信息备注信息备注信息
备注信息备注信息备注信息备注信息备注信息备注信息备注信息
备注信息备注信息备注信息备注信息备注信息备注信息备注信息备注信息备注信息备注信息备注信息备注信息备注信息备注信息备注信息备注信息备注信息备注信息
备注信息备注信息备注信息备注信息备注信息备注信息备注信息备注信息备注信息备注信息备注信息备注信息备注信息备注信息', 10)
GO
INSERT [dbo].[TB_NewsIntor] ([ID], [NewsId], [Title], [Image], [ImageAlt], [Intor], [Link], [Remarks], [Sort]) VALUES (1004, 2, N'章节标题章节标题章节标题章节标题章节标题2', N'', N'图片说明图片说明图片说明图片说明图片说明2', N'详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容
详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容
详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容
详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容', N'', N'', 9)
GO
SET IDENTITY_INSERT [dbo].[TB_NewsIntor] OFF
GO
SET IDENTITY_INSERT [dbo].[TB_NewsType] ON 

GO
INSERT [dbo].[TB_NewsType] ([ID], [HtmlName], [PageTitle], [PageKey], [PageDes], [Name], [Sort], [IsPass], [AddTime]) VALUES (1, N'commpany', N'公司新闻', N'公司新闻', N'公司新闻', N'公司新闻', 0, 1, CAST(0x0000A4E501184E98 AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[TB_NewsType] OFF
GO
SET IDENTITY_INSERT [dbo].[TB_Stores] ON 

GO
INSERT [dbo].[TB_Stores] ([ID], [Name], [AddTime]) VALUES (1, N'总管理员', CAST(0x0000A2A501029BE8 AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[TB_Stores] OFF
GO
SET IDENTITY_INSERT [dbo].[TB_Territorial] ON 

GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1, N'北京市', N'北京', N'', 1, 0, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2, N'昌平区', N'昌平', N'', 2, 1, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3, N'朝阳区', N'朝阳', N'', 2, 1, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (4, N'大兴区', N'大兴', N'', 2, 1, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (5, N'东城区', N'东城', N'', 2, 1, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (6, N'房山区', N'房山', N'', 2, 1, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (7, N'丰台区', N'丰台', N'', 2, 1, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (8, N'怀柔区', N'怀柔', N'', 2, 1, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (9, N'门头沟区', N'门头沟', N'', 2, 1, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (10, N'平谷区', N'平谷', N'', 2, 1, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (11, N'石景山区', N'石景山', N'', 2, 1, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (12, N'顺义区', N'顺义', N'', 2, 1, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (13, N'通州区', N'通州', N'', 2, 1, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (14, N'西城区', N'西城', N'', 2, 1, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (15, N'密云县', N'密云', N'', 2, 1, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (16, N'延庆县', N'延庆', N'', 2, 1, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (17, N'上海市', N'上海', N'', 1, 0, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (18, N'奉贤区', N'奉贤', N'', 2, 17, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (19, N'虹口区', N'虹口', N'', 2, 17, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (20, N'黄浦区', N'黄浦', N'', 2, 17, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (21, N'嘉定区', N'嘉定', N'', 2, 17, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (22, N'金山区', N'金山', N'', 2, 17, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (23, N'静安区', N'静安', N'', 2, 17, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (24, N'闵行区', N'闵行', N'', 2, 17, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (25, N'浦东新区', N'浦东新', N'', 2, 17, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (26, N'普陀区', N'普陀', N'', 2, 17, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (27, N'青浦区', N'青浦', N'', 2, 17, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (28, N'松江区', N'松江', N'', 2, 17, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (29, N'徐汇区', N'徐汇', N'', 2, 17, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (30, N'杨浦区', N'杨浦', N'', 2, 17, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (31, N'闸北区', N'闸北', N'', 2, 17, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (32, N'长宁区', N'长宁', N'', 2, 17, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (33, N'崇明县', N'崇明', N'', 2, 17, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (34, N'天津市', N'天津', N'', 1, 0, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (35, N'宝坻区', N'宝坻', N'', 2, 34, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (36, N'北辰区', N'北辰', N'', 2, 34, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (37, N'滨海新区', N'滨海新', N'', 2, 34, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (38, N'东丽区', N'东丽', N'', 2, 34, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (39, N'和平区', N'和平', N'', 2, 34, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (40, N'河北区', N'河北', N'', 2, 34, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (41, N'河东区', N'河东', N'', 2, 34, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (42, N'河西区', N'河西', N'', 2, 34, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (43, N'红桥区', N'红桥', N'', 2, 34, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (44, N'津南区', N'津南', N'', 2, 34, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (45, N'南开区
', N'南开
', N'', 2, 34, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (46, N'武清区
', N'武清
', N'', 2, 34, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (47, N'西青区
', N'西青
', N'', 2, 34, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (48, N'蓟县
', N'蓟
县', N'', 2, 34, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (49, N'静海县
', N'静海
', N'', 2, 34, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (50, N'宁河县
', N'宁河
', N'', 2, 34, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (51, N'重庆市', N'重庆市', N'', 1, 0, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (52, N'巴南区', N'巴南', N'', 2, 51, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (53, N'北碚区
', N'北碚
', N'', 2, 51, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (54, N'大渡口区
', N'大渡口
', N'', 2, 51, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (55, N'涪陵区
', N'涪陵
', N'', 2, 51, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (56, N'合川区
', N'合川
', N'', 2, 51, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (57, N'江北区
', N'江北
', N'', 2, 51, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (58, N'江津区
', N'江津
', N'', 2, 51, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (59, N'九龙坡区
', N'九龙坡
', N'', 2, 51, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (60, N'南岸区
', N'南岸
', N'', 2, 51, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (61, N'南川区
', N'南川
', N'', 2, 51, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (62, N'黔江区
', N'黔江
', N'', 2, 51, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (63, N'沙坪坝区
', N'沙坪坝
', N'', 2, 51, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (64, N'万州区
', N'万州
', N'', 2, 51, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (65, N'永川区
', N'永川
', N'', 2, 51, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (66, N'渝北区
', N'渝北
', N'', 2, 51, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (67, N'渝中区
', N'渝中
', N'', 2, 51, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (68, N'长寿区
', N'长寿
', N'', 2, 51, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (69, N'璧山县
', N'璧山
', N'', 2, 51, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (70, N'城口县
', N'城口
', N'', 2, 51, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (71, N'大足县
', N'大足
', N'', 2, 51, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (72, N'垫江县
', N'垫江
', N'', 2, 51, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (73, N'丰都县
', N'丰都
', N'', 2, 51, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (74, N'奉节县
', N'奉节
', N'', 2, 51, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (75, N'开县
', N'开
县', N'', 2, 51, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (76, N'梁平县
', N'梁平
', N'', 2, 51, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (77, N'彭水苗族土家族自治县
', N'彭水
', N'', 2, 51, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (78, N'綦江县
', N'綦江
', N'', 2, 51, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (79, N'荣昌县
', N'荣昌
', N'', 2, 51, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (80, N'石柱土家族自治县
', N'石柱', N'', 2, 51, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (81, N'铜梁县
', N'铜梁
', N'', 2, 51, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (82, N'潼南县
', N'潼南
', N'', 2, 51, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (83, N'巫山县
', N'巫山
', N'', 2, 51, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (84, N'巫溪县
', N'巫溪
', N'', 2, 51, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (85, N'武隆县
', N'武隆
', N'', 2, 51, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (86, N'秀山土家族苗族自治县
', N'秀山
', N'', 2, 51, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (87, N'酉阳土家族苗族自治县
', N'酉阳
', N'', 2, 51, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (88, N'云阳县
', N'云阳
', N'', 2, 51, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (89, N'忠县
', N'忠

县', N'', 2, 51, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (90, N'安徽省', N'安徽', N'', 1, 0, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (91, N'安庆市










', N'安庆', N'', 2, 90, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (92, N'大观区
', N'大观', N'', 3, 91, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (93, N'怀宁县
', N'怀宁', N'', 3, 91, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (94, N'潜山县
', N'潜山', N'', 3, 91, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (95, N'太湖县
', N'太湖', N'', 3, 91, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (96, N'桐城市
', N'桐城', N'', 3, 91, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (97, N'望江县
', N'望江', N'', 3, 91, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (98, N'宿松县
', N'宿松', N'', 3, 91, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (99, N'宜秀区
', N'宜秀
', N'', 3, 91, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (100, N'迎江区
', N'迎江', N'', 3, 91, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (101, N'岳西县
', N'岳西', N'', 3, 91, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (102, N'枞阳县
', N'枞阳', N'', 3, 91, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (103, N'蚌埠市', N'蚌埠', N'', 2, 90, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (104, N'蚌山区
', N'蚌山', N'', 3, 103, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (105, N'固镇县
', N'固镇', N'', 3, 103, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (106, N'怀远县
', N'怀远', N'', 3, 103, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (107, N'淮上区
', N'淮上', N'', 3, 103, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (108, N'龙子湖区
', N'龙子湖', N'', 3, 103, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (109, N'五河县
', N'五河', N'', 3, 103, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (110, N'禹会区
', N'禹会
', N'', 3, 103, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (111, N'亳州市



', N'亳州', N'', 2, 90, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (112, N'利辛县
', N'利辛', N'', 3, 111, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (113, N'蒙城县
', N'蒙城', N'', 3, 111, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (114, N'谯城区
', N'谯城', N'', 3, 111, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (115, N'涡阳县
', N'涡阳', N'', 3, 111, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (116, N'池州市



', N'池州', N'', 2, 90, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (117, N'东至县
', N'东至', N'', 3, 116, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (118, N'贵池区
', N'贵池', N'', 3, 116, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (119, N'青阳县
', N'青阳', N'', 3, 116, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (120, N'石台县
', N'石台', N'', 3, 116, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (121, N'滁州市







', N'滁州', N'', 2, 90, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (122, N'定远县
', N'定远', N'', 3, 121, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (123, N'凤阳县
', N'凤阳', N'', 3, 121, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (124, N'来安县
', N'来安', N'', 3, 121, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (125, N'琅琊区
', N'琅琊', N'', 3, 121, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (126, N'明光市
', N'明光', N'', 3, 121, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (127, N'南谯区
', N'南谯', N'', 3, 121, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (128, N'全椒县
', N'全椒', N'', 3, 121, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (129, N'天长市
', N'天长', N'', 3, 121, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (130, N'阜阳市







', N'阜阳', N'', 2, 90, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (131, N'阜南县
', N'阜南', N'', 3, 130, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (132, N'界首市
', N'界首', N'', 3, 130, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (133, N'临泉县
', N'临泉', N'', 3, 130, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (134, N'太和县
', N'太和', N'', 3, 130, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (135, N'颍东区
', N'颍东', N'', 3, 130, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (136, N'颍泉区
', N'颍泉', N'', 3, 130, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (137, N'颍上县
', N'颍上', N'', 3, 130, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (138, N'颍州区
', N'颍州', N'', 3, 130, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (139, N'合肥市








', N'合肥', N'', 2, 90, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (140, N'包河区
', N'包河', N'', 3, 139, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (141, N'巢湖市
', N'巢湖', N'', 3, 139, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (142, N'肥东县
', N'肥东', N'', 3, 139, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (143, N'肥西县
', N'肥西', N'', 3, 139, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (144, N'庐江县
', N'庐江', N'', 3, 139, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (145, N'庐阳区
', N'庐阳', N'', 3, 139, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (146, N'蜀山区
', N'蜀山', N'', 3, 139, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (147, N'瑶海区
', N'瑶海', N'', 3, 139, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (148, N'长丰县
', N'长丰', N'', 3, 139, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (149, N'淮北市



', N'淮北', N'', 2, 90, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (150, N'杜集区
', N'杜集', N'', 3, 149, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (151, N'烈山区
', N'烈山', N'', 3, 149, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (152, N'濉溪县
', N'濉溪', N'', 3, 149, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (153, N'相山区
', N'相山', N'', 3, 149, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (154, N'淮南市





', N'淮南





', N'', 2, 90, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (155, N'八公山区
', N'八公山', N'', 3, 154, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (156, N'大通区
', N'大通', N'', 3, 154, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (157, N'凤台县
', N'凤台', N'', 3, 154, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (158, N'潘集区
', N'潘集', N'', 3, 154, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (159, N'田家庵区
', N'田家庵
', N'', 3, 154, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (160, N'谢家集区
', N'谢家集', N'', 3, 154, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (161, N'黄山市






', N'黄山', N'', 2, 90, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (162, N'黄山区
', N'黄山', N'', 3, 161, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (163, N'徽州区
', N'徽州区
', N'', 3, 161, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (164, N'祁门县
', N'祁门县
', N'', 3, 161, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (165, N'屯溪区
', N'屯溪区
', N'', 3, 161, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (166, N'歙县
', N'歙县
', N'', 3, 161, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (167, N'休宁县
', N'休宁县
', N'', 3, 161, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (168, N'黟县
', N'黟县
', N'', 3, 161, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (169, N'六安市






', N'六安', N'', 2, 90, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (170, N'霍邱县
', N'霍邱', N'', 3, 169, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (171, N'霍山县
', N'霍山县
', N'', 3, 169, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (172, N'金安区
', N'金安区
', N'', 3, 169, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (173, N'金寨县
', N'金寨县
', N'', 3, 169, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (174, N'寿县
', N'寿县
', N'', 3, 169, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (175, N'舒城县
', N'舒城县
', N'', 3, 169, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (176, N'裕安区
', N'裕安', N'', 3, 169, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (177, N'马鞍山市





', N'马鞍山', N'', 2, 90, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (178, N'博望区
', N'博望', N'', 3, 177, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (179, N'当涂县
', N'当涂', N'', 3, 177, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (180, N'含山县
', N'含山', N'', 3, 177, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (181, N'和县
', N'和县
', N'', 3, 177, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (182, N'花山区
', N'花山', N'', 3, 177, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (183, N'雨山区
', N'雨山', N'', 3, 177, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (184, N'铜陵市



', N'铜陵', N'', 2, 90, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (185, N'郊区
', N'郊区
', N'', 3, 184, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (186, N'狮子山区
', N'狮子山', N'', 3, 184, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (187, N'铜官山区
', N'铜官山', N'', 3, 184, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (188, N'铜陵县
', N'铜陵', N'', 3, 184, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (189, N'芜湖市







', N'芜湖', N'', 2, 90, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (190, N'繁昌县
', N'繁昌', N'', 3, 189, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (191, N'镜湖区
', N'镜湖', N'', 3, 189, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (192, N'鸠江区
', N'鸠江', N'', 3, 189, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (193, N'南陵县
', N'南陵', N'', 3, 189, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (194, N'三山区
', N'三山', N'', 3, 189, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (195, N'无为县
', N'无为', N'', 3, 189, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (196, N'芜湖县
', N'芜湖', N'', 3, 189, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (197, N'弋江区
', N'弋江', N'', 3, 189, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (198, N'宿州市




', N'宿州市




', N'', 2, 90, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (199, N'砀山县
', N'砀山县
', N'', 3, 198, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (200, N'灵璧县
', N'灵璧县
', N'', 3, 198, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (201, N'泗县
', N'泗县
', N'', 3, 198, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (202, N'萧县
', N'萧县
', N'', 3, 198, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (203, N'埇桥区
', N'埇桥', N'', 3, 198, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (204, N'宣城市






', N'宣城', N'', 2, 90, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (205, N'广德县
', N'广德', N'', 3, 204, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (206, N'绩溪县
', N'绩溪', N'', 3, 204, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (207, N'泾县
', N'泾县
', N'', 3, 204, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (208, N'旌德县
', N'旌德', N'', 3, 204, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (209, N'郎溪县
', N'郎溪', N'', 3, 204, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (210, N'宁国市
', N'宁国', N'', 3, 204, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (211, N'宣州区
', N'宣州', N'', 3, 204, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (212, N'福建省




















































































', N'福建', N'', 1, 0, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (213, N'福州市












', N'福州', N'', 2, 212, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (214, N'仓山区
', N'仓山', N'', 3, 213, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (215, N'福清市
', N'福清', N'', 3, 213, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (216, N'鼓楼区
', N'鼓楼', N'', 3, 213, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (217, N'晋安区
', N'晋安', N'', 3, 213, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (218, N'连江县
', N'连江
', N'', 3, 213, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (219, N'罗源县
', N'罗源', N'', 3, 213, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (220, N'马尾区
', N'马尾', N'', 3, 213, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (221, N'闽侯县
', N'闽侯
', N'', 3, 213, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (222, N'闽清县
', N'闽清', N'', 3, 213, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (223, N'平潭县
', N'平潭', N'', 3, 213, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (224, N'台江区
', N'台江', N'', 3, 213, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (225, N'永泰县
', N'永泰', N'', 3, 213, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (226, N'长乐市
', N'长乐', N'', 3, 213, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (227, N'龙岩市', N'龙岩', N'', 2, 212, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (228, N'连城县
', N'连城', N'', 3, 227, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (229, N'上杭县
', N'上杭', N'', 3, 227, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (230, N'武平县
', N'武平', N'', 3, 227, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (231, N'新罗区
', N'新罗', N'', 3, 227, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (232, N'永定县
', N'永定', N'', 3, 227, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (233, N'漳平市
', N'漳平', N'', 3, 227, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (234, N'长汀县
', N'长汀', N'', 3, 227, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (235, N'南平市', N'南平', N'', 2, 212, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (236, N'光泽县', N'光泽', N'', 3, 235, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (237, N'建瓯市', N'建瓯', N'', 3, 235, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (238, N'建阳市', N'建阳', N'', 3, 235, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (239, N'浦城县', N'浦城', N'', 3, 235, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (240, N'邵武市', N'邵武', N'', 3, 235, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (241, N'顺昌县', N'顺昌', N'', 3, 235, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (242, N'松溪县', N'松溪', N'', 3, 235, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (243, N'武夷山市', N'武夷山', N'', 3, 235, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (244, N'延平区', N'延平', N'', 3, 235, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (245, N'政和县', N'政和', N'', 3, 235, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (246, N'宁德市', N'宁德', N'', 2, 212, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (247, N'福安市', N'福安', N'', 3, 246, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (248, N'福鼎市', N'福鼎', N'', 3, 246, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (249, N'古田县', N'古田', N'', 3, 246, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (250, N'蕉城区', N'蕉城', N'', 3, 246, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (251, N'屏南县', N'屏南', N'', 3, 246, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (252, N'寿宁县', N'寿宁', N'', 3, 246, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (253, N'霞浦县', N'霞浦', N'', 3, 246, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (254, N'柘荣县', N'柘荣', N'', 3, 246, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (255, N'周宁县', N'周宁', N'', 3, 246, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (256, N'莆田市', N'莆田', N'', 2, 212, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (257, N'城厢区', N'城厢', N'', 3, 256, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (258, N'涵江区', N'涵江', N'', 3, 256, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (259, N'荔城区', N'荔城', N'', 3, 256, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (260, N'仙游县', N'仙游', N'', 3, 256, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (261, N'秀屿区', N'秀屿', N'', 3, 256, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (262, N'泉州市', N'泉州', N'', 2, 212, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (263, N'安溪县', N'安溪', N'', 3, 262, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (264, N'德化县', N'德化', N'', 3, 262, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (265, N'丰泽区', N'丰泽', N'', 3, 262, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (266, N'惠安县', N'惠安', N'', 3, 262, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (267, N'金门县', N'金门', N'', 3, 262, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (268, N'晋江市', N'晋江', N'', 3, 262, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (269, N'鲤城区', N'鲤城', N'', 3, 262, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (270, N'洛江区', N'洛江', N'', 3, 262, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (271, N'南安市', N'南安', N'', 3, 262, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (272, N'泉港区', N'泉港', N'', 3, 262, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (273, N'石狮市', N'石狮', N'', 3, 262, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (274, N'永春县', N'永春', N'', 3, 262, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (275, N'三明市', N'三明', N'', 2, 212, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (276, N'大田县', N'大田', N'', 3, 275, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (277, N'建宁县', N'建宁', N'', 3, 275, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (278, N'将乐县', N'将乐', N'', 3, 275, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (279, N'梅列区', N'梅列', N'', 3, 275, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (280, N'明溪县', N'明溪', N'', 3, 275, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (281, N'宁化县', N'宁化', N'', 3, 275, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (282, N'清流县', N'清流', N'', 3, 275, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (283, N'三元区', N'三元', N'', 3, 275, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (284, N'沙县', N'沙县', N'', 3, 275, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (285, N'泰宁县', N'泰宁', N'', 3, 275, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (286, N'永安市', N'永安', N'', 3, 275, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (287, N'尤溪县', N'尤溪', N'', 3, 275, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (288, N'厦门市', N'厦门', N'', 2, 212, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (289, N'海沧区', N'海沧', N'', 3, 288, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (290, N'湖里区', N'湖里', N'', 3, 288, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (291, N'集美区', N'集美', N'', 3, 288, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (292, N'思明区', N'思明', N'', 3, 288, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (293, N'同安区', N'同安', N'', 3, 288, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (294, N'翔安区', N'翔安', N'', 3, 288, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (295, N'漳州市', N'漳州', N'', 2, 212, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (296, N'东山县', N'东山', N'', 3, 295, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (297, N'华安县', N'华安', N'', 3, 295, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (298, N'龙海市', N'龙海', N'', 3, 295, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (299, N'龙文区', N'龙文', N'', 3, 295, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (300, N'南靖县', N'南靖', N'', 3, 295, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (301, N'平和县', N'平和', N'', 3, 295, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (302, N'芗城区', N'芗城', N'', 3, 295, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (303, N'云霄县', N'云霄', N'', 3, 295, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (304, N'漳浦县', N'漳浦', N'', 3, 295, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (305, N'长泰县', N'长泰', N'', 3, 295, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (306, N'诏安县', N'诏安', N'', 3, 295, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (307, N'白银市', N'白银', N'', 2, 321, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (308, N'白银区', N'白银', N'', 3, 307, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (309, N'会宁县', N'会宁', N'', 3, 307, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (310, N'景泰县', N'景泰', N'', 3, 307, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (311, N'靖远县', N'靖远', N'', 3, 307, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (312, N'平川区', N'平川', N'', 3, 307, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (313, N'定西市', N'定西', N'', 2, 321, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (314, N'安定区', N'安定', N'', 3, 313, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (315, N'临洮县', N'临洮', N'', 3, 313, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (316, N'陇西县', N'陇西', N'', 3, 313, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (317, N'岷县', N'岷县', N'', 3, 313, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (318, N'通渭县', N'通渭', N'', 3, 313, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (319, N'渭源县', N'渭源', N'', 3, 313, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (320, N'漳县', N'漳县', N'', 3, 313, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (321, N'甘肃省', N'甘肃', N'', 1, 0, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (322, N'甘南藏族自治州', N'甘南', N'', 2, 321, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (323, N'迭部县', N'迭部', N'', 3, 322, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (324, N'合作市', N'合作', N'', 3, 322, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (325, N'临潭县', N'临潭', N'', 3, 322, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (326, N'碌曲县', N'碌曲', N'', 3, 322, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (327, N'玛曲县', N'玛曲', N'', 3, 322, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (328, N'夏河县', N'夏河', N'', 3, 322, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (329, N'舟曲县', N'舟曲', N'', 3, 322, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (330, N'卓尼县', N'卓尼', N'', 3, 322, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (331, N'嘉峪关市
', N'嘉峪关', N'', 2, 321, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (332, N'金昌市', N'金昌', N'', 2, 321, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (333, N'金川区', N'金川', N'', 3, 332, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (334, N'永昌县', N'永昌', N'', 3, 332, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (335, N'酒泉市', N'酒泉', N'', 2, 321, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (336, N'阿克塞哈萨克族自治县', N'阿克塞', N'', 3, 335, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (337, N'敦煌市', N'敦煌', N'', 3, 335, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (338, N'瓜州县', N'瓜州', N'', 3, 335, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (339, N'金塔县', N'金塔', N'', 3, 335, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (340, N'肃北蒙古族自治县', N'肃北', N'', 3, 335, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (341, N'肃州区', N'肃州', N'', 3, 335, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (342, N'玉门市', N'玉门', N'', 3, 335, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (343, N'兰州市', N'兰州', N'', 2, 321, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (344, N'安宁区', N'安宁', N'', 3, 343, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (345, N'城关区', N'城关', N'', 3, 343, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (346, N'皋兰县', N'皋兰', N'', 3, 343, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (347, N'红古区', N'红古', N'', 3, 343, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (348, N'七里河区', N'七里河', N'', 3, 343, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (349, N'西固区', N'西固', N'', 3, 343, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (350, N'永登县', N'永登', N'', 3, 343, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (351, N'榆中县', N'榆中', N'', 3, 343, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (352, N'临夏回族自治州', N'临夏', N'', 2, 321, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (353, N'东乡族自治县', N'东乡族', N'', 3, 352, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (354, N'广河县', N'广河', N'', 3, 352, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (355, N'和政县', N'和政', N'', 3, 352, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (356, N'积石山保安族东乡族撒拉族自治县', N'积石山', N'', 3, 352, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (357, N'康乐县', N'康乐', N'', 3, 352, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (358, N'临夏市', N'临夏', N'', 3, 352, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (359, N'临夏县', N'临夏', N'', 3, 352, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (360, N'永靖县', N'永靖', N'', 3, 352, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (361, N'陇南市', N'陇南', N'', 2, 321, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (362, N'成县', N'成县', N'', 3, 361, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (363, N'宕昌县', N'宕昌', N'', 3, 361, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (364, N'徽县', N'徽县', N'', 3, 361, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (365, N'康县', N'康县', N'', 3, 361, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (366, N'礼县', N'礼县', N'', 3, 361, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (367, N'两当县', N'两当', N'', 3, 361, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (368, N'文县', N'文县', N'', 3, 361, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (369, N'武都区', N'武都', N'', 3, 361, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (370, N'西和县', N'西和', N'', 3, 361, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (371, N'平凉市', N'平凉', N'', 2, 321, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (372, N'崇信县', N'崇信', N'', 3, 371, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (373, N'华亭县', N'华亭', N'', 3, 371, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (374, N'泾川县', N'泾川', N'', 3, 371, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (375, N'静宁县', N'静宁', N'', 3, 371, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (376, N'崆峒区', N'崆峒', N'', 3, 371, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (377, N'灵台县', N'灵台', N'', 3, 371, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (378, N'庄浪县', N'庄浪', N'', 3, 371, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (379, N'庆阳市', N'庆阳', N'', 2, 321, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (380, N'合水县', N'合水', N'', 3, 379, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (381, N'华池县', N'华池', N'', 3, 379, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (382, N'环县', N'环县', N'', 3, 379, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (383, N'宁县', N'宁县', N'', 3, 379, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (384, N'庆城县', N'庆城', N'', 3, 379, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (385, N'西峰区', N'西峰', N'', 3, 379, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (386, N'镇原县', N'镇原', N'', 3, 379, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (387, N'正宁县', N'正宁', N'', 3, 379, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (388, N'天水市', N'天水', N'', 2, 321, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (389, N'甘谷县', N'甘谷', N'', 3, 388, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (390, N'麦积区', N'麦积', N'', 3, 388, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (391, N'秦安县', N'秦安', N'', 3, 388, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (392, N'秦州区', N'秦州', N'', 3, 388, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (393, N'清水县', N'清水', N'', 3, 388, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (394, N'武山县', N'武山', N'', 3, 388, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (395, N'张家川回族自治县', N'张家川', N'', 3, 388, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (396, N'武威市', N'武威', N'', 2, 321, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (397, N'古浪县', N'古浪', N'', 3, 396, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (398, N'凉州区', N'凉州', N'', 3, 396, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (399, N'民勤县', N'民勤', N'', 3, 396, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (400, N'天祝藏族自治县', N'天祝', N'', 3, 396, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (401, N'张掖市', N'张掖', N'', 2, 321, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (402, N'甘州区', N'甘州', N'', 3, 401, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (403, N'高台县', N'高台', N'', 3, 401, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (404, N'临泽县', N'临泽', N'', 3, 401, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (405, N'民乐县', N'民乐', N'', 3, 401, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (406, N'山丹县', N'山丹', N'', 3, 401, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (407, N'肃南裕固族自治县', N'肃南', N'', 3, 401, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (408, N'广东省', N'广东', N'', 1, 0, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (409, N'潮州市', N'潮州', N'', 2, 408, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (410, N'潮安区', N'潮安', N'', 3, 409, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (411, N'饶平县', N'饶平', N'', 3, 409, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (412, N'湘桥区', N'湘桥', N'', 3, 409, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (413, N'东莞市', N'东莞', N'', 2, 408, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (414, N'佛山市', N'佛山', N'', 2, 408, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (415, N'禅城区', N'禅城', N'', 3, 414, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (416, N'高明区', N'高明', N'', 3, 414, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (417, N'南海区', N'南海', N'', 3, 414, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (418, N'三水区', N'三水', N'', 3, 414, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (419, N'顺德区', N'顺德', N'', 3, 414, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (420, N'广州市', N'广州', N'', 2, 408, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (421, N'白云区', N'白云', N'', 3, 420, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (422, N'从化市', N'从化', N'', 3, 420, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (423, N'番禺区', N'番禺', N'', 3, 420, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (424, N'海珠区', N'海珠', N'', 3, 420, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (425, N'花都区', N'花都', N'', 3, 420, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (426, N'黄埔区', N'黄埔', N'', 3, 420, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (427, N'荔湾区', N'荔湾', N'', 3, 420, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (428, N'萝岗区', N'萝岗', N'', 3, 420, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (429, N'南沙区', N'南沙', N'', 3, 420, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (430, N'天河区', N'天河', N'', 3, 420, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (431, N'越秀区', N'越秀', N'', 3, 420, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (432, N'增城市', N'增城', N'', 3, 420, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (433, N'河源市', N'河源', N'', 2, 408, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (434, N'东源县', N'东源', N'', 3, 433, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (435, N'和平县', N'和平', N'', 3, 433, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (436, N'连平县', N'连平', N'', 3, 433, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (437, N'龙川县', N'龙川', N'', 3, 433, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (438, N'源城区', N'源城', N'', 3, 433, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (439, N'紫金县', N'紫金', N'', 3, 433, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (440, N'惠州市', N'惠州', N'', 2, 408, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (441, N'博罗县', N'博罗', N'', 3, 440, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (442, N'惠城区', N'惠城', N'', 3, 440, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (443, N'惠东县', N'惠东', N'', 3, 440, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (444, N'惠阳区', N'惠阳', N'', 3, 440, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (445, N'龙门县', N'龙门', N'', 3, 440, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (446, N'江门市', N'江门', N'', 2, 408, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (447, N'恩平市', N'恩平', N'', 3, 446, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (448, N'鹤山市', N'鹤山', N'', 3, 446, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (449, N'江海区', N'江海', N'', 3, 446, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (450, N'开平市', N'开平', N'', 3, 446, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (451, N'蓬江区', N'蓬江', N'', 3, 446, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (452, N'台山市', N'台山', N'', 3, 446, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (453, N'新会区', N'新会', N'', 3, 446, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (454, N'揭阳市', N'揭阳', N'', 2, 408, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (455, N'惠来县', N'惠来', N'', 3, 454, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (456, N'揭东区', N'揭东', N'', 3, 454, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (457, N'揭西县', N'揭西', N'', 3, 454, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (458, N'普宁市', N'普宁', N'', 3, 454, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (459, N'榕城区', N'榕城', N'', 3, 454, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (460, N'茂名市', N'茂名', N'', 2, 408, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (461, N'电白县', N'电白', N'', 3, 460, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (462, N'高州市', N'高州', N'', 3, 460, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (463, N'化州市', N'化州', N'', 3, 460, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (464, N'茂港区', N'茂港', N'', 3, 460, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (465, N'茂南区', N'茂南', N'', 3, 460, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (466, N'信宜市', N'信宜', N'', 3, 460, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (467, N'梅州市', N'梅州', N'', 2, 408, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (468, N'大埔县', N'大埔', N'', 3, 467, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (469, N'丰顺县', N'丰顺', N'', 3, 467, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (470, N'蕉岭县', N'蕉岭', N'', 3, 467, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (471, N'梅江区', N'梅江', N'', 3, 467, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (472, N'梅县区', N'梅县', N'', 3, 467, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (473, N'平远县', N'平远', N'', 3, 467, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (474, N'五华县', N'五华', N'', 3, 467, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (475, N'兴宁市', N'兴宁', N'', 3, 467, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (476, N'清远市', N'清远', N'', 2, 408, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (477, N'佛冈县', N'佛冈', N'', 3, 476, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (478, N'连南瑶族自治县', N'连南', N'', 3, 476, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (479, N'连山壮族瑶族自治县', N'连山', N'', 3, 476, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (480, N'连州市', N'连州', N'', 3, 476, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (481, N'清城区', N'清城', N'', 3, 476, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (482, N'清新区', N'清新', N'', 3, 476, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (483, N'阳山县', N'阳山', N'', 3, 476, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (484, N'英德市', N'英德', N'', 3, 476, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (485, N'汕头市', N'汕头', N'', 2, 408, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (486, N'潮南区', N'潮南', N'', 3, 485, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (487, N'潮阳区', N'潮阳', N'', 3, 485, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (488, N'澄海区', N'澄海', N'', 3, 485, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (489, N'濠江区', N'濠江', N'', 3, 485, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (490, N'金平区', N'金平', N'', 3, 485, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (491, N'龙湖区', N'龙湖', N'', 3, 485, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (492, N'南澳县', N'南澳', N'', 3, 485, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (493, N'汕尾市', N'汕尾', N'', 2, 408, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (494, N'城区', N'城区', N'', 3, 493, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (495, N'海丰县', N'海丰', N'', 3, 493, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (496, N'陆丰市', N'陆丰', N'', 3, 493, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (497, N'陆河县', N'陆河', N'', 3, 493, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (498, N'韶关市', N'韶关', N'', 2, 408, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (499, N'乐昌市', N'乐昌', N'', 3, 498, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (500, N'南雄市', N'南雄', N'', 3, 498, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (501, N'曲江区', N'曲江', N'', 3, 498, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (502, N'仁化县', N'仁化', N'', 3, 498, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (503, N'乳源瑶族自治县', N'乳源', N'', 3, 498, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (504, N'始兴县', N'始兴', N'', 3, 498, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (505, N'翁源县', N'翁源', N'', 3, 498, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (506, N'武江区', N'武江', N'', 3, 498, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (507, N'新丰县', N'新丰', N'', 3, 498, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (508, N'浈江区', N'浈江', N'', 3, 498, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (509, N'深圳市', N'深圳', N'', 2, 408, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (510, N'宝安区', N'宝安', N'', 3, 509, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (511, N'福田区', N'福田', N'', 3, 509, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (512, N'龙岗区', N'龙岗', N'', 3, 509, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (513, N'罗湖区', N'罗湖', N'', 3, 509, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (514, N'南山区', N'南山', N'', 3, 509, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (515, N'盐田区', N'盐田', N'', 3, 509, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (516, N'阳江市', N'阳江', N'', 2, 408, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (517, N'江城区', N'江城', N'', 3, 516, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (518, N'阳春市', N'阳春', N'', 3, 516, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (519, N'阳东县', N'阳东', N'', 3, 516, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (520, N'阳西县', N'阳西', N'', 3, 516, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (521, N'云浮市', N'云浮', N'', 2, 408, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (522, N'罗定市', N'罗定', N'', 3, 521, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (523, N'新兴县', N'新兴', N'', 3, 521, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (524, N'郁南县', N'郁南', N'', 3, 521, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (525, N'云安县', N'云安', N'', 3, 521, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (526, N'云城区', N'云城', N'', 3, 521, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (527, N'湛江市', N'湛江', N'', 2, 408, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (528, N'赤坎区', N'赤坎', N'', 3, 527, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (529, N'雷州市', N'雷州', N'', 3, 527, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (530, N'廉江市', N'廉江', N'', 3, 527, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (531, N'麻章区', N'麻章', N'', 3, 527, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (532, N'坡头区', N'坡头', N'', 3, 527, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (533, N'遂溪县', N'遂溪', N'', 3, 527, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (534, N'吴川市', N'吴川', N'', 3, 527, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (535, N'霞山区', N'霞山', N'', 3, 527, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (536, N'徐闻县', N'徐闻', N'', 3, 527, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (537, N'肇庆市', N'肇庆', N'', 2, 408, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (538, N'德庆县', N'德庆', N'', 3, 537, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (539, N'鼎湖区', N'鼎湖', N'', 3, 537, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (540, N'端州区', N'端州', N'', 3, 537, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (541, N'封开县', N'封开', N'', 3, 537, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (542, N'高要市', N'高要', N'', 3, 537, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (543, N'广宁县', N'广宁', N'', 3, 537, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (544, N'怀集县', N'怀集', N'', 3, 537, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (545, N'四会市', N'四会', N'', 3, 537, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (546, N'中山市', N'中山', N'', 2, 408, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (547, N'珠海市', N'珠海', N'', 2, 408, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (548, N'斗门区', N'斗门', N'', 3, 547, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (549, N'金湾区', N'金湾', N'', 3, 547, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (550, N'香洲区', N'香洲', N'', 3, 547, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (551, N'广西壮族自治区', N'广西', N'', 1, 0, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (552, N'百色市', N'百色', N'', 2, 551, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (553, N'德保县', N'德保', N'', 3, 552, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (554, N'靖西县', N'靖西', N'', 3, 552, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (555, N'乐业县', N'乐业', N'', 3, 552, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (556, N'凌云县', N'凌云', N'', 3, 552, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (557, N'隆林各族自治县', N'隆林', N'', 3, 552, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (558, N'那坡县', N'那坡', N'', 3, 552, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (559, N'平果县', N'平果', N'', 3, 552, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (560, N'田东县', N'田东', N'', 3, 552, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (561, N'田林县', N'田林', N'', 3, 552, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (562, N'田阳县', N'田阳', N'', 3, 552, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (563, N'西林县', N'西林', N'', 3, 552, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (564, N'右江区', N'右江', N'', 3, 552, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (565, N'北海市', N'北海', N'', 2, 551, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (566, N'海城区', N'海城', N'', 3, 565, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (567, N'合浦县', N'合浦', N'', 3, 565, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (568, N'铁山港区', N'铁山港', N'', 3, 565, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (569, N'银海区', N'银海', N'', 3, 565, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (570, N'崇左市', N'崇左', N'', 2, 551, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (571, N'大新县', N'大新', N'', 3, 570, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (572, N'扶绥县', N'扶绥', N'', 3, 570, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (573, N'江洲区', N'江洲', N'', 3, 570, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (574, N'龙州县', N'龙州', N'', 3, 570, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (575, N'宁明县', N'宁明', N'', 3, 570, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (576, N'凭祥市', N'凭祥', N'', 3, 570, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (577, N'天等县', N'天等', N'', 3, 570, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (578, N'防城港市', N'防城港', N'', 2, 551, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (579, N'东兴市', N'东兴', N'', 3, 578, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (580, N'防城区', N'防城', N'', 3, 578, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (581, N'港口区', N'港口', N'', 3, 578, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (582, N'上思县', N'上思', N'', 3, 578, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (583, N'贵港市', N'贵港', N'', 2, 551, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (584, N'港北区', N'港北', N'', 3, 583, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (585, N'港南区', N'港南', N'', 3, 583, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (586, N'桂平市', N'桂平', N'', 3, 583, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (587, N'平南县', N'平南', N'', 3, 583, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (588, N'覃塘区', N'覃塘', N'', 3, 583, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (589, N'桂林市', N'桂林', N'', 2, 551, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (590, N'叠彩区', N'叠彩', N'', 3, 589, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (591, N'恭城瑶族自治县', N'恭城', N'', 3, 589, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (592, N'灌阳县', N'灌阳', N'', 3, 589, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (593, N'荔蒲县', N'荔蒲', N'', 3, 589, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (594, N'临桂区', N'临桂', N'', 3, 589, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (595, N'灵川县', N'灵川', N'', 3, 589, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (596, N'龙胜各族自治县', N'龙胜', N'', 3, 589, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (597, N'平乐县', N'平乐', N'', 3, 589, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (598, N'七星区', N'七星', N'', 3, 589, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (599, N'全州县', N'全州', N'', 3, 589, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (600, N'象山区', N'象山', N'', 3, 589, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (601, N'兴安县', N'兴安', N'', 3, 589, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (602, N'秀峰区', N'秀峰', N'', 3, 589, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (603, N'雁山区', N'雁山', N'', 3, 589, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (604, N'阳朔县', N'阳朔', N'', 3, 589, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (605, N'永福县', N'永福', N'', 3, 589, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (606, N'资源县', N'资源', N'', 3, 589, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (607, N'河池市', N'河池', N'', 2, 551, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (608, N'巴马瑶族自治县', N'巴马', N'', 3, 607, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (609, N'大化瑶族自治县', N'大化', N'', 3, 607, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (610, N'东兰县', N'东兰', N'', 3, 607, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (611, N'都安瑶族自治县', N'都安', N'', 3, 607, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (612, N'凤山县', N'凤山', N'', 3, 607, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (613, N'环江毛南族自治县', N'环江', N'', 3, 607, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (614, N'金城江区', N'金城江', N'', 3, 607, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (615, N'罗城仫佬族自治县', N'罗城', N'', 3, 607, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (616, N'南丹县', N'南丹', N'', 3, 607, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (617, N'天峨县', N'天峨', N'', 3, 607, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (618, N'宜州市', N'宜州', N'', 3, 607, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (619, N'贺州市', N'贺州', N'', 2, 551, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (620, N'八步区', N'八步', N'', 3, 619, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (621, N'富川瑶族自治县', N'富川', N'', 3, 619, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (622, N'昭平县', N'昭平', N'', 3, 619, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (623, N'钟山县', N'钟山', N'', 3, 619, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (624, N'来宾市', N'来宾', N'', 2, 551, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (625, N'合山市', N'合山', N'', 3, 624, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (626, N'金秀瑶族自治县', N'金秀', N'', 3, 624, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (627, N'武宣县', N'武宣', N'', 3, 624, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (628, N'象州县', N'象州', N'', 3, 624, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (629, N'忻城县', N'忻城', N'', 3, 624, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (630, N'兴宾区', N'兴宾', N'', 3, 624, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (631, N'柳州市', N'柳州', N'', 2, 551, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (632, N'城中区', N'城中', N'', 3, 631, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (633, N'柳北区', N'柳北', N'', 3, 631, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (634, N'柳城县', N'柳城', N'', 3, 631, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (635, N'柳江县', N'柳江', N'', 3, 631, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (636, N'柳南区', N'柳南', N'', 3, 631, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (637, N'鹿寨县', N'鹿寨', N'', 3, 631, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (638, N'融安县', N'融安', N'', 3, 631, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (639, N'融水苗族自治县', N'融水', N'', 3, 631, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (640, N'三江侗族自治县', N'三江', N'', 3, 631, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (641, N'鱼峰区', N'鱼峰', N'', 3, 631, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (642, N'南宁市', N'南宁', N'', 2, 551, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (643, N'宾阳县', N'宾阳', N'', 3, 642, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (644, N'横县', N'横县', N'', 3, 642, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (645, N'江南区', N'江南', N'', 3, 642, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (646, N'良庆区', N'良庆', N'', 3, 642, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (647, N'隆安县', N'隆安', N'', 3, 642, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (648, N'马山县', N'马山', N'', 3, 642, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (649, N'青秀区', N'青秀', N'', 3, 642, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (650, N'上林县', N'上林', N'', 3, 642, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (651, N'武鸣县', N'武鸣', N'', 3, 642, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (652, N'西乡塘区', N'西乡塘', N'', 3, 642, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (653, N'兴宁区', N'兴宁', N'', 3, 642, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (654, N'邕宁区', N'邕宁', N'', 3, 642, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (655, N'钦州市', N'钦州', N'', 2, 551, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (656, N'灵山县', N'灵山', N'', 3, 655, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (657, N'浦北县', N'浦北', N'', 3, 655, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (658, N'钦北区', N'钦北', N'', 3, 655, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (659, N'钦南区', N'钦南', N'', 3, 655, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (660, N'梧州市', N'梧州', N'', 2, 551, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (661, N'苍梧县', N'苍梧', N'', 3, 660, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (662, N'岑溪市', N'岑溪', N'', 3, 660, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (663, N'龙圩区', N'龙圩', N'', 3, 660, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (664, N'蒙山县', N'蒙山', N'', 3, 660, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (665, N'藤县', N'藤县', N'', 3, 660, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (666, N'万秀区', N'万秀', N'', 3, 660, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (667, N'长洲区', N'长洲', N'', 3, 660, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (668, N'玉林市', N'玉林', N'', 2, 551, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (669, N'北流市', N'北流', N'', 3, 668, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (670, N'博白县', N'博白', N'', 3, 668, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (671, N'福绵区', N'福绵', N'', 3, 668, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (672, N'陆川县', N'陆川', N'', 3, 668, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (673, N'容县', N'容县', N'', 3, 668, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (674, N'兴业县', N'兴业', N'', 3, 668, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (675, N'玉州区', N'玉州', N'', 3, 668, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (676, N'贵州省', N'贵州', N'', 1, 0, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (677, N'安顺市', N'安顺', N'', 2, 676, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (678, N'关岭布依族苗族自治县', N'关岭', N'', 3, 677, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (679, N'平坝县', N'平坝', N'', 3, 677, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (680, N'普定县', N'普定', N'', 3, 677, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (681, N'西秀区', N'西秀', N'', 3, 677, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (682, N'镇宁布依族苗族自治县', N'镇宁', N'', 3, 677, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (683, N'紫云苗族布依族自治县', N'紫云', N'', 3, 677, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (684, N'毕节市', N'毕节', N'', 2, 676, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (685, N'大方县', N'大方', N'', 3, 684, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (686, N'赫章县', N'赫章', N'', 3, 684, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (687, N'金沙县', N'金沙', N'', 3, 684, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (688, N'纳雍县', N'纳雍', N'', 3, 684, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (689, N'七星关区', N'七星关', N'', 3, 684, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (690, N'黔西县', N'黔西', N'', 3, 684, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (691, N'威宁彝族回族苗族自治县', N'威宁', N'', 3, 684, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (692, N'织金县', N'织金', N'', 3, 684, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (693, N'贵阳市', N'贵阳', N'', 2, 676, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (694, N'白云区', N'白云', N'', 3, 693, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (695, N'观山湖区', N'观山湖', N'', 3, 693, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (696, N'花溪区', N'花溪', N'', 3, 693, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (697, N'开阳县', N'开阳', N'', 3, 693, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (698, N'南明区', N'南明', N'', 3, 693, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (699, N'清镇市', N'清镇', N'', 3, 693, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (700, N'乌当区', N'乌当', N'', 3, 693, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (701, N'息烽县', N'息烽', N'', 3, 693, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (702, N'修文县', N'修文', N'', 3, 693, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (703, N'云岩区', N'云岩', N'', 3, 693, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (704, N'六盘水市', N'六盘水', N'', 2, 676, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (705, N'六枝特区', N'六枝', N'', 3, 704, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (706, N'盘县', N'盘县', N'', 3, 704, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (707, N'水城县', N'水城', N'', 3, 704, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (708, N'钟山区', N'钟山', N'', 3, 704, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (709, N'黔东南苗族侗族自治州', N'黔东南', N'', 2, 676, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (710, N'岑巩县', N'岑巩', N'', 3, 709, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (711, N'从江县', N'从江', N'', 3, 709, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (712, N'丹寨县', N'丹寨', N'', 3, 709, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (713, N'黄平县', N'黄平', N'', 3, 709, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (714, N'剑河县', N'剑河', N'', 3, 709, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (715, N'锦屏县', N'锦屏', N'', 3, 709, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (716, N'凯里市', N'凯里', N'', 3, 709, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (717, N'雷山县', N'雷山', N'', 3, 709, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (718, N'黎平县', N'黎平', N'', 3, 709, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (719, N'麻江县', N'麻江', N'', 3, 709, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (720, N'榕江县', N'榕江', N'', 3, 709, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (721, N'三穗县', N'三穗', N'', 3, 709, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (722, N'施秉县', N'施秉', N'', 3, 709, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (723, N'台江县', N'台江', N'', 3, 709, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (724, N'天柱县', N'天柱', N'', 3, 709, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (725, N'镇远县', N'镇远', N'', 3, 709, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (726, N'黔南布依族苗族自治州', N'黔南', N'', 2, 676, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (727, N'都匀市', N'都匀', N'', 3, 726, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (728, N'独山县', N'独山', N'', 3, 726, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (729, N'福泉市', N'福泉', N'', 3, 726, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (730, N'贵定县', N'贵定', N'', 3, 726, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (731, N'惠水县', N'惠水', N'', 3, 726, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (732, N'荔波县', N'荔波', N'', 3, 726, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (733, N'龙里县', N'龙里', N'', 3, 726, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (734, N'罗甸县', N'罗甸', N'', 3, 726, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (735, N'平塘县', N'平塘', N'', 3, 726, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (736, N'三都水族自治县', N'三都', N'', 3, 726, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (737, N'瓮安县', N'瓮安', N'', 3, 726, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (738, N'长顺县', N'长顺', N'', 3, 726, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (739, N'黔西南布依族苗族自治州', N'黔西南', N'', 2, 676, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (740, N'安龙县', N'安龙', N'', 3, 739, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (741, N'册亨县', N'册亨', N'', 3, 739, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (742, N'普安县', N'普安', N'', 3, 739, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (743, N'晴隆县', N'晴隆', N'', 3, 739, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (744, N'望谟县', N'望谟', N'', 3, 739, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (745, N'兴仁县', N'兴仁', N'', 3, 739, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (746, N'兴义市', N'兴义', N'', 3, 739, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (747, N'贞丰县', N'贞丰', N'', 3, 739, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (748, N'铜仁市', N'铜仁', N'', 2, 676, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (749, N'碧江区', N'碧江', N'', 3, 748, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (750, N'德江县', N'德江', N'', 3, 748, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (751, N'江口县', N'江口', N'', 3, 748, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (752, N'石阡县', N'石阡', N'', 3, 748, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (753, N'思南县', N'思南', N'', 3, 748, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (754, N'松桃苗族自治县', N'松桃', N'', 3, 748, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (755, N'万山区', N'万山', N'', 3, 748, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (756, N'沿河土家族自治县', N'沿河', N'', 3, 748, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (757, N'印江土家族苗族自治县', N'印江', N'', 3, 748, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (758, N'玉屏侗族自治县', N'玉屏', N'', 3, 748, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (759, N'遵义市', N'遵义', N'', 2, 676, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (760, N'赤水市', N'赤水', N'', 3, 759, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (761, N'道真仡佬族苗族自治县', N'道真', N'', 3, 759, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (762, N'凤冈县', N'凤冈', N'', 3, 759, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (763, N'红花岗区', N'红花岗', N'', 3, 759, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (764, N'汇川区', N'汇川', N'', 3, 759, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (765, N'湄潭县', N'湄潭', N'', 3, 759, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (766, N'仁怀市', N'仁怀', N'', 3, 759, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (767, N'绥阳县', N'绥阳', N'', 3, 759, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (768, N'桐梓县', N'桐梓', N'', 3, 759, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (769, N'务川仡佬族苗族自治县', N'务川', N'', 3, 759, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (770, N'习水县', N'习水', N'', 3, 759, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (771, N'余庆县', N'余庆', N'', 3, 759, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (772, N'正安县', N'正安', N'', 3, 759, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (773, N'遵义县', N'遵义', N'', 3, 759, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (774, N'海南省', N'海南', N'', 1, 0, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (775, N'海口市', N'海口', N'', 2, 774, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (776, N'龙华区', N'龙华', N'', 3, 775, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (777, N'美兰区', N'美兰', N'', 3, 775, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (778, N'琼山区', N'琼山', N'', 3, 775, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (779, N'秀英区', N'秀英', N'', 3, 775, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (780, N'三亚市', N'三亚', N'', 2, 774, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (781, N'省直辖县级行政区划', N'省直辖', N'', 2, 774, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (782, N'白沙黎族自治县', N'白沙', N'', 3, 781, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (783, N'保亭黎族苗族自治县', N'保亭', N'', 3, 781, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (784, N'昌江黎族自治县', N'昌江', N'', 3, 781, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (785, N'澄迈县', N'澄迈', N'', 3, 781, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (786, N'儋州市', N'儋州', N'', 3, 781, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (787, N'定安县', N'定安', N'', 3, 781, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (788, N'东方市', N'东方', N'', 3, 781, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (789, N'乐东黎族自治县', N'乐东', N'', 3, 781, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (790, N'临高县', N'临高', N'', 3, 781, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (791, N'陵水黎族自治县', N'陵水', N'', 3, 781, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (792, N'南沙群岛', N'南沙', N'', 3, 781, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (793, N'琼海市', N'琼海', N'', 3, 781, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (794, N'琼中黎族苗族自治县', N'琼中', N'', 3, 781, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (795, N'屯昌县', N'屯昌', N'', 3, 781, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (796, N'万宁市', N'万宁', N'', 3, 781, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (797, N'文昌市', N'文昌', N'', 3, 781, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (798, N'五指山市', N'五指山', N'', 3, 781, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (799, N'西沙群岛', N'西沙', N'', 3, 781, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (800, N'中沙群岛', N'中沙', N'', 3, 781, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (801, N'河北省', N'河北', N'', 1, 0, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (802, N'保定市', N'保定市', N'', 2, 801, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (803, N'安国市', N'安国', N'', 3, 802, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (804, N'安新县', N'安新', N'', 3, 802, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (805, N'北市区', N'北市', N'', 3, 802, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (806, N'博野县', N'博野', N'', 3, 802, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (807, N'定兴县', N'定兴', N'', 3, 802, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (808, N'定州市', N'定州', N'', 3, 802, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (809, N'阜平县', N'阜平', N'', 3, 802, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (810, N'高碑店市', N'高碑店', N'', 3, 802, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (811, N'高阳县', N'高阳', N'', 3, 802, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (812, N'涞水县', N'涞水', N'', 3, 802, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (813, N'涞源县', N'涞源', N'', 3, 802, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (814, N'蠡县', N'蠡县', N'', 3, 802, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (815, N'满城县', N'满城', N'', 3, 802, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (816, N'南市区', N'南市', N'', 3, 802, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (817, N'清苑县', N'清苑', N'', 3, 802, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (818, N'曲阳县', N'曲阳', N'', 3, 802, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (819, N'容城县', N'容城', N'', 3, 802, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (820, N'顺平县', N'顺平', N'', 3, 802, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (821, N'唐县', N'唐县', N'', 3, 802, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (822, N'望都县', N'望都', N'', 3, 802, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (823, N'新市区', N'新市', N'', 3, 802, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (824, N'雄县', N'雄县', N'', 3, 802, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (825, N'徐水县', N'徐水', N'', 3, 802, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (826, N'易县', N'易县', N'', 3, 802, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (827, N'涿州市', N'涿州', N'', 3, 802, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (828, N'沧州市', N'沧州', N'', 2, 801, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (829, N'泊头市', N'泊头', N'', 3, 828, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (830, N'沧县', N'沧县', N'', 3, 828, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (831, N'东光县', N'东光', N'', 3, 828, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (832, N'海兴县', N'海兴', N'', 3, 828, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (833, N'河间市', N'河间', N'', 3, 828, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (834, N'黄骅市', N'黄骅', N'', 3, 828, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (835, N'孟村回族自治县', N'孟村', N'', 3, 828, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (836, N'南皮县', N'南皮', N'', 3, 828, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (837, N'青县', N'青县', N'', 3, 828, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (838, N'任丘市', N'任丘', N'', 3, 828, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (839, N'肃宁县', N'肃宁', N'', 3, 828, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (840, N'吴桥县', N'吴桥', N'', 3, 828, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (841, N'献县', N'献县', N'', 3, 828, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (842, N'新华区', N'新华', N'', 3, 828, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (843, N'盐山县', N'盐山', N'', 3, 828, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (844, N'运河区', N'运河', N'', 3, 828, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (845, N'承德市', N'承德', N'', 2, 801, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (846, N'承德县', N'承德', N'', 3, 845, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (847, N'丰宁满族自治县', N'丰宁', N'', 3, 845, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (848, N'宽城满族自治县', N'宽城', N'', 3, 845, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (849, N'隆化县', N'隆化', N'', 3, 845, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (850, N'滦平县', N'滦平', N'', 3, 845, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (851, N'平泉县', N'平泉', N'', 3, 845, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (852, N'双滦区', N'双滦', N'', 3, 845, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (853, N'双桥区', N'双桥', N'', 3, 845, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (854, N'围场满族蒙古族自治县', N'围场', N'', 3, 845, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (855, N'兴隆县', N'兴隆', N'', 3, 845, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (856, N'鹰手营子矿区', N'鹰手营子', N'', 3, 845, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (857, N'邯郸市', N'邯郸', N'', 2, 801, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (858, N'成安县', N'成安', N'', 3, 857, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (859, N'磁县', N'磁县', N'', 3, 857, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (860, N'丛台区', N'丛台', N'', 3, 857, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (861, N'大名县', N'大名', N'', 3, 857, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (862, N'肥乡县', N'肥乡', N'', 3, 857, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (863, N'峰峰矿区', N'峰峰', N'', 3, 857, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (864, N'复兴区', N'复兴', N'', 3, 857, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (865, N'馆陶县', N'馆陶', N'', 3, 857, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (866, N'广平县', N'广平', N'', 3, 857, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (867, N'邯郸县', N'邯郸', N'', 3, 857, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (868, N'邯山区', N'邯山', N'', 3, 857, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (869, N'鸡泽县', N'鸡泽', N'', 3, 857, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (870, N'临漳县', N'临漳', N'', 3, 857, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (871, N'邱县', N'邱县', N'', 3, 857, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (872, N'曲周县', N'曲周', N'', 3, 857, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (873, N'涉县', N'涉县', N'', 3, 857, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (874, N'魏县', N'魏县', N'', 3, 857, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (875, N'武安市', N'武安', N'', 3, 857, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (876, N'永年县', N'永年', N'', 3, 857, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (877, N'衡水市', N'衡水', N'', 2, 801, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (878, N'安平县', N'安平', N'', 3, 877, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (879, N'阜城县', N'阜城', N'', 3, 877, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (880, N'故城县', N'故城', N'', 3, 877, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (881, N'冀州市', N'冀州', N'', 3, 877, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (882, N'景县', N'景县', N'', 3, 877, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (883, N'饶阳县', N'饶阳', N'', 3, 877, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (884, N'深州市', N'深州', N'', 3, 877, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (885, N'桃城区', N'桃城', N'', 3, 877, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (886, N'武强县', N'武强', N'', 3, 877, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (887, N'武邑县', N'武邑', N'', 3, 877, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (888, N'枣强县', N'枣强', N'', 3, 877, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (889, N'廊坊市', N'廊坊', N'', 2, 801, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (890, N'安次区', N'安次', N'', 3, 889, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (891, N'霸州市', N'霸州', N'', 3, 889, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (892, N'大厂回族自治县', N'大厂', N'', 3, 889, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (893, N'大城县', N'大城', N'', 3, 889, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (894, N'固安县', N'固安', N'', 3, 889, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (895, N'广阳区', N'广阳', N'', 3, 889, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (896, N'三河市', N'三河', N'', 3, 889, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (897, N'文安县', N'文安', N'', 3, 889, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (898, N'香河县', N'香河', N'', 3, 889, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (899, N'永清县', N'永清', N'', 3, 889, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (900, N'秦皇岛市', N'秦皇岛', N'', 2, 801, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (901, N'北戴河区', N'北戴河', N'', 3, 900, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (902, N'昌黎县', N'昌黎', N'', 3, 900, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (903, N'抚宁县', N'抚宁', N'', 3, 900, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (904, N'海港区', N'海港', N'', 3, 900, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (905, N'卢龙县', N'卢龙', N'', 3, 900, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (906, N'青龙满族自治县', N'青龙', N'', 3, 900, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (907, N'山海关区', N'山海关', N'', 3, 900, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (908, N'石家庄市', N'石家庄', N'', 2, 801, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (909, N'高邑县', N'高邑', N'', 3, 908, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (910, N'藁城市', N'藁城', N'', 3, 908, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (911, N'行唐县', N'行唐', N'', 3, 908, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (912, N'晋州市', N'晋州', N'', 3, 908, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (913, N'井陉矿区', N'井陉', N'', 3, 908, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (914, N'井陉县', N'井陉', N'', 3, 908, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (915, N'灵寿县', N'灵寿', N'', 3, 908, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (916, N'鹿泉市', N'鹿泉', N'', 3, 908, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (917, N'栾城县', N'栾城', N'', 3, 908, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (918, N'平山县', N'平山', N'', 3, 908, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (919, N'桥东区', N'桥东', N'', 3, 908, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (920, N'桥西区', N'桥西', N'', 3, 908, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (921, N'深泽县', N'深泽', N'', 3, 908, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (922, N'无极县', N'无极', N'', 3, 908, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (923, N'辛集市', N'辛集', N'', 3, 908, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (924, N'新华区', N'新华', N'', 3, 908, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (925, N'新乐市', N'新乐', N'', 3, 908, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (926, N'裕华区', N'裕华', N'', 3, 908, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (927, N'元氏县', N'元氏', N'', 3, 908, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (928, N'赞皇县', N'赞皇', N'', 3, 908, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (929, N'长安区', N'长安', N'', 3, 908, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (930, N'赵县', N'赵县', N'', 3, 908, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (931, N'正定县', N'正定', N'', 3, 908, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (932, N'唐山市', N'唐山', N'', 2, 801, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (933, N'曹妃甸区', N'曹妃甸', N'', 3, 932, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (934, N'丰南区', N'丰南', N'', 3, 932, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (935, N'丰润区', N'丰润', N'', 3, 932, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (936, N'古冶区', N'古冶', N'', 3, 932, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (937, N'开平区', N'开平', N'', 3, 932, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (938, N'乐亭县', N'乐亭', N'', 3, 932, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (939, N'路北区', N'路北', N'', 3, 932, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (940, N'路南区', N'路南', N'', 3, 932, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (941, N'滦南县', N'滦南', N'', 3, 932, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (942, N'滦县', N'滦县', N'', 3, 932, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (943, N'迁安市', N'迁安', N'', 3, 932, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (944, N'迁西县', N'迁西', N'', 3, 932, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (945, N'玉田县', N'玉田', N'', 3, 932, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (946, N'遵化市', N'遵化', N'', 3, 932, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (947, N'邢台市', N'邢台', N'', 2, 801, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (948, N'柏乡县', N'柏乡', N'', 3, 947, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (949, N'广宗县', N'广宗', N'', 3, 947, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (950, N'巨鹿县', N'巨鹿', N'', 3, 947, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (951, N'临城县', N'临城', N'', 3, 947, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (952, N'临西县', N'临西', N'', 3, 947, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (953, N'隆尧县', N'隆尧', N'', 3, 947, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (954, N'南宫市', N'南宫', N'', 3, 947, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (955, N'南和县', N'南和', N'', 3, 947, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (956, N'内丘县', N'内丘', N'', 3, 947, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (957, N'宁晋县', N'宁晋', N'', 3, 947, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (958, N'平乡县', N'平乡', N'', 3, 947, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (959, N'桥东区', N'桥东', N'', 3, 947, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (960, N'桥西区', N'桥西', N'', 3, 947, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (961, N'清河县', N'清河', N'', 3, 947, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (962, N'任县', N'任县', N'', 3, 947, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (963, N'沙河市', N'沙河', N'', 3, 947, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (964, N'威县', N'威县', N'', 3, 947, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (965, N'新河县', N'新河', N'', 3, 947, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (966, N'邢台县', N'邢台', N'', 3, 947, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (967, N'张家口市', N'张家口', N'', 2, 801, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (968, N'赤城县', N'赤城', N'', 3, 967, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (969, N'崇礼县', N'崇礼', N'', 3, 967, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (970, N'沽源县', N'沽源', N'', 3, 967, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (971, N'怀安县', N'怀安', N'', 3, 967, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (972, N'怀来县', N'怀来', N'', 3, 967, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (973, N'康保县', N'康保', N'', 3, 967, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (974, N'桥东区', N'桥东', N'', 3, 967, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (975, N'桥西区', N'桥西', N'', 3, 967, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (976, N'尚义县', N'尚义', N'', 3, 967, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (977, N'万全县', N'万全', N'', 3, 967, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (978, N'蔚县', N'蔚县', N'', 3, 967, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (979, N'下花园区', N'下花园', N'', 3, 967, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (980, N'宣化区', N'宣化', N'', 3, 967, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (981, N'宣化县', N'宣化', N'', 3, 967, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (982, N'阳原县', N'阳原', N'', 3, 967, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (983, N'张北县', N'张北', N'', 3, 967, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (984, N'涿鹿县', N'涿鹿', N'', 3, 967, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (985, N'河南省', N'河南', N'', 1, 0, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (986, N'安阳市', N'安阳', N'', 2, 985, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (987, N'安阳县', N'安阳', N'', 3, 986, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (988, N'北关区', N'北关', N'', 3, 986, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (989, N'滑县', N'滑县', N'', 3, 986, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (990, N'林州市', N'林州', N'', 3, 986, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (991, N'龙安区', N'龙安', N'', 3, 986, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (992, N'内黄县', N'内黄', N'', 3, 986, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (993, N'汤阴县', N'汤阴', N'', 3, 986, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (994, N'文峰区', N'文峰', N'', 3, 986, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (995, N'殷都区', N'殷都', N'', 3, 986, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (996, N'鹤壁市', N'鹤壁', N'', 2, 985, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (997, N'鹤山区', N'鹤山', N'', 3, 996, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (998, N'浚县', N'浚县', N'', 3, 996, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (999, N'淇滨区', N'淇滨', N'', 3, 996, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1000, N'淇县', N'淇县', N'', 3, 996, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1001, N'山城区', N'山城', N'', 3, 996, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1002, N'焦作市', N'焦作', N'', 2, 985, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1003, N'博爱县', N'博爱', N'', 3, 1002, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1004, N'解放区', N'解放', N'', 3, 1002, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1005, N'马村区', N'马村', N'', 3, 1002, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1006, N'孟州市', N'孟州', N'', 3, 1002, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1007, N'沁阳市', N'沁阳', N'', 3, 1002, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1008, N'山阳区', N'山阳', N'', 3, 1002, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1009, N'温县', N'温县', N'', 3, 1002, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1010, N'武陟县', N'武陟', N'', 3, 1002, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1011, N'修武县', N'修武', N'', 3, 1002, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1012, N'中站区', N'中站', N'', 3, 1002, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1013, N'开封市', N'开封', N'', 2, 985, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1014, N'鼓楼区', N'鼓楼', N'', 3, 1013, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1015, N'金明区', N'金明', N'', 3, 1013, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1016, N'开封县', N'开封', N'', 3, 1013, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1017, N'兰考县', N'兰考', N'', 3, 1013, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1018, N'龙亭区', N'龙亭', N'', 3, 1013, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1019, N'杞县', N'杞县', N'', 3, 1013, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1020, N'顺河回族区', N'顺河', N'', 3, 1013, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1021, N'通许县', N'通许', N'', 3, 1013, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1022, N'尉氏县', N'尉氏', N'', 3, 1013, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1023, N'禹王台区', N'禹王台', N'', 3, 1013, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1024, N'洛阳市', N'洛阳', N'', 2, 985, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1025, N'瀍河回族区', N'瀍河', N'', 3, 1024, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1026, N'吉利区', N'吉利', N'', 3, 1024, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1027, N'涧西区', N'涧西', N'', 3, 1024, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1028, N'老城区', N'老城', N'', 3, 1024, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1029, N'栾川县', N'栾川', N'', 3, 1024, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1030, N'洛龙区', N'洛龙', N'', 3, 1024, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1031, N'洛宁县', N'洛宁', N'', 3, 1024, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1032, N'孟津县', N'孟津', N'', 3, 1024, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1033, N'汝阳县', N'汝阳', N'', 3, 1024, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1034, N'嵩县', N'嵩县', N'', 3, 1024, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1035, N'西工区', N'西工', N'', 3, 1024, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1036, N'新安县', N'新安', N'', 3, 1024, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1037, N'偃师市', N'偃师', N'', 3, 1024, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1038, N'伊川县', N'伊川', N'', 3, 1024, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1039, N'宜阳县', N'宜阳', N'', 3, 1024, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1040, N'漯河市', N'漯河', N'', 2, 985, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1041, N'临颍县', N'临颍', N'', 3, 1040, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1042, N'舞阳县', N'舞阳', N'', 3, 1040, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1043, N'郾城区', N'郾城', N'', 3, 1040, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1044, N'源汇区', N'源汇', N'', 3, 1040, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1045, N'召陵区', N'召陵', N'', 3, 1040, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1046, N'南阳市', N'南阳', N'', 2, 985, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1047, N'邓州市', N'邓州', N'', 3, 1046, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1048, N'方城县', N'方城', N'', 3, 1046, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1049, N'南召县', N'南召', N'', 3, 1046, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1050, N'内乡县', N'内乡', N'', 3, 1046, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1051, N'社旗县', N'社旗', N'', 3, 1046, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1052, N'唐河县', N'唐河', N'', 3, 1046, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1053, N'桐柏县', N'桐柏', N'', 3, 1046, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1054, N'宛城区', N'宛城', N'', 3, 1046, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1055, N'卧龙区', N'卧龙', N'', 3, 1046, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1056, N'西峡县', N'西峡', N'', 3, 1046, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1057, N'淅川县', N'淅川', N'', 3, 1046, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1058, N'新野县', N'新野', N'', 3, 1046, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1059, N'镇平县', N'镇平', N'', 3, 1046, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1060, N'平顶山市', N'平顶山', N'', 2, 985, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1061, N'宝丰县', N'宝丰', N'', 3, 1060, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1062, N'郏县', N'郏县', N'', 3, 1060, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1063, N'鲁山县', N'鲁山', N'', 3, 1060, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1064, N'汝州市', N'汝州', N'', 3, 1060, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1065, N'石龙区', N'石龙', N'', 3, 1060, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1066, N'卫东区', N'卫东', N'', 3, 1060, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1067, N'舞钢市', N'舞钢', N'', 3, 1060, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1068, N'新华区', N'新华', N'', 3, 1060, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1069, N'叶县', N'叶县', N'', 3, 1060, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1070, N'湛河区', N'湛河', N'', 3, 1060, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1071, N'濮阳市', N'濮阳', N'', 2, 985, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1072, N'范县', N'范县', N'', 3, 1071, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1073, N'华龙区', N'华龙', N'', 3, 1071, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1074, N'南乐县', N'南乐', N'', 3, 1071, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1075, N'濮阳县', N'濮阳', N'', 3, 1071, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1076, N'清丰县', N'清丰', N'', 3, 1071, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1077, N'台前县', N'台前', N'', 3, 1071, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1078, N'三门峡市', N'三门峡', N'', 2, 985, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1079, N'湖滨区', N'湖滨', N'', 3, 1078, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1080, N'灵宝市', N'灵宝', N'', 3, 1078, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1081, N'卢氏县', N'卢氏', N'', 3, 1078, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1082, N'渑池县', N'渑池', N'', 3, 1078, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1083, N'陕县', N'陕县', N'', 3, 1078, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1084, N'义马市', N'义马', N'', 3, 1078, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1085, N'商丘市', N'商丘', N'', 2, 985, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1086, N'梁园区', N'梁园', N'', 3, 1085, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1087, N'民权县', N'民权', N'', 3, 1085, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1088, N'宁陵县', N'宁陵', N'', 3, 1085, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1089, N'睢县', N'睢县', N'', 3, 1085, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1090, N'睢阳区', N'睢阳', N'', 3, 1085, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1091, N'夏邑县', N'夏邑', N'', 3, 1085, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1092, N'永城市', N'永城', N'', 3, 1085, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1093, N'虞城县', N'虞城', N'', 3, 1085, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1094, N'柘城县', N'柘城', N'', 3, 1085, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1095, N'省直辖县级行政区划', N'省直辖', N'', 2, 985, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1096, N'济源市', N'济源', N'', 3, 1095, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1097, N'新乡市', N'新乡', N'', 2, 985, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1098, N'封丘县', N'封丘', N'', 3, 1097, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1099, N'凤泉区', N'凤泉', N'', 3, 1097, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1100, N'红旗区', N'红旗', N'', 3, 1097, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1101, N'辉县市', N'辉县', N'', 3, 1097, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1102, N'获嘉县', N'获嘉', N'', 3, 1097, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1103, N'牧野区', N'牧野', N'', 3, 1097, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1104, N'卫滨区', N'卫滨', N'', 3, 1097, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1105, N'卫辉市', N'卫辉', N'', 3, 1097, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1106, N'新乡县', N'新乡', N'', 3, 1097, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1107, N'延津县', N'延津', N'', 3, 1097, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1108, N'原阳县', N'原阳', N'', 3, 1097, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1109, N'长垣县', N'长垣', N'', 3, 1097, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1110, N'信阳市', N'信阳', N'', 2, 985, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1111, N'固始县', N'固始', N'', 3, 1110, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1112, N'光山县', N'光山', N'', 3, 1110, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1113, N'淮滨县', N'淮滨', N'', 3, 1110, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1114, N'潢川县', N'潢川', N'', 3, 1110, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1115, N'罗山县', N'罗山', N'', 3, 1110, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1116, N'平桥区', N'平桥', N'', 3, 1110, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1117, N'商城县', N'商城', N'', 3, 1110, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1118, N'浉河区', N'浉河', N'', 3, 1110, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1119, N'息县', N'息县', N'', 3, 1110, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1120, N'新县', N'新县', N'', 3, 1110, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1121, N'许昌市', N'许昌', N'', 2, 985, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1122, N'魏都区', N'魏都', N'', 3, 1121, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1123, N'襄城县', N'襄城', N'', 3, 1121, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1124, N'许昌县', N'许昌', N'', 3, 1121, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1125, N'鄢陵县', N'鄢陵', N'', 3, 1121, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1126, N'禹州市', N'禹州', N'', 3, 1121, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1127, N'长葛市', N'长葛', N'', 3, 1121, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1128, N'郑州市', N'郑州', N'', 2, 985, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1129, N'登封市', N'登封', N'', 3, 1128, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1130, N'二七区', N'二七', N'', 3, 1128, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1131, N'巩义市', N'巩义', N'', 3, 1128, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1132, N'管城回族区', N'管城', N'', 3, 1128, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1133, N'惠济区', N'惠济', N'', 3, 1128, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1134, N'金水区', N'金水', N'', 3, 1128, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1135, N'上街区', N'上街', N'', 3, 1128, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1136, N'新密市', N'新密', N'', 3, 1128, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1137, N'新郑市', N'新郑', N'', 3, 1128, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1138, N'荥阳市', N'荥阳', N'', 3, 1128, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1139, N'中牟县', N'中牟', N'', 3, 1128, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1140, N'中原区', N'中原', N'', 3, 1128, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1141, N'周口市', N'周口', N'', 2, 985, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1142, N'川汇区', N'川汇', N'', 3, 1141, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1143, N'郸城县', N'郸城', N'', 3, 1141, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1144, N'扶沟县', N'扶沟', N'', 3, 1141, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1145, N'淮阳县', N'淮阳', N'', 3, 1141, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1146, N'鹿邑县', N'鹿邑', N'', 3, 1141, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1147, N'商水县', N'商水', N'', 3, 1141, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1148, N'沈丘县', N'沈丘', N'', 3, 1141, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1149, N'太康县', N'太康', N'', 3, 1141, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1150, N'西华县', N'西华', N'', 3, 1141, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1151, N'项城市', N'项城', N'', 3, 1141, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1152, N'驻马店市', N'驻马店', N'', 2, 985, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1153, N'泌阳县', N'泌阳', N'', 3, 1152, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1154, N'平舆县', N'平舆', N'', 3, 1152, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1155, N'确山县', N'确山', N'', 3, 1152, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1156, N'汝南县', N'汝南', N'', 3, 1152, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1157, N'上蔡县', N'上蔡', N'', 3, 1152, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1158, N'遂平县', N'遂平', N'', 3, 1152, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1159, N'西平县', N'西平', N'', 3, 1152, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1160, N'新蔡县', N'新蔡', N'', 3, 1152, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1161, N'驿城区', N'驿城', N'', 3, 1152, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1162, N'正阳县', N'正阳', N'', 3, 1152, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1163, N'黑龙江省', N'黑龙江', N'', 1, 0, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1164, N'大庆市', N'大庆', N'', 2, 1163, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1165, N'大同区', N'大同', N'', 3, 1164, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1166, N'杜尔伯特蒙古族自治县', N'杜尔伯特', N'', 3, 1164, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1167, N'红岗区', N'红岗', N'', 3, 1164, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1168, N'林甸县', N'林甸', N'', 3, 1164, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1169, N'龙凤区', N'龙凤', N'', 3, 1164, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1170, N'让胡路区', N'让胡路', N'', 3, 1164, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1171, N'萨尔图区', N'萨尔图', N'', 3, 1164, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1172, N'肇源县', N'肇源', N'', 3, 1164, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1173, N'肇州县', N'肇州', N'', 3, 1164, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1174, N'大兴安岭地区', N'大兴安岭', N'', 2, 1163, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1175, N'呼玛县', N'呼玛', N'', 3, 1174, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1176, N'漠河县', N'漠河', N'', 3, 1174, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1177, N'塔河县', N'塔河', N'', 3, 1174, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1178, N'哈尔滨市', N'哈尔滨', N'', 2, 1163, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1179, N'阿城区', N'阿城', N'', 3, 1178, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1180, N'巴彦县', N'巴彦', N'', 3, 1178, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1181, N'宾县', N'宾县', N'', 3, 1178, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1182, N'道里区', N'道里', N'', 3, 1178, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1183, N'道外区', N'道外', N'', 3, 1178, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1184, N'方正县', N'方正', N'', 3, 1178, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1185, N'呼兰区', N'呼兰', N'', 3, 1178, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1186, N'木兰县', N'木兰', N'', 3, 1178, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1187, N'南岗区', N'南岗', N'', 3, 1178, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1188, N'平房区', N'平房', N'', 3, 1178, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1189, N'尚志市', N'尚志', N'', 3, 1178, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1190, N'双城市', N'双城', N'', 3, 1178, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1191, N'松北区', N'松北', N'', 3, 1178, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1192, N'通河县', N'通河', N'', 3, 1178, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1193, N'五常市', N'五常', N'', 3, 1178, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1194, N'香坊区', N'香坊', N'', 3, 1178, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1195, N'延寿县', N'延寿', N'', 3, 1178, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1196, N'依兰县', N'依兰', N'', 3, 1178, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1197, N'鹤岗市', N'鹤岗', N'', 2, 1163, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1198, N'东山区', N'东山', N'', 3, 1197, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1199, N'工农区', N'工农', N'', 3, 1197, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1200, N'萝北县', N'萝北', N'', 3, 1197, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1201, N'南山区', N'南山', N'', 3, 1197, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1202, N'绥滨县', N'绥滨', N'', 3, 1197, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1203, N'向阳区', N'向阳', N'', 3, 1197, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1204, N'兴安区', N'兴安', N'', 3, 1197, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1205, N'兴山区', N'兴山', N'', 3, 1197, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1206, N'黑河市', N'黑河', N'', 2, 1163, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1207, N'爱辉区', N'爱辉', N'', 3, 1206, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1208, N'北安市', N'北安', N'', 3, 1206, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1209, N'嫩江县', N'嫩江', N'', 3, 1206, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1210, N'孙吴县', N'孙吴', N'', 3, 1206, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1211, N'五大连池市', N'五大连池', N'', 3, 1206, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1212, N'逊克县', N'逊克', N'', 3, 1206, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1213, N'鸡西市', N'鸡西', N'', 2, 1163, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1214, N'城子河区', N'城子河', N'', 3, 1213, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1215, N'滴道区', N'滴道', N'', 3, 1213, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1216, N'恒山区', N'恒山', N'', 3, 1213, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1217, N'虎林市', N'虎林', N'', 3, 1213, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1218, N'鸡东县', N'鸡东', N'', 3, 1213, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1219, N'鸡冠区', N'鸡冠', N'', 3, 1213, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1220, N'梨树区', N'梨树', N'', 3, 1213, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1221, N'麻山区', N'麻山', N'', 3, 1213, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1222, N'密山市', N'密山', N'', 3, 1213, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1223, N'佳木斯市', N'佳木斯', N'', 2, 1163, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1224, N'东风区', N'东风', N'', 3, 1223, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1225, N'抚远县', N'抚远', N'', 3, 1223, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1226, N'富锦市', N'富锦', N'', 3, 1223, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1227, N'桦川县', N'桦川', N'', 3, 1223, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1228, N'桦南县', N'桦南', N'', 3, 1223, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1229, N'郊区', N'郊区', N'', 3, 1223, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1230, N'前进区', N'前进', N'', 3, 1223, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1231, N'汤原县', N'汤原', N'', 3, 1223, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1232, N'同江市', N'同江', N'', 3, 1223, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1233, N'向阳区', N'向阳', N'', 3, 1223, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1234, N'牡丹江市', N'牡丹江', N'', 2, 1163, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1235, N'爱民区', N'爱民', N'', 3, 1234, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1236, N'东安区', N'东安', N'', 3, 1234, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1237, N'东宁县', N'东宁', N'', 3, 1234, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1238, N'海林市', N'海林', N'', 3, 1234, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1239, N'林口县', N'林口', N'', 3, 1234, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1240, N'穆棱市', N'穆棱', N'', 3, 1234, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1241, N'宁安市', N'宁安', N'', 3, 1234, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1242, N'绥芬河市', N'绥芬河', N'', 3, 1234, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1243, N'西安区', N'西安', N'', 3, 1234, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1244, N'阳明区', N'阳明', N'', 3, 1234, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1245, N'七台河市', N'七台河', N'', 2, 1163, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1246, N'勃利县', N'勃利', N'', 3, 1245, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1247, N'茄子河区', N'茄子河', N'', 3, 1245, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1248, N'桃山区', N'桃山', N'', 3, 1245, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1249, N'新兴区', N'新兴', N'', 3, 1245, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1250, N'齐齐哈尔市', N'齐齐哈尔', N'', 2, 1163, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1251, N'昂昂溪区', N'昂昂溪', N'', 3, 1250, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1252, N'拜泉县', N'拜泉', N'', 3, 1250, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1253, N'富拉尔基区', N'富拉尔基', N'', 3, 1250, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1254, N'富裕县', N'富裕', N'', 3, 1250, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1255, N'甘南县', N'甘南', N'', 3, 1250, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1256, N'建华区', N'建华', N'', 3, 1250, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1257, N'克东县', N'克东', N'', 3, 1250, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1258, N'克山县', N'克山', N'', 3, 1250, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1259, N'龙江县', N'龙江', N'', 3, 1250, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1260, N'龙沙区', N'龙沙', N'', 3, 1250, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1261, N'梅里斯达斡尔族区', N'梅里斯', N'', 3, 1250, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1262, N'讷河市', N'讷河', N'', 3, 1250, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1263, N'碾子山区', N'碾子山', N'', 3, 1250, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1264, N'泰来县', N'泰来', N'', 3, 1250, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1265, N'铁锋区', N'铁锋', N'', 3, 1250, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1266, N'依安县', N'依安', N'', 3, 1250, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1267, N'双鸭山市', N'双鸭山', N'', 2, 1163, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1268, N'宝清县', N'宝清', N'', 3, 1267, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1269, N'宝山区', N'宝山', N'', 3, 1267, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1270, N'集贤县', N'集贤', N'', 3, 1267, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1271, N'尖山区', N'尖山', N'', 3, 1267, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1272, N'岭东区', N'岭东', N'', 3, 1267, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1273, N'饶河县', N'饶河', N'', 3, 1267, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1274, N'四方台区', N'四方台', N'', 3, 1267, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1275, N'友谊县', N'友谊', N'', 3, 1267, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1276, N'绥化市', N'绥化', N'', 2, 1163, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1277, N'安达市', N'安达', N'', 3, 1276, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1278, N'北林区', N'北林', N'', 3, 1276, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1279, N'海伦市', N'海伦', N'', 3, 1276, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1280, N'兰西县', N'兰西', N'', 3, 1276, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1281, N'明水县', N'明水', N'', 3, 1276, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1282, N'青冈县', N'青冈', N'', 3, 1276, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1283, N'庆安县', N'庆安', N'', 3, 1276, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1284, N'绥棱县', N'绥棱', N'', 3, 1276, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1285, N'望奎县', N'望奎', N'', 3, 1276, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1286, N'肇东市', N'肇东', N'', 3, 1276, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1287, N'伊春市', N'伊春', N'', 2, 1163, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1288, N'翠峦区', N'翠峦', N'', 3, 1287, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1289, N'带岭区', N'带岭', N'', 3, 1287, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1290, N'红星区', N'红星', N'', 3, 1287, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1291, N'嘉荫县', N'嘉荫', N'', 3, 1287, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1292, N'金山屯区', N'金山屯', N'', 3, 1287, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1293, N'美溪区', N'美溪', N'', 3, 1287, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1294, N'南岔区', N'南岔', N'', 3, 1287, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1295, N'上甘岭区', N'上甘岭', N'', 3, 1287, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1296, N'汤旺河区', N'汤旺河', N'', 3, 1287, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1297, N'铁力市', N'铁力', N'', 3, 1287, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1298, N'乌马河区', N'乌马河', N'', 3, 1287, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1299, N'乌伊岭区', N'乌伊岭', N'', 3, 1287, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1300, N'五营区', N'五营', N'', 3, 1287, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1301, N'西林区', N'西林', N'', 3, 1287, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1302, N'新青区', N'新青', N'', 3, 1287, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1303, N'伊春区', N'伊春', N'', 3, 1287, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1304, N'友好区', N'友好', N'', 3, 1287, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1305, N'湖北省', N'湖北', N'', 1, 0, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1306, N'鄂州市', N'鄂州', N'', 2, 1305, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1307, N'鄂城区', N'鄂城', N'', 3, 1306, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1308, N'华容区', N'华容', N'', 3, 1306, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1309, N'梁子湖区', N'梁子湖', N'', 3, 1306, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1310, N'恩施土家族苗族自治州', N'恩施', N'', 2, 1305, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1311, N'巴东县', N'巴东', N'', 3, 1310, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1312, N'恩施市', N'恩施', N'', 3, 1310, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1313, N'鹤峰县', N'鹤峰', N'', 3, 1310, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1314, N'建始县', N'建始', N'', 3, 1310, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1315, N'来凤县', N'来凤', N'', 3, 1310, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1316, N'利川市', N'利川', N'', 3, 1310, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1317, N'咸丰县', N'咸丰', N'', 3, 1310, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1318, N'宣恩县', N'宣恩', N'', 3, 1310, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1319, N'黄冈市', N'黄冈', N'', 2, 1305, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1320, N'红安县', N'红安', N'', 3, 1319, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1321, N'黄梅县', N'黄梅', N'', 3, 1319, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1322, N'黄州区', N'黄州', N'', 3, 1319, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1323, N'罗田县', N'罗田', N'', 3, 1319, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1324, N'麻城市', N'麻城', N'', 3, 1319, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1325, N'蕲春县', N'蕲春', N'', 3, 1319, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1326, N'团风县', N'团风', N'', 3, 1319, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1327, N'武穴市', N'武穴', N'', 3, 1319, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1328, N'浠水县', N'浠水', N'', 3, 1319, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1329, N'英山县', N'英山', N'', 3, 1319, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1330, N'黄石市', N'黄石', N'', 2, 1305, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1331, N'大冶市', N'大冶', N'', 3, 1330, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1332, N'黄石港区', N'黄石港', N'', 3, 1330, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1333, N'铁山区', N'铁山', N'', 3, 1330, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1334, N'西塞山区', N'西塞山', N'', 3, 1330, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1335, N'下陆区', N'下陆', N'', 3, 1330, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1336, N'阳新县', N'阳新', N'', 3, 1330, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1337, N'荆门市', N'荆门', N'', 2, 1305, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1338, N'东宝区', N'东宝', N'', 3, 1337, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1339, N'掇刀区', N'掇刀', N'', 3, 1337, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1340, N'京山县', N'京山', N'', 3, 1337, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1341, N'沙洋县', N'沙洋', N'', 3, 1337, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1342, N'钟祥市', N'钟祥', N'', 3, 1337, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1343, N'荆州市', N'荆州', N'', 2, 1305, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1344, N'公安县', N'公安', N'', 3, 1343, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1345, N'洪湖市', N'洪湖', N'', 3, 1343, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1346, N'监利县', N'监利', N'', 3, 1343, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1347, N'江陵县', N'江陵', N'', 3, 1343, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1348, N'荆州区', N'荆州', N'', 3, 1343, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1349, N'沙市区', N'沙市', N'', 3, 1343, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1350, N'石首市', N'石首', N'', 3, 1343, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1351, N'松滋市', N'松滋', N'', 3, 1343, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1352, N'省直辖县级行政区划', N'省直辖', N'', 2, 1305, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1353, N'潜江市', N'潜江', N'', 3, 1352, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1354, N'神农架林区', N'神农架', N'', 3, 1352, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1355, N'天门市', N'天门', N'', 3, 1352, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1356, N'仙桃市', N'仙桃', N'', 3, 1352, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1357, N'十堰市', N'十堰', N'', 2, 1305, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1358, N'丹江口市', N'丹江口', N'', 3, 1357, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1359, N'房县', N'房县', N'', 3, 1357, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1360, N'茅箭区', N'茅箭', N'', 3, 1357, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1361, N'郧西县', N'郧西', N'', 3, 1357, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1362, N'郧县', N'郧县', N'', 3, 1357, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1363, N'张湾区', N'张湾', N'', 3, 1357, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1364, N'竹山县', N'竹山', N'', 3, 1357, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1365, N'竹溪县', N'竹溪', N'', 3, 1357, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1366, N'随州市', N'随州', N'', 2, 1305, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1367, N'曾都区', N'曾都', N'', 3, 1366, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1368, N'广水市', N'广水', N'', 3, 1366, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1369, N'随县', N'随县', N'', 3, 1366, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1370, N'武汉市', N'武汉', N'', 2, 1305, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1371, N'蔡甸区', N'蔡甸', N'', 3, 1370, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1372, N'东西湖区', N'东西湖', N'', 3, 1370, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1373, N'汉南区', N'汉南', N'', 3, 1370, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1374, N'汉阳区', N'汉阳', N'', 3, 1370, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1375, N'洪山区', N'洪山', N'', 3, 1370, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1376, N'黄陂区', N'黄陂', N'', 3, 1370, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1377, N'江岸区', N'江岸', N'', 3, 1370, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1378, N'江汉区', N'江汉', N'', 3, 1370, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1379, N'江夏区', N'江夏', N'', 3, 1370, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1380, N'硚口区', N'硚口', N'', 3, 1370, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1381, N'青山区', N'青山', N'', 3, 1370, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1382, N'武昌区', N'武昌', N'', 3, 1370, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1383, N'新洲区', N'新洲', N'', 3, 1370, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1384, N'咸宁市', N'咸宁', N'', 2, 1305, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1385, N'赤壁市', N'赤壁', N'', 3, 1384, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1386, N'崇阳县', N'崇阳', N'', 3, 1384, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1387, N'嘉鱼县', N'嘉鱼', N'', 3, 1384, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1388, N'通城县', N'通城', N'', 3, 1384, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1389, N'通山县', N'通山', N'', 3, 1384, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1390, N'咸安区', N'咸安', N'', 3, 1384, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1391, N'襄阳市', N'襄阳', N'', 2, 1305, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1392, N'保康县', N'保康', N'', 3, 1391, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1393, N'樊城区', N'樊城', N'', 3, 1391, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1394, N'谷城县', N'谷城', N'', 3, 1391, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1395, N'老河口市', N'老河口', N'', 3, 1391, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1396, N'南漳县', N'南漳', N'', 3, 1391, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1397, N'襄城区', N'襄城', N'', 3, 1391, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1398, N'襄州区', N'襄州', N'', 3, 1391, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1399, N'宜城市', N'宜城', N'', 3, 1391, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1400, N'枣阳市', N'枣阳', N'', 3, 1391, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1401, N'孝感市', N'孝感', N'', 2, 1305, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1402, N'安陆市', N'安陆', N'', 3, 1401, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1403, N'大悟县', N'大悟', N'', 3, 1401, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1404, N'汉川市', N'汉川', N'', 3, 1401, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1405, N'孝昌县', N'孝昌', N'', 3, 1401, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1406, N'孝南区', N'孝南', N'', 3, 1401, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1407, N'应城市', N'应城', N'', 3, 1401, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1408, N'云梦县', N'云梦', N'', 3, 1401, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1409, N'宜昌市', N'宜昌', N'', 2, 1305, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1410, N'当阳市', N'当阳', N'', 3, 1409, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1411, N'点军区', N'点军', N'', 3, 1409, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1412, N'五峰土家族自治县', N'五峰', N'', 3, 1409, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1413, N'伍家岗区', N'伍家岗', N'', 3, 1409, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1414, N'西陵区', N'西陵', N'', 3, 1409, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1415, N'猇亭区', N'猇亭', N'', 3, 1409, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1416, N'兴山县', N'兴山', N'', 3, 1409, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1417, N'夷陵区', N'夷陵', N'', 3, 1409, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1418, N'宜都市', N'宜都', N'', 3, 1409, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1419, N'远安县', N'远安', N'', 3, 1409, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1420, N'长阳土家族自治县', N'长阳', N'', 3, 1409, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1421, N'枝江市', N'枝江', N'', 3, 1409, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1422, N'秭归县', N'秭归', N'', 3, 1409, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1423, N'湖南省', N'湖南', N'', 1, 0, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1424, N'常德市', N'常德', N'', 2, 1423, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1425, N'安乡县', N'安乡', N'', 3, 1424, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1426, N'鼎城区', N'鼎城', N'', 3, 1424, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1427, N'汉寿县', N'汉寿', N'', 3, 1424, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1428, N'津市市', N'津市', N'', 3, 1424, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1429, N'澧县', N'澧县', N'', 3, 1424, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1430, N'临澧县', N'临澧', N'', 3, 1424, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1431, N'石门县', N'石门', N'', 3, 1424, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1432, N'桃源县', N'桃源', N'', 3, 1424, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1433, N'武陵区', N'武陵', N'', 3, 1424, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1434, N'郴州市', N'郴州', N'', 2, 1423, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1435, N'安仁县', N'安仁', N'', 3, 1434, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1436, N'北湖区', N'北湖', N'', 3, 1434, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1437, N'桂东县', N'桂东', N'', 3, 1434, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1438, N'桂阳县', N'桂阳', N'', 3, 1434, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1439, N'嘉禾县', N'嘉禾', N'', 3, 1434, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1440, N'临武县', N'临武', N'', 3, 1434, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1441, N'汝城县', N'汝城', N'', 3, 1434, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1442, N'苏仙区', N'苏仙', N'', 3, 1434, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1443, N'宜章县', N'宜章', N'', 3, 1434, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1444, N'永兴县', N'永兴', N'', 3, 1434, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1445, N'资兴市', N'资兴', N'', 3, 1434, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1446, N'衡阳市', N'衡阳', N'', 2, 1423, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1447, N'常宁市', N'常宁', N'', 3, 1446, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1448, N'衡东县', N'衡东', N'', 3, 1446, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1449, N'衡南县', N'衡南', N'', 3, 1446, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1450, N'衡山县', N'衡山', N'', 3, 1446, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1451, N'衡阳县', N'衡阳', N'', 3, 1446, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1452, N'耒阳市', N'耒阳', N'', 3, 1446, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1453, N'南岳区', N'南岳', N'', 3, 1446, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1454, N'祁东县', N'祁东', N'', 3, 1446, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1455, N'石鼓区', N'石鼓', N'', 3, 1446, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1456, N'雁峰区', N'雁峰', N'', 3, 1446, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1457, N'蒸湘区', N'蒸湘', N'', 3, 1446, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1458, N'珠晖区', N'珠晖', N'', 3, 1446, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1459, N'怀化市', N'怀化', N'', 2, 1423, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1460, N'辰溪县', N'辰溪', N'', 3, 1459, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1461, N'鹤城区', N'鹤城', N'', 3, 1459, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1462, N'洪江市', N'洪江', N'', 3, 1459, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1463, N'会同县', N'会同', N'', 3, 1459, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1464, N'靖州苗族侗族自治县', N'靖州', N'', 3, 1459, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1465, N'麻阳苗族自治县', N'麻阳', N'', 3, 1459, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1466, N'通道侗族自治县', N'通道', N'', 3, 1459, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1467, N'新晃侗族自治县', N'新晃', N'', 3, 1459, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1468, N'溆浦县', N'溆浦', N'', 3, 1459, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1469, N'沅陵县', N'沅陵', N'', 3, 1459, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1470, N'芷江侗族自治县', N'芷江', N'', 3, 1459, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1471, N'中方县', N'中方', N'', 3, 1459, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1472, N'娄底市', N'娄底', N'', 2, 1423, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1473, N'冷水江市', N'冷水江', N'', 3, 1472, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1474, N'涟源市', N'涟源', N'', 3, 1472, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1475, N'娄星区', N'娄星', N'', 3, 1472, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1476, N'双峰县', N'双峰', N'', 3, 1472, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1477, N'新化县', N'新化', N'', 3, 1472, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1478, N'邵阳市', N'邵阳', N'', 2, 1423, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1479, N'北塔区', N'北塔', N'', 3, 1478, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1480, N'城步苗族自治县', N'城步', N'', 3, 1478, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1481, N'大祥区', N'大祥', N'', 3, 1478, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1482, N'洞口县', N'洞口', N'', 3, 1478, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1483, N'隆回县', N'隆回', N'', 3, 1478, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1484, N'邵东县', N'邵东', N'', 3, 1478, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1485, N'邵阳县', N'邵阳', N'', 3, 1478, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1486, N'双清区', N'双清', N'', 3, 1478, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1487, N'绥宁县', N'绥宁', N'', 3, 1478, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1488, N'武冈市', N'武冈', N'', 3, 1478, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1489, N'新宁县', N'新宁', N'', 3, 1478, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1490, N'新邵县', N'新邵', N'', 3, 1478, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1491, N'湘潭市', N'湘潭', N'', 2, 1423, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1492, N'韶山市', N'韶山', N'', 3, 1491, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1493, N'湘潭县', N'湘潭', N'', 3, 1491, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1494, N'湘乡市', N'湘乡', N'', 3, 1491, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1495, N'雨湖区', N'雨湖', N'', 3, 1491, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1496, N'岳塘区', N'岳塘', N'', 3, 1491, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1497, N'湘西土家族苗族自治州', N'湘西', N'', 2, 1423, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1498, N'保靖县', N'保靖', N'', 3, 1497, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1499, N'凤凰县', N'凤凰', N'', 3, 1497, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1500, N'古丈县', N'古丈', N'', 3, 1497, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1501, N'花垣县', N'花垣', N'', 3, 1497, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1502, N'吉首市', N'吉首', N'', 3, 1497, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1503, N'龙山县', N'龙山', N'', 3, 1497, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1504, N'泸溪县', N'泸溪', N'', 3, 1497, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1505, N'永顺县', N'永顺', N'', 3, 1497, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1506, N'益阳市', N'益阳', N'', 2, 1423, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1507, N'安化县', N'安化', N'', 3, 1506, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1508, N'赫山区', N'赫山', N'', 3, 1506, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1509, N'南县', N'南县', N'', 3, 1506, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1510, N'桃江县', N'桃江', N'', 3, 1506, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1511, N'沅江市', N'沅江', N'', 3, 1506, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1512, N'资阳区', N'资阳', N'', 3, 1506, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1513, N'永州市', N'永州', N'', 2, 1423, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1514, N'道县', N'道县', N'', 3, 1513, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1515, N'东安县', N'东安', N'', 3, 1513, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1516, N'江华瑶族自治县', N'江华', N'', 3, 1513, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1517, N'江永县', N'江永', N'', 3, 1513, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1518, N'蓝山县', N'蓝山', N'', 3, 1513, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1519, N'冷水滩区', N'冷水滩', N'', 3, 1513, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1520, N'零陵区', N'零陵', N'', 3, 1513, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1521, N'宁远县', N'宁远', N'', 3, 1513, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1522, N'祁阳县', N'祁阳', N'', 3, 1513, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1523, N'双牌县', N'双牌', N'', 3, 1513, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1524, N'新田县', N'新田', N'', 3, 1513, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1525, N'岳阳市', N'岳阳', N'', 2, 1423, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1526, N'华容县', N'华容', N'', 3, 1525, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1527, N'君山区', N'君山', N'', 3, 1525, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1528, N'临湘市', N'临湘', N'', 3, 1525, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1529, N'汨罗市', N'汨罗', N'', 3, 1525, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1530, N'平江县', N'平江', N'', 3, 1525, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1531, N'湘阴县', N'湘阴', N'', 3, 1525, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1532, N'岳阳县', N'岳阳', N'', 3, 1525, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1533, N'岳阳楼区', N'岳阳楼', N'', 3, 1525, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1534, N'云溪区', N'云溪', N'', 3, 1525, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1535, N'张家界市', N'张家界', N'', 2, 1423, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1536, N'慈利县', N'慈利', N'', 3, 1535, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1537, N'桑植县', N'桑植', N'', 3, 1535, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1538, N'武陵源区', N'武陵源', N'', 3, 1535, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1539, N'永定区', N'永定', N'', 3, 1535, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1540, N'长沙市', N'长沙', N'', 2, 1423, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1541, N'芙蓉区', N'芙蓉', N'', 3, 1540, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1542, N'开福区', N'开福', N'', 3, 1540, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1543, N'浏阳市', N'浏阳', N'', 3, 1540, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1544, N'宁乡县', N'宁乡', N'', 3, 1540, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1545, N'天心区', N'天心', N'', 3, 1540, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1546, N'望城区', N'望城', N'', 3, 1540, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1547, N'雨花区', N'雨花', N'', 3, 1540, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1548, N'岳麓区', N'岳麓', N'', 3, 1540, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1549, N'长沙县', N'长沙', N'', 3, 1540, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1550, N'株洲市', N'株洲', N'', 2, 1423, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1551, N'茶陵县', N'茶陵', N'', 3, 1550, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1552, N'荷塘区', N'荷塘', N'', 3, 1550, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1553, N'醴陵市', N'醴陵', N'', 3, 1550, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1554, N'芦淞区', N'芦淞', N'', 3, 1550, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1555, N'石峰区', N'石峰', N'', 3, 1550, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1556, N'天元区', N'天元', N'', 3, 1550, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1557, N'炎陵县', N'炎陵', N'', 3, 1550, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1558, N'攸县', N'攸县', N'', 3, 1550, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1559, N'株洲县', N'株洲', N'', 3, 1550, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1560, N'吉林省', N'吉林', N'', 1, 0, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1561, N'白城市', N'株洲', N'', 2, 1560, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1562, N'大安市', N'大安', N'', 3, 1561, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1563, N'洮北区', N'洮北', N'', 3, 1561, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1564, N'洮南市', N'洮南', N'', 3, 1561, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1565, N'通榆县', N'通榆', N'', 3, 1561, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1566, N'镇赉县', N'镇赉', N'', 3, 1561, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1567, N'白山市', N'白山', N'', 2, 1560, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1568, N'抚松县', N'抚松', N'', 3, 1567, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1569, N'浑江区', N'浑江', N'', 3, 1567, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1570, N'江源区', N'江源', N'', 3, 1567, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1571, N'靖宇县', N'靖宇', N'', 3, 1567, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1572, N'临江市', N'临江', N'', 3, 1567, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1573, N'长白朝鲜族自治县', N'长白', N'', 3, 1567, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1574, N'吉林市', N'吉林', N'', 2, 1560, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1575, N'昌邑区', N'昌邑', N'', 3, 1574, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1576, N'船营区', N'船营', N'', 3, 1574, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1577, N'丰满区', N'丰满', N'', 3, 1574, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1578, N'桦甸市', N'桦甸', N'', 3, 1574, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1579, N'蛟河市', N'蛟河', N'', 3, 1574, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1580, N'龙潭区', N'龙潭', N'', 3, 1574, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1581, N'磐石市', N'磐石', N'', 3, 1574, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1582, N'舒兰市', N'舒兰', N'', 3, 1574, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1583, N'永吉县', N'永吉', N'', 3, 1574, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1584, N'辽源市', N'辽源', N'', 2, 1560, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1585, N'东丰县', N'东丰', N'', 3, 1584, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1586, N'东辽县', N'东辽', N'', 3, 1584, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1587, N'龙山区', N'龙山', N'', 3, 1584, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1588, N'西安区', N'西安', N'', 3, 1584, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1589, N'四平市', N'四平', N'', 2, 1560, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1590, N'公主岭市', N'公主岭', N'', 3, 1589, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1591, N'梨树县', N'梨树', N'', 3, 1589, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1592, N'双辽市', N'双辽', N'', 3, 1589, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1593, N'铁东区', N'铁东', N'', 3, 1589, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1594, N'铁西区', N'铁西', N'', 3, 1589, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1595, N'伊通满族自治县', N'伊通', N'', 3, 1589, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1596, N'松原市', N'松原', N'', 2, 1560, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1597, N'扶余市', N'扶余', N'', 3, 1596, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1598, N'宁江区', N'宁江', N'', 3, 1596, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1599, N'前郭尔罗斯蒙古族自治县', N'前郭尔罗斯', N'', 3, 1596, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1600, N'乾安县', N'乾安', N'', 3, 1596, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1601, N'长岭县', N'长岭', N'', 3, 1596, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1602, N'通化市', N'通化', N'', 2, 1560, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1603, N'东昌区', N'东昌', N'', 3, 1602, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1604, N'二道江区', N'二道江', N'', 3, 1602, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1605, N'辉南县', N'辉南', N'', 3, 1602, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1606, N'集安市', N'集安', N'', 3, 1602, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1607, N'柳河县', N'柳河', N'', 3, 1602, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1608, N'梅河口市', N'梅河口', N'', 3, 1602, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1609, N'通化县', N'通化', N'', 3, 1602, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1610, N'延边朝鲜族自治州', N'延边', N'', 2, 1560, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1611, N'安图县', N'安图', N'', 3, 1610, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1612, N'敦化市', N'敦化', N'', 3, 1610, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1613, N'和龙市', N'和龙', N'', 3, 1610, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1614, N'珲春市', N'珲春', N'', 3, 1610, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1615, N'龙井市', N'龙井', N'', 3, 1610, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1616, N'图们市', N'图们', N'', 3, 1610, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1617, N'汪清县', N'汪清', N'', 3, 1610, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1618, N'延吉市', N'延吉', N'', 3, 1610, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1619, N'长春市', N'长春', N'', 2, 1560, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1620, N'朝阳区', N'朝阳', N'', 3, 1619, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1621, N'德惠市', N'德惠', N'', 3, 1619, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1622, N'二道区', N'二道', N'', 3, 1619, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1623, N'九台市', N'九台', N'', 3, 1619, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1624, N'宽城区', N'宽城', N'', 3, 1619, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1625, N'绿园区', N'绿园', N'', 3, 1619, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1626, N'南关区', N'南关', N'', 3, 1619, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1627, N'农安县', N'农安', N'', 3, 1619, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1628, N'双阳区', N'双阳', N'', 3, 1619, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1629, N'榆树市', N'榆树', N'', 3, 1619, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1630, N'江苏省', N'江苏', N'', 1, 0, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1631, N'常州市', N'常州', N'', 2, 1630, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1632, N'金坛市', N'金坛', N'', 3, 1631, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1633, N'溧阳市', N'溧阳', N'', 3, 1631, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1634, N'戚墅堰区', N'戚墅堰', N'', 3, 1631, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1635, N'天宁区', N'天宁', N'', 3, 1631, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1636, N'武进区', N'武进', N'', 3, 1631, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1637, N'新北区', N'新北', N'', 3, 1631, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1638, N'钟楼区', N'钟楼', N'', 3, 1631, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1639, N'淮安市', N'淮安', N'', 2, 1630, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1640, N'洪泽县', N'洪泽', N'', 3, 1639, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1641, N'淮安区', N'淮安', N'', 3, 1639, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1642, N'淮阴区', N'淮阴', N'', 3, 1639, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1643, N'金湖县', N'金湖', N'', 3, 1639, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1644, N'涟水县', N'涟水', N'', 3, 1639, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1645, N'清河区', N'清河', N'', 3, 1639, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1646, N'清浦区', N'清浦', N'', 3, 1639, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1647, N'盱眙县', N'盱眙', N'', 3, 1639, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1648, N'连云港市', N'连云港', N'', 2, 1630, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1649, N'东海县', N'东海', N'', 3, 1648, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1650, N'赣榆县', N'赣榆', N'', 3, 1648, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1651, N'灌南县', N'灌南', N'', 3, 1648, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1652, N'灌云县', N'灌云', N'', 3, 1648, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1653, N'海州区', N'海州', N'', 3, 1648, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1654, N'连云区', N'连云', N'', 3, 1648, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1655, N'新浦区', N'新浦', N'', 3, 1648, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1656, N'南京市', N'南京', N'', 2, 1630, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1657, N'高淳区', N'高淳', N'', 3, 1656, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1658, N'鼓楼区', N'鼓楼', N'', 3, 1656, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1659, N'建邺区', N'建邺', N'', 3, 1656, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1660, N'江宁区', N'江宁', N'', 3, 1656, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1661, N'溧水区', N'溧水', N'', 3, 1656, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1662, N'六合区', N'六合', N'', 3, 1656, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1663, N'浦口区', N'浦口', N'', 3, 1656, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1664, N'栖霞区', N'栖霞', N'', 3, 1656, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1665, N'秦淮区', N'秦淮', N'', 3, 1656, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1666, N'玄武区', N'玄武', N'', 3, 1656, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1667, N'雨花台区', N'雨花台', N'', 3, 1656, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1668, N'南通市', N'南通', N'', 2, 1630, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1669, N'崇川区', N'崇川', N'', 3, 1668, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1670, N'港闸区', N'港闸', N'', 3, 1668, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1671, N'海安县', N'海安', N'', 3, 1668, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1672, N'海门市', N'海门', N'', 3, 1668, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1673, N'启东市', N'启东', N'', 3, 1668, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1674, N'如东县', N'如东', N'', 3, 1668, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1675, N'如皋市', N'如皋', N'', 3, 1668, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1676, N'通州区', N'通州', N'', 3, 1668, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1677, N'苏州市', N'苏州', N'', 2, 1630, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1678, N'常熟市', N'常熟', N'', 3, 1677, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1679, N'姑苏区', N'姑苏', N'', 3, 1677, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1680, N'虎丘区', N'虎丘', N'', 3, 1677, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1681, N'昆山市', N'昆山', N'', 3, 1677, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1682, N'太仓市', N'太仓', N'', 3, 1677, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1683, N'吴江市', N'吴江', N'', 3, 1677, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1684, N'吴中区', N'吴中', N'', 3, 1677, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1685, N'相城区', N'相城', N'', 3, 1677, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1686, N'张家港市', N'张家港', N'', 3, 1677, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1687, N'泰州市', N'泰州', N'', 2, 1630, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1688, N'高港区', N'高港', N'', 3, 1687, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1689, N'海陵区', N'海陵', N'', 3, 1687, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1690, N'姜堰区', N'姜堰', N'', 3, 1687, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1691, N'靖江市', N'靖江', N'', 3, 1687, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1692, N'泰兴市', N'泰兴', N'', 3, 1687, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1693, N'兴化市', N'兴化', N'', 3, 1687, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1694, N'无锡市', N'无锡', N'', 2, 1630, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1695, N'北塘区', N'北塘', N'', 3, 1694, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1696, N'滨湖区', N'滨湖', N'', 3, 1694, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1697, N'崇安区', N'崇安', N'', 3, 1694, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1698, N'惠山区', N'惠山', N'', 3, 1694, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1699, N'江阴市', N'江阴', N'', 3, 1694, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1700, N'南长区', N'南长', N'', 3, 1694, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1701, N'锡山区', N'锡山', N'', 3, 1694, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1702, N'宜兴市', N'宜兴', N'', 3, 1694, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1703, N'宿迁市', N'宿迁', N'', 2, 1630, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1704, N'沭阳县', N'沭阳', N'', 3, 1703, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1705, N'泗洪县', N'泗洪', N'', 3, 1703, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1706, N'泗阳县', N'泗阳', N'', 3, 1703, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1707, N'宿城区', N'宿城', N'', 3, 1703, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1708, N'宿豫区', N'宿豫', N'', 3, 1703, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1709, N'徐州市', N'徐州', N'', 2, 1630, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1710, N'丰县', N'丰县', N'', 3, 1709, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1711, N'鼓楼区', N'鼓楼', N'', 3, 1709, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1712, N'贾汪区', N'贾汪', N'', 3, 1709, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1713, N'沛县', N'沛县', N'', 3, 1709, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1714, N'邳州市', N'邳州', N'', 3, 1709, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1715, N'泉山区', N'泉山', N'', 3, 1709, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1716, N'睢宁县', N'睢宁', N'', 3, 1709, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1717, N'铜山区', N'铜山', N'', 3, 1709, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1718, N'新沂市', N'新沂', N'', 3, 1709, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1719, N'云龙区', N'云龙', N'', 3, 1709, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1720, N'盐城市', N'盐城', N'', 2, 1630, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1721, N'滨海县', N'滨海', N'', 3, 1720, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1722, N'大丰市', N'大丰', N'', 3, 1720, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1723, N'东台市', N'东台', N'', 3, 1720, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1724, N'阜宁县', N'阜宁', N'', 3, 1720, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1725, N'建湖县', N'建湖', N'', 3, 1720, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1726, N'射阳县', N'射阳', N'', 3, 1720, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1727, N'亭湖区', N'亭湖', N'', 3, 1720, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1728, N'响水县', N'响水', N'', 3, 1720, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1729, N'盐都区', N'盐都', N'', 3, 1720, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1730, N'扬州市', N'扬州', N'', 2, 1630, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1731, N'宝应县', N'宝应', N'', 3, 1730, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1732, N'高邮市', N'高邮', N'', 3, 1730, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1733, N'广陵区', N'广陵', N'', 3, 1730, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1734, N'邗江区', N'邗江', N'', 3, 1730, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1735, N'江都区', N'江都', N'', 3, 1730, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1736, N'仪征市', N'仪征', N'', 3, 1730, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1737, N'镇江市', N'镇江', N'', 2, 1630, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1738, N'丹徒区', N'丹徒', N'', 3, 1737, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1739, N'丹阳市', N'丹阳', N'', 3, 1737, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1740, N'京口区', N'京口', N'', 3, 1737, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1741, N'句容市', N'句容', N'', 3, 1737, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1742, N'润州区', N'润州', N'', 3, 1737, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1743, N'扬中市', N'扬中', N'', 3, 1737, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1744, N'江西省', N'江西', N'', 1, 0, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1745, N'抚州市', N'抚州', N'', 2, 1744, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1746, N'崇仁县', N'崇仁', N'', 3, 1745, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1747, N'东乡县', N'东乡', N'', 3, 1745, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1748, N'广昌县', N'广昌', N'', 3, 1745, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1749, N'金溪县', N'金溪', N'', 3, 1745, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1750, N'乐安县', N'乐安', N'', 3, 1745, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1751, N'黎川县', N'黎川', N'', 3, 1745, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1752, N'临川区', N'临川', N'', 3, 1745, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1753, N'南城县', N'南城', N'', 3, 1745, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1754, N'南丰县', N'南丰', N'', 3, 1745, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1755, N'宜黄县', N'宜黄', N'', 3, 1745, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1756, N'资溪县', N'资溪', N'', 3, 1745, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1757, N'赣州市', N'赣州', N'', 2, 1744, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1758, N'安远县', N'安远', N'', 3, 1757, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1759, N'崇义县', N'崇义', N'', 3, 1757, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1760, N'大余县', N'大余', N'', 3, 1757, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1761, N'定南县', N'定南', N'', 3, 1757, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1762, N'赣县', N'赣县', N'', 3, 1757, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1763, N'会昌县', N'会昌', N'', 3, 1757, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1764, N'龙南县', N'龙南', N'', 3, 1757, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1765, N'南康区', N'南康', N'', 3, 1757, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1766, N'宁都县', N'宁都', N'', 3, 1757, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1767, N'全南县', N'全南', N'', 3, 1757, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1768, N'瑞金市', N'瑞金', N'', 3, 1757, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1769, N'上犹县', N'上犹', N'', 3, 1757, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1770, N'石城县', N'石城', N'', 3, 1757, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1771, N'信丰县', N'信丰', N'', 3, 1757, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1772, N'兴国县', N'兴国', N'', 3, 1757, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1773, N'寻乌县', N'寻乌', N'', 3, 1757, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1774, N'于都县', N'于都', N'', 3, 1757, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1775, N'章贡区', N'章贡', N'', 3, 1757, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1776, N'吉安市', N'吉安', N'', 2, 1744, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1777, N'安福县', N'安福', N'', 3, 1776, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1778, N'吉安县', N'吉安', N'', 3, 1776, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1779, N'吉水县', N'吉水', N'', 3, 1776, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1780, N'吉州区', N'吉州', N'', 3, 1776, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1781, N'井冈山市', N'井冈山', N'', 3, 1776, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1782, N'青原区', N'青原', N'', 3, 1776, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1783, N'遂川县', N'遂川', N'', 3, 1776, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1784, N'泰和县', N'泰和', N'', 3, 1776, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1785, N'万安县', N'万安', N'', 3, 1776, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1786, N'峡江县', N'峡江', N'', 3, 1776, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1787, N'新干县', N'新干', N'', 3, 1776, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1788, N'永丰县', N'永丰', N'', 3, 1776, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1789, N'永新县', N'永新', N'', 3, 1776, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1790, N'景德镇市', N'景德镇', N'', 2, 1744, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1791, N'昌江区', N'昌江', N'', 3, 1790, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1792, N'浮梁县', N'浮梁', N'', 3, 1790, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1793, N'乐平市', N'乐平', N'', 3, 1790, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1794, N'珠山区', N'珠山', N'', 3, 1790, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1795, N'九江市', N'九江', N'', 2, 1744, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1796, N'德安县', N'德安', N'', 3, 1795, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1797, N'都昌县', N'都昌', N'', 3, 1795, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1798, N'共青城市', N'共青城', N'', 3, 1795, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1799, N'湖口县', N'湖口', N'', 3, 1795, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1800, N'九江县', N'九江', N'', 3, 1795, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1801, N'庐山区', N'庐山', N'', 3, 1795, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1802, N'彭泽县', N'彭泽', N'', 3, 1795, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1803, N'瑞昌市', N'瑞昌', N'', 3, 1795, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1804, N'武宁县', N'武宁', N'', 3, 1795, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1805, N'星子县', N'星子', N'', 3, 1795, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1806, N'修水县', N'修水', N'', 3, 1795, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1807, N'浔阳区', N'浔阳', N'', 3, 1795, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1808, N'永修县', N'永修', N'', 3, 1795, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1809, N'南昌市', N'南昌', N'', 2, 1744, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1810, N'安义县', N'安义', N'', 3, 1809, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1811, N'东湖区', N'东湖', N'', 3, 1809, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1812, N'进贤县', N'进贤', N'', 3, 1809, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1813, N'南昌县', N'南昌', N'', 3, 1809, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1814, N'青山湖区', N'青山湖', N'', 3, 1809, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1815, N'青云谱区', N'青云谱', N'', 3, 1809, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1816, N'湾里区', N'湾里', N'', 3, 1809, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1817, N'西湖区', N'西湖', N'', 3, 1809, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1818, N'新建县', N'新建', N'', 3, 1809, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1819, N'萍乡市', N'萍乡', N'', 2, 1744, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1820, N'安源区', N'安源', N'', 3, 1819, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1821, N'莲花县', N'莲花', N'', 3, 1819, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1822, N'芦溪县', N'芦溪', N'', 3, 1819, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1823, N'上栗县', N'上栗', N'', 3, 1819, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1824, N'湘东区', N'湘东', N'', 3, 1819, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1825, N'上饶市', N'上饶', N'', 2, 1744, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1826, N'德兴市', N'德兴', N'', 3, 1825, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1827, N'广丰县', N'广丰', N'', 3, 1825, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1828, N'横峰县', N'横峰', N'', 3, 1825, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1829, N'鄱阳县', N'鄱阳', N'', 3, 1825, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1830, N'铅山县', N'铅山', N'', 3, 1825, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1831, N'上饶县', N'上饶', N'', 3, 1825, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1832, N'万年县', N'万年', N'', 3, 1825, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1833, N'婺源县', N'婺源', N'', 3, 1825, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1834, N'信州区', N'信州', N'', 3, 1825, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1835, N'弋阳县', N'弋阳', N'', 3, 1825, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1836, N'余干县', N'余干', N'', 3, 1825, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1837, N'玉山县', N'玉山', N'', 3, 1825, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1838, N'新余市', N'新余', N'', 2, 1744, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1839, N'分宜县', N'分宜', N'', 3, 1838, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1840, N'渝水区', N'渝水', N'', 3, 1838, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1841, N'宜春市', N'宜春', N'', 2, 1744, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1842, N'丰城市', N'丰城', N'', 3, 1841, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1843, N'奉新县', N'奉新', N'', 3, 1841, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1844, N'高安市', N'高安', N'', 3, 1841, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1845, N'靖安县', N'靖安', N'', 3, 1841, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1846, N'上高县', N'上高', N'', 3, 1841, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1847, N'铜鼓县', N'铜鼓', N'', 3, 1841, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1848, N'万载县', N'万载', N'', 3, 1841, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1849, N'宜丰县', N'宜丰', N'', 3, 1841, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1850, N'袁州区', N'袁州', N'', 3, 1841, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1851, N'樟树市', N'樟树', N'', 3, 1841, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1852, N'鹰潭市', N'鹰潭', N'', 2, 1744, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1853, N'贵溪市', N'贵溪', N'', 3, 1852, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1854, N'余江县', N'余江', N'', 3, 1852, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1855, N'月湖区', N'月湖', N'', 3, 1852, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1856, N'辽宁省', N'辽宁', N'', 1, 0, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1857, N'鞍山市', N'鞍山', N'', 2, 1856, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1858, N'海城市', N'海城', N'', 3, 1857, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1859, N'立山区', N'立山', N'', 3, 1857, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1860, N'千山区', N'千山', N'', 3, 1857, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1861, N'台安县', N'台安', N'', 3, 1857, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1862, N'铁东区', N'铁东', N'', 3, 1857, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1863, N'铁西区', N'铁西', N'', 3, 1857, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1864, N'岫岩满族自治县', N'岫岩', N'', 3, 1857, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1865, N'本溪市', N'本溪', N'', 2, 1856, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1866, N'本溪满族自治县', N'本溪', N'', 3, 1865, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1867, N'桓仁满族自治县', N'桓仁', N'', 3, 1865, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1868, N'明山区', N'明山', N'', 3, 1865, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1869, N'南芬区', N'南芬', N'', 3, 1865, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1870, N'平山区', N'平山', N'', 3, 1865, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1871, N'溪湖区', N'溪湖', N'', 3, 1865, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1872, N'朝阳市', N'朝阳', N'', 2, 1856, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1873, N'北票市', N'北票', N'', 3, 1872, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1874, N'朝阳县', N'朝阳', N'', 3, 1872, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1875, N'建平县', N'建平', N'', 3, 1872, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1876, N'喀喇沁左翼蒙古族自治县', N'喀喇沁', N'', 3, 1872, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1877, N'凌源市', N'凌源', N'', 3, 1872, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1878, N'龙城区', N'龙城', N'', 3, 1872, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1879, N'双塔区', N'双塔', N'', 3, 1872, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1880, N'大连市', N'大连', N'', 2, 1856, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1881, N'甘井子区', N'甘井子', N'', 3, 1880, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1882, N'金州区', N'金州', N'', 3, 1880, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1883, N'旅顺口区', N'旅顺口', N'', 3, 1880, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1884, N'普兰店市', N'普兰店', N'', 3, 1880, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1885, N'沙河口区', N'沙河口', N'', 3, 1880, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1886, N'瓦房店市', N'瓦房店', N'', 3, 1880, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1887, N'西岗区', N'西岗', N'', 3, 1880, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1888, N'长海县', N'长海', N'', 3, 1880, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1889, N'中山区', N'中山', N'', 3, 1880, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1890, N'庄河市', N'庄河', N'', 3, 1880, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1891, N'丹东市', N'丹东', N'', 2, 1856, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1892, N'东港市', N'东港', N'', 3, 1891, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1893, N'凤城市', N'凤城', N'', 3, 1891, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1894, N'宽甸满族自治县', N'宽甸', N'', 3, 1891, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1895, N'元宝区', N'元宝', N'', 3, 1891, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1896, N'振安区', N'振安', N'', 3, 1891, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1897, N'振兴区', N'振兴', N'', 3, 1891, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1898, N'抚顺市', N'抚顺', N'', 2, 1856, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1899, N'东洲区', N'东洲', N'', 3, 1898, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1900, N'抚顺县', N'抚顺', N'', 3, 1898, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1901, N'清原满族自治县', N'清原', N'', 3, 1898, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1902, N'顺城区', N'顺城', N'', 3, 1898, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1903, N'望花区', N'望花', N'', 3, 1898, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1904, N'新宾满族自治县', N'新宾', N'', 3, 1898, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1905, N'新抚区', N'新抚', N'', 3, 1898, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1906, N'阜新市', N'阜新', N'', 2, 1856, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1907, N'阜新蒙古族自治县', N'阜新', N'', 3, 1906, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1908, N'海州区', N'海州', N'', 3, 1906, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1909, N'清河门区', N'清河门', N'', 3, 1906, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1910, N'太平区', N'太平', N'', 3, 1906, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1911, N'细河区', N'细河', N'', 3, 1906, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1912, N'新邱区', N'新邱', N'', 3, 1906, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1913, N'彰武县', N'彰武', N'', 3, 1906, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1914, N'葫芦岛市', N'葫芦岛', N'', 2, 1856, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1915, N'建昌县', N'建昌', N'', 3, 1914, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1916, N'连山区', N'连山', N'', 3, 1914, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1917, N'龙港区', N'龙港', N'', 3, 1914, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1918, N'南票区', N'南票', N'', 3, 1914, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1919, N'绥中县', N'绥中', N'', 3, 1914, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1920, N'兴城市', N'兴城', N'', 3, 1914, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1921, N'锦州市', N'锦州', N'', 2, 1856, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1922, N'北镇市', N'北镇', N'', 3, 1921, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1923, N'古塔区', N'古塔', N'', 3, 1921, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1924, N'黑山县', N'黑山', N'', 3, 1921, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1925, N'凌海市', N'凌海', N'', 3, 1921, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1926, N'凌河区', N'凌河', N'', 3, 1921, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1927, N'太和区', N'太和', N'', 3, 1921, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1928, N'义县', N'义县', N'', 3, 1921, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1929, N'辽阳市', N'辽阳', N'', 2, 1856, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1930, N'白塔区', N'白塔', N'', 3, 1929, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1931, N'灯塔市', N'灯塔', N'', 3, 1929, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1932, N'弓长岭区', N'弓长岭', N'', 3, 1929, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1933, N'宏伟区', N'宏伟', N'', 3, 1929, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1934, N'辽阳县', N'辽阳', N'', 3, 1929, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1935, N'太子河区', N'太子河', N'', 3, 1929, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1936, N'文圣区', N'文圣', N'', 3, 1929, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1937, N'盘锦市', N'盘锦', N'', 2, 1856, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1938, N'大洼县', N'大洼', N'', 3, 1937, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1939, N'盘山县', N'盘山', N'', 3, 1937, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1940, N'双台子区', N'双台子', N'', 3, 1937, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1941, N'兴隆台区', N'兴隆台', N'', 3, 1937, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1942, N'沈阳市', N'沈阳', N'', 2, 1856, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1943, N'大东区', N'大东', N'', 3, 1942, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1944, N'东陵区', N'东陵', N'', 3, 1942, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1945, N'法库县', N'法库', N'', 3, 1942, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1946, N'和平区', N'和平', N'', 3, 1942, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1947, N'皇姑区', N'皇姑', N'', 3, 1942, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1948, N'康平县', N'康平', N'', 3, 1942, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1949, N'辽中县', N'辽中', N'', 3, 1942, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1950, N'沈北新区', N'沈北', N'', 3, 1942, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1951, N'沈河区', N'沈河', N'', 3, 1942, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1952, N'苏家屯区', N'苏家屯', N'', 3, 1942, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1953, N'铁西区', N'铁西', N'', 3, 1942, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1954, N'新民市', N'新民', N'', 3, 1942, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1955, N'于洪区', N'于洪', N'', 3, 1942, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1956, N'铁岭市', N'铁岭', N'', 2, 1856, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1957, N'昌图县', N'昌图', N'', 3, 1956, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1958, N'开原市', N'开原', N'', 3, 1956, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1959, N'清河区', N'清河', N'', 3, 1956, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1960, N'调兵山市', N'调兵山', N'', 3, 1956, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1961, N'铁岭县', N'铁岭', N'', 3, 1956, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1962, N'西丰县', N'西丰', N'', 3, 1956, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1963, N'银州区', N'银州', N'', 3, 1956, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1964, N'营口市', N'营口', N'', 2, 1856, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1965, N'鲅鱼圈区', N'鲅鱼圈', N'', 3, 1964, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1966, N'大石桥市', N'大石桥', N'', 3, 1964, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1967, N'盖州市', N'盖州', N'', 3, 1964, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1968, N'老边区', N'老边', N'', 3, 1964, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1969, N'西市区', N'西市', N'', 3, 1964, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1970, N'站前区', N'站前', N'', 3, 1964, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1971, N'内蒙古自治区', N'内蒙古', N'', 1, 0, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1972, N'阿拉善盟', N'阿拉善', N'', 2, 1971, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1973, N'阿拉善右旗', N'阿拉善右', N'', 3, 1972, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1974, N'阿拉善左旗', N'阿拉善左', N'', 3, 1972, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1975, N'额济纳旗', N'额济纳', N'', 3, 1972, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1976, N'巴彦淖尔市', N'巴彦淖尔', N'', 2, 1971, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1977, N'磴口县', N'磴口', N'', 3, 1976, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1978, N'杭锦后旗', N'杭锦后', N'', 3, 1976, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1979, N'临河区', N'临河', N'', 3, 1976, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1980, N'乌拉特后旗', N'乌拉特后', N'', 3, 1976, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1981, N'乌拉特前旗', N'乌拉特前', N'', 3, 1976, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1982, N'乌拉特中旗', N'乌拉特中', N'', 3, 1976, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1983, N'五原县', N'五原', N'', 3, 1976, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1984, N'包头市', N'包头', N'', 2, 1971, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1985, N'达尔罕茂明安联合旗', N'达尔罕茂明安', N'', 3, 1984, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1986, N'东河区', N'东河', N'', 3, 1984, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1987, N'固阳县', N'固阳', N'', 3, 1984, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1988, N'九原区', N'九原', N'', 3, 1984, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1989, N'白云鄂博矿区', N'矿区', N'', 3, 1984, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1990, N'昆都仑区', N'昆都仑', N'', 3, 1984, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1991, N'青山区', N'青山', N'', 3, 1984, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1992, N'石拐区', N'石拐', N'', 3, 1984, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1993, N'土默特右旗', N'土默特右', N'', 3, 1984, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1994, N'赤峰市', N'赤峰', N'', 2, 1971, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1995, N'阿鲁科尔沁旗', N'阿鲁科尔沁', N'', 3, 1994, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1996, N'敖汉旗', N'敖汉', N'', 3, 1994, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1997, N'巴林右旗', N'巴林右', N'', 3, 1994, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1998, N'巴林左旗', N'巴林左', N'', 3, 1994, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (1999, N'红山区', N'红山', N'', 3, 1994, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2000, N'喀喇沁旗', N'喀喇沁', N'', 3, 1994, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2001, N'克什克腾旗', N'克什克腾', N'', 3, 1994, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2002, N'林西县', N'林西', N'', 3, 1994, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2003, N'宁城县', N'宁城', N'', 3, 1994, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2004, N'松山区', N'松山', N'', 3, 1994, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2005, N'翁牛特旗', N'翁牛特', N'', 3, 1994, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2006, N'元宝山区', N'元宝山', N'', 3, 1994, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2007, N'鄂尔多斯市', N'鄂尔多斯', N'', 2, 1971, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2008, N'达拉特旗', N'达拉特', N'', 3, 2007, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2009, N'东胜区', N'东胜', N'', 3, 2007, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2010, N'鄂托克旗', N'鄂托克', N'', 3, 2007, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2011, N'鄂托克前旗', N'鄂托克前', N'', 3, 2007, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2012, N'杭锦旗', N'杭锦', N'', 3, 2007, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2013, N'乌审旗', N'乌审', N'', 3, 2007, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2014, N'伊金霍洛旗', N'伊金霍洛', N'', 3, 2007, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2015, N'准格尔旗', N'准格尔', N'', 3, 2007, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2016, N'呼和浩特市', N'呼和浩特', N'', 2, 1971, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2017, N'和林格尔县', N'和林格尔', N'', 3, 2016, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2018, N'回民区', N'回民', N'', 3, 2016, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2019, N'清水河县', N'清水河', N'', 3, 2016, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2020, N'赛罕区', N'赛罕', N'', 3, 2016, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2021, N'土默特左旗', N'土默特左', N'', 3, 2016, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2022, N'托克托县', N'托克托', N'', 3, 2016, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2023, N'武川县', N'武川', N'', 3, 2016, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2024, N'新城区', N'新城', N'', 3, 2016, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2025, N'玉泉区', N'玉泉', N'', 3, 2016, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2026, N'呼伦贝尔市', N'呼伦贝尔', N'', 2, 1971, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2027, N'阿荣旗', N'阿荣', N'', 3, 2026, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2028, N'陈巴尔虎旗', N'陈巴尔虎', N'', 3, 2026, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2029, N'额尔古纳市', N'额尔古纳', N'', 3, 2026, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2030, N'鄂伦春自治旗', N'鄂伦春', N'', 3, 2026, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2031, N'鄂温克族自治旗', N'鄂温克', N'', 3, 2026, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2032, N'根河市', N'根河', N'', 3, 2026, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2033, N'海拉尔区', N'海拉尔', N'', 3, 2026, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2034, N'满洲里市', N'满洲里', N'', 3, 2026, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2035, N'莫力达瓦达斡尔族自治旗', N'莫力达瓦', N'', 3, 2026, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2036, N'新巴尔虎右旗', N'新巴尔虎右', N'', 3, 2026, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2037, N'新巴尔虎左旗', N'新巴尔虎左', N'', 3, 2026, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2038, N'牙克石市', N'牙克石', N'', 3, 2026, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2039, N'扎赉诺尔区', N'扎赉诺尔', N'', 3, 2026, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2040, N'扎兰屯市', N'扎兰屯', N'', 3, 2026, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2041, N'通辽市', N'通辽', N'', 2, 1971, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2042, N'霍林郭勒市', N'霍林郭勒', N'', 3, 2041, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2043, N'开鲁县', N'开鲁', N'', 3, 2041, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2044, N'科尔沁区', N'科尔沁', N'', 3, 2041, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2045, N'科尔沁左翼后旗', N'科尔沁左翼后', N'', 3, 2041, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2046, N'科尔沁左翼中旗', N'科尔沁左翼中', N'', 3, 2041, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2047, N'库伦旗', N'库伦', N'', 3, 2041, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2048, N'奈曼旗', N'奈曼', N'', 3, 2041, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2049, N'扎鲁特旗', N'扎鲁特', N'', 3, 2041, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2050, N'乌海市', N'乌海', N'', 2, 1971, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2051, N'海勃湾区', N'海勃湾', N'', 3, 2050, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2052, N'海南区', N'海南', N'', 3, 2050, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2053, N'乌达区', N'乌达', N'', 3, 2050, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2054, N'乌兰察布市', N'乌兰察布', N'', 2, 1971, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2055, N'察哈尔右翼后旗', N'察哈尔右翼后', N'', 3, 2054, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2056, N'察哈尔右翼前旗', N'察哈尔右翼前', N'', 3, 2054, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2057, N'察哈尔右翼中旗', N'察哈尔右翼中', N'', 3, 2054, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2058, N'丰镇市', N'丰镇', N'', 3, 2054, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2059, N'化德县', N'化德', N'', 3, 2054, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2060, N'集宁区', N'集宁', N'', 3, 2054, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2061, N'凉城县', N'凉城', N'', 3, 2054, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2062, N'商都县', N'商都', N'', 3, 2054, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2063, N'四子王旗', N'四子王', N'', 3, 2054, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2064, N'兴和县', N'兴和', N'', 3, 2054, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2065, N'卓资县', N'卓资', N'', 3, 2054, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2066, N'锡林郭勒盟', N'锡林郭勒', N'', 2, 1971, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2067, N'阿巴嘎旗', N'阿巴嘎', N'', 3, 2066, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2068, N'东乌珠穆沁旗', N'东乌珠穆沁', N'', 3, 2066, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2069, N'多伦县', N'多伦', N'', 3, 2066, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2070, N'二连浩特市', N'二连浩特', N'', 3, 2066, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2071, N'苏尼特右旗', N'苏尼特右', N'', 3, 2066, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2072, N'苏尼特左旗', N'苏尼特左', N'', 3, 2066, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2073, N'太仆寺旗', N'太仆寺', N'', 3, 2066, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2074, N'西乌珠穆沁旗', N'西乌珠穆沁', N'', 3, 2066, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2075, N'锡林浩特市', N'锡林浩特', N'', 3, 2066, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2076, N'镶黄旗', N'镶黄', N'', 3, 2066, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2077, N'正蓝旗', N'正蓝', N'', 3, 2066, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2078, N'正镶白旗', N'正镶白', N'', 3, 2066, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2079, N'兴安盟', N'兴安', N'', 2, 1971, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2080, N'阿尔山市', N'阿尔山', N'', 3, 2079, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2081, N'科尔沁右翼前旗', N'科尔沁右翼前', N'', 3, 2079, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2082, N'科尔沁右翼中旗', N'科尔沁右翼中', N'', 3, 2079, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2083, N'突泉县', N'突泉', N'', 3, 2079, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2084, N'乌兰浩特市', N'乌兰浩特', N'', 3, 2079, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2085, N'扎赉特旗', N'扎赉特', N'', 3, 2079, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2086, N'宁夏回族自治区', N'宁夏', N'', 1, 0, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2087, N'固原市', N'固原', N'', 2, 2086, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2088, N'泾源县', N'泾源', N'', 3, 2087, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2089, N'隆德县', N'隆德', N'', 3, 2087, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2090, N'彭阳县', N'彭阳', N'', 3, 2087, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2091, N'西吉县', N'西吉', N'', 3, 2087, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2092, N'原州区', N'原州', N'', 3, 2087, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2093, N'石嘴山市', N'石嘴山', N'', 2, 2086, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2094, N'大武口区', N'大武口', N'', 3, 2093, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2095, N'惠农区', N'惠农', N'', 3, 2093, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2096, N'平罗县', N'平罗', N'', 3, 2093, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2097, N'吴忠市', N'吴忠', N'', 2, 2086, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2098, N'红寺堡区', N'红寺堡', N'', 3, 2097, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2099, N'利通区', N'利通', N'', 3, 2097, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2100, N'青铜峡市', N'青铜峡', N'', 3, 2097, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2101, N'同心县', N'同心', N'', 3, 2097, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2102, N'盐池县', N'盐池', N'', 3, 2097, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2103, N'银川市', N'银川', N'', 2, 2086, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2104, N'贺兰县', N'贺兰', N'', 3, 2103, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2105, N'金凤区', N'金凤', N'', 3, 2103, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2106, N'灵武市', N'灵武', N'', 3, 2103, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2107, N'西夏区', N'西夏', N'', 3, 2103, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2108, N'兴庆区', N'兴庆', N'', 3, 2103, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2109, N'永宁县', N'永宁', N'', 3, 2103, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2110, N'中卫市', N'中卫', N'', 2, 2086, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2111, N'海原县', N'海原', N'', 3, 2110, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2112, N'沙坡头区', N'沙坡头', N'', 3, 2110, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2113, N'中宁县', N'中宁', N'', 3, 2110, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2114, N'果洛藏族自治州', N'果洛', N'', 2, 2114, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2115, N'班玛县', N'班玛', N'', 3, 2114, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2116, N'达日县', N'达日', N'', 3, 2114, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2117, N'甘德县', N'甘德', N'', 3, 2114, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2118, N'久治县', N'久治', N'', 3, 2114, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2119, N'玛多县', N'玛多', N'', 3, 2114, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2120, N'玛沁县', N'玛沁', N'', 3, 2114, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2121, N'青海省', N'青海', N'', 1, 0, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2122, N'果洛藏族自治州', N'果洛', N'', 2, 2121, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2123, N'班玛县', N'班玛', N'', 3, 2122, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2124, N'达日县', N'达日', N'', 3, 2122, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2125, N'甘德县', N'甘德', N'', 3, 2122, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2126, N'久治县', N'久治', N'', 3, 2122, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2127, N'玛多县', N'玛多', N'', 3, 2122, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2128, N'玛沁县', N'玛沁', N'', 3, 2122, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2129, N'海北藏族自治州', N'海北', N'', 2, 2121, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2130, N'刚察县', N'刚察', N'', 3, 2129, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2131, N'海晏县', N'海晏', N'', 3, 2129, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2132, N'门源回族自治县', N'门源', N'', 3, 2129, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2133, N'祁连县', N'祁连', N'', 3, 2129, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2134, N'海东市', N'海东', N'', 2, 2121, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2135, N'互助土族自治县', N'互助', N'', 3, 2134, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2136, N'化隆回族自治县', N'化隆', N'', 3, 2134, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2137, N'乐都区', N'乐都', N'', 3, 2134, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2138, N'民和回族土族自治县', N'民和', N'', 3, 2134, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2139, N'平安县', N'平安', N'', 3, 2134, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2140, N'循化撒拉族自治县', N'循化', N'', 3, 2134, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2141, N'海南藏族自治州', N'海南', N'', 2, 2121, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2142, N'共和县', N'共和', N'', 3, 2141, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2143, N'贵德县', N'贵德', N'', 3, 2141, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2144, N'贵南县', N'贵南', N'', 3, 2141, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2145, N'同德县', N'同德', N'', 3, 2141, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2146, N'兴海县', N'兴海', N'', 3, 2141, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2147, N'海西蒙古族藏族自治州', N'海西', N'', 2, 2121, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2148, N'德令哈市', N'德令哈', N'', 3, 2147, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2149, N'都兰县', N'都兰', N'', 3, 2147, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2150, N'格尔木市', N'格尔木', N'', 3, 2147, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2151, N'天峻县', N'天峻', N'', 3, 2147, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2152, N'乌兰县', N'乌兰', N'', 3, 2147, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2153, N'黄南藏族自治州', N'黄南', N'', 2, 2121, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2154, N'河南蒙古族自治县', N'河南', N'', 3, 2153, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2155, N'尖扎县', N'尖扎', N'', 3, 2153, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2156, N'同仁县', N'同仁', N'', 3, 2153, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2157, N'泽库县', N'泽库', N'', 3, 2153, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2158, N'西宁市', N'西宁', N'', 2, 2121, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2159, N'城北区', N'城北', N'', 3, 2158, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2160, N'城东区', N'城东', N'', 3, 2158, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2161, N'城西区', N'城西', N'', 3, 2158, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2162, N'城中区', N'城中', N'', 3, 2158, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2163, N'大通回族土族自治县', N'大通', N'', 3, 2158, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2164, N'湟源县', N'湟源', N'', 3, 2158, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2165, N'湟中县', N'湟中', N'', 3, 2158, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2166, N'玉树藏族自治州', N'玉树', N'', 2, 2121, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2167, N'称多县', N'称多', N'', 3, 2166, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2168, N'囊谦县', N'囊谦', N'', 3, 2166, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2169, N'曲麻莱县', N'曲麻莱', N'', 3, 2166, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2170, N'玉树市', N'玉树', N'', 3, 2166, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2171, N'杂多县', N'杂多', N'', 3, 2166, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2172, N'治多县', N'治多', N'', 3, 2166, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2173, N'滨州市', N'滨州', N'', 2, 2173, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2174, N'滨城区', N'滨城', N'', 3, 2173, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2175, N'博兴县', N'博兴', N'', 3, 2173, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2176, N'惠民县', N'惠民', N'', 3, 2173, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2177, N'无棣县', N'无棣', N'', 3, 2173, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2178, N'阳信县', N'阳信', N'', 3, 2173, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2179, N'沾化县', N'沾化', N'', 3, 2173, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2180, N'邹平县', N'邹平', N'', 3, 2173, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2181, N'山东省', N'山东', N'', 1, 0, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2182, N'滨州市', N'滨州', N'', 2, 2181, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2183, N'滨城区', N'滨城', N'', 3, 2182, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2184, N'博兴县', N'博兴', N'', 3, 2182, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2185, N'惠民县', N'惠民', N'', 3, 2182, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2186, N'无棣县', N'无棣', N'', 3, 2182, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2187, N'阳信县', N'阳信', N'', 3, 2182, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2188, N'沾化县', N'沾化', N'', 3, 2182, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2189, N'邹平县', N'邹平', N'', 3, 2182, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2190, N'德州市', N'德州', N'', 2, 2181, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2191, N'德城区', N'德城', N'', 3, 2190, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2192, N'乐陵市', N'乐陵', N'', 3, 2190, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2193, N'临邑县', N'临邑', N'', 3, 2190, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2194, N'陵县', N'陵县', N'', 3, 2190, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2195, N'宁津县', N'宁津', N'', 3, 2190, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2196, N'平原县', N'平原', N'', 3, 2190, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2197, N'齐河县', N'齐河', N'', 3, 2190, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2198, N'庆云县', N'庆云', N'', 3, 2190, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2199, N'武城县', N'武城', N'', 3, 2190, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2200, N'夏津县', N'夏津', N'', 3, 2190, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2201, N'禹城市', N'禹城', N'', 3, 2190, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2202, N'东营市', N'东营', N'', 2, 2181, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2203, N'东营区', N'东营', N'', 3, 2202, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2204, N'广饶县', N'广饶', N'', 3, 2202, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2205, N'河口区', N'河口', N'', 3, 2202, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2206, N'垦利县', N'垦利', N'', 3, 2202, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2207, N'利津县', N'利津', N'', 3, 2202, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2208, N'菏泽市', N'菏泽', N'', 2, 2181, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2209, N'曹县', N'曹县', N'', 3, 2208, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2210, N'成武县', N'成武', N'', 3, 2208, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2211, N'定陶县', N'定陶', N'', 3, 2208, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2212, N'东明县', N'东明', N'', 3, 2208, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2213, N'巨野县', N'巨野', N'', 3, 2208, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2214, N'鄄城县', N'鄄城', N'', 3, 2208, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2215, N'牡丹区', N'牡丹', N'', 3, 2208, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2216, N'单县', N'单县', N'', 3, 2208, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2217, N'郓城县', N'郓城', N'', 3, 2208, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2218, N'济南市', N'济南', N'', 2, 2181, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2219, N'槐荫区', N'槐荫', N'', 3, 2218, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2220, N'济阳县', N'济阳', N'', 3, 2218, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2221, N'历城区', N'历城', N'', 3, 2218, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2222, N'历下区', N'历下', N'', 3, 2218, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2223, N'平阴县', N'平阴', N'', 3, 2218, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2224, N'商河县', N'商河', N'', 3, 2218, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2225, N'市中区', N'市中', N'', 3, 2218, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2226, N'天桥区', N'天桥', N'', 3, 2218, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2227, N'章丘市', N'章丘', N'', 3, 2218, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2228, N'长清区', N'长清', N'', 3, 2218, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2229, N'济宁市', N'济宁', N'', 2, 2181, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2230, N'嘉祥县', N'嘉祥', N'', 3, 2229, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2231, N'金乡县', N'金乡', N'', 3, 2229, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2232, N'梁山县', N'梁山', N'', 3, 2229, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2233, N'曲阜市', N'曲阜', N'', 3, 2229, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2234, N'任城区', N'任城', N'', 3, 2229, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2235, N'泗水县', N'泗水', N'', 3, 2229, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2236, N'微山县', N'微山', N'', 3, 2229, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2237, N'汶上县', N'汶上', N'', 3, 2229, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2238, N'兖州区', N'兖州', N'', 3, 2229, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2239, N'鱼台县', N'鱼台', N'', 3, 2229, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2240, N'邹城市', N'邹城', N'', 3, 2229, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2241, N'莱芜市', N'莱芜', N'', 2, 2181, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2242, N'钢城区', N'钢城', N'', 3, 2241, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2243, N'莱城区', N'莱城', N'', 3, 2241, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2244, N'聊城市', N'聊城', N'', 2, 2181, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2245, N'茌平县', N'茌平', N'', 3, 2244, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2246, N'东阿县', N'东阿', N'', 3, 2244, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2247, N'东昌府区', N'东昌府', N'', 3, 2244, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2248, N'高唐县', N'高唐', N'', 3, 2244, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2249, N'冠县', N'冠县', N'', 3, 2244, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2250, N'临清市', N'临清', N'', 3, 2244, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2251, N'莘县', N'莘县', N'', 3, 2244, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2252, N'阳谷县', N'阳谷', N'', 3, 2244, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2253, N'临沂市', N'临沂', N'', 2, 2181, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2254, N'苍山县', N'苍山', N'', 3, 2253, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2255, N'费县', N'费县', N'', 3, 2253, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2256, N'河东区', N'河东', N'', 3, 2253, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2257, N'莒南县', N'莒南', N'', 3, 2253, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2258, N'兰山区', N'兰山', N'', 3, 2253, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2259, N'临沭县', N'临沭', N'', 3, 2253, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2260, N'罗庄区', N'罗庄', N'', 3, 2253, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2261, N'蒙阴县', N'蒙阴', N'', 3, 2253, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2262, N'平邑县', N'平邑', N'', 3, 2253, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2263, N'郯城县', N'郯城', N'', 3, 2253, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2264, N'沂南县', N'沂南', N'', 3, 2253, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2265, N'沂水县', N'沂水', N'', 3, 2253, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2266, N'青岛市', N'青岛', N'', 2, 2181, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2267, N'城阳区', N'城阳', N'', 3, 2266, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2268, N'黄岛区', N'黄岛', N'', 3, 2266, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2269, N'即墨市', N'即墨', N'', 3, 2266, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2270, N'胶州市', N'胶州', N'', 3, 2266, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2271, N'莱西市', N'莱西', N'', 3, 2266, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2272, N'崂山区', N'崂山', N'', 3, 2266, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2273, N'李沧区', N'李沧', N'', 3, 2266, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2274, N'平度市', N'平度', N'', 3, 2266, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2275, N'市北区', N'市北', N'', 3, 2266, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2276, N'市南区', N'市南', N'', 3, 2266, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2277, N'日照市', N'日照', N'', 2, 2181, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2278, N'东港区', N'东港', N'', 3, 2277, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2279, N'莒县', N'莒县', N'', 3, 2277, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2280, N'岚山区', N'岚山', N'', 3, 2277, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2281, N'五莲县', N'五莲', N'', 3, 2277, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2282, N'泰安市', N'泰安', N'', 2, 2181, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2283, N'岱岳区', N'岱岳', N'', 3, 2282, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2284, N'东平县', N'东平', N'', 3, 2282, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2285, N'肥城市', N'肥城', N'', 3, 2282, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2286, N'宁阳县', N'宁阳', N'', 3, 2282, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2287, N'泰山区', N'泰山', N'', 3, 2282, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2288, N'新泰市', N'新泰', N'', 3, 2282, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2289, N'威海市', N'威海', N'', 2, 2181, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2290, N'环翠区', N'环翠', N'', 3, 2289, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2291, N'荣成市', N'荣成', N'', 3, 2289, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2292, N'乳山市', N'乳山', N'', 3, 2289, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2293, N'文登市', N'文登', N'', 3, 2289, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2294, N'潍坊市', N'潍坊', N'', 2, 2181, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2295, N'安丘市', N'安丘', N'', 3, 2294, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2296, N'昌乐县', N'昌乐', N'', 3, 2294, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2297, N'昌邑市', N'昌邑', N'', 3, 2294, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2298, N'坊子区', N'坊子', N'', 3, 2294, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2299, N'高密市', N'高密', N'', 3, 2294, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2300, N'寒亭区', N'寒亭', N'', 3, 2294, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2301, N'奎文区', N'奎文', N'', 3, 2294, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2302, N'临朐县', N'临朐', N'', 3, 2294, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2303, N'青州市', N'青州', N'', 3, 2294, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2304, N'寿光市', N'寿光', N'', 3, 2294, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2305, N'潍城区', N'潍城', N'', 3, 2294, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2306, N'诸城市', N'诸城', N'', 3, 2294, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2307, N'烟台市', N'烟台', N'', 2, 2181, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2308, N'福山区', N'福山', N'', 3, 2307, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2309, N'海阳市', N'海阳', N'', 3, 2307, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2310, N'莱山区', N'莱山', N'', 3, 2307, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2311, N'莱阳市', N'莱阳', N'', 3, 2307, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2312, N'莱州市', N'莱州', N'', 3, 2307, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2313, N'龙口市', N'龙口', N'', 3, 2307, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2314, N'牟平区', N'牟平', N'', 3, 2307, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2315, N'蓬莱市', N'蓬莱', N'', 3, 2307, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2316, N'栖霞市', N'栖霞', N'', 3, 2307, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2317, N'长岛县', N'长岛', N'', 3, 2307, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2318, N'招远市', N'招远', N'', 3, 2307, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2319, N'芝罘区', N'芝罘', N'', 3, 2307, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2320, N'枣庄市', N'枣庄', N'', 2, 2181, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2321, N'山亭区', N'山亭', N'', 3, 2320, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2322, N'市中区', N'市中', N'', 3, 2320, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2323, N'台儿庄区', N'台儿庄', N'', 3, 2320, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2324, N'滕州市', N'滕州', N'', 3, 2320, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2325, N'薛城区', N'薛城', N'', 3, 2320, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2326, N'峄城区', N'峄城', N'', 3, 2320, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2327, N'淄博市', N'淄博', N'', 2, 2181, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2328, N'博山区', N'博山', N'', 3, 2327, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2329, N'高青县', N'高青', N'', 3, 2327, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2330, N'桓台县', N'桓台', N'', 3, 2327, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2331, N'临淄区', N'临淄', N'', 3, 2327, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2332, N'沂源县', N'沂源', N'', 3, 2327, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2333, N'张店区', N'张店', N'', 3, 2327, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2334, N'周村区', N'周村', N'', 3, 2327, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2335, N'淄川区', N'淄川', N'', 3, 2327, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2336, N'山西省', N'山西', N'', 1, 0, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2337, N'大同市', N'大同', N'', 2, 2336, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2338, N'城区', N'城区', N'', 3, 2337, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2339, N'大同县', N'大同', N'', 3, 2337, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2340, N'广灵县', N'广灵', N'', 3, 2337, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2341, N'浑源县', N'浑源', N'', 3, 2337, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2342, N'矿区', N'矿区', N'', 3, 2337, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2343, N'灵丘县', N'灵丘', N'', 3, 2337, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2344, N'南郊区', N'南郊', N'', 3, 2337, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2345, N'天镇县', N'天镇', N'', 3, 2337, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2346, N'新荣区', N'新荣', N'', 3, 2337, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2347, N'阳高县', N'阳高', N'', 3, 2337, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2348, N'左云县', N'左云', N'', 3, 2337, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2349, N'晋城市', N'晋城', N'', 2, 2336, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2350, N'城区', N'城区', N'', 3, 2349, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2351, N'高平市', N'高平', N'', 3, 2349, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2352, N'陵川县', N'陵川', N'', 3, 2349, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2353, N'沁水县', N'沁水', N'', 3, 2349, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2354, N'阳城县', N'阳城', N'', 3, 2349, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2355, N'泽州县', N'泽州', N'', 3, 2349, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2356, N'晋中市', N'晋中', N'', 2, 2336, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2357, N'和顺县', N'和顺', N'', 3, 2356, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2358, N'介休市', N'介休', N'', 3, 2356, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2359, N'灵石县', N'灵石', N'', 3, 2356, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2360, N'平遥县', N'平遥', N'', 3, 2356, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2361, N'祁县', N'祁县', N'', 3, 2356, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2362, N'寿阳县', N'寿阳', N'', 3, 2356, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2363, N'太谷县', N'太谷', N'', 3, 2356, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2364, N'昔阳县', N'昔阳', N'', 3, 2356, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2365, N'榆次区', N'榆次', N'', 3, 2356, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2366, N'榆社县', N'榆社', N'', 3, 2356, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2367, N'左权县', N'左权', N'', 3, 2356, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2368, N'临汾市', N'临汾', N'', 2, 2336, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2369, N'安泽县', N'安泽', N'', 3, 2368, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2370, N'大宁县', N'大宁', N'', 3, 2368, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2371, N'汾西县', N'汾西', N'', 3, 2368, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2372, N'浮山县', N'浮山', N'', 3, 2368, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2373, N'古县', N'古县', N'', 3, 2368, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2374, N'洪洞县', N'洪洞', N'', 3, 2368, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2375, N'侯马市', N'侯马', N'', 3, 2368, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2376, N'霍州市', N'霍州', N'', 3, 2368, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2377, N'吉县', N'吉县', N'', 3, 2368, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2378, N'蒲县', N'蒲县', N'', 3, 2368, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2379, N'曲沃县', N'曲沃', N'', 3, 2368, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2380, N'隰县', N'隰县', N'', 3, 2368, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2381, N'乡宁县', N'乡宁', N'', 3, 2368, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2382, N'襄汾县', N'襄汾', N'', 3, 2368, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2383, N'尧都区', N'尧都', N'', 3, 2368, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2384, N'翼城县', N'翼城', N'', 3, 2368, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2385, N'永和县', N'永和', N'', 3, 2368, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2386, N'吕梁市', N'吕梁', N'', 2, 2336, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2387, N'方山县', N'方山', N'', 3, 2386, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2388, N'汾阳市', N'汾阳', N'', 3, 2386, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2389, N'交城县', N'交城', N'', 3, 2386, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2390, N'交口县', N'交口', N'', 3, 2386, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2391, N'岚县', N'岚县', N'', 3, 2386, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2392, N'离石区', N'离石', N'', 3, 2386, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2393, N'临县', N'临县', N'', 3, 2386, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2394, N'柳林县', N'柳林', N'', 3, 2386, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2395, N'石楼县', N'石楼', N'', 3, 2386, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2396, N'文水县', N'文水', N'', 3, 2386, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2397, N'孝义市', N'孝义', N'', 3, 2386, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2398, N'兴县', N'兴县', N'', 3, 2386, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2399, N'中阳县', N'中阳', N'', 3, 2386, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2400, N'朔州市', N'朔州', N'', 2, 2336, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2401, N'怀仁县', N'怀仁', N'', 3, 2400, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2402, N'平鲁区', N'平鲁', N'', 3, 2400, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2403, N'山阴县', N'山阴', N'', 3, 2400, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2404, N'朔城区', N'朔城', N'', 3, 2400, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2405, N'应县', N'应县', N'', 3, 2400, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2406, N'右玉县', N'右玉', N'', 3, 2400, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2407, N'太原市', N'太原', N'', 2, 2336, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2408, N'古交市', N'古交', N'', 3, 2407, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2409, N'尖草坪区', N'尖草坪', N'', 3, 2407, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2410, N'晋源区', N'晋源', N'', 3, 2407, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2411, N'娄烦县', N'娄烦', N'', 3, 2407, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2412, N'清徐县', N'清徐', N'', 3, 2407, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2413, N'万柏林区', N'万柏林', N'', 3, 2407, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2414, N'小店区', N'小店', N'', 3, 2407, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2415, N'杏花岭区', N'杏花岭', N'', 3, 2407, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2416, N'阳曲县', N'阳曲', N'', 3, 2407, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2417, N'迎泽区', N'迎泽', N'', 3, 2407, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2418, N'忻州市', N'忻州', N'', 2, 2336, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2419, N'保德县', N'保德', N'', 3, 2418, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2420, N'代县', N'代县', N'', 3, 2418, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2421, N'定襄县', N'定襄', N'', 3, 2418, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2422, N'繁峙县', N'繁峙', N'', 3, 2418, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2423, N'河曲县', N'河曲', N'', 3, 2418, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2424, N'静乐县', N'静乐', N'', 3, 2418, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2425, N'岢岚县', N'岢岚', N'', 3, 2418, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2426, N'宁武县', N'宁武', N'', 3, 2418, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2427, N'偏关县', N'偏关', N'', 3, 2418, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2428, N'神池县', N'神池', N'', 3, 2418, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2429, N'五台县', N'五台', N'', 3, 2418, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2430, N'五寨县', N'五寨', N'', 3, 2418, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2431, N'忻府区', N'忻府', N'', 3, 2418, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2432, N'原平市', N'原平', N'', 3, 2418, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2433, N'阳泉市', N'阳泉', N'', 2, 2336, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2434, N'城区', N'城区', N'', 3, 2433, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2435, N'郊区', N'郊区', N'', 3, 2433, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2436, N'矿区', N'矿区', N'', 3, 2433, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2437, N'平定县', N'平定', N'', 3, 2433, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2438, N'盂县', N'盂县', N'', 3, 2433, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2439, N'运城市', N'运城', N'', 2, 2336, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2440, N'河津市', N'河津', N'', 3, 2439, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2441, N'稷山县', N'稷山', N'', 3, 2439, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2442, N'绛县', N'绛县', N'', 3, 2439, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2443, N'临猗县', N'临猗', N'', 3, 2439, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2444, N'平陆县', N'平陆', N'', 3, 2439, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2445, N'芮城县', N'芮城', N'', 3, 2439, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2446, N'万荣县', N'万荣', N'', 3, 2439, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2447, N'闻喜县', N'闻喜', N'', 3, 2439, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2448, N'夏县', N'夏县', N'', 3, 2439, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2449, N'新绛县', N'新绛', N'', 3, 2439, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2450, N'盐湖区', N'盐湖', N'', 3, 2439, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2451, N'永济市', N'永济', N'', 3, 2439, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2452, N'垣曲县', N'垣曲', N'', 3, 2439, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2453, N'长治市', N'长治', N'', 2, 2336, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2454, N'长治县', N'长治', N'', 3, 2453, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2455, N'城区', N'城区', N'', 3, 2453, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2456, N'壶关县', N'壶关', N'', 3, 2453, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2457, N'郊区', N'郊区', N'', 3, 2453, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2458, N'黎城县', N'黎城', N'', 3, 2453, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2459, N'潞城市', N'潞城', N'', 3, 2453, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2460, N'平顺县', N'平顺', N'', 3, 2453, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2461, N'沁县', N'沁县', N'', 3, 2453, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2462, N'沁源县', N'沁源', N'', 3, 2453, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2463, N'屯留县', N'屯留', N'', 3, 2453, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2464, N'武乡县', N'武乡', N'', 3, 2453, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2465, N'襄垣县', N'襄垣', N'', 3, 2453, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2466, N'长子县', N'长子', N'', 3, 2453, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2467, N'陕西省', N'陕西', N'', 1, 0, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2468, N'安康市', N'安康', N'', 2, 2467, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2469, N'白河县', N'白河', N'', 3, 2468, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2470, N'汉滨区', N'汉滨', N'', 3, 2468, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2471, N'汉阴县', N'汉阴', N'', 3, 2468, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2472, N'岚皋县', N'岚皋', N'', 3, 2468, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2473, N'宁陕县', N'宁陕', N'', 3, 2468, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2474, N'平利县', N'平利', N'', 3, 2468, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2475, N'石泉县', N'石泉', N'', 3, 2468, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2476, N'旬阳县', N'旬阳', N'', 3, 2468, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2477, N'镇坪县', N'镇坪', N'', 3, 2468, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2478, N'紫阳县', N'紫阳', N'', 3, 2468, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2479, N'宝鸡市', N'宝鸡', N'', 2, 2467, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2480, N'陈仓区', N'陈仓', N'', 3, 2479, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2481, N'凤县', N'凤县', N'', 3, 2479, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2482, N'凤翔县', N'凤翔', N'', 3, 2479, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2483, N'扶风县', N'扶风', N'', 3, 2479, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2484, N'金台区', N'金台', N'', 3, 2479, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2485, N'麟游县', N'麟游', N'', 3, 2479, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2486, N'陇县', N'陇县', N'', 3, 2479, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2487, N'眉县', N'眉县', N'', 3, 2479, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2488, N'岐山县', N'岐山', N'', 3, 2479, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2489, N'千阳县', N'千阳', N'', 3, 2479, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2490, N'太白县', N'太白', N'', 3, 2479, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2491, N'渭滨区', N'渭滨', N'', 3, 2479, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2492, N'汉中市', N'汉中', N'', 2, 2467, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2493, N'城固县', N'城固', N'', 3, 2492, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2494, N'佛坪县', N'佛坪', N'', 3, 2492, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2495, N'汉台区', N'汉台', N'', 3, 2492, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2496, N'留坝县', N'留坝', N'', 3, 2492, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2497, N'略阳县', N'略阳', N'', 3, 2492, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2498, N'勉县', N'勉县', N'', 3, 2492, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2499, N'南郑县', N'南郑', N'', 3, 2492, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2500, N'宁强县', N'宁强', N'', 3, 2492, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2501, N'西乡县', N'西乡', N'', 3, 2492, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2502, N'洋县', N'洋县', N'', 3, 2492, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2503, N'镇巴县', N'镇巴', N'', 3, 2492, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2504, N'商洛市', N'商洛', N'', 2, 2467, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2505, N'丹凤县', N'丹凤', N'', 3, 2504, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2506, N'洛南县', N'洛南', N'', 3, 2504, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2507, N'山阳县', N'山阳', N'', 3, 2504, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2508, N'商南县', N'商南', N'', 3, 2504, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2509, N'商州区', N'商州', N'', 3, 2504, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2510, N'柞水县', N'柞水', N'', 3, 2504, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2511, N'镇安县', N'镇安', N'', 3, 2504, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2512, N'铜川市', N'铜川', N'', 2, 2467, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2513, N'王益区', N'王益', N'', 3, 2512, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2514, N'耀州区', N'耀州', N'', 3, 2512, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2515, N'宜君县', N'宜君', N'', 3, 2512, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2516, N'印台区', N'印台', N'', 3, 2512, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2517, N'渭南市', N'渭南', N'', 2, 2467, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2518, N'白水县', N'白水', N'', 3, 2517, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2519, N'澄城县', N'澄城', N'', 3, 2517, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2520, N'大荔县', N'大荔', N'', 3, 2517, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2521, N'富平县', N'富平', N'', 3, 2517, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2522, N'韩城市', N'韩城', N'', 3, 2517, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2523, N'合阳县', N'合阳', N'', 3, 2517, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2524, N'华县', N'华县', N'', 3, 2517, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2525, N'华阴市', N'华阴', N'', 3, 2517, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2526, N'临渭区', N'临渭', N'', 3, 2517, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2527, N'蒲城县', N'蒲城', N'', 3, 2517, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2528, N'潼关县', N'潼关', N'', 3, 2517, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2529, N'西安市', N'西安', N'', 2, 2467, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2530, N'灞桥区', N'灞桥', N'', 3, 2529, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2531, N'碑林区', N'碑林', N'', 3, 2529, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2532, N'高陵县', N'高陵', N'', 3, 2529, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2533, N'户县', N'户县', N'', 3, 2529, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2534, N'蓝田县', N'蓝田', N'', 3, 2529, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2535, N'莲湖区', N'莲湖', N'', 3, 2529, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2536, N'临潼区', N'临潼', N'', 3, 2529, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2537, N'未央区', N'未央', N'', 3, 2529, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2538, N'新城区', N'新城', N'', 3, 2529, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2539, N'阎良区', N'阎良', N'', 3, 2529, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2540, N'雁塔区', N'雁塔', N'', 3, 2529, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2541, N'长安区', N'长安', N'', 3, 2529, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2542, N'周至县', N'周至', N'', 3, 2529, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2543, N'咸阳市', N'咸阳', N'', 2, 2467, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2544, N'彬县', N'彬县', N'', 3, 2543, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2545, N'淳化县', N'淳化', N'', 3, 2543, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2546, N'泾阳县', N'泾阳', N'', 3, 2543, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2547, N'礼泉县', N'礼泉', N'', 3, 2543, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2548, N'乾县', N'乾县', N'', 3, 2543, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2549, N'秦都区', N'秦都', N'', 3, 2543, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2550, N'三原县', N'三原', N'', 3, 2543, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2551, N'渭城区', N'渭城', N'', 3, 2543, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2552, N'武功县', N'武功', N'', 3, 2543, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2553, N'兴平市', N'兴平', N'', 3, 2543, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2554, N'旬邑县', N'旬邑', N'', 3, 2543, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2555, N'杨陵区', N'杨陵', N'', 3, 2543, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2556, N'永寿县', N'永寿', N'', 3, 2543, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2557, N'长武县', N'长武', N'', 3, 2543, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2558, N'延安市', N'延安', N'', 2, 2467, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2559, N'安塞县', N'安塞', N'', 3, 2558, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2560, N'宝塔区', N'宝塔', N'', 3, 2558, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2561, N'富县', N'富县', N'', 3, 2558, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2562, N'甘泉县', N'甘泉', N'', 3, 2558, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2563, N'黄陵县', N'黄陵', N'', 3, 2558, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2564, N'黄龙县', N'黄龙', N'', 3, 2558, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2565, N'洛川县', N'洛川', N'', 3, 2558, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2566, N'吴起县', N'吴起', N'', 3, 2558, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2567, N'延川县', N'延川', N'', 3, 2558, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2568, N'延长县', N'延长', N'', 3, 2558, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2569, N'宜川县', N'宜川', N'', 3, 2558, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2570, N'志丹县', N'志丹', N'', 3, 2558, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2571, N'子长县', N'子长', N'', 3, 2558, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2572, N'榆林市', N'榆林', N'', 2, 2467, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2573, N'定边县', N'定边', N'', 3, 2572, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2574, N'府谷县', N'府谷', N'', 3, 2572, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2575, N'横山县', N'横山', N'', 3, 2572, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2576, N'佳县', N'佳县', N'', 3, 2572, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2577, N'靖边县', N'靖边', N'', 3, 2572, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2578, N'米脂县', N'米脂', N'', 3, 2572, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2579, N'清涧县', N'清涧', N'', 3, 2572, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2580, N'神木县', N'神木', N'', 3, 2572, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2581, N'绥德县', N'绥德', N'', 3, 2572, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2582, N'吴堡县', N'吴堡', N'', 3, 2572, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2583, N'榆阳区', N'榆阳', N'', 3, 2572, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2584, N'子洲县', N'子洲', N'', 3, 2572, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2585, N'四川省', N'四川', N'', 1, 0, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2586, N'阿坝藏族羌族自治州', N'阿坝', N'', 2, 2585, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2587, N'阿坝县', N'阿坝', N'', 3, 2586, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2588, N'黑水县', N'黑水', N'', 3, 2586, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2589, N'红原县', N'红原', N'', 3, 2586, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2590, N'金川县', N'金川', N'', 3, 2586, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2591, N'九寨沟县', N'九寨沟', N'', 3, 2586, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2592, N'理县', N'理县', N'', 3, 2586, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2593, N'马尔康县', N'马尔康', N'', 3, 2586, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2594, N'茂县', N'茂县', N'', 3, 2586, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2595, N'壤塘县', N'壤塘', N'', 3, 2586, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2596, N'若尔盖县', N'若尔盖', N'', 3, 2586, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2597, N'松潘县', N'松潘', N'', 3, 2586, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2598, N'汶川县', N'汶川', N'', 3, 2586, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2599, N'小金县', N'小金', N'', 3, 2586, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2600, N'巴中市', N'巴中', N'', 2, 2585, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2601, N'巴州区', N'巴州', N'', 3, 2600, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2602, N'恩阳区', N'恩阳', N'', 3, 2600, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2603, N'南江县', N'南江', N'', 3, 2600, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2604, N'平昌县', N'平昌', N'', 3, 2600, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2605, N'通江县', N'通江', N'', 3, 2600, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2606, N'成都市', N'成都', N'', 2, 2585, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2607, N'成华区', N'成华', N'', 3, 2606, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2608, N'崇州市', N'崇州', N'', 3, 2606, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2609, N'大邑县', N'大邑', N'', 3, 2606, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2610, N'都江堰市', N'都江堰', N'', 3, 2606, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2611, N'金牛区', N'金牛', N'', 3, 2606, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2612, N'金堂县', N'金堂', N'', 3, 2606, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2613, N'锦江区', N'锦江', N'', 3, 2606, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2614, N'龙泉驿区', N'龙泉驿', N'', 3, 2606, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2615, N'彭州市', N'彭州', N'', 3, 2606, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2616, N'郫县', N'郫县', N'', 3, 2606, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2617, N'蒲江县', N'蒲江', N'', 3, 2606, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2618, N'青白江区', N'青白江', N'', 3, 2606, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2619, N'青羊区', N'青羊', N'', 3, 2606, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2620, N'邛崃市', N'邛崃', N'', 3, 2606, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2621, N'双流县', N'双流', N'', 3, 2606, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2622, N'温江区', N'温江', N'', 3, 2606, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2623, N'武侯区', N'武侯', N'', 3, 2606, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2624, N'新都区', N'新都', N'', 3, 2606, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2625, N'新津县', N'新津', N'', 3, 2606, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2626, N'达州市', N'达州', N'', 2, 2585, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2627, N'达川区', N'达川', N'', 3, 2626, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2628, N'大竹县', N'大竹', N'', 3, 2626, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2629, N'开江县', N'开江', N'', 3, 2626, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2630, N'渠县', N'渠县', N'', 3, 2626, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2631, N'通川区', N'通川', N'', 3, 2626, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2632, N'万源市', N'万源', N'', 3, 2626, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2633, N'宣汉县', N'宣汉', N'', 3, 2626, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2634, N'德阳市', N'德阳', N'', 2, 2585, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2635, N'广汉市', N'广汉', N'', 3, 2634, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2636, N'旌阳区', N'旌阳', N'', 3, 2634, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2637, N'罗江县', N'罗江', N'', 3, 2634, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2638, N'绵竹市', N'绵竹', N'', 3, 2634, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2639, N'什邡市', N'什邡', N'', 3, 2634, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2640, N'中江县', N'中江', N'', 3, 2634, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2641, N'甘孜藏族自治州', N'甘孜', N'', 2, 2585, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2642, N'巴塘县', N'巴塘', N'', 3, 2641, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2643, N'白玉县', N'白玉', N'', 3, 2641, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2644, N'丹巴县', N'丹巴', N'', 3, 2641, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2645, N'道孚县', N'道孚', N'', 3, 2641, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2646, N'稻城县', N'稻城', N'', 3, 2641, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2647, N'得荣县', N'得荣', N'', 3, 2641, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2648, N'德格县', N'德格', N'', 3, 2641, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2649, N'甘孜县', N'甘孜', N'', 3, 2641, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2650, N'九龙县', N'九龙', N'', 3, 2641, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2651, N'康定县', N'康定', N'', 3, 2641, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2652, N'理塘县', N'理塘', N'', 3, 2641, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2653, N'炉霍县', N'炉霍', N'', 3, 2641, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2654, N'泸定县', N'泸定', N'', 3, 2641, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2655, N'色达县', N'色达', N'', 3, 2641, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2656, N'石渠县', N'石渠', N'', 3, 2641, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2657, N'乡城县', N'乡城', N'', 3, 2641, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2658, N'新龙县', N'新龙', N'', 3, 2641, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2659, N'雅江县', N'雅江', N'', 3, 2641, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2660, N'广安市', N'广安', N'', 2, 2585, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2661, N'广安区', N'广安', N'', 3, 2660, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2662, N'华蓥市', N'华蓥', N'', 3, 2660, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2663, N'邻水县', N'邻水', N'', 3, 2660, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2664, N'前锋区', N'前锋', N'', 3, 2660, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2665, N'武胜县', N'武胜', N'', 3, 2660, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2666, N'岳池县', N'岳池', N'', 3, 2660, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2667, N'广元市', N'广元', N'', 2, 2585, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2668, N'苍溪县', N'苍溪', N'', 3, 2667, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2669, N'朝天区', N'朝天', N'', 3, 2667, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2670, N'剑阁县', N'剑阁', N'', 3, 2667, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2671, N'利州区', N'利州', N'', 3, 2667, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2672, N'青川县', N'青川', N'', 3, 2667, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2673, N'旺苍县', N'旺苍', N'', 3, 2667, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2674, N'昭化区', N'昭化', N'', 3, 2667, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2675, N'乐山市', N'乐山', N'', 2, 2585, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2676, N'峨边彝族自治县', N'峨边', N'', 3, 2675, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2677, N'峨眉山市', N'峨眉山', N'', 3, 2675, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2678, N'夹江县', N'夹江', N'', 3, 2675, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2679, N'犍为县', N'犍为', N'', 3, 2675, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2680, N'金口河区', N'金口河', N'', 3, 2675, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2681, N'井研县', N'井研', N'', 3, 2675, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2682, N'马边彝族自治县', N'马边', N'', 3, 2675, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2683, N'沐川县', N'沐川', N'', 3, 2675, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2684, N'沙湾区', N'沙湾', N'', 3, 2675, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2685, N'市中区', N'市中', N'', 3, 2675, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2686, N'五通桥区', N'五通桥', N'', 3, 2675, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2687, N'凉山彝族自治州', N'凉山', N'', 2, 2585, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2688, N'布拖县', N'布拖', N'', 3, 2687, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2689, N'德昌县', N'德昌', N'', 3, 2687, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2690, N'甘洛县', N'甘洛', N'', 3, 2687, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2691, N'会东县', N'会东', N'', 3, 2687, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2692, N'会理县', N'会理', N'', 3, 2687, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2693, N'金阳县', N'金阳', N'', 3, 2687, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2694, N'雷波县', N'雷波', N'', 3, 2687, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2695, N'美姑县', N'美姑', N'', 3, 2687, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2696, N'冕宁县', N'冕宁', N'', 3, 2687, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2697, N'木里藏族自治县', N'木里', N'', 3, 2687, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2698, N'宁南县', N'宁南', N'', 3, 2687, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2699, N'普格县', N'普格', N'', 3, 2687, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2700, N'西昌市', N'西昌', N'', 3, 2687, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2701, N'喜德县', N'喜德', N'', 3, 2687, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2702, N'盐源县', N'盐源', N'', 3, 2687, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2703, N'越西县', N'越西', N'', 3, 2687, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2704, N'昭觉县', N'昭觉', N'', 3, 2687, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2705, N'泸州市', N'泸州', N'', 2, 2585, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2706, N'古蔺县', N'古蔺', N'', 3, 2705, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2707, N'合江县', N'合江', N'', 3, 2705, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2708, N'江阳区', N'江阳', N'', 3, 2705, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2709, N'龙马潭区', N'龙马潭', N'', 3, 2705, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2710, N'泸县', N'泸县', N'', 3, 2705, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2711, N'纳溪区', N'纳溪', N'', 3, 2705, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2712, N'叙永县', N'叙永', N'', 3, 2705, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2713, N'眉山市', N'眉山', N'', 2, 2585, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2714, N'丹棱县', N'丹棱', N'', 3, 2713, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2715, N'东坡区', N'东坡', N'', 3, 2713, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2716, N'洪雅县', N'洪雅', N'', 3, 2713, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2717, N'彭山县', N'彭山', N'', 3, 2713, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2718, N'青神县', N'青神', N'', 3, 2713, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2719, N'仁寿县', N'仁寿', N'', 3, 2713, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2720, N'绵阳市', N'绵阳', N'', 2, 2585, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2721, N'安县', N'安县', N'', 3, 2720, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2722, N'北川羌族自治县', N'北川', N'', 3, 2720, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2723, N'涪城区', N'涪城', N'', 3, 2720, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2724, N'江油市', N'江油', N'', 3, 2720, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2725, N'平武县', N'平武', N'', 3, 2720, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2726, N'三台县', N'三台', N'', 3, 2720, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2727, N'盐亭县', N'盐亭', N'', 3, 2720, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2728, N'游仙区', N'游仙', N'', 3, 2720, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2729, N'梓潼县', N'梓潼', N'', 3, 2720, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2730, N'南充市', N'南充', N'', 2, 2585, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2731, N'高坪区', N'高坪', N'', 3, 2730, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2732, N'嘉陵区', N'嘉陵', N'', 3, 2730, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2733, N'阆中市', N'阆中', N'', 3, 2730, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2734, N'南部县', N'南部', N'', 3, 2730, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2735, N'蓬安县', N'蓬安', N'', 3, 2730, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2736, N'顺庆区', N'顺庆', N'', 3, 2730, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2737, N'西充县', N'西充', N'', 3, 2730, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2738, N'仪陇县', N'仪陇', N'', 3, 2730, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2739, N'营山县', N'营山', N'', 3, 2730, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2740, N'内江市', N'内江', N'', 2, 2585, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2741, N'东兴区', N'东兴', N'', 3, 2740, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2742, N'隆昌县', N'隆昌', N'', 3, 2740, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2743, N'市中区', N'市中', N'', 3, 2740, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2744, N'威远县', N'威远', N'', 3, 2740, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2745, N'资中县', N'资中', N'', 3, 2740, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2746, N'攀枝花市', N'攀枝花', N'', 2, 2585, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2747, N'东区', N'东区', N'', 3, 2746, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2748, N'米易县', N'米易', N'', 3, 2746, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2749, N'仁和区', N'仁和', N'', 3, 2746, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2750, N'西区', N'西区', N'', 3, 2746, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2751, N'盐边县', N'盐边', N'', 3, 2746, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2752, N'遂宁市', N'遂宁', N'', 2, 2585, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2753, N'安居区', N'安居', N'', 3, 2752, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2754, N'船山区', N'船山', N'', 3, 2752, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2755, N'大英县', N'大英', N'', 3, 2752, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2756, N'蓬溪县', N'蓬溪', N'', 3, 2752, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2757, N'射洪县', N'射洪', N'', 3, 2752, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2758, N'雅安市', N'雅安', N'', 2, 2585, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2759, N'宝兴县', N'宝兴', N'', 3, 2758, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2760, N'汉源县', N'汉源', N'', 3, 2758, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2761, N'芦山县', N'芦山', N'', 3, 2758, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2762, N'名山区', N'名山', N'', 3, 2758, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2763, N'石棉县', N'石棉', N'', 3, 2758, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2764, N'天全县', N'天全', N'', 3, 2758, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2765, N'荥经县', N'荥经', N'', 3, 2758, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2766, N'雨城区', N'雨城', N'', 3, 2758, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2767, N'宜宾市', N'宜宾', N'', 2, 2585, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2768, N'翠屏区', N'翠屏', N'', 3, 2767, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2769, N'高县', N'高县', N'', 3, 2767, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2770, N'珙县', N'珙县', N'', 3, 2767, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2771, N'江安县', N'江安', N'', 3, 2767, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2772, N'筠连县', N'筠连', N'', 3, 2767, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2773, N'南溪区', N'南溪', N'', 3, 2767, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2774, N'屏山县', N'屏山', N'', 3, 2767, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2775, N'兴文县', N'兴文', N'', 3, 2767, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2776, N'宜宾县', N'宜宾', N'', 3, 2767, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2777, N'长宁县', N'长宁', N'', 3, 2767, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2778, N'资阳市', N'资阳', N'', 2, 2585, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2779, N'安岳县', N'安岳', N'', 3, 2778, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2780, N'简阳市', N'简阳', N'', 3, 2778, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2781, N'乐至县', N'乐至', N'', 3, 2778, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2782, N'雁江区', N'雁江', N'', 3, 2778, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2783, N'自贡市', N'自贡', N'', 2, 2585, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2784, N'大安区', N'大安', N'', 3, 2783, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2785, N'富顺县', N'富顺', N'', 3, 2783, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2786, N'贡井区', N'贡井', N'', 3, 2783, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2787, N'荣县', N'荣县', N'', 3, 2783, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2788, N'沿滩区', N'沿滩', N'', 3, 2783, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2789, N'自流井区', N'自流井', N'', 3, 2783, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2790, N'西藏自治区', N'西藏', N'', 1, 1, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2791, N'阿里地区', N'阿里', N'', 2, 2790, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2792, N'措勤县', N'措勤', N'', 3, 2791, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2793, N'噶尔县', N'噶尔', N'', 3, 2791, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2794, N'改则县', N'改则', N'', 3, 2791, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2795, N'革吉县', N'革吉', N'', 3, 2791, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2796, N'普兰县', N'普兰', N'', 3, 2791, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2797, N'日土县', N'日土', N'', 3, 2791, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2798, N'札达县', N'札达', N'', 3, 2791, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2799, N'昌都地区', N'昌都', N'', 2, 2790, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2800, N'八宿县', N'八宿', N'', 3, 2799, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2801, N'边坝县', N'边坝', N'', 3, 2799, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2802, N'察雅县', N'察雅', N'', 3, 2799, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2803, N'昌都县', N'昌都', N'', 3, 2799, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2804, N'丁青县', N'丁青', N'', 3, 2799, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2805, N'贡觉县', N'贡觉', N'', 3, 2799, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2806, N'江达县', N'江达', N'', 3, 2799, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2807, N'类乌齐县', N'类乌齐', N'', 3, 2799, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2808, N'洛隆县', N'洛隆', N'', 3, 2799, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2809, N'芒康县', N'芒康', N'', 3, 2799, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2810, N'左贡县', N'左贡', N'', 3, 2799, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2811, N'拉萨市', N'拉萨', N'', 2, 2790, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2812, N'城关区', N'城关', N'', 3, 2811, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2813, N'达孜县', N'达孜', N'', 3, 2811, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2814, N'当雄县', N'当雄', N'', 3, 2811, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2815, N'堆龙德庆县', N'堆龙德庆', N'', 3, 2811, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2816, N'林周县', N'林周', N'', 3, 2811, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2817, N'墨竹工卡县', N'墨竹工卡', N'', 3, 2811, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2818, N'尼木县', N'尼木', N'', 3, 2811, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2819, N'曲水县', N'曲水', N'', 3, 2811, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2820, N'林芝地区', N'林芝', N'', 2, 2790, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2821, N'波密县', N'波密', N'', 3, 2820, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2822, N'察隅县', N'察隅', N'', 3, 2820, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2823, N'工布江达县', N'工布江达', N'', 3, 2820, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2824, N'朗县', N'朗县', N'', 3, 2820, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2825, N'林芝县', N'林芝', N'', 3, 2820, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2826, N'米林县', N'米林', N'', 3, 2820, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2827, N'墨脱县', N'墨脱', N'', 3, 2820, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2828, N'那曲地区', N'那曲', N'', 2, 2790, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2829, N'安多县', N'安多', N'', 3, 2828, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2830, N'巴青县', N'巴青', N'', 3, 2828, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2831, N'班戈县', N'班戈', N'', 3, 2828, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2832, N'比如县', N'比如', N'', 3, 2828, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2833, N'嘉黎县', N'嘉黎', N'', 3, 2828, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2834, N'那曲县', N'那曲', N'', 3, 2828, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2835, N'尼玛县', N'尼玛', N'', 3, 2828, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2836, N'聂荣县', N'聂荣', N'', 3, 2828, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2837, N'申扎县', N'申扎', N'', 3, 2828, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2838, N'双湖县', N'双湖', N'', 3, 2828, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2839, N'索县', N'索县', N'', 3, 2828, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2840, N'日喀则地区', N'日喀则', N'', 2, 2790, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2841, N'昂仁县', N'昂仁', N'', 3, 2840, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2842, N'白朗县', N'白朗', N'', 3, 2840, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2843, N'定结县', N'定结', N'', 3, 2840, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2844, N'定日县', N'定日', N'', 3, 2840, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2845, N'岗巴县', N'岗巴', N'', 3, 2840, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2846, N'吉隆县', N'吉隆', N'', 3, 2840, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2847, N'江孜县', N'江孜', N'', 3, 2840, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2848, N'康马县', N'康马', N'', 3, 2840, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2849, N'拉孜县', N'拉孜', N'', 3, 2840, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2850, N'南木林县', N'南木林', N'', 3, 2840, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2851, N'聂拉木县', N'聂拉木', N'', 3, 2840, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2852, N'仁布县', N'仁布', N'', 3, 2840, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2853, N'日喀则市', N'日喀则', N'', 3, 2840, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2854, N'萨嘎县', N'萨嘎', N'', 3, 2840, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2855, N'萨迦县', N'萨迦', N'', 3, 2840, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2856, N'谢通门县', N'谢通门', N'', 3, 2840, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2857, N'亚东县', N'亚东', N'', 3, 2840, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2858, N'仲巴县', N'仲巴', N'', 3, 2840, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2859, N'山南地区', N'山南', N'', 2, 2790, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2860, N'措美县', N'措美', N'', 3, 2859, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2861, N'错那县', N'错那', N'', 3, 2859, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2862, N'贡嘎县', N'贡嘎', N'', 3, 2859, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2863, N'加查县', N'加查', N'', 3, 2859, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2864, N'浪卡子县', N'浪卡子', N'', 3, 2859, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2865, N'隆子县', N'隆子', N'', 3, 2859, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2866, N'洛扎县', N'洛扎', N'', 3, 2859, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2867, N'乃东县', N'乃东', N'', 3, 2859, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2868, N'琼结县', N'琼结', N'', 3, 2859, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2869, N'曲松县', N'曲松', N'', 3, 2859, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2870, N'桑日县', N'桑日', N'', 3, 2859, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2871, N'扎囊县', N'扎囊', N'', 3, 2859, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2872, N'新疆维吾尔自治区', N'新疆', N'', 1, 0, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2873, N'阿克苏地区', N'阿克苏', N'', 2, 2872, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2874, N'阿克苏市', N'阿克苏', N'', 3, 2873, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2875, N'阿瓦提县', N'阿瓦提', N'', 3, 2873, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2876, N'拜城县', N'拜城', N'', 3, 2873, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2877, N'柯坪县', N'柯坪', N'', 3, 2873, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2878, N'库车县', N'库车', N'', 3, 2873, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2879, N'沙雅县', N'沙雅', N'', 3, 2873, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2880, N'温宿县', N'温宿', N'', 3, 2873, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2881, N'乌什县', N'乌什', N'', 3, 2873, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2882, N'新和县', N'新和', N'', 3, 2873, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2883, N'阿勒泰地区', N'阿勒泰', N'', 2, 2872, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2884, N'阿勒泰市', N'阿勒泰', N'', 3, 2883, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2885, N'布尔津县', N'布尔津', N'', 3, 2883, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2886, N'福海县', N'福海', N'', 3, 2883, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2887, N'富蕴县', N'富蕴', N'', 3, 2883, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2888, N'哈巴河县', N'哈巴河', N'', 3, 2883, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2889, N'吉木乃县', N'吉木乃', N'', 3, 2883, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2890, N'青河县', N'青河', N'', 3, 2883, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2891, N'巴音郭楞蒙古自治州', N'巴音郭楞', N'', 2, 2872, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2892, N'博湖县', N'博湖', N'', 3, 2891, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2893, N'和静县', N'和静', N'', 3, 2891, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2894, N'和硕县', N'和硕', N'', 3, 2891, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2895, N'库尔勒市', N'库尔勒', N'', 3, 2891, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2896, N'轮台县', N'轮台', N'', 3, 2891, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2897, N'且末县', N'且末', N'', 3, 2891, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2898, N'若羌县', N'若羌', N'', 3, 2891, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2899, N'尉犁县', N'尉犁', N'', 3, 2891, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2900, N'焉耆回族自治县', N'焉耆', N'', 3, 2891, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2901, N'博尔塔拉蒙古自治州', N'博尔塔拉', N'', 2, 2872, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2902, N'阿拉山口市', N'阿拉山口', N'', 3, 2901, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2903, N'博乐市', N'博乐', N'', 3, 2901, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2904, N'精河县', N'精河', N'', 3, 2901, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2905, N'温泉县', N'温泉', N'', 3, 2901, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2906, N'昌吉回族自治州', N'昌吉', N'', 2, 2872, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2907, N'昌吉市', N'昌吉', N'', 3, 2906, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2908, N'阜康市', N'阜康', N'', 3, 2906, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2909, N'呼图壁县', N'呼图壁', N'', 3, 2906, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2910, N'吉木萨尔县', N'吉木萨尔', N'', 3, 2906, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2911, N'玛纳斯县', N'玛纳斯', N'', 3, 2906, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2912, N'木垒哈萨克自治县', N'木垒', N'', 3, 2906, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2913, N'奇台县', N'奇台', N'', 3, 2906, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2914, N'哈密地区', N'哈密', N'', 2, 2872, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2915, N'巴里坤哈萨克自治县', N'巴里坤', N'', 3, 2914, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2916, N'哈密市', N'哈密', N'', 3, 2914, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2917, N'伊吾县', N'伊吾', N'', 3, 2914, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2918, N'和田地区', N'和田', N'', 2, 2872, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2919, N'策勒县', N'策勒', N'', 3, 2918, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2920, N'和田市', N'和田', N'', 3, 2918, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2921, N'和田县', N'和田', N'', 3, 2918, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2922, N'洛浦县', N'洛浦', N'', 3, 2918, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2923, N'民丰县', N'民丰', N'', 3, 2918, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2924, N'墨玉县', N'墨玉', N'', 3, 2918, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2925, N'皮山县', N'皮山', N'', 3, 2918, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2926, N'于田县', N'于田', N'', 3, 2918, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2927, N'喀什地区', N'喀什', N'', 2, 2872, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2928, N'巴楚县', N'巴楚', N'', 3, 2927, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2929, N'伽师县', N'伽师', N'', 3, 2927, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2930, N'喀什市', N'喀什', N'', 3, 2927, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2931, N'麦盖提县', N'麦盖提', N'', 3, 2927, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2932, N'莎车县', N'莎车', N'', 3, 2927, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2933, N'疏附县', N'疏附', N'', 3, 2927, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2934, N'疏勒县', N'疏勒', N'', 3, 2927, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2935, N'塔什库尔干塔吉克自治县', N'塔什库尔干', N'', 3, 2927, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2936, N'叶城县', N'叶城', N'', 3, 2927, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2937, N'英吉沙县', N'英吉沙', N'', 3, 2927, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2938, N'岳普湖县', N'岳普湖', N'', 3, 2927, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2939, N'泽普县', N'泽普', N'', 3, 2927, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2940, N'克拉玛依市', N'克拉玛依', N'', 2, 2872, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2941, N'白碱滩区', N'白碱滩', N'', 3, 2940, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2942, N'独山子区', N'独山子', N'', 3, 2940, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2943, N'克拉玛依区', N'克拉玛依', N'', 3, 2940, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2944, N'乌尔禾区', N'乌尔禾', N'', 3, 2940, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2945, N'克孜勒苏柯尔克孜自治州', N'克孜勒苏', N'', 2, 2872, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2946, N'阿合奇县', N'阿合奇', N'', 3, 2945, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2947, N'阿克陶县', N'阿克陶', N'', 3, 2945, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2948, N'阿图什市', N'阿图什', N'', 3, 2945, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2949, N'乌恰县', N'乌恰', N'', 3, 2945, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2950, N'自治区直辖县级行政区划', N'区直辖', N'', 2, 2872, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2951, N'阿拉尔市', N'阿拉尔', N'', 3, 2950, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2952, N'北屯市', N'北屯', N'', 3, 2950, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2953, N'石河子市', N'石河子', N'', 3, 2950, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2954, N'铁门关市', N'铁门关', N'', 3, 2950, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2955, N'图木舒克市', N'图木舒克', N'', 3, 2950, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2956, N'五家渠市', N'五家渠', N'', 3, 2950, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2957, N'塔城地区', N'塔城', N'', 2, 2872, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2958, N'额敏县', N'额敏', N'', 3, 2957, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2959, N'和布克赛尔蒙古自治县', N'和布克赛尔', N'', 3, 2957, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2960, N'沙湾县', N'沙湾', N'', 3, 2957, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2961, N'塔城市', N'塔城', N'', 3, 2957, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2962, N'托里县', N'托里', N'', 3, 2957, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2963, N'乌苏市', N'乌苏', N'', 3, 2957, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2964, N'裕民县', N'裕民', N'', 3, 2957, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2965, N'吐鲁番地区', N'吐鲁番', N'', 2, 2872, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2966, N'鄯善县', N'鄯善', N'', 3, 2965, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2967, N'吐鲁番市', N'吐鲁番', N'', 3, 2965, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2968, N'托克逊县', N'托克逊', N'', 3, 2965, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2969, N'乌鲁木齐市', N'乌鲁木齐', N'', 2, 2872, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2970, N'达坂城区', N'达坂城', N'', 3, 2969, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2971, N'米东区', N'米东', N'', 3, 2969, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2972, N'沙依巴克区', N'沙依巴克', N'', 3, 2969, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2973, N'水磨沟区', N'水磨沟', N'', 3, 2969, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2974, N'天山区', N'天山', N'', 3, 2969, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2975, N'头屯河区', N'头屯河', N'', 3, 2969, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2976, N'乌鲁木齐县', N'乌鲁木齐', N'', 3, 2969, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2977, N'新市区', N'新市', N'', 3, 2969, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2978, N'伊犁哈萨克自治州', N'伊犁', N'', 2, 2872, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2979, N'察布查尔锡伯自治县', N'察布查尔', N'', 3, 2978, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2980, N'巩留县', N'巩留', N'', 3, 2978, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2981, N'霍城县', N'霍城', N'', 3, 2978, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2982, N'奎屯市', N'奎屯', N'', 3, 2978, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2983, N'尼勒克县', N'尼勒克', N'', 3, 2978, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2984, N'特克斯县', N'特克斯', N'', 3, 2978, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2985, N'新源县', N'新源', N'', 3, 2978, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2986, N'伊宁市', N'伊宁', N'', 3, 2978, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2987, N'伊宁县', N'伊宁', N'', 3, 2978, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2988, N'昭苏县', N'昭苏', N'', 3, 2978, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2989, N'云南省', N'云南', N'', 1, 0, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2990, N'保山市', N'保山', N'', 2, 2989, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2991, N'昌宁县', N'昌宁', N'', 3, 2990, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2992, N'龙陵县', N'龙陵', N'', 3, 2990, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2993, N'隆阳区', N'隆阳', N'', 3, 2990, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2994, N'施甸县', N'施甸', N'', 3, 2990, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2995, N'腾冲县', N'腾冲', N'', 3, 2990, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2996, N'楚雄彝族自治州', N'楚雄', N'', 2, 2989, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2997, N'楚雄市', N'楚雄', N'', 3, 2996, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2998, N'大姚县', N'大姚', N'', 3, 2996, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (2999, N'禄丰县', N'禄丰', N'', 3, 2996, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3000, N'牟定县', N'牟定', N'', 3, 2996, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3001, N'南华县', N'南华', N'', 3, 2996, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3002, N'双柏县', N'双柏', N'', 3, 2996, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3003, N'武定县', N'武定', N'', 3, 2996, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3004, N'姚安县', N'姚安', N'', 3, 2996, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3005, N'永仁县', N'永仁', N'', 3, 2996, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3006, N'元谋县', N'元谋', N'', 3, 2996, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3007, N'大理白族自治州', N'大理', N'', 2, 2989, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3008, N'宾川县', N'宾川', N'', 3, 3007, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3009, N'大理市', N'大理', N'', 3, 3007, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3010, N'洱源县', N'洱源', N'', 3, 3007, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3011, N'鹤庆县', N'鹤庆', N'', 3, 3007, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3012, N'剑川县', N'剑川', N'', 3, 3007, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3013, N'弥渡县', N'弥渡', N'', 3, 3007, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3014, N'南涧彝族自治县', N'南涧', N'', 3, 3007, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3015, N'巍山彝族回族自治县', N'巍山', N'', 3, 3007, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3016, N'祥云县', N'祥云', N'', 3, 3007, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3017, N'漾濞彝族自治县', N'漾濞', N'', 3, 3007, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3018, N'永平县', N'永平', N'', 3, 3007, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3019, N'云龙县', N'云龙', N'', 3, 3007, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3020, N'德宏傣族景颇族自治州', N'德宏', N'', 2, 2989, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3021, N'梁河县', N'梁河', N'', 3, 3020, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3022, N'陇川县', N'陇川', N'', 3, 3020, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3023, N'芒市', N'芒市', N'', 3, 3020, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3024, N'瑞丽市', N'瑞丽', N'', 3, 3020, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3025, N'盈江县', N'盈江', N'', 3, 3020, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3026, N'迪庆藏族自治州', N'迪庆', N'', 2, 2989, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3027, N'德钦县', N'德钦', N'', 3, 3026, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3028, N'维西傈僳族自治县', N'维西', N'', 3, 3026, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3029, N'香格里拉县', N'香格里拉', N'', 3, 3026, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3030, N'红河哈尼族彝族自治州', N'红河', N'', 2, 2989, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3031, N'个旧市', N'个旧', N'', 3, 3030, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3032, N'河口瑶族自治县', N'河口', N'', 3, 3030, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3033, N'红河县', N'红河', N'', 3, 3030, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3034, N'建水县', N'建水', N'', 3, 3030, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3035, N'金平苗族瑶族傣族自治县', N'金平', N'', 3, 3030, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3036, N'开远市', N'开远', N'', 3, 3030, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3037, N'泸西县', N'泸西', N'', 3, 3030, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3038, N'绿春县', N'绿春', N'', 3, 3030, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3039, N'蒙自市', N'蒙自', N'', 3, 3030, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3040, N'弥勒市', N'弥勒', N'', 3, 3030, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3041, N'屏边苗族自治县', N'屏边', N'', 3, 3030, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3042, N'石屏县', N'石屏', N'', 3, 3030, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3043, N'元阳县', N'元阳', N'', 3, 3030, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3044, N'昆明市', N'昆明', N'', 2, 2989, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3045, N'安宁市', N'安宁', N'', 3, 3044, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3046, N'呈贡区', N'呈贡', N'', 3, 3044, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3047, N'东川区', N'东川', N'', 3, 3044, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3048, N'富民县', N'富民', N'', 3, 3044, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3049, N'官渡区', N'官渡', N'', 3, 3044, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3050, N'晋宁县', N'晋宁', N'', 3, 3044, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3051, N'禄劝彝族苗族自治县', N'禄劝', N'', 3, 3044, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3052, N'盘龙区', N'盘龙', N'', 3, 3044, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3053, N'石林彝族自治县', N'石林', N'', 3, 3044, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3054, N'嵩明县', N'嵩明', N'', 3, 3044, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3055, N'五华区', N'五华', N'', 3, 3044, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3056, N'西山区', N'西山', N'', 3, 3044, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3057, N'寻甸回族彝族自治县', N'寻甸', N'', 3, 3044, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3058, N'宜良县', N'宜良', N'', 3, 3044, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3059, N'丽江市', N'丽江', N'', 2, 2989, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3060, N'古城区', N'古城', N'', 3, 3059, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3061, N'华坪县', N'华坪', N'', 3, 3059, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3062, N'宁蒗彝族自治县', N'宁蒗', N'', 3, 3059, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3063, N'永胜县', N'永胜', N'', 3, 3059, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3064, N'玉龙纳西族自治县', N'玉龙', N'', 3, 3059, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3065, N'临沧市', N'临沧', N'', 2, 2989, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3066, N'沧源佤族自治县', N'沧源', N'', 3, 3065, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3067, N'凤庆县', N'凤庆', N'', 3, 3065, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3068, N'耿马傣族佤族自治县', N'耿马', N'', 3, 3065, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3069, N'临翔区', N'临翔', N'', 3, 3065, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3070, N'双江拉祜族佤族布朗族傣族自治县', N'双江', N'', 3, 3065, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3071, N'永德县', N'永德', N'', 3, 3065, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3072, N'云县', N'云县', N'', 3, 3065, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3073, N'镇康县', N'镇康', N'', 3, 3065, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3074, N'怒江傈僳族自治州', N'怒江', N'', 2, 2989, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3075, N'福贡县', N'福贡', N'', 3, 3074, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3076, N'贡山独龙族怒族自治县', N'贡山', N'', 3, 3074, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3077, N'兰坪白族普米族自治县', N'兰坪', N'', 3, 3074, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3078, N'泸水县', N'泸水', N'', 3, 3074, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3079, N'普洱市', N'普洱', N'', 2, 2989, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3080, N'江城哈尼族彝族自治县', N'江城', N'', 3, 3079, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3081, N'景东彝族自治县', N'景东', N'', 3, 3079, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3082, N'景谷傣族彝族自治县', N'景谷', N'', 3, 3079, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3083, N'澜沧拉祜族自治县', N'澜沧', N'', 3, 3079, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3084, N'孟连傣族拉祜族佤族自治县', N'孟连', N'', 3, 3079, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3085, N'墨江哈尼族自治县', N'墨江', N'', 3, 3079, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3086, N'宁洱哈尼族彝族自治县', N'宁洱', N'', 3, 3079, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3087, N'思茅区', N'思茅', N'', 3, 3079, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3088, N'西盟佤族自治县', N'西盟', N'', 3, 3079, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3089, N'镇沅彝族哈尼族拉祜族自治县', N'镇沅', N'', 3, 3079, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3090, N'曲靖市', N'曲靖', N'', 2, 2989, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3091, N'富源县', N'富源', N'', 3, 3090, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3092, N'会泽县', N'会泽', N'', 3, 3090, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3093, N'陆良县', N'陆良', N'', 3, 3090, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3094, N'罗平县', N'罗平', N'', 3, 3090, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3095, N'马龙县', N'马龙', N'', 3, 3090, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3096, N'麒麟区', N'麒麟', N'', 3, 3090, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3097, N'师宗县', N'师宗', N'', 3, 3090, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3098, N'宣威市', N'宣威', N'', 3, 3090, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3099, N'沾益县', N'沾益', N'', 3, 3090, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3100, N'文山壮族苗族自治州', N'文山', N'', 2, 2989, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3101, N'富宁县', N'富宁', N'', 3, 3100, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3102, N'广南县', N'广南', N'', 3, 3100, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3103, N'麻栗坡县', N'麻栗坡', N'', 3, 3100, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3104, N'马关县', N'马关', N'', 3, 3100, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3105, N'丘北县', N'丘北', N'', 3, 3100, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3106, N'文山市', N'文山', N'', 3, 3100, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3107, N'西畴县', N'西畴', N'', 3, 3100, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3108, N'砚山县', N'砚山', N'', 3, 3100, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3109, N'西双版纳傣族自治州', N'西双版纳', N'', 2, 2989, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3110, N'景洪市', N'景洪', N'', 3, 3109, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3111, N'勐海县', N'勐海', N'', 3, 3109, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3112, N'勐腊县', N'勐腊', N'', 3, 3109, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3113, N'玉溪市', N'玉溪', N'', 2, 2989, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3114, N'澄江县', N'澄江', N'', 3, 3113, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3115, N'峨山彝族自治县', N'峨山', N'', 3, 3113, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3116, N'红塔区', N'红塔', N'', 3, 3113, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3117, N'华宁县', N'华宁', N'', 3, 3113, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3118, N'江川县', N'江川', N'', 3, 3113, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3119, N'通海县', N'通海', N'', 3, 3113, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3120, N'新平彝族傣族自治县', N'新平', N'', 3, 3113, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3121, N'易门县', N'易门', N'', 3, 3113, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3122, N'元江哈尼族彝族傣族自治县', N'元江', N'', 3, 3113, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3123, N'昭通市', N'昭通', N'', 2, 2989, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3124, N'大关县', N'大关', N'', 3, 3123, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3125, N'鲁甸县', N'鲁甸', N'', 3, 3123, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3126, N'巧家县', N'巧家', N'', 3, 3123, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3127, N'水富县', N'水富', N'', 3, 3123, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3128, N'绥江县', N'绥江', N'', 3, 3123, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3129, N'威信县', N'威信', N'', 3, 3123, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3130, N'盐津县', N'盐津', N'', 3, 3123, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3131, N'彝良县', N'彝良', N'', 3, 3123, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3132, N'永善县', N'永善', N'', 3, 3123, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3133, N'昭阳区', N'昭阳', N'', 3, 3123, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3134, N'镇雄县', N'镇雄', N'', 3, 3123, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3135, N'浙江省', N'浙江', N'', 1, 0, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3136, N'杭州市', N'杭州', N'', 2, 3135, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3137, N'滨江区', N'滨江', N'', 3, 3136, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3138, N'淳安县', N'淳安', N'', 3, 3136, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3139, N'富阳市', N'富阳', N'', 3, 3136, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3140, N'拱墅区', N'拱墅', N'', 3, 3136, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3141, N'建德市', N'建德', N'', 3, 3136, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3142, N'江干区', N'江干', N'', 3, 3136, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3143, N'临安市', N'临安', N'', 3, 3136, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3144, N'上城区', N'上城', N'', 3, 3136, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3145, N'桐庐县', N'桐庐', N'', 3, 3136, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3146, N'西湖区', N'西湖', N'', 3, 3136, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3147, N'下城区', N'下城', N'', 3, 3136, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3148, N'萧山区', N'萧山', N'', 3, 3136, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3149, N'余杭区', N'余杭', N'', 3, 3136, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3150, N'湖州市', N'湖州', N'', 2, 3135, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3151, N'安吉县', N'安吉', N'', 3, 3150, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3152, N'德清县', N'德清', N'', 3, 3150, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3153, N'南浔区', N'南浔', N'', 3, 3150, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3154, N'吴兴区', N'吴兴', N'', 3, 3150, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3155, N'长兴县', N'长兴', N'', 3, 3150, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3156, N'嘉兴市', N'嘉兴', N'', 2, 3135, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3157, N'海宁市', N'海宁', N'', 3, 3156, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3158, N'海盐县', N'海盐', N'', 3, 3156, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3159, N'嘉善县', N'嘉善', N'', 3, 3156, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3160, N'南湖区', N'南湖', N'', 3, 3156, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3161, N'平湖市', N'平湖', N'', 3, 3156, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3162, N'桐乡市', N'桐乡', N'', 3, 3156, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3163, N'秀洲区', N'秀洲', N'', 3, 3156, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3164, N'嘉兴市', N'嘉兴', N'', 2, 3135, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3165, N'海宁市', N'海宁', N'', 3, 3164, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3166, N'海盐县', N'海盐', N'', 3, 3164, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3167, N'嘉善县', N'嘉善', N'', 3, 3164, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3168, N'南湖区', N'南湖', N'', 3, 3164, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3169, N'平湖市', N'平湖', N'', 3, 3164, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3170, N'桐乡市', N'桐乡', N'', 3, 3164, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3171, N'秀洲区', N'秀洲', N'', 3, 3164, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3172, N'金华市', N'金华', N'', 2, 3135, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3173, N'东阳市', N'东阳', N'', 3, 3172, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3174, N'金东区', N'金东', N'', 3, 3172, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3175, N'兰溪市', N'兰溪', N'', 3, 3172, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3176, N'磐安县', N'磐安', N'', 3, 3172, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3177, N'浦江县', N'浦江', N'', 3, 3172, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3178, N'武义县', N'武义', N'', 3, 3172, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3179, N'婺城区', N'婺城', N'', 3, 3172, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3180, N'义乌市', N'义乌', N'', 3, 3172, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3181, N'永康市', N'永康', N'', 3, 3172, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3182, N'丽水市', N'丽水', N'', 2, 3135, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3183, N'缙云县', N'缙云', N'', 3, 3182, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3184, N'景宁畲族自治县', N'景宁', N'', 3, 3182, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3185, N'莲都区', N'莲都', N'', 3, 3182, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3186, N'龙泉市', N'龙泉', N'', 3, 3182, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3187, N'青田县', N'青田', N'', 3, 3182, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3188, N'庆元县', N'庆元', N'', 3, 3182, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3189, N'松阳县', N'松阳', N'', 3, 3182, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3190, N'遂昌县', N'遂昌', N'', 3, 3182, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3191, N'云和县', N'云和', N'', 3, 3182, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3192, N'宁波市', N'宁波', N'', 2, 3135, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3193, N'北仑区', N'北仑', N'', 3, 3192, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3194, N'慈溪市', N'慈溪', N'', 3, 3192, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3195, N'奉化市', N'奉化', N'', 3, 3192, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3196, N'海曙区', N'海曙', N'', 3, 3192, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3197, N'江北区', N'江北', N'', 3, 3192, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3198, N'江东区', N'江东', N'', 3, 3192, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3199, N'宁海县', N'宁海', N'', 3, 3192, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3200, N'象山县', N'象山', N'', 3, 3192, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3201, N'鄞州区', N'鄞州', N'', 3, 3192, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3202, N'余姚市', N'余姚', N'', 3, 3192, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3203, N'镇海区', N'镇海', N'', 3, 3192, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3204, N'衢州市', N'衢州', N'', 2, 3135, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3205, N'常山县', N'常山', N'', 3, 3204, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3206, N'江山市', N'江山', N'', 3, 3204, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3207, N'开化县', N'开化', N'', 3, 3204, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3208, N'柯城区', N'柯城', N'', 3, 3204, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3209, N'龙游县', N'龙游', N'', 3, 3204, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3210, N'衢江区', N'衢江', N'', 3, 3204, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3211, N'绍兴市', N'绍兴', N'', 2, 3135, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3212, N'柯桥区', N'柯桥', N'', 3, 3211, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3213, N'上虞区', N'上虞', N'', 3, 3211, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3214, N'嵊州市', N'嵊州', N'', 3, 3211, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3215, N'新昌县', N'新昌', N'', 3, 3211, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3216, N'越城区', N'越城', N'', 3, 3211, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3217, N'诸暨市', N'诸暨', N'', 3, 3211, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3218, N'台州市', N'台州', N'', 2, 3135, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3219, N'黄岩区', N'黄岩', N'', 3, 3218, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3220, N'椒江区', N'椒江', N'', 3, 3218, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3221, N'临海市', N'临海', N'', 3, 3218, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3222, N'路桥区', N'路桥', N'', 3, 3218, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3223, N'三门县', N'三门', N'', 3, 3218, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3224, N'天台县', N'天台', N'', 3, 3218, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3225, N'温岭市', N'温岭', N'', 3, 3218, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3226, N'仙居县', N'仙居', N'', 3, 3218, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3227, N'玉环县', N'玉环', N'', 3, 3218, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3228, N'温州市', N'温州', N'', 2, 3135, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3229, N'苍南县', N'苍南', N'', 3, 3228, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3230, N'洞头县', N'洞头', N'', 3, 3228, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3231, N'乐清市', N'乐清', N'', 3, 3228, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3232, N'龙湾区', N'龙湾', N'', 3, 3228, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3233, N'鹿城区', N'鹿城', N'', 3, 3228, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3234, N'瓯海区', N'瓯海', N'', 3, 3228, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3235, N'平阳县', N'平阳', N'', 3, 3228, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3236, N'瑞安市', N'瑞安', N'', 3, 3228, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3237, N'泰顺县', N'泰顺', N'', 3, 3228, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3238, N'文成县', N'文成', N'', 3, 3228, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3239, N'永嘉县', N'永嘉', N'', 3, 3228, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3240, N'舟山市', N'舟山', N'', 2, 3135, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3241, N'岱山县', N'岱山', N'', 3, 3240, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3242, N'定海区', N'定海', N'', 3, 3240, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3243, N'普陀区', N'普陀', N'', 3, 3240, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3244, N'嵊泗县', N'嵊泗', N'', 3, 3240, 1)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3245, N'香港特别行政区', N'香港', N'', 1, 0, 0)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3246, N'澳门特别行政区', N'澳门', N'', 1, 0, 0)
GO
INSERT [dbo].[TB_Territorial] ([ID], [Name], [SpellName], [EnglisName], [Kind], [ParentID], [IsPass]) VALUES (3247, N'台湾省', N'台湾', N'', 1, 0, 0)
GO
SET IDENTITY_INSERT [dbo].[TB_Territorial] OFF
GO
INSERT [dbo].[TB_TPermission] ([FormID], [RoleID], [Permission]) VALUES (1006, 1, 31)
GO
INSERT [dbo].[TB_TPermission] ([FormID], [RoleID], [Permission]) VALUES (1001, 1, 31)
GO
INSERT [dbo].[TB_TPermission] ([FormID], [RoleID], [Permission]) VALUES (1003, 1, 13)
GO
INSERT [dbo].[TB_TPermission] ([FormID], [RoleID], [Permission]) VALUES (1005, 1, 31)
GO
INSERT [dbo].[TB_TPermission] ([FormID], [RoleID], [Permission]) VALUES (1002, 1, 31)
GO
INSERT [dbo].[TB_TPermission] ([FormID], [RoleID], [Permission]) VALUES (1004, 1, 31)
GO
SET IDENTITY_INSERT [dbo].[TB_Urls] ON 

GO
INSERT [dbo].[TB_Urls] ([ID], [HtmlUrl], [Url], [AddTime]) VALUES (3, N'/news/commpany.shtml', N'/news/default.aspx?ID=1', CAST(0x0000A4E600C20BED AS DateTime))
GO
INSERT [dbo].[TB_Urls] ([ID], [HtmlUrl], [Url], [AddTime]) VALUES (5, N'/news/hehe.html', N'/news/detail.aspx?ID=2', CAST(0x0000A4E600EBA653 AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[TB_Urls] OFF
GO
ALTER TABLE [dbo].[TB_Admin] ADD  DEFAULT ((0)) FOR [RoleID]
GO
ALTER TABLE [dbo].[TB_Admin] ADD  DEFAULT (getdate()) FOR [Lastlogintime]
GO
ALTER TABLE [dbo].[TB_Admin] ADD  DEFAULT ((0)) FOR [Logincount]
GO
ALTER TABLE [dbo].[TB_Admin] ADD  DEFAULT ((0)) FOR [IsPass]
GO
ALTER TABLE [dbo].[TB_Admin] ADD  DEFAULT (getdate()) FOR [AddTime]
GO
ALTER TABLE [dbo].[TB_AdminLog] ADD  DEFAULT ((0)) FOR [OperationTypes]
GO
ALTER TABLE [dbo].[TB_AdminLog] ADD  DEFAULT (getdate()) FOR [AddTime]
GO
ALTER TABLE [dbo].[TB_AppointmentComment] ADD  CONSTRAINT [DF__TB_Appoin__AddTi__70FDBF69]  DEFAULT (getdate()) FOR [AddTime]
GO
ALTER TABLE [dbo].[TB_AppointmentComment] ADD  CONSTRAINT [DF__TB_Appoin__IsRea__71F1E3A2]  DEFAULT ((0)) FOR [IsReached]
GO
ALTER TABLE [dbo].[TB_Country] ADD  CONSTRAINT [DF_TB_Country_Uid]  DEFAULT ((0)) FOR [Uid]
GO
ALTER TABLE [dbo].[TB_GuideGuest] ADD  CONSTRAINT [DF__TB_GuideG__AddTi__2E06CDA9]  DEFAULT (getdate()) FOR [AddTime]
GO
ALTER TABLE [dbo].[TB_News] ADD  CONSTRAINT [DF__TB_News__Relevan__33BFA6FF]  DEFAULT ((0)) FOR [RelevantSchool]
GO
ALTER TABLE [dbo].[TB_News] ADD  CONSTRAINT [DF__TB_News__Click__34B3CB38]  DEFAULT ((0)) FOR [Click]
GO
ALTER TABLE [dbo].[TB_News] ADD  CONSTRAINT [DF__TB_News__AddTime__35A7EF71]  DEFAULT (getdate()) FOR [AddTime]
GO
ALTER TABLE [dbo].[TB_NewsIntor] ADD  CONSTRAINT [DF__TB_NewsInt__Sort__3D491139]  DEFAULT ((0)) FOR [Sort]
GO
ALTER TABLE [dbo].[TB_NewsType] ADD  CONSTRAINT [DF__TB_NewsTy__AddTi__74CE504D]  DEFAULT (getdate()) FOR [AddTime]
GO
ALTER TABLE [dbo].[TB_Schools] ADD  CONSTRAINT [DF__TB_School__Click__5614BF03]  DEFAULT ((0)) FOR [Click]
GO
ALTER TABLE [dbo].[TB_Schools] ADD  CONSTRAINT [DF__TB_School__AddTi__5708E33C]  DEFAULT (getdate()) FOR [AddTime]
GO
ALTER TABLE [dbo].[TB_Stores] ADD  CONSTRAINT [DF__TB_Stores__AddTi__7E8CC4B1]  DEFAULT (getdate()) FOR [AddTime]
GO
ALTER TABLE [dbo].[TB_Territorial] ADD  CONSTRAINT [DF_TB_Territorial_EnglisName]  DEFAULT ('') FOR [EnglisName]
GO
ALTER TABLE [dbo].[TB_Territorial] ADD  CONSTRAINT [DF_TB_Territorial_IsPass]  DEFAULT ((1)) FOR [IsPass]
GO
ALTER TABLE [dbo].[TB_TPermission] ADD  DEFAULT ((0)) FOR [RoleID]
GO
ALTER TABLE [dbo].[TB_TPermission] ADD  DEFAULT ((0)) FOR [Permission]
GO
ALTER TABLE [dbo].[TB_Urls] ADD  DEFAULT (getdate()) FOR [AddTime]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'主键' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Admin', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'角色ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Admin', @level2type=N'COLUMN',@level2name=N'RoleID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Admin', @level2type=N'COLUMN',@level2name=N'Username'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'密码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Admin', @level2type=N'COLUMN',@level2name=N'Password'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'最后一次登录IP' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Admin', @level2type=N'COLUMN',@level2name=N'Lastloginip'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'最后一次登录时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Admin', @level2type=N'COLUMN',@level2name=N'Lastlogintime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'登录次数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Admin', @level2type=N'COLUMN',@level2name=N'Logincount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'管理员名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Admin', @level2type=N'COLUMN',@level2name=N'Realname'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'邮箱' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Admin', @level2type=N'COLUMN',@level2name=N'Email'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'审核' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Admin', @level2type=N'COLUMN',@level2name=N'IsPass'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'添加时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Admin', @level2type=N'COLUMN',@level2name=N'AddTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'管理员' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Admin'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'主键' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_AdminLog', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'操作类型 0:登录 1:添加 2:修改 3:删除' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_AdminLog', @level2type=N'COLUMN',@level2name=N'OperationTypes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'操作描述' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_AdminLog', @level2type=N'COLUMN',@level2name=N'ODescription'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'管理员账号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_AdminLog', @level2type=N'COLUMN',@level2name=N'UserName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'IP地址' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_AdminLog', @level2type=N'COLUMN',@level2name=N'IP'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'添加时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_AdminLog', @level2type=N'COLUMN',@level2name=N'AddTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_AppointmentComment', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'姓名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_AppointmentComment', @level2type=N'COLUMN',@level2name=N'Name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'手机号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_AppointmentComment', @level2type=N'COLUMN',@level2name=N'Mobile'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'所在城市' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_AppointmentComment', @level2type=N'COLUMN',@level2name=N'City'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'学生年龄' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_AppointmentComment', @level2type=N'COLUMN',@level2name=N'Age'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'所在年级' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_AppointmentComment', @level2type=N'COLUMN',@level2name=N'Grade'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'意向出国时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_AppointmentComment', @level2type=N'COLUMN',@level2name=N'AbroadTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'面试志愿学校一' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_AppointmentComment', @level2type=N'COLUMN',@level2name=N'DesireSchool1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'面试志愿学校二' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_AppointmentComment', @level2type=N'COLUMN',@level2name=N'DesireSchool2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'面试地点' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_AppointmentComment', @level2type=N'COLUMN',@level2name=N'InterviewPlace'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'来宾人数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_AppointmentComment', @level2type=N'COLUMN',@level2name=N'GuestNum'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'留言' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_AppointmentComment', @level2type=N'COLUMN',@level2name=N'Comment'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'提交时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_AppointmentComment', @level2type=N'COLUMN',@level2name=N'AddTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'已回访' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_AppointmentComment', @level2type=N'COLUMN',@level2name=N'IsReached'
GO
EXEC sys.sp_addextendedproperty @name=N'TB_AppointmentComment', @value=N'招生会报名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_AppointmentComment'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Country', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'国家' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Country', @level2type=N'COLUMN',@level2name=N'CNName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'英文名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Country', @level2type=N'COLUMN',@level2name=N'ENName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'父级' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Country', @level2type=N'COLUMN',@level2name=N'Uid'
GO
EXEC sys.sp_addextendedproperty @name=N'TB_Country', @value=N'国家' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Country'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_GuideGuest', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'姓名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_GuideGuest', @level2type=N'COLUMN',@level2name=N'Name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'照片' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_GuideGuest', @level2type=N'COLUMN',@level2name=N'Image'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'职称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_GuideGuest', @level2type=N'COLUMN',@level2name=N'Position'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'嘉宾介绍' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_GuideGuest', @level2type=N'COLUMN',@level2name=N'Introduction'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'讲座亮点' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_GuideGuest', @level2type=N'COLUMN',@level2name=N'Highlights'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'排序' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_GuideGuest', @level2type=N'COLUMN',@level2name=N'Sort'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'显示' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_GuideGuest', @level2type=N'COLUMN',@level2name=N'IsPass'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'添加时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_GuideGuest', @level2type=N'COLUMN',@level2name=N'AddTime'
GO
EXEC sys.sp_addextendedproperty @name=N'TB_GuideGuest', @value=N'重磅嘉宾' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_GuideGuest'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_News', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'伪静态名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_News', @level2type=N'COLUMN',@level2name=N'HtmlName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页面标题' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_News', @level2type=N'COLUMN',@level2name=N'PageTitle'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页面关键词' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_News', @level2type=N'COLUMN',@level2name=N'PageKey'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页面描述' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_News', @level2type=N'COLUMN',@level2name=N'PageDes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'新闻标题' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_News', @level2type=N'COLUMN',@level2name=N'Title'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'新闻图片' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_News', @level2type=N'COLUMN',@level2name=N'Image'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'所属类型' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_News', @level2type=N'COLUMN',@level2name=N'Kind'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'相关学校' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_News', @level2type=N'COLUMN',@level2name=N'RelevantSchool'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'新闻导语' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_News', @level2type=N'COLUMN',@level2name=N'Lead'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'来源名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_News', @level2type=N'COLUMN',@level2name=N'SourceName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'来源职位' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_News', @level2type=N'COLUMN',@level2name=N'SourePosition'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'来源照片' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_News', @level2type=N'COLUMN',@level2name=N'SourePhone'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'来源简介' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_News', @level2type=N'COLUMN',@level2name=N'SoureIntor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'来源连接' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_News', @level2type=N'COLUMN',@level2name=N'SoureLink'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'显示' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_News', @level2type=N'COLUMN',@level2name=N'IsPass'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'排序' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_News', @level2type=N'COLUMN',@level2name=N'Sort'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'预览数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_News', @level2type=N'COLUMN',@level2name=N'Click'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'添加时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_News', @level2type=N'COLUMN',@level2name=N'AddTime'
GO
EXEC sys.sp_addextendedproperty @name=N'TB_News', @value=N'新闻' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_News'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_NewsIntor', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'新闻编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_NewsIntor', @level2type=N'COLUMN',@level2name=N'NewsId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'正文标题' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_NewsIntor', @level2type=N'COLUMN',@level2name=N'Title'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'正文图片' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_NewsIntor', @level2type=N'COLUMN',@level2name=N'Image'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'图片说明' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_NewsIntor', @level2type=N'COLUMN',@level2name=N'ImageAlt'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'正文内容' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_NewsIntor', @level2type=N'COLUMN',@level2name=N'Intor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'连接地址' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_NewsIntor', @level2type=N'COLUMN',@level2name=N'Link'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'备注' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_NewsIntor', @level2type=N'COLUMN',@level2name=N'Remarks'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'排序' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_NewsIntor', @level2type=N'COLUMN',@level2name=N'Sort'
GO
EXEC sys.sp_addextendedproperty @name=N'TB_NewsIntor', @value=N'新闻正文' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_NewsIntor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_NewsType', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'伪静态名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_NewsType', @level2type=N'COLUMN',@level2name=N'HtmlName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页面标题' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_NewsType', @level2type=N'COLUMN',@level2name=N'PageTitle'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页面关键词' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_NewsType', @level2type=N'COLUMN',@level2name=N'PageKey'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页面描述' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_NewsType', @level2type=N'COLUMN',@level2name=N'PageDes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分类名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_NewsType', @level2type=N'COLUMN',@level2name=N'Name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'排序' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_NewsType', @level2type=N'COLUMN',@level2name=N'Sort'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'审核' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_NewsType', @level2type=N'COLUMN',@level2name=N'IsPass'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'添加时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_NewsType', @level2type=N'COLUMN',@level2name=N'AddTime'
GO
EXEC sys.sp_addextendedproperty @name=N'TB_NewsType', @value=N'新闻分类' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_NewsType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Schools', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'伪静态名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Schools', @level2type=N'COLUMN',@level2name=N'HtmlName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页面标题' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Schools', @level2type=N'COLUMN',@level2name=N'PageTitle'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页面关键词' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Schools', @level2type=N'COLUMN',@level2name=N'PageKey'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页面描述' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Schools', @level2type=N'COLUMN',@level2name=N'PageDes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'院校中文名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Schools', @level2type=N'COLUMN',@level2name=N'CNName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'院校英文名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Schools', @level2type=N'COLUMN',@level2name=N'ENName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'院校LOGO' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Schools', @level2type=N'COLUMN',@level2name=N'LOGO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'院校默认图' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Schools', @level2type=N'COLUMN',@level2name=N'Image'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'成立年份' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Schools', @level2type=N'COLUMN',@level2name=N'FoundingTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'所在国家' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Schools', @level2type=N'COLUMN',@level2name=N'Country'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'学校类型' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Schools', @level2type=N'COLUMN',@level2name=N'SchoolType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'学校规模(英亩）' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Schools', @level2type=N'COLUMN',@level2name=N'AreaSize'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'入学起始年龄' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Schools', @level2type=N'COLUMN',@level2name=N'AgeStart'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'入学截至年龄' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Schools', @level2type=N'COLUMN',@level2name=N'AgeEnd'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'学校网址' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Schools', @level2type=N'COLUMN',@level2name=N'Website'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'关注人数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Schools', @level2type=N'COLUMN',@level2name=N'Followers'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'学校官员中文译名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Schools', @level2type=N'COLUMN',@level2name=N'OfficerCNName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'学校官员英文名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Schools', @level2type=N'COLUMN',@level2name=N'OfficerENName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'学校官员职衔' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Schools', @level2type=N'COLUMN',@level2name=N'OfficerTitle'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'学校官员照片' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Schools', @level2type=N'COLUMN',@level2name=N'OfficerPhone'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'学校官员简介' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Schools', @level2type=N'COLUMN',@level2name=N'OfficerProfile'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'推荐理由' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Schools', @level2type=N'COLUMN',@level2name=N'RecommendedReason'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'申请准备及建议' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Schools', @level2type=N'COLUMN',@level2name=N'ApplicationAdvice'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'学校简介' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Schools', @level2type=N'COLUMN',@level2name=N'SchoolIntroduction'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'交通距离' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Schools', @level2type=N'COLUMN',@level2name=N'SchoolTravel'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'地理环境' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Schools', @level2type=N'COLUMN',@level2name=N'SchoolEnvironment'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'南坐标' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Schools', @level2type=N'COLUMN',@level2name=N'SouthLatitude'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'北坐标' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Schools', @level2type=N'COLUMN',@level2name=N'NorthLatitude'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'横坐标' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Schools', @level2type=N'COLUMN',@level2name=N'Location_X'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'纵坐标' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Schools', @level2type=N'COLUMN',@level2name=N'Location_Y'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'邮政编码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Schools', @level2type=N'COLUMN',@level2name=N'ZipCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'学生人数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Schools', @level2type=N'COLUMN',@level2name=N'StudentNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'师生配比' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Schools', @level2type=N'COLUMN',@level2name=N'PeopleRatio'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'寄宿学生人数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Schools', @level2type=N'COLUMN',@level2name=N'BoardingStudent'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'寄宿生比例' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Schools', @level2type=N'COLUMN',@level2name=N'BoardingProportion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'国际学生人数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Schools', @level2type=N'COLUMN',@level2name=N'InternationalStudent'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'国际学生比例' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Schools', @level2type=N'COLUMN',@level2name=N'InternationalProportion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'中国学生人数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Schools', @level2type=N'COLUMN',@level2name=N'ChineseStudent'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'学院设置' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Schools', @level2type=N'COLUMN',@level2name=N'SchoolSettings'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'课堂规模' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Schools', @level2type=N'COLUMN',@level2name=N'ClassSize'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'入学平均成绩' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Schools', @level2type=N'COLUMN',@level2name=N'MeanScore'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'录取率' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Schools', @level2type=N'COLUMN',@level2name=N'AdmissionRate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'每年学费及寄宿费' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Schools', @level2type=N'COLUMN',@level2name=N'AnnualCost'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'学校特色' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Schools', @level2type=N'COLUMN',@level2name=N'Highlights'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'教学理念' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Schools', @level2type=N'COLUMN',@level2name=N'SchoolMotto'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'入学标准' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Schools', @level2type=N'COLUMN',@level2name=N'EntranceRequirements'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'师资力量' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Schools', @level2type=N'COLUMN',@level2name=N'TeacherStrength'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'学生关怀' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Schools', @level2type=N'COLUMN',@level2name=N'StudentCaring'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'学院设置' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Schools', @level2type=N'COLUMN',@level2name=N'AcademicUnits'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'专业课程' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Schools', @level2type=N'COLUMN',@level2name=N'AcademicCourses'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'特色课程' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Schools', @level2type=N'COLUMN',@level2name=N'SpecialCourses'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'体育课程' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Schools', @level2type=N'COLUMN',@level2name=N'SchoolSports'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'科技课程' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Schools', @level2type=N'COLUMN',@level2name=N'SchoolIT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'艺术课程' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Schools', @level2type=N'COLUMN',@level2name=N'SchoolArts'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'课外活动' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Schools', @level2type=N'COLUMN',@level2name=N'Extracurriculum'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'外语辅导课程' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Schools', @level2type=N'COLUMN',@level2name=N'LanguageCourses'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'毕业生学术成就' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Schools', @level2type=N'COLUMN',@level2name=N'GraduateAchievement'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'升学院校' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Schools', @level2type=N'COLUMN',@level2name=N'GraduateDestination'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'教学设施' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Schools', @level2type=N'COLUMN',@level2name=N'AcademicFacility'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'运动设施' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Schools', @level2type=N'COLUMN',@level2name=N'SportsFacility'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'科技设施' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Schools', @level2type=N'COLUMN',@level2name=N'ITFacility'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'艺术设施' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Schools', @level2type=N'COLUMN',@level2name=N'ArtFacility'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'宿舍' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Schools', @level2type=N'COLUMN',@level2name=N'Accommodation'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'餐厅' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Schools', @level2type=N'COLUMN',@level2name=N'Catering'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'图书馆' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Schools', @level2type=N'COLUMN',@level2name=N'Library'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'代表校友中文姓名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Schools', @level2type=N'COLUMN',@level2name=N'RepresentativeCNName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'代表校友英文姓名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Schools', @level2type=N'COLUMN',@level2name=N'RepresentativeENName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'代表校友照片' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Schools', @level2type=N'COLUMN',@level2name=N'RepresentativePhone'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'代表校友成就' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Schools', @level2type=N'COLUMN',@level2name=N'RepresentativeAchievement'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'其他知名校友' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Schools', @level2type=N'COLUMN',@level2name=N'RepresentativeOther'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'排序' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Schools', @level2type=N'COLUMN',@level2name=N'Sort'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'显示' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Schools', @level2type=N'COLUMN',@level2name=N'IsPass'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'预览数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Schools', @level2type=N'COLUMN',@level2name=N'Click'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'添加时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Schools', @level2type=N'COLUMN',@level2name=N'AddTime'
GO
EXEC sys.sp_addextendedproperty @name=N'TB_Schools', @value=N'院校' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Schools'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_SchoolsConsultant', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'学校编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_SchoolsConsultant', @level2type=N'COLUMN',@level2name=N'SchoolId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'中文名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_SchoolsConsultant', @level2type=N'COLUMN',@level2name=N'CNName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'英文名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_SchoolsConsultant', @level2type=N'COLUMN',@level2name=N'ENName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'照片' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_SchoolsConsultant', @level2type=N'COLUMN',@level2name=N'Phone'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'职衔' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_SchoolsConsultant', @level2type=N'COLUMN',@level2name=N'Title'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'点评内容' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_SchoolsConsultant', @level2type=N'COLUMN',@level2name=N'Comment'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'排序' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_SchoolsConsultant', @level2type=N'COLUMN',@level2name=N'Sort'
GO
EXEC sys.sp_addextendedproperty @name=N'TB_SchoolsConsultant', @value=N'顾问点评' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_SchoolsConsultant'
GO
EXEC sys.sp_addextendedproperty @name=N'TB_SchoolsImage', @value=N'院校照片' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_SchoolsImage'
GO
EXEC sys.sp_addextendedproperty @name=N'TB_SchoolsVoide', @value=N'院校视频' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_SchoolsVoide'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'序列号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Stores', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'门店名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Stores', @level2type=N'COLUMN',@level2name=N'Name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'添加时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Stores', @level2type=N'COLUMN',@level2name=N'AddTime'
GO
EXEC sys.sp_addextendedproperty @name=N'TB_Stores', @value=N'门店' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Stores'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'序列号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Territorial', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'地区名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Territorial', @level2type=N'COLUMN',@level2name=N'Name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'首拼名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Territorial', @level2type=N'COLUMN',@level2name=N'SpellName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'英文名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Territorial', @level2type=N'COLUMN',@level2name=N'EnglisName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'级别' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Territorial', @level2type=N'COLUMN',@level2name=N'Kind'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'所属父级' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Territorial', @level2type=N'COLUMN',@level2name=N'ParentID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'审核' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Territorial', @level2type=N'COLUMN',@level2name=N'IsPass'
GO
EXEC sys.sp_addextendedproperty @name=N'TB_Territorial', @value=N'地区' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Territorial'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'主键(模块编号)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_TPermission', @level2type=N'COLUMN',@level2name=N'FormID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'角色ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_TPermission', @level2type=N'COLUMN',@level2name=N'RoleID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'权限掩码和' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_TPermission', @level2type=N'COLUMN',@level2name=N'Permission'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'权限与模块' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_TPermission'
GO
USE [master]
GO
ALTER DATABASE [201507_BiYi] SET  READ_WRITE 
GO
