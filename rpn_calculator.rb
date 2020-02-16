module RPN_Calculator
    # @note In order to make constant fully immutable .freeze ensures that constant itself [array] can't be modified and
    #   .map(&:freeze) ensures that the object references of the constant's values [array elements] can't be modified
    OPERATORS_1_NUM = %w(sqrt sin cos tan).map(&:freeze).freeze
    OPERATORS_2_NUM = %w(+ - * / **).map(&:freeze).freeze

    # @note Must be called in class initialize method
    def initialise_calculator
        @stack = []
    end

    def parse_input(expression)
        # @note Re-initialising stack here ensures invalid expression data isn't maintained. This would need to be
        #   adjusted, or passed back to a parent stack if allowing for answer retention with multiple expressions is
        #   desirable. As this functionality is not currently supported, this will suffice for now.
        @stack = []
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