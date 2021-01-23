if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'cptlic')
begin
	drop table cptlic
end
go
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'cptlic')
begin 
CREATE TABLE [dbo].[cptlic](
	[cidchaves] [char](128) NOT NULL,
	[cidip1s] [char](20) NOT NULL,
	[cnomemaq1s] [char](32) NOT NULL,
	[tdtapls] [datetime] NULL,
 CONSTRAINT [cptlic_cidchaves] PRIMARY KEY CLUSTERED 
(
	[cidchaves] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
end 
