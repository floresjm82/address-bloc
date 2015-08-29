# 8 We tell Ruby to load the library named entry.rb relative to address_book.rb's file path using require_relative
  require_relative "entry.rb"
  require "csv"

class AddressBook

    attr_accessor :entries

    def initialize
      @entries = []
    end

    def add_entry(name, phone_number, email)
#9 We create a variable to store the insertion index.
      index = 0
      @entries.each do |entry|
#10 We compare name with the name of the current entry.  If name
#lexicographically proceeds entry.name, we've found the index to insert at.
#Otherwise we increment index and continue comparing with the other entries.
        if name < entry.name
          break
        end
      index += 1
      end
#11 We insert a new entry into entries using the caluclated index.
      @entries.insert(index, Entry.new(name, phone_number, email))
  end
=begin
7 - We defined import_from_csv. The method starts by reading the file, using
File.read. The file will be in a csv format. We use the csv class to parse the
file. The result of csv.parse is an object of type csv::Table.
=end
  def import_from_csv(file_name)
    csv_text = File.read(file_name)
    csv = CSV.parse(csv_text, headers: true, skip_blanks: true)
=begin
8 - we iterate over the CSV::Table object's rows. On the next line we create a
hash for each row. We convert each row_hash to an Entry by using the add_entry
method which will also add the Entry to the AddressBook's entries.
=end
    csv.each do |row|
      row_hash = row.to_hash
      add_entry(row_hash["name"], row_hash ["phone_number"], row_hash["email"])
    end
  end


  def remove_entry(name, phone_number, email)
    @entries.delete_if {|entry| entry.name == name}
  end

# Search AddressBook for a specific entry by name
  def binary_search (name)
=begin
1 - We save the index of the leftmost item in the array in a variable named
lower, and the index of rightmost item in the array in upper. If we think of the
array in terms of left-to-right where the leftmost item is the zeroth index and
the rightmost item is the entries.length-1 index.
=end
    lower = 0
    upper = entries.length - 1
# 2 we loop wheil our lower index is less than or equal to our upper index
    while lower <= upper
=begin
3 - we find the middle index by taking the sum of lower and upper and dividing it
by two. Ruby will truncate any decimal numbers, so if upper is five and lower is
zero, then mid will get set to two. Then we retrieve the name of the entry at
the middle index and store it in mid_name.
=end
      mid = (lower + upper) / 2
      mid_name = entries[mid].name
=begin
4 - we compare the name that we are searching for, name, to the name of the middle
index, mid_name. Take note that we are using the == operator when comparing the
names which makes the search case sensative
=end
      if name == mid_name
        return entries[mid]
      elsif name < mid_name
        upper = mid -1
      elsif name > mid_name
        lower = mid + 1
      end
    end
# 5 - if we divide and conquer to the point where no match is found, we simply return nil.
    return nil
  end

  def iterative_search (name)
    @entries.each do |entry|
      if entry.name == name
        return entry
      end
    end
    return nil
  end


end
