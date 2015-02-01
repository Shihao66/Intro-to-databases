for $m in doc("matches.xml")/matches/match
let $team1 := $m/teams/team[1]
let $team2 := $m/teams/team[2]

let $team1_info := doc("teams.xml")/teams/team[some $tid in ./@tid satisfies ($tid = $team1/@tid)]
let $team2_info := doc("teams.xml")/teams/team[some $tid2 in ./@tid satisfies ($tid2 = $team2/@tid)]


return 
if (((xs:integer($team1/@score) gt xs:integer($team2/@score)) and (xs:integer($team1_info/budget) lt xs:integer($team2_info/budget))) or ((xs:integer($team1/@score) lt xs:integer($team2/@score)) and (xs:integer($team1_info/budget) gt xs:integer($team2_info/budget)))
then <result> {$m/@mid} </result>
else ()

