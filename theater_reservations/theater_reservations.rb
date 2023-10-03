=begin
  Theater romm

  Problem descripton: 
  Supose a system of seating reserves for a theater. The theater counts with 10 rows with 10 seating each one. It needs to devlop a system (without data bases, only data management in logic form) that allows the next:

    1. Load the "map" of the seating. Indicating with an 'X' the seats reserved and with an 'L' the free seats. At the start of the program, all the seats must be free.

    2. Manage the reserve of seats keeping in mind that one seat ONLY CAN BE RESERVED if is free ("L"), in case of the seat is reserved ("X"), the system must be allow choose another seat.
    If the seat is free ("L"), it must be change to reserved ("X") in that momment.

    3. To leave the program, is necessary to press a key (you can choose the key to leave). Keep in mind that there is no limit number of times to execute the program.

    4. Keep in mind that ONLY EXIST 10 ROWS and 10 SEATS. It can't be sell seats out of that range.

    * Considerations *: It is not necessary the GUI implementation or DB.
    * Bonus *: In case of the client request to view the free seats, the system must be show in a formatted way the map of free seats, remember, DON'T USE GUI to this exercise.
  
=end

class Theater
  def initialize
    @room = Array.new(100) # Create bidimentional array for the theater room
    @sold = []

    print "Raising theater..."
    set_room() # Initializing the room with all the seats free
  end

  def menu
    system("cls")
    print "1.- Print seating map\n"
    print "2.- Sell tickets\n"
    print "3.- View count of sold tickets\n"
    print "4.- View number of free seats\n"
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
        reserve_seats
      when 3
        sold_seats
      when 4
        free_seats
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
  
  def reserve_seats
    system("cls")
    print "\n\nQuantity: "
    @reserve = gets.chomp.to_i
    
    while @reserve > 0
      print_room
      print "Choose the number of seats to reserve: "
      seat = gets.chomp.to_i
      
      validate_seats_disponibility seat
      
      @reserve -= 1
    end
  end
  
  # Validates if the seat choosed is out of range or if has already been taken

  def validate_seats_disponibility seat
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

  def sold_seats
    print "\n\nThe room counts with #{@sold.count} sold tickets"
    gets
  end

  def free_seats
    print "\n\nThe room counts with #{@room.count - @sold.count} free tickets"
    gets
  end
end

theater = Theater.new
theater.start