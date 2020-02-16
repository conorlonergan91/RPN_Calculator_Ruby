require_relative 'RPN_Calculator'

class RPN_Client
    include RPN_Calculator

    def initialize(input: $stdin, output: $stdout)
        @input, @output = input, output
    end

    def solicit_multiline_input
        @output.puts "Please provide RPN expression. Type '=' and hit return to submit."
        @output.flush
        valid_input = parse_input
        until valid_input
            @output.puts "\nError! Only valid operations and numbers allowed!"
            @output.puts "Please provide RPN expression. Type '=' and hit return to submit."
            @output.flush
            valid_input = parse_input
        end
        @output.puts valid_input
        valid_input
    end
end
if __FILE__ == $0
    client = RPN_Client.new
    client.solicit_multiline_input
    puts RPN_Calculator.constants(false)
end