# RIBMDB

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

### Example
```R
#Load library
library(DBI)
library(RIBMDBDBI)

# At first, we make a sample table using RODBC package
con <- dbConnect(RIBMDBDBI::ODBC(), dsn='test')

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

## Contributing

- Fork it ( https://github.com/AWADHAMBIKA/RIBMDBDBI/fork )
- Create your feature branch (git checkout -b my-new-feature)
- Commit your changes (git commit -am 'Add some feature')
- Push to the branch (git push origin my-new-feature)
- Create a new Pull Request

## Acknowledgements

Many thanks to Brian D. Ripley, Michael Lapsley since This package is just a wrapper of [RODBC package](https://cran.r-project.org/package=RODBC).
