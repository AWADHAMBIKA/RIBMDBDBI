# RIBMDBDBI

RIBMDBDBI is an DBI-compliant interface to ODBC database. It's a wrapper of RIBMDB package(Developed over RODBC package).

## Installation
RIBMDB isn't availbale in CRAN yet but you can get it from github at:


```
https://github.com/ibmdb/RIBMDB
```
RIBMDBDBI isn't available from CRAN yet, but you can get it from github at:

```
https://github.com/AWADHAMBIKA/RIBMDBDBI
```

## Basic usage
### Before you start
You have to create a system data source name (DSN) to indicate which data source you want to use.
The following links are useful to do that.
- https://support.microsoft.com/en-us/kb/300596
- https://drill.apache.org/docs/configuring-odbc-on-windows/

### Context:
This package is mainly for connection pooling support for RIBMDB in relation with "pool" package. Check below link for details:

- https://db.rstudio.com/pool/
- https://www.rdocumentation.org/packages/pool/versions/0.1.4.3/topics/Pool
- https://shiny.rstudio.com/articles/pool-basics.html

### Example - 1
```R
#Load library
library(DBI)
library(RIBMDBDBI)

# At first, we make a sample table using RODBC package
con <- dbConnect(RODBCDBI::ODBC(), 'foodb','bar.fly.com',12345,'guest','guest')
(or)
con <- function()
{
  dbname <- 'foodb'
  host <- 'bar.fly.com'
  port <- 12345
  uid <- 'guest'
  pwd <- 'guest'
  dbConnect(RODBCDBI::ODBC(), dbname,host,port,uid,pwd)
}

#Show table lists
dbListTables(con)

#Add new tables(iris, USArrests)
dbWriteTable(con, "USArrests", USArrests)
dbWriteTable(con, "iris", iris)

#Show table again to check that the above tables are added correctly.
dbListTables(con)

#Show the columns(fields) of iris table
dbListFields(con, "iris")

#Get the entire contents of iris and USArrests tables
dbReadTable(con, "iris")
dbReadTable(con, "USArrests")

# You can fetch all results by SQL:
res <- dbSendQuery(con, "SELECT * FROM USArrests")
dbFetch(res)
# ...Or indicate its size of the row.
dbFetch(res, n=3)

# If you want to know the only row size of your query, you can use dbGetRowCount
# Or you can get all result at once by dbGetQuery
dbGetRowCount(res, "SELECT * FROM USArrests")

# You can get the column information of your query.(not implemented completely)
dbColumnInfo(res)

# Clear the result
dbClearResult(res)

# Disconnect from the database
dbDisconnect(con)
```
### Example - 2

```R
# load pool Library
library(pool)

# Create pool object. This will give you a connection of pool to be used instead of individual connection.
 
  pool <- dbPool(
    drv = RODBCDBI::ODBC(),
    dbname = "foodb",
    host = "foo.bar.com",
    port = 60000,
    user = "guest",
    password = "guest"
  )
  
# Create table.
  dbWriteTable(pool, "iris", iris, overwrite=TRUE)

# Query Table  
  dbGetQuery(pool, "SELECT * from iris;")
  
# Drop Table
  dbRemoveTable(pool, "iris")
  
# Close the pool once done.
  poolClose(pool)

```

## Contributing

- Fork it ( https://github.com/AWADHAMBIKA/RIBMDBDBI/fork )
- Create your feature branch (git checkout -b my-new-feature)
- Commit your changes (git commit -am 'Add some feature')
- Push to the branch (git push origin my-new-feature)
- Create a new Pull Request

## Acknowledgements

Many thanks to Brian D. Ripley, Michael Lapsley since this package is a wrapper of RIBMDB package built on [RODBC package](https://cran.r-project.org/package=RODBC) & Nagi Teramo since [RODBCDBI package](https://cran.r-project.org/web/packages/RODBCDBI/index.html) is used as reference/base code.
