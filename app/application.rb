require 'pry'
class Application 
  @@items = []
  def call (env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)
    if req.path.match(/items/)
        item_name = req.path.split("/items/").last
        # binding.pry
      if item = @@items.find{|item| item.name == item_name}
        resp.write item.price
      else
        resp.status = 400
        resp.write "Route not found"
      end
    else
      resp.status = 404
      resp.write "Route not found"
    end
  end
end

  # if it has the item the response would be the item price if not you would set the response status to 404 and have the response be Item not found
  # 1. Your application should only accept the `/items/<ITEM NAME>` route. Everything else should `404`
  # 2. If a user requests `/items/<Item Name>` it should return the price of that item
  # 3. IF a user requests an item that you don't have, then return a `400` and an error message