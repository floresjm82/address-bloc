require_relative '../models/address_book.rb'

RSpec.describe AddressBook do
=begin
1 - creates a new instance of the AddressBook model and assigns it to the book
using the let syntax provided by RSpec.  This lets us use book in all our tests,
removing the duplicaiton of having to instantiate a new AddressBook for each test.
=end
    let(:book) {AddressBook.new}
=begin
2 - we see context and it statements which are an RSpec paradigm to explain what
we are testing.  it expalins the functionality of the method being tested in
human readable form. RSpec will take the content from context and it and output
them nicely to the command line when the test is executed.
=end

=begin
6 - we created a helper method named check_entry which consolidates the redundant
code. We can now pass in the particular name, phone number, and email we want into
this reusable helper method.  WE have our basic tests set up. The next step is to
build the implentation of the import_from_csv method.
=end
    def check_entry(entry, expected_name, expected_phone_number, expected_email)
      expect(entry.name).to eql expected_name
      expect(entry.phone_number).to eql expected_phone_number
      expect(entry.email).to eql expected_email
    end


  context "attributes" do

    it "should respond to entries" do
      expect(book).to respond_to(:entries)
    end

    it "should initialize entries as an array" do
      expect(book.entries).to be_a(Array)
    end

    it "should initialize entries as empty" do
      expect(book.entries.size).to eq 0
    end

  end

  context "#add_entry" do

    it "adds only one entry to the address book" do
      book.add_entry('Ada Lovelace', '010.012.1815','augusta.king@lovelace.com')
      expect(book.entries.size).to eq 1
    end

    it "adds the correct information to entries" do
      book.add_entry('Ada Lovelace', '010.012.1815','augusta.king@lovelace.com')
      new_entry = book.entries[0]

      expect(new_entry.name).to eq 'Ada Lovelace'
      expect(new_entry.phone_number).to eq '010.012.1815'
      expect(new_entry.email).to eq 'augusta.king@lovelace.com'
    end

  end

  context "#remove_entry" do

    it "removes only one entry to the address book" do
      book.add_entry('Tsubasa', '001.011.111','tsubasa@soccer.com')

      expect(book.entries.size).to eq 1
      book.remove_entry('Tsubasa', '001.011.111','tsubasa@soccer.com')
      expect(book.entries.size).to eq 0

    end
  end
# tests that AddressBook's .import_from_csv() method is working as expected
  context ".import_from_csv" do

    it "imports the correct number of entries" do
=begin
3 - after the context and it statements we call the import_from_csv method on
the book object which is of type AddressBook (our data model). We pass
import_from_csv the string entries.csv as a parameter. csv files are a fairly
typical way of dealing with data. On the next line we refrence the AddressBook.entries
variable to get its size.  This variable will be an array. Next we save the size
of the AddressBook.entries to our local variable book_size.
=end
      book.import_from_csv("entries.csv")
      book_size = book.entries.size

      # check the size of the entries in AddressBook
      expect(book_size).to eql 5

    end

#4 - we access the first entry in the array of entries that our AddressBook stores.
    it "imports the 1st entry" do
      book.import_from_csv("entries.csv")
      # check the first entry
      imported_entry = book.entries[0]
      check_entry(imported_entry, "Bill", "555-555-4854", "bill@blocmail.com")
=begin
5 - we've added three "expect"s to verify that the first entry has the name,
the phone number, and the email.  This will still fail however as there are 5
entries that are expected.  To prevent redundancy however we can write the
following check_entry method instead and comment out code listed below.
      expect(entry_one.name).to eql "Bill"
      expect(entry_one.phone_number).to eql "555-555-4854"
      expect(entry_one.email).to eql "bill@blocmail.com"
=end
    end

    it "imports the 2nd entry" do
      book.import_from_csv("entries.csv")
      imported_entry = book.entries[1]
      check_entry(imported_entry, "Bob", "555-555-5415", "bob@blocmail.com")
    end

    it "imports the 3rd entry" do
      book.import_from_csv("entries.csv")
      imported_entry = book.entries[2]
      check_entry(imported_entry, "Joe", "555-555-3660", "joe@blocmail.com")
    end

    it "imports the 4th entry" do
      book.import_from_csv("entries.csv")
      imported_entry = book.entries[3]
      check_entry(imported_entry, "Sally", "555-555-4646", "sally@blocmail.com")
    end

    it "imports the 5th entry" do
      book.import_from_csv("entries.csv")
      imported_entry = book.entries[4]
      check_entry(imported_entry, "Sussie", "555-555-2036", "sussie@blocmail.com")
    end

