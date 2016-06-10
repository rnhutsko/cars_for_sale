class CarsforSale::CLI

  def call
    get_cars
    menu
    bid_you_adieu
  end


  def get_cars
    @cars = CarsforSale::Car.scrape_srp
  end

  def list_cars
    @cars.each.with_index(1) do |srp_list,i|
          puts "#{i}. #{srp_list.year}  #{srp_list.make} #{srp_list.model} - #{srp_list.price}"
          puts ""
        end
  end

  def menu
    input = nil
    puts "Welcome to Cars.com's cars for sale..."
    
    if @cars.length >= 50
      puts "There are 50+ cars.  You can view up to 50"
    puts "Which group of cars do wish to see? "
      puts "1-25, 26-50, ALL or EXIT?"
      input = gets.strip
   
    elsif @cars.length >= 15 && @cars.length < 50
      length_split = (@cars.length / 2).round
      length_split_plus_one = length_split + 1
      length_split_plus_one = length_split_plus_one.to_s
      length_split = length_split.to_s

      puts "There are #{@cars_length} cars."
      puts "Which group of cars do wish to see? "
      puts "1-#{length_split}, #{length_split_plus_one}-#{@cars.length}, ALL or EXIT?"
      
      input = gets.strip
    end

    list_cars

    while input != "exit" do
      if input == "1"
        list_cars
        end
      
      puts "Which car do wish to see more info on or exit?(enter line number)"
      input = gets.strip
      end
  end


  def bid_you_adieu
    puts "Thanks for using this gem.  Have a great day!"
  end

end #of CLI class
