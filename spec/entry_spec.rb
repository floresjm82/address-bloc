require_relative '../models/entry.rb'

#1 We are saying that the file is a spec file and that it tests Entry
RSpec.describe Entry do
#2 We are saying that the specs in the context will test Entry attributes
  context "attributes" do
#3 We seperate our individual tests using the it method
    it "should respond to name" do
      entry = Entry.new('Ada Lovelace', '010.012.1815','augusta.king@lovelace.com')
#4 Each Rspec test ends with one or more expect method that we use to declare the expectations for the test
      expect(entry).to respond_to(:name)
    end

    it "should respond to phone number" do
      entry = Entry.new('Ada Lovelace', '010.012.1815','augusta.king@lovelace.com')
      expect(entry).to respond_to(:phone_number)
    end

    it "should respond to email" do
      entry = Entry.new('Ada Lovelace', '010.012.1815','augusta.king@lovelace.com')
      expect(entry).to respond_to(:email)
    end

  end
#5 We use a new context to seperate the to_s test from the initializer tests
  context "#to_s" do
    it "prints an entry as a string" do
      entry = Entry.new('Ada Lovelace', '010.012.1815','augusta.king@lovelace.com')
      expected_string = "Name: Ada Lovelace\nPhone Number: 010.012.1815\nEmail: augusta.king@lovelace.com"
#6 We use eq to check that to_s returns a string equal to expected_string
      expect(entry.to_s).to eq(expected_string)
    end
  end

end
