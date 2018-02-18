class Road
  def initialize(roads, height, width)
    @roads  = roads
    @height = height
    @width  = width
    @count  = 0

    @road_count  = @roads.flatten.count
    @white_count = @roads.flatten.inject(0) do |count, road|
      road == "." ? count += 1 : count
    end
    @black_count = @roads.flatten.inject(0) do |count, road|
      road == "#" ? count += 1 : count
    end
  end

  def walk(height = 0, width = 0, count = 0)
    count += 1
    if height == @height && width == @width
      return @count = count
    end

    if right_loc = right(height, width)
      right_loc = walk(right_loc[:height], right_loc[:width], count)
      return right_loc unless right_loc.nil?
    end

    if bottom_loc = bottom(height, width)
      bottom_loc = walk(bottom_loc[:height], bottom_loc[:width], count)
      return bottom_loc unless bottom_loc.nil?
    end

    if right_loc.nil? && bottom_loc.nil? && top_loc = top(height, width)
      top_loc = walk(top_loc[:height], top_loc[:width], count)
      return top_loc unless top_loc.nil?
    end

    if right_loc.nil? && bottom_loc.nil? && left_loc = left(height, width)
      left_loc = walk(left_loc[:height], left_loc[:width], count)
      return left_loc unless left_loc.nil?
    end

    return nil
  end

  def score
    return -1 if @count.zero?

    score     = @road_count - @black_count - @count
    return -1 if score < 0

    return score
  end

  private

  def top(height, width)
    height -= 1

    return nil if height < 0
    white?(height, width)
  end

  def right(height, width)
    width += 1

    return nil if width > @width
    white?(height, width)
  end

  def bottom(height, width)
    height += 1

    return nil if height > @height
    white?(height, width)
  end

  def left(height, width)
    width -= 1

    return nil if width < 0
    white?(height, width)
  end

  def white?(height, width)
    if @roads[height][width] == "."
      {height: height, width: width}
    else
      nil
    end
  end
end

input = readlines
first = input.shift.split(" ")
h     = first[0].to_i - 1
w     = first[1].to_i - 1

roads = input.map {|r| r.scan(/\.|#/)}

road = Road.new(roads, h, w)
road.walk
puts road.score
