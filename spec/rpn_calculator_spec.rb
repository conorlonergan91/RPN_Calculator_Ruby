require_relative 'spec_helper.rb'
require_relative '../rpn_calculator'

describe RPN_Calculator do
    it "adds 20 and 39" do
        input = StringIO.new("20 39 +")
        output = StringIO.new

        example = Example.new(input: input, output: output)
        expect(example.ask_for_number).to be true
        calculator = RPN_Calculator.new


        expect(calculator.solicit_multiline_input)
    end
end