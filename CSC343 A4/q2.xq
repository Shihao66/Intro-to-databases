distinct-values(
for $i in doc("players.xml")/players/player
for $j in doc("players.xml")/players/player
where $i[@fname = $j/@fname] and $i[@lname = $j/@lname] and $i[@pid != $j/@pid]
return <result> {distinct-values($i/(@fname|@lname))} </result>
)
