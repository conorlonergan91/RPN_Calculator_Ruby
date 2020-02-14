require_relative 'spec_helper.rb'
require_relative '../example'

describe return_5 do
    result = return_5

    context "correct result shout be that" do
        it 'returns 5' do
            expect(result).to eq(5)
        end
    end

    context "given other numbers" do
        it "doesn't return 10" do
            expect(result).not_to eq(10)
        end

    end

    context "given strings" do
        it "doesn't return 'hello'" do
            expect(result).not_to eq('hello')
        end
        it "doesn't return '5'" do
            expect(result).not_to eq('5')
        end
    end
end