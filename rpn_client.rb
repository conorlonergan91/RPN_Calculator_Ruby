# frozen_string_literal: true

require_relative 'RPN_Calculator'

# Client for the RPN calculator. Solicits input from the user, formats the input
#   into a valid expression sends input to be calculated and then handles the
#   response.
class RPNClient
  include RPNCalculator

  # If no input source and output destination are passed in, use global
  #   standard input and standard output
  #
  # @param input [StringIO] the designate user input source
  # @param output [StringIO] the designate console output destination
  # @return [StringIO] input
  # @return [StringIO] output
  def initialize(input: $stdin, output: $stdout)
    @input = input
    @output = output
  end

  # Solicits the user to input a mathematical expression. Sanitizes the input
  #   and formats the expression as an array of operators and operands.
  #   Ensures whitespace or empty string wasn't submitted. Sends expression
  #   to be calculated and validates the input. If input is invalid, displays
  #   advice message to user and solicits another valid expression.
  def solicit_multiline_input
    @output.puts "Input RPN expression. Type '=' and hit return to submit."
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
      @output.puts "Input RPN expression. Type '=' and hit return to submit."
      @output.flush
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  client = RPNClient.new
  client.solicit_multiline_input
end
