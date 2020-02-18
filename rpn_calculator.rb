# frozen_string_literal: true

# Mixin module that provides basic functionality of a Reverse Polish (Postfix)
#   Notation Calculator
module RPNCalculator
  # @note In order to make constant fully immutable .freeze ensures that
  #   constant itself [array] can't be modified and .map(&:freeze) ensures
  #   that the object references of the constant's values [array elements]
  #   can't be modified.
  #
  # Operators that are used with a single operand
  ONE_NUM_OPERATORS = %w[sqrt sin cos tan].map(&:freeze).freeze

  # Operators that are used with two operands
  TWO_NUM_OPERATORS = %w[+ - * / **].map(&:freeze).freeze

  # Matches positive and negative integers and floats
  NUMBERS_ONLY = Regexp.new('^-?[0-9]*\.?[0-9]*$').freeze

  # Accepts an expression from client and loops through each element in the
  #   expression. Checks whether the element is a valid operator and if there
  #   are sufficient operands in the stack to use it. If not, checks whether
  #   the element is an operand and adds it to the stack. If not, returns
  #   false. Upon reaching the final element in expression returns the result
  #   provided there weren't too many operands in the expression
  #
  # @param expression [Array] the expression to be calculated, in RPN format.
  #   Each element should be a valid operator (see ONE_NUM_OPERATORS and
  #   TWO_NUM_OPERATORS), or operand(integer or float)
  # @return [Enumerable, False] the result of calculated expression, or false
  #   if the expression was invalid
  def parse_input(expression)
    # Initialising stack here ensures invalid expression data isn't maintained.
    #   This would need to be initialised somewhere else, or have the result
    #   passed back to a parent stack if persistent stack over multiple
    #   expressions is desired.
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

      # If it's the last element in the expression
      if index == expression.size - 1
        # Provided there is only one element in the stack (i.e. the answer to
        #   expression) then return that answer, rounded appropriately.
        #   Otherwise return false as too many operands were provided.
        return @stack.length == 1 ? @stack.first.round(3) : false
      end
    end
  end

  private

  # Performs the appropriate calculation depending on the subset of the
  #   operator passed
  #
  # @note should not be called directly as input is validated and controlled
  #   using parse_input method.
  #
  # @param operator [String] see ONE_NUM_OPERATORS and TWO_NUM_OPERATORS for
  #   list of valid operators
  # @param [Array] operands an array of either one or two floats, depending
  #   on the operator passed
  def _calculate(operator, operands)
    if operands.length > 1
      # Inject combines operands by applying binary operation. In this case
      #   it seems that the operator string passed is being converted to a
      #   symbol that names the appropriate operator.
      # TODO Further research how string is mapped to operator. Ensure robust.
      result = operands.inject(operator)
    else
      # For single number operations, converts the operator string to a symbol
      #   and invokes the method from Math identified by symbol, passing
      #   the operand as argument to the method.
      result = Math.send(operator, operands[0])
    end
    @stack.push(result)
  end
end
