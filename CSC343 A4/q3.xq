for $location in doc("matches.xml")/matches/match/location
let $city := $location/city
let $country := $location/country
where $city[contains(text(), $country)]
return <result> {($city|$country)} </result>
