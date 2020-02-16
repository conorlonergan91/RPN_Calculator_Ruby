class RPN_Calculator
    attr_accessor :output
    OPERATORS_1_NUM = %w(sqrt sin cos tan)
    OPERATORS_2_NUM = %w(+ - * / **)

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

    def parse_input
        # (Re)Initialising stack here ensures invalid expression data isn't maintained
        # This would need to be adjusted, or passed back to a parent stack if we wanted to allow for
        # answer retention with multiple expressions, however as the program terminates after a single valid
        # expression, this will suffice for now
        @stack = []

        expression = @input.gets("=\n").chomp("=\n").to_s.split
        expression.each_with_index do |element, index|
            if OPERATORS_1_NUM.include? element and @stack.length >= 1
                calculate(element, @stack.pop(1))
            elsif OPERATORS_2_NUM.include? element and @stack.length >= 2
                calculate(element, @stack.pop(2))
            elsif element =~ (/^-?[0-9]*\.?[0-9]*$/)
                @stack.push(element.to_f)
            else
                return false
            end

            if index == expression.size - 1
                return (@stack.length == 1) ? @stack.first.round(3) : false
            end
        end
    end

    def calculate(operator, operands)
        if operands.length > 1
            result = operands.inject(operator)
            @stack.push(result)
        else
            result = Math.send(operator, operands[0])
            @stack.push(result)
        end
    end
end

if __FILE__ == $0
    calculator = RPN_Calculator.new
    calculator.solicit_multiline_input
end