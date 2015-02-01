for $team in doc("teams.xml")/teams/team
let $budget := $team/budget
(:for $player in $team/player/@pid:)
let $pid := $team/player/@pid
let $single_salary := doc("players.xml")/players/player[some $x in $pid satisfies ($x = ./@pid)]/salary
where sum($single_salary) > $budget
return $team/name
