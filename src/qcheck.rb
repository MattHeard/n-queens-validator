class QCheck
  def qcheck(input)
    oneQueenPerRow?(input) && oneQueenPerDiagonal?(input)
  end

  private

  def oneQueenPerRow?(input)
    input.uniq == input
  end

  def oneQueenPerDiagonal?(input)
    [
      transform_up(input),
      transform_down(input)
    ].all? { |input| oneQueenPerRow?(input) }
  end

  def transform_up(input)
    transform(input, :+)
  end

  def transform(input, operator)
    input.map.with_index { |x, i| x.public_send(operator, i) }
  end

  def transform_down(input)
    transform(input, :-)
  end
end
