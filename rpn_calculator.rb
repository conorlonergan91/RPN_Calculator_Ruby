#
# Write a Ruby module that implements a simple RPN calculator, without using 'eval'. The implementation should evaluate
# expressions provided in Reverse Polish (Postfix) Notation. For example:
# 1 1 + 3 * 2 - 3 * = 12 212+*=6
# The module should at a minimum implement addition, subtraction, multiplication and division and should round ​answers
# to three decimal places using the following rule:
# If the value of the digit in the fourth decimal place is less than 5, then truncate the result after the third decimal
# place. If the digit in the fourth decimal place is 5 or greater, then round up.
# Provide a client for the implementation that solicits multi-line user input at a prompt and uses the implementation to
# evaluate expressions. The user should be able to split the expression over a number of lines, with the final result
# displayed only when the user enters a line ending with ‘=’.
class RPN_Calculator
    OPERATORS = %w(+ - * / **)

    def initialize(input: $stdin, output: $stdout)
        @input, @output = input, output
        @stack = []
    end

    def solicit_multiline_input
        @output.puts "Please provide RPN expression. Type '=' and hit return to submit."
        @output.flush
        valid_input = parse_input
        until valid_input
            @output.puts "\nOnly valid operations and numbers allowed!"
            @output.puts "Operators: #{OPERATORS}"
            @output.puts "Please provide RPN expression. Type '=' and hit return to submit."
            @output.flush
            valid_input = parse_input
        end
        @output.puts valid_input
        valid_input
    end

    def parse_input
        expression = @input.gets("=\n").chomp("=\n").to_s.split
        expression.each_with_index do |element, index|
            if OPERATORS.include? element
                calculate(element)
            elsif element =~ (/^-?[0-9]*\.?[0-9]*$/)
                @stack.push(element.to_f)
            else
                return false
            end
            return @stack.first.round(3) if (index == expression.size - 1)
        end
    end

    def calculate(operator)
        operands = @stack.pop(2)
        result = operands.inject(operator)

        @stack.push(result)
    end
end

if __FILE__ == $0
    calculator = RPN_Calculator.new
    calculator.solicit_multiline_input
end