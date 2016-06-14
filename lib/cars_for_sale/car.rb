class CarsforSale::Car
  attr_accessor :year, :make, :model, :engine, :transmission, :ext_color, :price, :vdp_url, :dealer_name, :dealer_address, :dealer_phone, :type

  def self.scrape_srp
    doc = Nokogiri::HTML(open("http://www.hallauto.com/used-inventory/index.htm"))
    doc.css("li.inv-type-used").collect do |vehicle|
      self.new.tap do |car|
        car.year = vehicle.css('div.hproduct').attr('data-year').value
        car.type = vehicle.css('div.hproduct').attr('data-classification').value
        car.make = vehicle.css('div.hproduct').attr('data-make').value
        car.model = vehicle.css('div.hproduct').attr('data-model').value
        car.year = vehicle.css('div.hproduct').attr('data-year').value
        car.vdp_url = vehicle.css("div.media a").attr('href').value
        car.price = vehicle.css("div.pricing-area  ul.pricing  li  span.internetPrice span.value").text
      end
    end
  end

  def self.scrape_vdp(a_car)
    obj_url = "http://www.hallauto.com"
    obj_url << a_car.vdp_url
      
    a_doc = Nokogiri::HTML(open(obj_url))
      vehicle_details = a_doc.css("div.ddc-content.inventory-detail-quick-specs")
      color_array = vehicle_details.css("ul  li.exteriorColor  span.value").text
      color_array = color_array.split("\n")
      a_car.ext_color = color_array[1]
      a_car.engine = vehicle_details.css("ul li.engine span:nth-child(4)").text.gsub("\n","")
      a_car.transmission = vehicle_details.css("ul  li.engine  span:nth-child(5)").text
      
      dealer_details = a_doc.css("div.ddc-content.contact-info.ddc-box-1")
      a_car.dealer_name = dealer_details.css("div  p.fn.n  span").text
      street = dealer_details.css("div  p.adr  a  span.street-address").text
      city = dealer_details.css("div  p.adr  a  span.locality").text
      state =  dealer_details.css("div  p.adr  a  span.region").text
      zip_code = dealer_details.css("div > p.adr  a  span.postal-code").text
      a_car.dealer_address = street + " " + city + " " + state + " " + zip_code
      a_car.dealer_phone = dealer_details.css("div  ul  li  span.value").text
      a_car
  end
end #of class


# def self.inventory
#     doc = Nokogiri::HTML(open("http://www.hallauto.com/used-inventory/index.htm"))
#     total_inv_count = doc.css("div.selections.facet-breadcrumb-selections > div > span.vehicle-count").text
#     pagecount = (total_inv_count.to_i / 16).round
    #  http://www.hallauto.com/used-inventory/index.htm?start=16&

# From: /Users/rnhxfer/Development/code/cars_for_sale/lib/cars_for_sale/car.rb @ line 8 CarsforSale::Car.inventory:

#      4:   def self.inventory
#      5:     doc = Nokogiri::HTML(open("http://www.hallauto.com/used-inventory/index.htm"))
#      6:     total_inv_count = doc.css("div.selections.facet-breadcrumb-selections > div > span.vehicle-count").text
#      7:     pagecount = (total_inv_count.to_i / 16).round
#  =>  8: binding.pry
#      9:     #  http://www.hallauto.com/used-inventory/index.htm?start=16&
#     10:   end

# [1] pry(CarsforSale::Car)> pagecount
# => 47
# [2] pry(CarsforSale::Car)> total_inv_count
# => "764"
# [3] pry(CarsforSale::Car)> base_url = "http://www.hallauto.com/used-inventory/index.htm"
# => "http://www.hallauto.com/used-inventory/index.htm"
# [4] pry(CarsforSale::Car)> i = 2
# => 2
# [5] pry(CarsforSale::Car)> page = i * 16
# => 32
# [6] pry(CarsforSale::Car)> add_on = "?start=" + page + "&"
# TypeError: no implicit conversion of Fixnum into String
# from (pry):6:in `+'
# [7] pry(CarsforSale::Car)> add_on = "?start=" + page.to_s + "&"
# => "?start=32&"
# [8] pry(CarsforSale::Car)> base_url << add_on
# => "http://www.hallauto.com/used-inventory/index.htm?start=32&"
# [9] pry(CarsforSale::Car)> 





    
  # end

