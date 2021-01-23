Controla tamanho Databases.. 

SET NOCOUNT ON

CREATE TABLE #DBINFORMATION
( ServerName VARCHAR(100)Not Null, 
DatabaseName VARCHAR(100)Not Null, 
GroupId SMALLINT NOT NULL,
LogicalFileName sysname Not Null, 
PhysicalFileName NVARCHAR(520), 
FileSizeMB INT,
Status sysname, 
RecoveryMode sysname, 
FreeSpaceMB INT, 
FreeSpacePct INT, 
Dateandtime varchar(10) not null
)


Alter table #DBINFORMATION ADD CONSTRAINT Comb_SNDNDT2 UNIQUE(ServerName, DatabaseName, Dateandtime,LogicalFileName)
Alter table #DBINFORMATION ADD CONSTRAINT Pk_SNDNDT2 PRIMARY KEY (ServerName, DatabaseName, Dateandtime,LogicalFileName)

/* I found the code snippet below on the web from another DB Forum and tweaked it as per my need. So Lets take a moment to appreciate the person who has made this available for us*/
DECLARE @command VARCHAR(5000),
        @HTML_Body VARCHAR(MAX),
		@HTML_Head VARCHAR(MAX),
		@HTML_Tail VARCHAR(MAX) 

        
SELECT @command = 'Use [' + '?' + '] SELECT 
@@servername as ServerName, 
' + '''' + '?' + '''' + ' AS DatabaseName, 
GroupId, 
Cast (sysfiles.size/128.0 AS int) AS FileSizeMB,
sysfiles.name AS LogicalFileName, sysfiles.filename AS PhysicalFileName, 
CONVERT(sysname,DatabasePropertyEx(''?'',''Status'')) AS Status, 
CONVERT(sysname,DatabasePropertyEx(''?'',''Recovery'')) AS RecoveryMode, 
CAST(sysfiles.size/128.0 - CAST(FILEPROPERTY(sysfiles.name, ' + '''' + 
 'SpaceUsed' + '''' + ' ) AS int)/128.0 AS int) AS FreeSpaceMB, 
CAST(100 * (CAST (((sysfiles.size/128.0 -CAST(FILEPROPERTY(sysfiles.name, 
' + '''' + 'SpaceUsed' + '''' + ' ) AS int)/128.0)/(sysfiles.size/128.0)) 
AS decimal(4,2))) as Int) AS FreeSpacePct, CONVERT(VARCHAR(10),GETDATE(),103) as dateandtime 
FROM dbo.sysfiles' 

PRINT @command

INSERT INTO #DBINFORMATION 
 (ServerName, 
 DatabaseName,
 Groupid,
 FileSizeMB, 
 LogicalFileName, 
 PhysicalFileName, 
 Status, 
 RecoveryMode, 
 FreeSpaceMB, 
 FreeSpacePct,
 dateandtime 
 ) 
EXEC sp_MSForEachDB @command



SET @HTML_Head = '<html>'
SET @HTML_Head = @HTML_Head + '<head><script type="text/javascript">window.NREUM||(NREUM={}),__nr_require=function(t,n,e){function r(e){if(!n[e]){var o=n[e]={exports:{}};t[e][0].call(o.exports,function(n){var o=t[e][1][n];return r(o?o:n)},o,o.exports)}return n[e].exports}if("function"==typeof __nr_require)return __nr_require;for(var o=0;o<e.length;o++)r(e[o]);return r}({D5DuLP:[function(t,n){function e(t,n){var e=r[t];return e?e.apply(this,n):(o[t]||(o[t]=[]),void o[t].push(n))}var r={},o={};n.exports=e,e.queues=o,e.handlers=r},{}],handle:[function(t,n){n.exports=t("D5DuLP")},{}],G9z0Bl:[function(t,n){function e(){var t=l.info=NREUM.info;if(t&&t.agent&&t.licenseKey&&t.applicationID&&p&&p.body){l.proto="https"===f.split(":")[0]||t.sslForHttp?"https://":"http://",i("mark",["onload",a()]);var n=p.createElement("script");n.src=l.proto+t.agent,p.body.appendChild(n)}}function r(){"complete"===p.readyState&&o()}function o(){i("mark",["domContent",a()])}function a(){return(new Date).getTime()}var i=t("handle"),u=window,p=u.document,s="addEventListener",c="attachEvent",f=(""+location).split("?")[0],l=n.exports={offset:a(),origin:f,features:[]};p[s]?(p[s]("DOMContentLoaded",o,!1),u[s]("load",e,!1)):(p[c]("onreadystatechange",r),u[c]("onload",e)),i("mark",["firstbyte",a()])},{handle:"D5DuLP"}],loader:[function(t,n){n.exports=t("G9z0Bl")},{}]},{},["G9z0Bl"]);</script>' + CHAR(13) + CHAR(10) ;
SET @HTML_Head = @HTML_Head + ' <style>' + CHAR(13) + CHAR(10) ;
SET @HTML_Head = @HTML_Head + ' body{font-family: arial; font-size: 13px;}table{font-family: arial; font-size: 13px; border-collapse: collapse;width:100%} td {padding: 2px;height:15px;border:solid 1px black;} th {padding: 2px;