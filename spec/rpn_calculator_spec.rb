require_relative '../rpn_calculator'

describe 'RPN_Calculator' do
    before do
        @output = StringIO.new
        @input = StringIO.new
    end

    after do
        # Do Nothing
    end

    context 'given example input' do
        it "1 1 + 3 * 2 - 3 * = 12" do
            @input.puts "1 1 + 3 * 2 - 3 * =\n"
            @input.rewind
            calculator = RPN_Calculator.new(input: @input, output: @output)
            expect(calculator.solicit_multiline_input).to eq 12
        end

        it "2 1 2 + * = 6" do
            @input.puts "2 1 2 + * =\n"
            @input.rewind
            calculator = RPN_Calculator.new(input: @input, output: @output)
            expect(calculator.solicit_multiline_input).to eq 6
        end

        it "2 3 ** = 8" do
            @input.puts "2 3 ** =\n"
            @input.rewind
            calculator = RPN_Calculator.new(input: @input, output: @output)
            expect(calculator.solicit_multiline_input).to eq 8
        end
    end

    context 'given expression with decimal result' do
        it "rounds up tp 0.667" do
            @input.puts "2 3 / =\n"
            @input.rewind
            calculator = RPN_Calculator.new(input: @input, output: @output)
            expect(calculator.solicit_multiline_input).to eq 0.667
        end

        it "rounds up to 0.556 testing decimal 5 edge case" do
            @input.puts "5 9 / =\n"
            @input.rewind
            calculator = RPN_Calculator.new(input: @input, output: @output)
            expect(calculator.solicit_multiline_input).to eq 0.556
        end

        it "truncates to 0.333" do
            @input.puts "1 3 / =\n"
            @input.rewind
            calculator = RPN_Calculator.new(input: @input, output: @output)
            expect(calculator.solicit_multiline_input).to eq 0.333
        end

        it "returns correct result even if no decimal places" do
            @input.puts "10 5 / =\n"
            @input.rewind
            calculator = RPN_Calculator.new(input: @input, output: @output)
            expect(calculator.solicit_multiline_input).to eq 2
        end
    end

    context "provides invalid input" do
        #   Do something
    end

    context "provides insufficient numbers" do
        #   Do something
    end

    context "provides extra operators" do
        #   Do something
    end

    context "invalid order for operator and operands" do
        #   Do something
    end
end