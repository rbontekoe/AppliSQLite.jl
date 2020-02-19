# main.jl

include("./infrastructure.jl")

# Test co
struct AppliPerson
   id::String
   name::String
   email::String
    #constructors
   AppliPerson(id, name) = new(id, name, "")
   AppliPerson(id, name, email) = new(id, name, email)
end

daisy = AppliPerson("A", "Daisy", "")

mickey = AppliPerson("B", "Mickey", "")

#db = connect("test.sqlite")
db = DBInterface.connect(SQLite.DB, "test.sqlite")

archive(db, "subscribers", [daisy, mickey])

#import SQLite.DBInterface

r1 = retrieve( db, "subscribers")
#r1 = SQLite.DBInterface.execute(db, "select * from subscribers") |> DataFrame

println(r1)

r2 = retrieve( db, "subscribers", "key = '" * daisy.id * "'" )
#r2 = SQLite.DBInterface.execute( db, "select * from subscribers where key = '$(daisy.id)'") |> DataFrame

println(r2)

store(db, "users", [daisy, mickey])

#r3 = retrieve( db, "users")
r3 = SQLite.DBInterface.execute( db, "select * from users") |> DataFrame

println(r3)

#r4 = retrieve( db, "users", "id = '" * daisy.id * "'" )
r4 = SQLite.DBInterface.execute(db, "select * from users where id = '$(daisy.id)'") |> DataFrame

println(r4)

cmd = `rm test.sqlite`
run(cmd)
