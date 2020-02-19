# main module

module AppliSQLite

greet() = print("AppliSQLite")

#using SQLite

#using DataFrames

# Domain objects
#export create

# Database functions
export connect, archive, store, retrieve, runfunct

include("./infrastructure.jl")

end
