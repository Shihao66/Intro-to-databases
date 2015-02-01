for $a in doc("players.xml")/players/player
let $n := $a/nationality/country
where count($n) > 1
return <player> {$a/(@fname | @lname)} </player>
