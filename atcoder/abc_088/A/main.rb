input = readlines

n = input.shift.to_i
a = input.shift.to_i

while n > 500
  n -= 500
end

if a < n
  puts 'No'
else
  puts 'Yes'
end