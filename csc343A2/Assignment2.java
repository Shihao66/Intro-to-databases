import java.sql.*;

public class Assignment2 {
    
  
  // A connection to the database  
  Connection connection;
  
  // Statement to run queries
  Statement sql;
  
  // Prepared Statement
  PreparedStatement ps;
  
  // Resultset for the query
  ResultSet rs;
  
  String sqlText;
  //CONSTRUCTOR
  Assignment2() throws ClassNotFoundException, SQLException{
	  try {
		  Class.forName("org.postgresql.Driver");
	  } catch (ClassNotFoundException e){
		  e.printStackTrace();
	  }
	  this.sql = connection.createStatement();
	  
  }
  
  //Using the input parameters, establish a connection to be used for this session. 
  //Returns true if connection is sucessful
  
  public boolean connectDB(String URL, String username, String password) throws SQLException{
	  try{
	  connection = DriverManager.getConnection(URL, username, password);}
	  catch (SQLException e) {
		  e.printStackTrace();
		  
	  }
	  if (connection != null){
		  return true;
	  } else {
		  return false;
	  }
  }
  
  
  //Closes the connection. Returns true if closure was sucessful
  public boolean disconnectDB(){
	  try {
		connection.close();
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
		
	}
	  if (connection != null){
		  return false;
	  } else {
		  return true;
	  }
  }
    
  //Inserts a row into the country table. name is the name of the country (national team) and coach
  //is the coach of the newly inserted national team. You have to check if the country with id
  //cid exists. Returns true if the insertion was successful, false otherwise. 
  
  public boolean insertCountry (int cid, String name, String coach) throws SQLException {

   sqlText = ("INSERT INTO country(cid, name, coach) " +
   		      "VALUES(" + cid + "," + name + "," + coach + ")");
   int result = 0; 
   try {
		result = sql.executeUpdate(sqlText);
	} catch (SQLException e) {
	// TODO Auto-generated catch block
		return false;
	
	}
    if (result == 1) {
    	return true;
    }else{
    	return false;
    }
  }
  
  //Returns the number of players registered in table 'player' that play in country with id cid. Returns -1 
  //if an error occurs
  public int getPlayersCount(int cid) throws SQLException{

	int result = -1;
	sqlText =   ("SELECT p.pid AS counting " + 
				"FROM player p " + 
				"WHERE player.cid = " + cid);
	
	try{
		sql.executeQuery(sqlText);
	} catch (SQLException e){
		e.printStackTrace();
	}
	
	
	try {
		rs = sql.executeQuery(sqlText);
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	
	
	if (rs != null) {
		while (rs.next())  {
			result += 1;
		}
		result += 1;
	}
	
	rs.close();
	return result;

  }
  
  
  public String getPlayerInfo(int pid) throws SQLException{
	  String result = "";
	  
	  sqlText = String.format("SELECT fname, lname, position, goals " + 
	  			"FROM player " + 
	  			"WHERE player.pid = %d", pid);
	  
	  try {
		rs = sql.executeQuery(sqlText);
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	  
   if (rs == null) {
	   rs.close();
	   return result;
   } else {
	   result =  (rs.getString("fname") + ":" + rs.getString("lname") + ":" + 
			   rs.getString("position") + ":" + rs.getInt("goals") );
	   rs.close();
	   return result;   
   }
       
  }

  
  public boolean chgStadiumLocation(int sid, String newCity) throws SQLException{
	  sqlText = ("UPDATE stadium " + 
	  			"SET city = " + newCity + " " +
	  			"WHERE sid = " + sid);
	  sql.executeUpdate(sqlText);
	  
	  if (sql.getUpdateCount() > 0) {
		  return true;
	  } else {
		  return false;
	  }
	  
  }

  public boolean deleteCountry(int cid) throws SQLException{
	  sqlText = ("DELETE FROM country " + 
				 "WHERE cid = " + cid);
	  sql.executeUpdate(sqlText);
	  
	  if (sql.executeUpdate(sqlText) > 0) {
		  return true;
	  } else {
		  return false;
	  }
	  	     
  }
  
  public String listPlayers(String fcname) throws SQLException{
	  //TODO
	  String result = "";
	  sqlText = ("SELECT p.fname, p.lname, p.position, p.goals, co.name" + 
	  			"FROM appearance a, player p, club cl, country co " +
	  			"WHERE a.pid = p.pid " + 
	  			"AND p.fcid = cl.fcid " + 
	  			"AND cl.name = " + fcname +
	  			"AND p.cid = co.cid");
	  
	  rs = sql.executeQuery(sqlText);
	  
	  if (rs != null) {
		  while (rs.next()) {
			  result += (rs.getString("fname") + ":" + 
					     rs.getString("lname") + ":" + 
			  			 rs.getString("position") + ":" +
			  			 rs.getInt("goals") + ":" +
			  			 rs.getString("name") + "#");
		  }
	  } 
	rs.close();
	return result;
  }
  
  
  public boolean updateValues(String cname, int incrV) throws SQLException{
	  sqlText = ("UPDATE player " + 
	  			"SET value = value + " + incrV + 
	  			" FROM player p, country co " + 
	  			"WHERE p.fcid = co.fcid " + 
	  			"AND co.name = " + cname);
	  sql.executeUpdate(sqlText);
	  
	  if (sql.getUpdateCount() > 0) {
		  return true;
	  } else  {
		  return false;
	  }
  }
  
  public String query7(){
   return "";
  }
    
  public boolean updateDB(){
	return false;    
  }
  
}
