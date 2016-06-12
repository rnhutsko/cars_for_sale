class CarsforSale::Car
  attr_accessor :year, :make, :model, :engine, :transmission, :ext_color, :price, :vdp_url, :dealer_name, :dealer_address, :dealer_phone, :type

   def self.used
    
    #do stuff to scrape cars from Cars.com 
    cars_array
   end


  def self.scrape_srp
    cars_array = []
    doc = Nokogiri::HTML(open("http://www.hallauto.com/used-inventory/index.htm"))
    doc.css("li.inv-type-used").each do |vehicle|
      car = self.new
      car.year = vehicle.css('div.hproduct').attr('data-year').value
      car.type = vehicle.css('div.hproduct').attr('data-classification').value
      car.make = vehicle.css('div.hproduct').attr('data-make').value
      car.model = vehicle.css('div.hproduct').attr('data-model').value
      car.year = vehicle.css('div.hproduct').attr('data-year').value
      car.vdp_url = vehicle.css("div.media a").attr('href').value
      car.price = vehicle.css("div.pricing-area  ul.pricing  li  span.internetPrice span.value").text
      cars_array << car
    end
    cars_array
  end
#                        /used/Infiniti/2003-Infiniti-G35-0e288c120a0e0ae86dafef0e57940bf9.htm
# http://www.hallauto.com/used/Infiniti/2003-Infiniti-G35-0e288c120a0e0ae86dafef0e57940bf9.htm
 

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

#stubout
      
      # car.ext_color = "Red"
      # car.engine = "6.3L V12 48V GDI DOHC Hybrid"  
      # car.transmission = "7-Speed Automatic with Auto-Shift"
      # car.dealer_name = "Fusion Luxury Motors" 
      # car.dealer_address = "20837 Nordhoff St, Los Angeles, CA"
      # car.dealer_phone = "(866) 949-9665"






