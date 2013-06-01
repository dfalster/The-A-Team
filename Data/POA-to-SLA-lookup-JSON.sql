with poaCentroid as (
	select 
		POA_NAME,
		SLA_MAIN,
		[POA Geom].MakeValid().STCentroid() as centroid
	from [abs].[SLA-to-POA]
)
SELECT 
	'''' + 
	[POA_NAME] + 
	''': { ''SLA'': ''' + 
	[SLA_MAIN] + 
	''', ''Lattitude'': ''' + 
	cast(centroid.STY as varchar(20)) + 
	''', ''Longitude'': ''' + 
	cast(centroid.STX as varchar(20)) + 
	''' },'
FROM poaCentroid