
<Stats>
{
  for $path_team in doc("teams")/teams/team
  let $tname := $path_team/string(name)
  let $ttid := $path_team/@tid
  return <Bar teamname="{$tname}" count = "{count(
    
  for $path_match in doc("matches")/matches/match[@year=2014]
  let $counts := sum($path_match/teams//@tid[.=$ttid])
  
  return 
  if ($path_match/teams//@tid = $ttid)

  then <result>{$counts}</result>
  
  else()
  
)
  }"></Bar>
  
}
</Stats>
  

  