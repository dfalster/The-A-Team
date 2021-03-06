with poaCentroid as (
	select 
		c.POA_NAME,
		c.SLA_MAIN,
		c.[POA Geom].MakeValid().STCentroid() as centroid,
		b.[Response],
		b.[Bucket]
	from [abs].[SLA-to-POA] as c
	inner join [dbo].[RModelOutputBuckets] b on b.[SLA_number] = c.[SLA_MAIN]
	where c.[STATE_CODE] = '4'
)
SELECT 
	'''' + 
	[POA_NAME] + 
	''': { ''SLA'': ''' + 
	[SLA_MAIN] + 
	''', ''Lattitude'': ' + 
	convert(varchar,convert(numeric(20,16),centroid.STY)) +
	', ''Longitude'': ' + 
	convert(varchar,convert(numeric(20,16),centroid.STX)) + 
	', ''Quintile'': ' +
	convert(varchar,Bucket) + 
	' },'
FROM poaCentroid
order by [POA_NAME]