# Check for on a second CSV file
    it "imports the correct number of entries for the second CSV file" do

      book.import_from_csv("entries_2.csv")
      book_size = book.entries.size

      expect(book_size).to eql 3
    end

    it "imports the 1st entry in the second CSV file" do
      book.import_from_csv("entries_2.csv")
      imported_entry = book.entries[0]
      check_entry(imported_entry, "Jorge", "000-000-001", "jorge@blocmail.com")
    end

    it "imports the 2nd entry in the second CSV file" do
      book.import_from_csv("entries_2.csv")
      imported_entry = book.entries[1]
      check_entry(imported_entry, "Miguel", "000-000-002", "miguel@blocmail.com")
    end

    it "imports the 3rd entry in the second CSV file" do
      book.import_from_csv("entries_2.csv")
      imported_entry = book.entries[2]
      check_entry(imported_entry, "Robert", "000-000-003", "robert@blocmail.com")
    end



  end

# Tests the binary_search method
  context "#binary_search" do

    it "searches AddressBook for a non-existent entry" do
      book.import_from_csv("entries.csv")
      entry = book.binary_search("Dan")
      expect(entry).to be_nil
    end

    it "searches AddressBook for Bill" do
      book.import_from_csv("entries.csv")
      entry = book.binary_search("Bill")
      expect entry.instance_of?(Entry)
      check_entry(entry, "Bill", "555-555-4854", "bill@blocmail.com")
    end

    it "searches AddressBook for Bob" do
       book.import_from_csv("entries.csv")
       entry = book.binary_search("Bob")
       expect(entry).to be_a Entry
       check_entry(entry, "Bob", "555-555-5415", "bob@blocmail.com")
     end

     it "searches AddressBook for Joe" do
       book.import_from_csv("entries.csv")
       entry = book.binary_search("Joe")
       expect(entry).to be_a Entry
       check_entry(entry, "Joe", "555-555-3660", "joe@blocmail.com")
     end

     it "searches AddressBook for Sally" do
       book.import_from_csv("entries.csv")
       entry = book.binary_search("Sally")
       expect(entry).to be_a Entry
       check_entry(entry, "Sally", "555-555-4646", "sally@blocmail.com")
     end

     it "searches AddressBook for Sussie" do
       book.import_from_csv("entries.csv")
       entry = book.binary_search("Sussie")
       expect(entry).to be_a Entry
       check_entry(entry, "Sussie", "555-555-2036", "sussie@blocmail.com")
     end

     it "searches AddressBook for Billy" do
       book.import_from_csv("entries.csv")
       entry = book.binary_search("Billy")
       expect(entry).to be_nil
    end

  end
# tests Iterative Search method
  context "#iterative_search" do

    it "searches AddressBook for a non-existent entry" do
      book.import_from_csv("entries.csv")
      entry = book.iterative_search("Dan")
      expect(entry).to be_nil
    end

    it "searches AddressBook for Bill" do
      book.import_from_csv("entries.csv")
      entry = book.iterative_search("Bill")
      expect entry.instance_of?(Entry)
      check_entry(entry, "Bill", "555-555-4854", "bill@blocmail.com")
    end

    it "searches AddressBook for Bob" do
       book.import_from_csv("entries.csv")
       entry = book.iterative_search("Bob")
       expect(entry).to be_a Entry
       check_entry(entry, "Bob", "555-555-5415", "bob@blocmail.com")
     end

     it "searches AddressBook for Joe" do
       book.import_from_csv("entries.csv")
       entry = book.iterative_search("Joe")
       expect(entry).to be_a Entry
       check_entry(entry, "Joe", "555-555-3660", "joe@blocmail.com")
     end

     it "searches AddressBook for Sally" do
       book.import_from_csv("entries.csv")
       entry = book.iterative_search("Sally")
       expect(entry).to be_a Entry
       check_entry(entry, "Sally", "555-555-4646", "sally@blocmail.com")
     end

     it "searches AddressBook for Sussie" do
       book.import_from_csv("entries.csv")
       entry = book.iterative_search("Sussie")
       expect(entry).to be_a Entry
       check_entry(entry, "Sussie", "555-555-2036", "sussie@blocmail.com")
     end

     it "searches AddressBook for Billy" do
       book.import_from_csv("entries.csv")
       entry = book.iterative_search("Billy")
       expect(entry).to be_nil
     end

   end




end
