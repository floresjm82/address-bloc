def greeting
	ARGV.each_with_index do |name, index|
		if index != 0
			puts "#{ARGV.first} #{name}"
		end
	end
end

greeting