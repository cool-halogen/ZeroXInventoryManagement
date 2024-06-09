require_relative '../lib/factorial'

RSpec.describe 'factorial' do
  it 'returns 1 for factorial of 0' do
    expect(factorial(0)).to eq(1)
  end

  it 'returns 1 for factorial of 1' do
    expect(factorial(1)).to eq(1)
  end

  it 'returns the correct factorial for positive numbers' do
    expect(factorial(5)).to eq(120)
    expect(factorial(10)).to eq(3628800)
  end

  it 'raises an error for factorial of a negative number' do
    expect { factorial(-5) }.to raise_error(ArgumentError, "Factorial is not defined for negative numbers")
  end

  it 'raises an error for factorial of a decimal number' do
    expect { factorial(3.5) }.to raise_error(ArgumentError)
  end

  it 'raises an error for factorial of a non-integer number' do
    expect { factorial("abc") }.to raise_error(ArgumentError)
  end
end
