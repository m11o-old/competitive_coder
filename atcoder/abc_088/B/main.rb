input = readlines

n = input.shift.to_i
a = input.first.split(" ").sort_by {|point| -point.to_i}

alice = 0;
bob   = 0;

a.each_with_index do |point, index|
  if index % 2 == 0
    alice += point.to_i
  else
    bob   += point.to_i
  end
end

puts alice - bob