

(:winning team pid:)
distinct-values(
for $path_match in doc("matches")/matches/match
let $team1 := $path_match/teams/team[1]
let $team2 := $path_match/teams/team[2]
return
if ($team1/score < $team2/score)
then sum($team1/@tid)
else sum($team2/@tid)
)

