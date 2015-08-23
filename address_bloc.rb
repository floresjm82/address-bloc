require_relative "controllers/menu_controller.rb"


# 4 - Creates a new MenuController when AddressBloc starts
menu = MenuController.new
# 5 - Uses sytem "clear" to clear the command line
system "clear"
puts "Welcome to AddressBloc!"
# 6 - Calls main_menu to display the menu
menu.main_menu
