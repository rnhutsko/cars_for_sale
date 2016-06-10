class CarsforSale::CLI

  def call
    menu
    bid_you_adieu
  end


  def get_cars
    @cars = CarsforSale::Car.scrape_srp
  end

  def get_a_car(a_car)
    #scrapes the VDP page for the given car object and updates 
    #car object with details and returns that updated car object
    CarsforSale::Car.scrape_vdp(a_car)
    a_car
  end

  def list_a_car(a_car)
    #outputs a given car object to the screen
    
  end


  def list_cars(input = nil)
    if input.upcase == "ALL"
    @cars.each.with_index(1) do |srp_list,i|
          puts "#{i}. #{srp_list.year}  #{srp_list.make} #{srp_list.model} - #{srp_list.price}"
          puts ""
        end
    elsif input == "group_a"
      puts "output first half of list"
    else
      puts "output last half of list"
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
      length_split = (@cars.length / 2).round
      length_split_plus_one = length_split + 1
      length_split_plus_one = length_split_plus_one.to_s
      length_split = length_split.to_s

      puts "There are #{@cars.length} cars."
      puts "Which group of cars do wish to see? "
      puts "1-#{length_split}, #{length_split_plus_one}-#{@cars.length}, ALL or EXIT?"
      

    end

    input = gets.strip   
    input.upcase!

    while input != "EXIT" do
      if input == "ALL"
        list_cars(input)
      elsif input == "1-#{length_split}"
          input = "group_a"
          list_cars(input)
      elsif input == "{length_split_plus_one}-#{@cars.length}"
        input = "group_b"
        list_cars(input)
      end
      
      puts "Which car do wish to see more info on, list ALL again or EXIT?(enter line number)"
      input = gets.strip
      input.upcase!
      if input == "ALL"
        list_cars(input)
      elsif input != "EXIT"
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
