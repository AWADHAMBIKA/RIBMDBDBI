% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ODBCConnection.R
\docType{methods}
\name{dbReadTable,ODBCConnection,character-method}
\alias{dbReadTable,ODBCConnection,character-method}
\title{Convenience functions for importing/exporting DBMS tables}
\usage{
\S4method{dbReadTable}{ODBCConnection,character}(conn, name, row.names = NA,
  check.names = TRUE, select.cols = "*")
}
\arguments{
\item{conn}{a \code{\linkS4class{ODBCConnection}} object, produced by \code{\link[DBI]{dbConnect}}}

\item{name}{a character string specifying a table name.}

\item{row.names}{a character string specifying a table name.}

\item{check.names}{If \code{TRUE}, the default, column names will be converted to valid R identifiers.}

\item{select.cols}{A SQL statement (in the form of a character vector of 
length 1) giving the columns to select. E.g. "*" selects all columns, 
"x,y,z" selects three columns named as listed.}
}
\value{
A data.frame in the case of \code{dbReadTable}; otherwise a logical
indicating whether the operation was successful.
}
\description{
These functions mimic their R/S-Plus counterpart \code{get}, \code{assign},
\code{exists}, \code{remove}, and \code{objects}, except that they generate
code that gets remotely executed in a database engine.
}
\note{
Note that the data.frame returned by \code{dbReadTable} only has
primitive data, e.g., it does not coerce character data to factors.
}
\examples{
\dontrun{
library(DBI)
con <- dbConnect(RODBCDBI::ODBC(), dsn="test", user="sa", password="Password12!")
dbWriteTable(con, "mtcars", mtcars, overwrite=TRUE)
dbReadTable(con, "mtcars")
dbGetQuery(con, "SELECT * FROM mtcars WHERE cyl = 8")

# Supress row names
dbReadTable(con, "mtcars", row.names = FALSE)
dbGetQuery(con, "SELECT * FROM mtcars WHERE cyl = 8", row.names = FALSE)

dbDisconnect(con)
}
}

