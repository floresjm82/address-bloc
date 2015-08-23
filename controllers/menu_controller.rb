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
   puts "6 - Exit"
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

   end

   def read_csv

   end

   def entry_submenu(entry)
# 16 - displays the submenu options
     puts "n - next entry"
     puts "d - delete entry"
     puts "e - edit this entry"
     puts "m - return to main menu"
#17 - comp removes any trailing whitespace from the string gets returns
#this is necessary because "m" or "m/n" wont match "m".
     selection = gets.chomp

     case selection
# 18 - when the user asks to see the next entry, we can do nothing and control
# will be returned to view_all_entries.
     when "n"
# 19 - we'll handle deleting and editing in another checkpoint, for now the user
# will be shown the next entry.
     when "d"
     when "e"
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
