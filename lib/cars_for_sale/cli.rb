class CarsforSale::CLI

  def call
    menu
    bid_you_adieu
  end


  def get_cars
    @cars = CarsforSale::Car.scrape_srp
  end

  def get_a_car(a_car)
    CarsforSale::Car.scrape_vdp(a_car)
    a_car
  end

  def list_a_car(a_car)
    #outputs a given car object to the screen
    puts "Year: #{a_car.year}"  
    puts "Make: #{a_car.make}"
    puts "Model: #{a_car.model}"
    puts "Exterior Color: #{a_car.ext_color}"
    puts "Engine: #{a_car.engine}"
    puts "Transmission: #{a_car.transmission}"
    puts "Internet Price: #{a_car.price}"
    puts ""
    puts "Dealer Info:  #{a_car.dealer_name}"
    puts "              #{a_car.dealer_address}"
    puts "              #{a_car.dealer_phone}"

  end


  def list_cars(input = nil, length = nil, length_split = nil)
    if input.upcase == "ALL"
    @cars.each.with_index(1) do |srp_list,i|
          puts "#{i}. #{srp_list.year}  #{srp_list.make} #{srp_list.model} - #{srp_list.price}"
          puts ""
        end
    elsif input == "group_a"
        i= 0
        length_split -= 1
        while i <= length_split        
          puts "#{i + 1}. #{@cars[i].year}  #{@cars[i].make} #{@cars[i].model} - #{@cars[i].price}"
          puts ""
          i += 1
        end
    else
      i= length_split
      length -= 1
        while i <= length        
          puts "#{i + 1}. #{@cars[i].year}  #{@cars[i].make} #{@cars[i].model} - #{@cars[i].price}"
          puts ""
          i += 1
        end
    end #if
  end

  def menu
    get_cars
    input = nil
    puts "Welcome to Cars.com's cars for sale..."
    if @cars.length >= 50
      puts "There are 50+ cars.  You can view up to 50"
    puts "Which group of cars do wish to see? "
      puts "1-25, 26-50, ALL or EXIT?"
    elsif @cars.length >= 15 && @cars.length < 50
      length_full = @cars.length
      length_split = (length_full / 2).round
      length_split_plus_one = length_split + 1
      length_split_plus_one = length_split_plus_one.to_s
      length_split = length_split.to_s
      length_full = length_full.to_s
      group_a = "1-#{length_split}"
      group_b = "#{length_split_plus_one}-#{length_full}"
      puts "There are #{length_full} cars."
      puts "Which group of cars do wish to see? "
      puts "#{group_a}, #{group_b}, ALL or EXIT?"
    end

    input = gets.strip   
    input.upcase!
    while input != "EXIT" do
      if input == "ALL"
        list_cars(input)
      elsif input == group_a
          input = "group_a"
          list_cars(input, length_full.to_i, length_split.to_i)
      elsif input == group_b
        input = "group_b"
        list_cars(input, length_full.to_i, length_split.to_i)
      end
      puts "Which car do wish to see more info on (enter line number), list ALL partial or EXIT?"
      input = gets.strip
      input.upcase!
      if  input != "EXIT" && input != "ALL" && input != group_a && input != group_b
        puts "Calls VDP_scrapper to list vehicle details"
        input = input.to_i
        idx = input - 1
        get_a_car(@cars[idx])
        list_a_car(@cars[idx])
      end  
    end
  end


  def bid_you_adieu
    puts "Thanks for using this gem.  Have a great day!"
  end

end #of CLI class
