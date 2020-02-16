require_relative '../rpn_client'

describe "parse_input" do
    before do
        @input = StringIO.new
        @output = StringIO.new
        @calculator = RPN_Client.new(output: @output)
    end

    after do
        # Not really needed as rewind sets pointer back to the beginning of the last input But added to stop the
        #   StringIO objects from taking up too much memory as number of tests grows, improving test speed
        @input.truncate(0)
        @output.truncate(0)
    end

    context "given valid expression" do
        it "1 1 + 3 * 2 - 3 * = 12" do
            input = "1 1 + 3 * 2 - 3 *".to_s.split
            expect(@calculator.parse_input(input)).to eq 12
        end

        it "2 1 2 + * = 6" do
            input = "2 1 2 + *".to_s.split
            expect(@calculator.parse_input(input)).to eq 6
        end

        it "2 3 ** = 8" do
            input = "2 3 **".to_s.split
            expect(@calculator.parse_input(input)).to eq 8
        end

        it "returns 8.0" do
            input = "9 sqrt 5 +".to_s.split
            expect(@calculator.parse_input(input)).to eq 8.0
        end
    end

    context "given expression with decimal result" do
        it "rounds up tp 0.667" do
            input = "2 3 /".to_s.split
            expect(@calculator.parse_input(input)).to eq 0.667
        end

        it "rounds up to 0.556 testing decimal 5 edge case" do
            input = "5 9 /".to_s.split
            expect(@calculator.parse_input(input)).to eq 0.556
        end

        it "truncates to 0.333" do
            input = "1 3 /".to_s.split
            expect(@calculator.parse_input(input)).to eq 0.333
        end

        it "returns correct result even if no decimal places" do
            input = "10 5 /".to_s.split
            expect(@calculator.parse_input(input)).to eq 2
        end
    end

    # TODO ask client if the calculator should perform the operation with the first stack item repeated (like OSX RPN Calculator)
    context "where too many operators are supplied" do
        it "returns false" do
            input = "10 5 / +".to_s.split
            expect(@calculator.parse_input(input)).to eq false
        end
    end

    context "where too many operands are supplied" do
        it "should return false" do
            input = "9 sqrt 5 + 4".to_s.split
            expect(@calculator.parse_input(input)).to eq false
        end
    end

    context "where an invalid order for operators and operands is given" do
        it "should return false" do
            input = "10 / 5".to_s.split
            expect(@calculator.parse_input(input)).to eq false
        end
    end
end


describe "solicit_multiline_input" do
    before do
        @input = StringIO.new
        @output = StringIO.new
        @calculator = RPN_Client.new(input: @input, output: @output)
    end

    after do
        # Stops StringIO objects from taking up too much memory as number of tests grows
        @input.truncate(0)
        @output.truncate(0)
    end

    context "given a valid expression" do
        it "prints appropriate response to designated output" do
            @input.puts "10 5 + =\n"
            @input.rewind
            @calculator.solicit_multiline_input
            expect(@output.string).to eq "Please provide RPN expression. Type '=' and hit return to submit.\n15.0\n"
        end
    end

    context "given an invalid expression" do
        it "prints appropriate response to designated output" do
            @input.puts "10 5 sum =\n10 5 + =\n"
            @input.rewind
            @calculator.solicit_multiline_input
            expect(@output.string).to eq "Please provide RPN expression. Type '=' and hit return to submit.\n\nError! Only valid operations and numbers allowed!\nPlease provide RPN expression. Type '=' and hit return to submit.\n15.0\n"
        end
    end
end
