require_relative 'RPN_Calculator'

class RPN_Client
    include RPN_Calculator
    
# @param input [StringIO] the designate user input source
# @param output [StringIO] the Designate console output destination
    def initialize(input: $stdin, output: $stdout)
        @input, @output = input, output

        initialise_calculator
    end

# @return [Object]
    def solicit_multiline_input
        @output.puts "Please provide RPN expression. Type '=' and hit return to submit."
        @output.flush

        loop do
            expression = @input.gets("=\n").to_s.chomp("=\n").split

            unless expression.empty?
                valid_input = parse_input(expression)

                if valid_input
                    @output.puts valid_input

                    return valid_input
                end
            end

            @output.puts "\nError! Only valid operations and numbers allowed!"
            @output.puts "Please provide RPN expression. Type '=' and hit return to submit."
            @output.flush
        end
    end
end

if __FILE__ == $0
    client = RPN_Client.new
    client.solicit_multiline_input
end
