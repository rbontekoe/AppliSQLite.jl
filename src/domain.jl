# Database item
struct DatabaseItem{T}
   time::Float64
   agent::String
   action::String
   key::String
   item::T
end # end DatabaseItem
