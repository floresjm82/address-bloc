def greeting
  ARGV.each_with_index do |name, index|
  greet = ARGV[0]
    if index != 0
      puts "#{greet} #{name}"
    end
  end
end

greeting
