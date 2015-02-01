for $m in doc("matches.xml")/matches/match
let $mid := $m/@mid
let $team1 := $m/teams/team[1]
let $team2 := $m/teams/team[2]

let $team1_players := doc("teams.xml")/teams/team[some $tid in ./@tid satisfies ($tid = $team1/@tid)]/player
let $team2_players := doc("teams.xml")/teams/team[some $tid2 in ./@tid satisfies ($tid2 = $team2/@tid)]/player

for $player1 in $team1_players
let $p1 := doc("players.xml")/players/player[some $pid1 in ./@pid satisfies ($pid1 = $player1/@pid) and ./@married = 'yes']
let $team1_married := count($p1)

for $player2 in $team2_players
let $p2 := doc("players.xml")/players/player[some $pid2 in ./@pid satisfies ($pid2 = $player2/@pid) and (./married = 'yes')]
let $team2_married := count($p2)

return <result> {$mid} {sum($team1_married, $team2_married)} </result>
