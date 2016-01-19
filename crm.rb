# Add any require_relative statements here
require_relative 'contact.rb'
require 'pry'

class CRM
attr_accessor :contact, :attribute_select

  def self.run(name)
    # Implement this method
  end

  def initialize

  end

  def main_menu
    # Implement this method
    while true
      print_main_menu
      user_selected = gets.to_i
      puts ""
      call_option(user_selected)
    end
  end

  def print_main_menu
    system "clear"
    puts '[1] Add a new contact'
    puts '[2] Modify an existing contact'
    puts '[3] Delete a contact'
    puts '[4] Display all the contacts'
    puts '[5] Search by attribute'
    puts '[6] Exit'
  end

  def call_option(choice)
    case choice
    when 1 then add_new_contact
    when 2 then modify_existing_contact
    when 3 then delete_contact
    when 4 then display_all_contacts
    when 5
puts <<EOF
******Search Contacts by Attribute*******

Which attribute would you like to search by?
Select by letter (a,b,c,d) and press enter.

a. First Name
b. Last Name
c. Email
d. Note
EOF
#Lines 56-58 shows how to hide user input on screen
#$stdin.gets does not show input on screen
system 'stty -echo'
user_select = $stdin.gets.chomp.to_s
system 'stty echo'
puts ""
search_by_attribute_select(user_select)

      case @search_select
      when 'first_name'
          puts "Enter First Name"
      when 'last_name'
          puts "Enter Last Name"
      when 'email'
          puts "Enter Email"
      when 'note'
          puts "Enter Note"
      end


      attribute_value = gets.chomp.to_s
      puts ""
      search_by_attribute(attribute_value)
    when 6
      puts "Thanks for playing"
      exit
    end
  end

  def add_new_contact
    puts "First Name"
    first_name = gets.chomp.to_s

    puts "Last Name"
    last_name = gets.chomp.to_s

    puts "email"
    email = gets.chomp.to_s

    puts "Note"
    note = gets.chomp.to_s

    new_contact = Contact.create(first_name, last_name, email: email, note: note)
  end

  def modify_existing_contact
    puts "******Modify Existing Contact******\n\r"
    # Implement this method
    # 1. Show List of Contacts
    display_contacts
    # 2. Ask user to select a contact
    puts "Select User by id"
    id = gets.chomp.to_i
    # 3. Load instance variable
    @contact = Contact.get(id)
    puts "#{@contact.first_name}"
    # 4. Display all instance variable attributes
    # 5. Ask user which attribute they want to modify
    #Search for EOF for multiple ways to input text
    #Search ascii art you can copy and paste ascii generator

puts <<EOF
"Which attribute would you like to modify?"
"(Select by letter)"
EOF
puts <<EOF
"a. First Name"
"b. Last Name"
"c. Email"
"d. Note"
EOF
    #Alternative to gets
    #Google ARGV vs Gets
    attribute_select = gets.chomp.to_s
    modify_attribute_select(attribute_select)
    new_attribute_value
    # 6. Ask user to input new value for the attribute
  end

  def modify_attribute_select(attr)
    attr.downcase
    case attr
    when "a"
      @attribute_select = "first_name"
    when "b"
      @attribute_select = "last_name"
    when "c"
      @attribute_select = "email"
    when "d"
      @attribute_select = "note"
    end
  end

  def new_attribute_value
    puts "Please enter a new value for #{@attribute_select}"
    new_value = gets.chomp.to_s
    @contact.send("#{@attribute_select}=", "#{new_value}")
    puts "Updated attribute!"
    p @contact
    wait_for_input
  end

  def delete_contact
    puts "******Delete Contact*****\n\r"
    display_contacts
    puts"Select contact to delete by id number(1,2,3...)"
    id = gets.chomp.to_i
    Contact.all.delete_if{|i| i.id == id}
    puts "Contact Deleted!\n\r"
    puts "Here is your contact list now"
    display_all_contacts
  end

  def display_all_contacts
    # Implement this method
    # HINT: Make use of the display_contacts method
    #Calls the all method on the Contact class
    #The Contact class is available because we put require_relative 'contact.rb'
    #At the top of this file
    #This returns an array of objects
    #We then iterate over the array
    #Printing out all entries.
    #binding.pry
    # Contact.all.each do |contact|
    #   puts "#{contact.id} #{contact.full_name} #{contact.email} #{contact.note}"
    # end
    # puts "******Display All Contacts******\n\r"
    # Contact.all.each {|i| puts "#{i.id}: #{i.first_name}, #{i.last_name}, #{i.email}, #{i.note}"}
    display_contacts
    puts ""
    wait_for_input
  end

  def search_by_attribute(attribute)
    # Implement this method
    # HINT: Make use of the display_contacts method
    # Contact.select{|instance| instance.send("#{@search_select}") == attribute}
    # Must use p or puts to pull the array out of memory and print it in the console
    # the #select method returns an empty array if the block returns false
    matches = Contact.all.select{|instance| instance.send("#{@search_select}") == attribute}
      if matches == []
        puts "There are no contacts that match!"
        puts ""
      else
      puts "Here are all the contacts with that attribute:"
      matches.each {|i| puts "#{i.id}: #{i.first_name}, #{i.last_name}, #{i.email}, #{i.note}"}
      puts ""
      end
    wait_for_input
  end

  def search_by_attribute_select(attr)
    attr.downcase
    case attr
    when "a"
      @search_select = "first_name"
    when "b"
      @search_select = "last_name"
    when "c"
      @search_select = "email"
    when "d"
      @search_select = "note"
    end
  end

  def display_contacts
    # Implement this method
    # HINT: Make use of this method in the display_all_contacts and search_by_attribute methods
    Contact.all.each {|i| puts "#{i.id}: #{i.first_name}, #{i.last_name}, #{i.email}, #{i.note}"}
    puts ""
  end

  # Add other methods here, if you need them.

  def wait_for_input
    answer = ""
    while (answer != 'y') && (answer != 'n')
        puts "Do more stuff?(y/n)"
        answer = gets.chomp.to_s.downcase
    end

    if answer == 'n'
      puts "Thanks for playing!"
      exit
    elsif answer == 'y'
      main_menu
    else
      puts "Junk input, back to main menu"
    end
  end

end

crm = CRM.new
Contact.create("Matthew", "Smith", email: "msmithros@hotmail.com", note: "note")
Contact.create("Matthew", "Smith", email: "msmithros@hotmail.com", note: "note")
Contact.create("Matthew", "Smith", email: "msmithros@hotmail.com", note: "note")
Contact.create("Matthew", "Smith", email: "msmithros@hotmail.com", note: "note")
crm.main_menu
# Run the program here (See 'Using a class method`)
