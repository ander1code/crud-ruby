
require_relative 'src/crud'

def printmessage(method, result)
  if method.equal? 1
    if result.equal? 1
      puts "Successfully registered."
    end
    if result.equal? -1
      puts "Error registering."
    end
    if result.equal? 0
      puts "No records added."
    end
  end

  if method.equal? 2
    if result.equal? 1
      puts "Edited successfully."
    end
    if result.equal? -1
      puts "Error editing."
    end
    if result.equal? 0
      puts "No records edited."
    end
  end

  if method.equal? 3
    if result.equal? 1
      puts "Deleted successfully."
    end
    if result.equal? -1
      puts "Error deleting."
    end
    if result.equal? 0
      puts "No records deleted."
    end
  end

  if method.equal? 4
    if result.equal? 0
      puts "No record found with this name."
    end
  end

  if method.equal? 5
    if result.equal? 0
      puts "No record found with this ID."
    end
  end
end

def validatedata(*args)

  puts "\n"

  @result = true

  _name="#{args[0]}"
  _email="#{args[1]}"
  _salary="#{args[2]}"
  _birthday="#{args[3]}"
  _gender="#{args[4]}"

  if _name.empty?
    @result = false
    puts ' - Name is empty.'
  else
    if _name.length < 3 && _name.length < 1
      @result = false
      puts ' - Invalid character quantity for name.'
    end
  end

  if _email.empty?
    @result = false
    puts ' - Email is empty.'
  else
    if !_email.match('[a-z0-9]+[_a-z0-9\.-]*[a-z0-9]+@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,4})')
      @result = false
      puts ' - Invalid email.'
    end
  end

  def is_float?(fl)
    !!Float(fl) rescue false
  end

  if _salary.empty?
    @result = false
    puts ' - Salary is empty.'
  else
    if !is_float?(_salary)
      @result = false
      puts ' - Invalid salary.'
    else
      if _salary.to_f < 0
        @result = false
        puts ' - Salary can\'t be below zero.'
      end
    end
  end

  if _birthday.empty?
    @result = false
    puts ' - Birthday is empty.'
  else
    begin
      Date.parse _birthday
    rescue
      @result = false
      puts ' - Invalid birthday.'
    end
  end

  '' '
  if _gender.empty?
    @result = false
    puts  - Gender is empty.
  else
    if !(_gender == M)
      if !(_gender == F)
        @result = false
        puts  - Invalid gender.
      end
    end
  end
  ' ''
end


def insert_physicalperson
  puts "----------------------------------------|"
  puts "INSERT PHYSICAL PERSON                  |"
  puts "----------------------------------------|"
  print "Name: "
  _name = gets.chomp
  print "Email: "
  _email = gets.chomp
  print "Salary: "
  _salary = gets.chomp
  print "Birthday (Ex: 1981-11-12): "
  _birthday = gets.chomp
  print "Gender (M or F): "
  _gender = gets.chomp
  valid = validatedata(name=_name, email=_email, salary=_salary, birthday=_birthday, gender=_gender)
  if valid
    result = Crud.insert_physicalperson(name=_name, email=_email, salary=_salary, birthday=_birthday, gender=_gender)
    puts "\n----------------------------------------|"
    printmessage(1, result)
    puts "----------------------------------------|\n\n"
  else
    puts "\n----------------------------------------|"
    printmessage(1, 0)
    puts "----------------------------------------|\n\n"
  end
end


def delete_physicalperson
  puts "----------------------------------------|"
  puts "DELETE PHYSICAL PERSON                  |"
  puts "----------------------------------------|"
  print "ID: "
  _id = gets.chomp
  row = Crud.get_physicalperson_by_id(_id)
  begin
    if !row.nil?
      pp = row.next
      puts "Nome: " + pp[1]
      puts "Email: " + pp[2]
      puts "Salary: " + pp[5].to_s
      puts "Birthday: " + pp[6].to_s
      puts "Gender: " + pp[7]
      row.close
      puts "----------------------------------------|"
      print "Do you want delete this record?(1 = YES | 0 = NO): "
      _opc = gets.chomp
      if _opc == '1'
        result = Crud.delete_physicalperson(_id)
        puts "\n----------------------------------------|"
        printmessage(3, result)
        puts "----------------------------------------|\n\n"
      else
        puts "\n----------------------------------------|"
        printmessage(3, 0)
        puts "----------------------------------------|\n\n"
      end
    else
      puts "\n----------------------------------------|"
      printmessage(5, 0)
      puts "\n----------------------------------------|"
    end
  rescue Exception
    puts "\n----------------------------------------|"
    printmessage(5, 0)
    puts "\n----------------------------------------|"
  end
