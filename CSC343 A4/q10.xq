<Stats>
{
for $thecountry in 
distinct-values(
  for $path_country in doc("teams")/teams/team
  let $countries := $path_country/@country
  
  return string($countries)
)

return <Bar country="{$thecountry}" count="
{count(
for $path_compare in doc("teams")/teams/team
let $isCountry := $path_compare//@country

return
  if ($path_compare/@country [.=$thecountry])

  then <result>{$isCountry}</result>
  
  else()
)}">
</Bar>
}
</Stats>

  



