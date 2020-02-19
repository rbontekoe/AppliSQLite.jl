# api.jl

include("./api.jl")

using SQLite
using DataFrames
using Dates

# Connect
connect(path::String)::SQLite.DB = SQLite.DB(path)

connect()::SQLite.DB = SQLite.DB()

archive(db, table::String, domainItems::Array{T, 1} where {T <: Any}) = begin
   dbi = [ createDatabaseItem( i ; action="CREATE" ) for i in domainItems]
   DataFrame( dbi ) |> SQLite.load!(db, table)
end # create

store(db, table::String, items::Array{T, 1} where {T <: Any}) = begin
   DataFrame( items ) |> SQLite.load!(db, table)
end # tore


# retrieve all item from a table
retrieve(db, table::String)::DataFrame = begin
   r = SQLite.DBInterface.execute(db, "select * from $table") |> DataFrame
   return r
end # retrieve

# retrieve item form a table based on a sql condition
retrieve(db, table::String, condition::String )::DataFrame = begin
   r = SQLite.DBInterface.execute( db, "select * from $table where $condition")  |> DataFrame
   return r
end # retrieve

# run custom function
runfunct(funct, x, y, z) = funct(x, y, z)
