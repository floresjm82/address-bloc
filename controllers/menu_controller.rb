# 1 - Includes AddressBook using require_relative
require_relative "../models/address_book.rb"

class MenuController

  attr_accessor :address_book

  def initialize
    @address_book = AddressBook.new
  end

  def main_menu
# 2 - Displays the main menu options to the command line
    puts "Main Menu - #{@address_book.entries.count} entries"
    puts "1 - View all entries"
    puts "2 - View a specific entry"
    puts "3 - Create an entry"
    puts "4 - Search for an entry"
    puts "5 - Import entries from a CSV"
    puts "6 - Delete all entries"
    puts "7 - Exit"
    print "Enter your selection: "

# 3 - Retrieves user input from the command line using gets.
    selection = gets.to_i
    puts "You picked #{selection}"

# 7 - Use a case statement operator to determine the proper response to the user's input

    case selection
    when 1
      system "clear"
      view_all_entries
      main_menu
    when 2
      system "clear"
      view_specific_entry
      main_menu
    when 3
      system "clear"
      create_entry
      main_menu
    when 4
      system "clear"
      search_entries
      main_menu
    when 5
      system "clear"
      read_csv
      main_menu
    when 6
      system "clear"
      delete_all_entries
      main_menu
    when 7
      puts "Good-bye!"
# 8 - Terminates the program using exit(0), signals the program is exiting without an error
      exit(0)
# 9 - Uses an else to catch invalid user input and prompts the user to retry
    else
      system "clear"
      puts "Sorry, that is not a valid input"
      main_menu
    end
  end

# 10 -Stubs the rest of the methods called in main_menu
   def view_all_entries
# 14 - iterates through all entries in AddressBook using each.
      @address_book.entries.each do |entry|
        system "clear"
        puts entry.to_s
# 15 - we call entry_submenu to display a submenu for each entry.
          entry_submenu(entry)
      end

      system "clear"
      puts "End of entries"
   end

   def view_specific_entry
     system "clear"
     puts "Please type the entry number you would like to view: "
     entry_number = gets.to_i
     puts @address_book.entries.fetch(entry_number) {|entry_number| "I'm sorry #{entry_number} is not a valid entry, please try again."}
   end


   def create_entry
# 11 - clears the screen
     system "clear"
     puts "New AddressBloc Entry"
# 12 - uses print to prompt the user for each Entry attribute
# print works just like puts except that it doesn't add a newline
     print "Name: "
     name = gets.chomp
     print "Phone number: "
     phone_number = gets.chomp
     print "Email: "
     email = gets.chomp

# 13 - adds a new entry to @address_book using add_entry to ensure that the new
#entry is added in the proper order.
     @address_book.add_entry(name,phone_number, email)

     system "clear"
     puts "New entry created"
   end

   def search_entries
# we get the name that the user wants to search for and store it in name.
     print "Search by name: "
     name = gets.chomp
=begin
We call search on address_book which will either return a match or nil, it will
never return an empty string since import_from_csv will fail if an entry does not
have a name.
=end
     match = @address_book.binary_search(name)
     system "clear"
=begin
we check if search returned a match. This expression evaluates to false if search
returns nil since nil evaluates to false in Ruby. If search finds a match then
we call a helper method called search_submenu. search_submenu displays a list of
operations that can be performed on a Entry. We want to give the user the ability
to delete or edit an entry as well as return to the main menu when a match is
found.
=end
     if match
       puts match.to_s
       search_submenu(match)
     else
       puts "No match found for #{name}"
     end
   end

   def read_csv
=begin
1 - We prompt the user to enter a name of a csv file to import. We get the
filename from STDIN and call the chomp method which removes newlines.
=end
    print "Enter CSV file to import: "
    file_name = gets.chomp
# 2 - we check to see if the file name is empty, if yes then back to main_menu
    if file_name.empty?
      system "clear"
      puts "No CSV file read"
      main_menu
    end
=begin
3 - we import the specificied file with import_from_csv on address_book. We then
clear the screen and print the number of entries that were read from the file.
All of these commands are wrapped in a begin/rescue block. Begin will protect
the program from crashing if an exception is thrown (like dividing a rational num
by zero). Our begin/rescue block catches potential exceptions and handles them
by printing an error message and calling import_from_csv again.
=end
    begin
      entry_count = @address_book.import_from_csv(file_name).count
      system "clear"
      puts "#{entry_count} new entries added from #{file_name}"
    rescue
      puts "#{file_name} is not a valid CSV file, please enter the name of a valid CSV file"
      read_csv
    end
  end

  def delete_entry(entry)
    @address_book.entries.delete(entry)
    puts "#{entry.name} has been deleted"
  end

  def delete_all_entries
    @address_book.entries.replace([])
    puts "All entries have been deleted."
  end

  def edit_entry(entry)
=begin
4 - We perform a series of print statement followed by gets.chomp assignment
statements. Each gets.chomp statement gathers user input and assigns it to an
appropriately named variable.
=end
    print "Updated name: "
    name = gets.chomp
    print "Updated phone number: "
    phone_number = gets.chomp
    print "Updated email: "
    email = gets.chomp
=begin
5 - we use !attribute.empty? to set attributes on entry only if a valid attribute
was read from user input.
=end
    entry.name = if !name.empty?
    entry.phone_number = phone_number if !phone_number.empty?
    entry.email = email if !email.empty?
    system "clear"
# 6 - we print out entry with the updated attributes
    puts "Updated entry: "
    puts entry
  end

  def search_submenu(entry)
# we print out the submenu for an entry
    puts "\nd - delete entry"
    puts "e - edit this entry"
    puts "m - return to main menu"
# we save the user input to selection
    selection = gets.chomp
=begin
we use a case statement and take a specific action based on user input. If the
user input is d we call delete_entry and after it returns we call main_menu. If
the input is e we call edit_entry. m will return the user to the main menu. If
the input does not match anything (see the else statement) then we clear the
screen and ask for their input again by calling search_submenu.
=end
    case selection
    when "d"
      system "clear"
      delete_entry(entry)
      main_menu
    when "e"
      edit_entry(entry)
      system "clear"
      main_menu
    when "m"
      system "clear"
      main_menu
    else
      system "clear"
      puts "#{selection} is not a valid input"
      puts entry.to_s
      search_submenu(entry)
    end
  end


   def entry_submenu(entry)
# 16 - displays the submenu options
     puts "\nn - next entry"
     puts "d - delete entry"
     puts "e - edit this entry"
     puts "m - return to main menu"
#17 - comp removes any trailing whitespace from the string gets returns
#this is necessary because "m" or "m/n" wont match "m".
     selection = $stdin.gets.chomp

     case selection
# 18 - when the user asks to see the next entry, we can do nothing and control
# will be returned to view_all_entries.
     when "n"
# 19 - we'll handle deleting and editing in another checkpoint, for now the user
# will be shown the next entry.
     when "d"
       delete_entry(entry)
     when "e"
       edit_entry(entry)
       entry_submenu(entry)
# 20 - we return the user the main menu.
     when "m"
       system "clear"
       main_menu
     else
       system "clear"
       puts "#{selection} is not a valid input"
       entries_submenu(entry)
     end
   end
end
end
