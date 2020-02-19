# for test purposes

include("./domain.jl")

# createDatabaseItem - internal function
const agent = "AB9F"
createDatabaseItem(item::Any; agent=agent, action="CREATE") = DatabaseItem(time(), agent, action, item.id, item)
