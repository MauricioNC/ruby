class Teatro
  def initialize
    @sala = Array.new(100)
    @vendidos = []

    print "Raising theater..."
    set_sala()
  end

  def menu
    system("cls")
    print "1.- Ver mapa de asientos\n"
    print "2.- Vender boletos\n"
    print "3.- Ver cantidad de boletos vendidos\n"
    print "4.- Ver cantidad de boletos libres\n"
    print "0.- Salir\n"
    print "==========================\n"
    print "opt: "
    opt = gets.chomp.to_i
  end
  
  def start
    while true
      opt = menu

      case opt
      when 1
        print_sala
      when 2
        reservar_asiento
      when 3
        boletos_vendidos
      when 4
        boletos_libres
      when 0
        exit(0)
      else
        print("\n\nOpcion incorrecta.")
      end
    end
  end

  def print_sala
    print "\n\n"
    (0..99).step(10).each do |i|
      (i..i+9).each do |j|
        print "#{@sala[j][:asiento]}\t"
      end
      print "\n"
    end
    gets
  end

  private
  
  def reservar_asiento
    system("cls")
    print "\n\nCantidad: "
    @reservar = gets.chomp.to_i
    
    while @reservar > 0
      print_sala
      print "Elige el numero de asiento a reservar: "
      asiento = gets.chomp.to_i
      
      validar_asiento_diponible asiento
      
      @reservar -= 1
    end
  end
  
  def validar_asiento_diponible asiento
    if asiento < 1 || asiento > 100
      system("cls")
      print "\n\nEl numero de asiento elegido no existe"
      gets
    elsif !@vendidos.include? asiento-1
      set_sala asiento-1
      @vendidos.push(asiento-1)
      print_sala
    else
      system("cls")
      puts "\n\nEl asento elegido ya ha sido ocupado\n"
      gets
    end
  end

  def set_sala index = nil
    unless index.nil?
      @sala[index][:asiento] = "X"
    else
      @sala.each_with_index do |val1, i|
        @sala[i] = {asiento: "L-#{i+1}"}
      end
    end
  end

  def boletos_vendidos
    print "\n\nLa sala cuenta con #{@vendidos.count} boletos vendidos"
    gets
  end

  def boletos_libres
    print "\n\nLa suela cuenta con #{@sala.count - @vendidos.count} boletos libres"
    gets
  end
end

teatro = Teatro.new
teatro.start