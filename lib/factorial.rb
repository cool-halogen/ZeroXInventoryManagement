def factorial(n)
  raise ArgumentError, "Factorial is not defined for negative numbers" if n < 0

  if n == 0 || n == 1
    return 1
  else
    return n * factorial(n - 1)
  end
end
