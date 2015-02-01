for $m in doc("matches.xml")/match
let $team1 := $m/teams/team[1]
let $team2 := $m/teams/team[2]
if ($team1/score > team2/score)
then let $lost_team = team2/@tid
else let $lost_team = team1/@tid
