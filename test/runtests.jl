# runtests.jl

using Test

include("../src/infrastructure.jl")

struct AppliPerson
   id::String
   name::String
   email::String
    #constructors
   AppliPerson(id, name) = new(id, name, "")
   AppliPerson(id, name, email) = new(id, name, email)
end

# TEST MODEL
@testset "AppliPerson id, and name test" begin
    scrooge = AppliPerson("smcd", "Scrooge McDuck", "")
    @test scrooge.id == "smcd"
    @test scrooge.name == "Scrooge McDuck"
    @test scrooge.email == ""
end

@testset "AppliPerson id, name, and email test" begin
    scrooge = AppliPerson("smcd", "Scrooge McDuck", "scrooge@duckcity.com")
    @test scrooge.id == "smcd"
    @test scrooge.name == "Scrooge McDuck"
    @test scrooge.email == "scrooge@duckcity.com"
end

@testset "In-memory database test" begin
    db = connect()
    @test db.file == ":memory:"
end

@testset "Archive AppliPerson in database" begin
    db = DBInterface.connect(SQLite.DB, "test.sqlite")
    daisy = AppliPerson("dd", "Daisy", "")
    id = daisy.id
    name = daisy.name
    email = daisy.email
    archive(db, "persons", [daisy])
    r = retrieve(db, "persons", "key = '" * daisy.id * "'").item
    #r = SQLite.DBInterface.execute( db, "select * from persons where key = '$(daisy.id)'") |> DataFrame
    @test r[1].id == id
    @test r[1].name == name
    @test r[1].email == email

    cmd = `rm test.sqlite`
    run(cmd)
end

@testset "Retrieve AppliPerson from database" begin
    db = DBInterface.connect(SQLite.DB)
    daisy = AppliPerson("dd", "Daisy", "")
    id = daisy.id
    name = daisy.name
    email = daisy.email
    store(db, "persons", [daisy])
    r = retrieve(db, "persons", "id = '" * daisy.id * "'")
    #r = SQLite.DBInterface.execute(db, "select * from persons where id = '$(daisy.id)'") |> DataFrame
    @test r.id[1] == id
    @test r.name[1] == name
    @test r.email[1] == email
end
