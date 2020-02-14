require_relative '../rpn_calculator'

describe 'RPN_Calculator' do
    before do
        # Do Nothing
        @output = StringIO.new
    end

    after do
        # Do Nothing
    end

    context 'given example input' do
        # it 'solicits multi-line input' do
        #     input = StringIO.new("1 1 + =\n")
        #     calculator = RPN_Calculator.new(input: input, output: @output)
        #     @output.rewind
        #     expect(@output.read).to eq "Enter calculation [use = and return to submit]\n"
        # end

        it "returns 12" do
            input = StringIO.new("1 1 + 3 * 2 - 3 * =\n")
            calculator = RPN_Calculator.new(input: input, output: @output)
            expect(calculator.solicit_multiline_input).to eq 12
        end

        it "returns 6" do
            input = StringIO.new("2 1 2 + * =\n")
            calculator = RPN_Calculator.new(input: input, output: @output)
            expect(calculator.solicit_multiline_input).to eq 6
        end
    end
end