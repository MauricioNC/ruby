class Theater
  def initialize
    @room = Array.new(100) # Create bidimentional array for the theater room
    @sold = []

    print "Raising theater..."
    set_room() # Initializing the room with all the seating free
  end

  def menu
    system("cls")
    print "1.- Print seating map\n"
    print "2.- Sell tickets\n"
    print "3.- View count of sold tickets\n"
    print "4.- View number of free seating\n"
    print "0.- Leave\n"
    print "==========================\n"
    print "opt: "
    opt = gets.chomp.to_i
  end
  
  def start
    while true
      opt = menu

      case opt
      when 1
        print_room
      when 2
        reserve_seating
      when 3
        sold_seating
      when 4
        free_seating
      when 0
        exit(0)
      else
        print("\n\nInvalid option.")
      end
    end
  end

  def print_room
    print "\n\n"
    (0..99).step(10).each do |i| # Just formatting the view of the room in the console
      (i..i+9).each do |j|
        print "#{@room[j][:seat]}\t"
      end
      print "\n"
    end
    gets
  end

  private
  
  def reserve_seating
    system("cls")
    print "\n\nQuantity: "
    @reserve = gets.chomp.to_i
    
    while @reserve > 0
      print_room
      print "Choose the number of seating to reserve: "
      seat = gets.chomp.to_i
      
      validate_seating_disponibility seat
      
      @reserve -= 1
    end
  end
  
  # Validates if the seating choosed is out of range or if has already been taken

  def validate_seating_disponibility seat
    if seat < 1 || seat > 100 # out of range
      system("cls")
      print "\n\nThe chosen seat number does not exist"
      gets
    elsif !@sold.include? seat-1 
      set_room seat-1 # seat-1 is the index in the room array
      @sold.push(seat-1) # memoized array to save the seat sold
      print_room
    else
      system("cls")
      puts "\n\nThe seat number choosed is already been taken\n"
      gets
    end
  end

  def set_room index = nil
    unless index.nil? # if index existe, thats means a new ticket has been sold
      @room[index][:seat] = "X" # reserve the seat
    else # otherwise set the complete room to free
      @room.each_with_index do |val1, i| 
        @room[i] = {seat: "L-#{i+1}"}
      end
    end
  end

  def sold_seating
    print "\n\nThe room counts with #{@sold.count} sold tickets"
    gets
  end

  def free_seating
    print "\n\nThe room counts with #{@room.count - @sold.count} free tickets"
    gets
  end
end

theater = Theater.new
theater.start