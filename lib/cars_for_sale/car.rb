class CarsforSale::Car
  attr_accessor :year, :make, :model, :engine, :transmission, :ext_color, :price, :vdp_url, :dealer_name, :dealer_address, :dealer_phone, :type

   def self.used
    cars_array = []
    #do stuff to scrape cars from Cars.com 

    #stubout
      car = self.new
      car.type = "Used"
      car.year = "2014"
      car.make = "Ferrari"
      car.model = "LaFerrari Base"
      car.price = "$4,400,000 "
      car.ext_color = "Red"
      car.engine = "6.3L V12 48V GDI DOHC Hybrid"  
      car.transmission = "7-Speed Automatic with Auto-Shift"
      car.vdp_url = "https://www.cars.com/vehicledetail/detail/664236376/overview" 
      car.dealer_name = "Fusion Luxury Motors" 
      car.dealer_address = "20837 Nordhoff St, Los Angeles, CA"
      car.dealer_phone = "(866) 949-9665"

    cars_array << car


    cars_array
   end

 

end #of class