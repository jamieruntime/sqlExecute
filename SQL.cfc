component name = "SQL"
{

	/**
	* @hint adds a sql param to the current list
	* @name the name of the param (to be used like :this)
	* @value the vaule of the param
	* @type the type of the param
	*/
	public void function sqlParam(name, value, type="STRING")
	{
		if(!isDefined("application.sqlParam")) {application.sqlParam = [];}
		if(arguments.type == "BOOLEAN") {var newType = "CF_SQL_BIT";}
		if(arguments.type == "DATE") {var newType = "CF_SQL_DATE";}
		if(arguments.type == "INT") {var newType = "CF_SQL_INTEGER";}
		if(arguments.type == "STRING") {var newType = "CF_SQL_VARCHAR";}
		if(arguments.type == "TIME") {var newType = "CF_SQL_TIME";}
		if(arguments.type == "TIMESTAMP") {var newType = "CF_SQL_TIMESTAMP";}
		var newParam = {name = arguments.name, value = arguments.value, type = newType};
		arrayAppend(application.sqlParam, newParam);
	}

	/**
	* @hint executes a sql statement (with any params that have been added)
	* @statement the sql statement to execute
	* @datasource the datasource to use
	* @resultset the results to use in a query of queries
	*/
	public any function sqlExecute(statement, datasource = "default", resultset = "")
	{
		var queryObject = new query();
		if(datasource == "default") {queryObject.setDataSource(application.dsn);}
		else {queryObject.setDatasource(arguments.datasource);}
		queryObject.setSql(arguments.statement);
		if(isDefined("application.sqlParam"))
		{
			for(x = 1; x <= arrayLen(application.sqlParam); x++)
			{
				queryObject.addParam(name = application.sqlParam[x].name, value = application.sqlParam[x].value, CFSQLTYPE = application.sqlParam[x].type);
			}
		}
		if(!resultset == "")
		{
			queryObject.setDBType("query");
			evaluate("queryObject.setAttributes(query = " & resultset & ")");
		}
		var result = queryObject.execute();
		application.sqlParam = [];
		
		// Temp (do NOT leave this on - eats memory like a bitch!)
		// if(!isDefined('application.debug.SQL_EXECUTE_LOG')) {application.debug.SQL_EXECUTE_LOG = [];}
		// application.debug.SQL_EXECUTE_LOG.append({datasource:arguments.datasource, result:result, statement:arguments.statement, timestamp:now()});
		
		if(listFirst(arguments.statement, " ") == "INSERT")
		{
			try {return int(result.getPrefix().generatedKey);}
			catch(any e) {return e;}
		}
		else if(listFirst(arguments.statement, " ") == "SELECT") {return result.getResult();}
		return javaCast("null", 0);
	}
	
	public any function sqlExecuteQuery(statement, string query, datasource = "default")
	{
		return application.udf.sqlExecute(arguments.statement, arguments.datasource, arguments.query);
	}

}