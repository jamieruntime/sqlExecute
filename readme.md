SQL Execute
===========

Version 1.0.0
Jamie Purchase
30/01/2016

Description
-----------

A single line function for queries with multiple return types

<blockquote>
// Returns result set<br>
var result = sqlExecute("SELECT * FROM myTable");<br>
<br>
// Returns auto-generated identity ID<br>
var id = sqlExecute("INSERT INTO myTable (myValue) VALUES ('foo')");<br>
<br>
// Executes an update statement<br>
sqlExecute("UPDATE myTable SET myValue = 'bar' WHERE id = 1");<br>
</blockquote>

Notes
-----
* uses application.dsn as the default datasource (change as necessary)

About the Author
----------------

You can learn more at my site: <a href = "https://jamieruntime.wordpress.com/2016/01/30/sql-execute-the-one-line-sql-statement-udf/" target = "_blank">JamieRuntime article</a>