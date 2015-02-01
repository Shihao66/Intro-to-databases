(:1:)
(:for $p in doc("players.xml")/players/player
where count($p/nationality/country)>1
return <player>{$p/@fname}{$p/@lname}</player>:)

(:2:)
(:distinct-values(
  for $p1 in doc("players.xml")/players/player
  for $p2 in doc("players.xml")/players/player
  where $p1/@fname = $p2/@fname
  and $p1/@lname = $p2/@lname
  and $p1/@pid > $p2/@pid
  return 
  <player>
    {data($p1/@fname)}
    {data($p1/@lname)}
  </player>)
:)
(:3:)
(:
for $l in doc("matches.xml")/matches/match/location
where some $ctry in $l/country
satisfies contains(data($l/city),data($ctry))
return $l
:)
(:4:)
(:5:)
(:for $t in doc("teams.xml")/teams/team
where (for $pid in doc("teams.xml")/teams/team/player
                  for $p in doc("players.xml")/players/player
                  where $pid/@pid = $p/@pid
                  return sum($p/salary))>$t/budget
return $t/name
:)
(:6:)
(:for $cid in doc("teams.xml")/teams/team
for $pid in doc("teams.xml")/teams/team/player
where $cid/coach/@cid = $pid/@pid
return 
<player>{
for $p in doc("players.xml")/players/player
where $p/@pid = $pid/@pid
return 
(data($p/@fname),
data($p/@lname),
$p/salary,
$cid/name)
}</player>
:)
(:7:)
for $m in doc("matches.xml")/matches/match
for $t in $m/team
for $t2 in  doc("teams.xml")/teams/team
for $p in $t2/player
return (
  data($m/@mid),
  sum(
    count(
      {}
    )))
(:8:)
(:9:)
(:10:)
