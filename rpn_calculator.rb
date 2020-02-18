module RPN_Calculator
    # @note In order to make constant fully immutable .freeze ensures that constant itself [array] can't be modified and
    #   .map(&:freeze) ensures that the object references of the constant's values [array elements] can't be modified
    ONE_NUM_OPERATORS = %w(sqrt sin cos tan).map(&:freeze).freeze
    TWO_NUM_OPERATORS = %w(+ - * / **).map(&:freeze).freeze
    NUMBERS_ONLY = Regexp.new('^-?[0-9]*\.?[0-9]*$').freeze

    # @note Must be called in class initialize method
    def initialise_calculator
        @stack = []
    end
    private :initialise_calculator

    def parse_input(expression)
        # @note Re-initialising stack here ensures invalid expression data isn't maintained. This would need to be
        #   adjusted, or passed back to a parent stack if allowing for answer retention with multiple expressions is
        #   desirable. As this functionality is not currently supported, this will suffice for now.
        @stack = []

        expression.each_with_index do |element, index|
            if ONE_NUM_OPERATORS.include? element and @stack.length >= 1
                _calculate(element, @stack.pop(1))
            elsif TWO_NUM_OPERATORS.include? element and @stack.length >= 2
                _calculate(element, @stack.pop(2))
            elsif element =~ NUMBERS_ONLY
                @stack.push(element.to_f)
            else
                return false
            end

            if index == expression.size - 1
                return (@stack.length == 1) ? @stack.first.round(3) : false
            end
        end
    end

    def _calculate(operator, operands)
        if operands.length > 1
            result = operands.inject(operator)
            @stack.push(result)
        else
            result = Math.send(operator, operands[0])
            @stack.push(result)
        end
    end
    private :_calculate
end