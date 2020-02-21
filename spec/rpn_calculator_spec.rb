require_relative '../rpn_client'

describe RPNClient, 'parse_input' do
  output = StringIO.new
  calculator = RPNClient.new(output: output)

  after do
    output.truncate(0)
    output.rewind
  end

  context 'when valid' do
    context '1 number expression is given' do
      context 'with one operand' do
        it 'calculates correct answer 8.0' do
          input = %(9 sqrt).to_s.split
          expect(calculator.parse_input(input)).to eq 3.0
        end
      end

      context 'with multiple operands' do
        it 'calculates correct answer 8.0' do
          input = %(9 sqrt 5 +).to_s.split
          expect(calculator.parse_input(input)).to eq 8.0
        end
      end
    end

    context '2 number expression is given' do
      context 'with one operand' do
        it 'calculates correct answer 8' do
          input = %(2 3 **).to_s.split
          expect(calculator.parse_input(input)).to eq 8
        end
      end

      context 'with multiple operands' do
        it 'calculates correct answer 6' do
          input = %(2 1 2 + *).to_s.split
          expect(calculator.parse_input(input)).to eq 6
        end

        it 'calculates correct answer 12' do
          input = %(1 1 + 3 * 2.0 - 3 *).to_s.split
          expect(calculator.parse_input(input)).to eq 12
        end
      end
    end

    context 'multi-line input is given' do
      it 'calculates correct answer -5.0' do
        input = %(1 2\n 4\n + - \n).to_s.split
        expect(calculator.parse_input(input)).to eq -5.0
      end
    end

    context 'input with decimal result is given' do
      it 'rounds up tp 0.667' do
        input = %(2 3 /).to_s.split
        expect(calculator.parse_input(input)).to eq 0.667
      end

      it 'rounds up to 0.556' do
        input = %(5 9.0 /).to_s.split
        expect(calculator.parse_input(input)).to eq 0.556
      end

      it 'truncates to 0.333' do
        input = %(1.0 3 /).to_s.split
        expect(calculator.parse_input(input)).to eq 0.333
      end

      it 'returns correct result 2.0 for .0000' do
        input = %(10 5 /).to_s.split
        expect(calculator.parse_input(input)).to eq 2.0
      end
    end
  end

  # TODO ask client if the calculator should perform the operation with the first stack item repeated (like OSX RPN Calculator)
  context 'where invalid' do
    context 'input with too many operators is given' do
      it 'returns false' do
        input = %(10 5 / +).to_s.split
        expect(calculator.parse_input(input)).to be_falsey
      end
		end

    context 'input with too many operands is given' do
      it 'returns false' do
        input = %(9 sqrt 5 + 4).to_s.split
        expect(calculator.parse_input(input)).to be_falsey
      end
    end

    context 'order for operators and operands is given' do
      it 'returns false' do
        input = %(10 / 5).to_s.split
        expect(calculator.parse_input(input)).to be_falsey
      end
    end

    context 'multi-line input is given' do
      it 'returns false' do
        input = %(1 2\n 4\n + minus \n).to_s.split
        expect(calculator.parse_input(input)).to be_falsey
      end
    end
  end
end


describe 'solicit_multiline_input' do
  input = StringIO.new
  output = StringIO.new
  calculator = RPNClient.new(input: input, output: output)
	success_string = %(Input RPN expression. Type "=" and hit return to submit.\n)
	error_string = %(Input RPN expression. Type "=" and hit return to submit.\n
Error! Only valid operations and numbers allowed!
Input RPN expression. Type "=" and hit return to submit.\n)

  after do
		# @note Not really necessary to clear StringIO objects every time, however
    #   this prevents the StringIO objects from taking up too much memory as
    #   number of tests grows and is more efficient than re-instantiating object
    #   and waiting for Garbage Collector to clean up.
    input.truncate(0)
    input.rewind
    output.truncate(0)
    output.rewind
  end

  context 'given a valid expression' do
    it 'prints appropriate response to designated output' do
      input.puts %(10 5 + =\n)
      input.rewind
      calculator.solicit_multiline_input
      expect(output.string).to eq(success_string + %(15.0\n))
    end
  end

  context 'given an invalid expression' do
    it 'prints appropriate response to designated output' do
      input.puts %(10 5 sum =\n10 5 + =\n)
      input.rewind
      calculator.solicit_multiline_input
      expect(output.string).to eq(error_string + %(15.0\n))
    end

    context 'where the input is an empty string' do
      it 'sends appropriate response to designated output' do
        input.puts %(=\n 9 sqrt =\n)
        input.rewind
        calculator.solicit_multiline_input
        expect(output.string).to eq(error_string + %(3.0\n))
      end
    end

    context 'where the input contains a single quote character' do
      it 'flags as invalid and requests new input' do
        input.puts %(' ' =\n 9 sqrt =\n)
        input.rewind
        calculator.solicit_multiline_input
        expect(output.string).to eq(error_string + %(3.0\n))
      end
    end

    context 'where the input contains a double quote character' do
      it 'flags as invalid and requests new input' do
        input.puts %(" " "=\n 9 sqrt =\n)
        input.rewind
        calculator.solicit_multiline_input
        expect(output.string).to eq(error_string + %(3.0\n))
      end
    end
  end
end

describe 'calculate' do
  output = StringIO.new
  calculator = RPNClient.new(output: output)

  after do
    output.truncate(0)
    output.rewind
  end

  context 'where calculate is called from client object' do
    it 'raises NoMethodError' do
      operator = %(+)
      operands = [1, 2]
      expect { calculator.calculate(operator, operands) }.to raise_error(NoMethodError)
    end
  end
end
