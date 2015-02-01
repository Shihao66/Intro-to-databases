for $t in doc("teams")/teams/team
let $coach_player_team := $t[some $id in $t/player/@pid satisfies ($id = ./coach/@cid)]
let $coach_player_id := $coach_player_team/coach/@cid
let $cp_team_name := $coach_player_team/name
let $coach_player := doc("players.xml")/players/player[some $pid in ./@pid satisfies ($pid = $coach_player_id)]
where $coach_player_team != <player/>
return 
<player> 
{$coach_player/(@fname | @lname) | $coach_player/salary | $cp_team_name
}
</player>
