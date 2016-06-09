class CarsforSale::CLI

  def call
    list_cars
    menu
    bid_you_adieu
  end


  def list_cars
    puts "Welcome to Cars.com's cars for sale..."
    puts "Which group of cars do wish to see? "
    puts "1-25 or 26-50 or exit?"
    puts "Enter Group Choice:"
    
  end

  def menu
    @cars = CarsforSale::Car.used
    input = gets.strip
    while input != "exit"
      if input == "1-25"
        @cars.each.with_index(1) do |srp_list,i|
          puts "#{i}. #{srp_list.year}  #{srp_list.make} #{srp_list.model} - #{srp_list.price}"
          puts ""
        end
      end
      puts "Which car do wish to see more info on or exit?(enter line number)"
      input = gets.strip
    end
  end


  def bid_you_adieu
    puts "Thanks for using this gem.  Have a great day!"
  end
end
# puts "Which group of cars do wish to see? "
#     puts "1-25 or 26-50 or exit?"
#     puts "Enter Group Choice:"