end


def edit_physicalperson
  puts "----------------------------------------|"
  puts "EDIT PHYSICAL PERSON                    |"
  puts "----------------------------------------|"
  print "ID: "
  _id = gets.chomp
  row = Crud.get_physicalperson_by_id(_id)
  begin
    if !row.nil?
      pp = row.next
      puts "Nome: " + pp[1]
      puts "Email: " + pp[2]
      puts "Salary: " + pp[5].to_s
      puts "Birthday: " + pp[6].to_s
      puts "Gender: " + pp[7]
      row.close
      puts "\n----------------------------------------|"
      puts "NEW DATA FOR THIS RECORD:"
      puts "----------------------------------------|"
      print "Name: "
      _name = gets.chomp
      print "Email: "
      _email = gets.chomp
      print "Salary: "
      _salary = gets.chomp
      print "Birthday (Ex: 1981-11-12): "
      _birthday = gets.chomp
      print "Gender (M or F): "
      _gender = gets.chomp
      valid = validatedata(name=_name, email=_email, salary=_salary, birthday=_birthday, gender=_gender)
      if valid
        result = Crud.edit_physicalperson(id=_id, name=_name, email=_email, salary=_salary, birthday=_birthday, gender=_gender)
        puts "\n----------------------------------------|"
        printmessage(2, result)
        puts "----------------------------------------|\n\n"
      else
        puts "\n----------------------------------------|"
        printmessage(2, 0)
        puts "----------------------------------------|\n\n"
      end
    else
      puts "\n----------------------------------------|"
      printmessage(5, 0)
      puts "\n----------------------------------------|"
    end
  rescue Exception
    puts "\n----------------------------------------|"
    printmessage(5, 0)
    puts "\n----------------------------------------|"
  end
end


def get_physicalperson_by_id
  puts "----------------------------------------|"
  puts "GET PHYSICAL PERSON BY ID               |"
  puts "----------------------------------------|"
  print "ID: "
  _id = gets.chomp
  row = Crud.get_physicalperson_by_id(_id)
  begin
    if !row.nil?
      pp = row.next
      puts "Nome: " + pp[1]
      puts "Email: " + pp[2]
      puts "Salary: " + pp[5].to_s
      puts "Birthday: " + pp[6].to_s
      puts "Gender: " + pp[7]
      row.close
      puts "----------------------------------------|"
      puts "\n\n"
    end
  rescue Exception
    row.close
    puts "----------------------------------------|"
    printmessage(5, 0)
    puts "----------------------------------------|\n\n"
  end
end

def get_physicalperson_by_name
  begin
    puts "----------------------------------------|"
    puts "GET PHYSICAL PERSON BY NAME             |"
    puts "----------------------------------------|"
    begin
      print "NAME: "
      _name = gets.chomp
      row = Crud.get_physicalperson_by_name(_name)
    rescue
      row = Crud.get_physicalperson_by_name('')
    end
    if !row.nil?
      while (pp = row.next) do
        puts "----------------------------------------|"
        puts "Nome: " + pp[1]
        puts "Email: " + pp[2]
        puts "Salary: " + pp[5].to_s
        puts "Birthday: " + pp[6].to_s
        puts "Gender: " + pp[7]
      end
      row.close
      puts "----------------------------------------|"
      puts "\n\n"
    end
  rescue Exception
    row.close
    puts "----------------------------------------|"
    printmessage(4, 0)
    puts "----------------------------------------|\n\n"
  end
end

opc = 1
while opc != 0
  puts "########################################|"
  puts " REGISTRATION PHYSICAL PERSON           |"
  puts "########################################|"
  puts " 1 - INSERT PHYSICAL PERSON             |"
  puts " 2 - EDIT PHYSICAL PERSON               |"
  puts " 3 - DELETE PHYSICAL PERSON             |"
  puts " 4 - GET PHYSICAL PERSON BY NAME        |"
  puts " 5 - GET PHYSICAL PERSON BY ID          |"
  puts " 0 - FINISH                             |"
  puts "########################################|\n"
  print "Enter your option: "
  opc = gets.chomp
  case opc
    when '1'
      insert_physicalperson
    when '2'
      edit_physicalperson
    when '3'
      delete_physicalperson
    when '4'
      get_physicalperson_by_name
    when '5'
      get_physicalperson_by_id
    else
      print "FINISH!"
      opc = 0
  end
end