describe 'qcheck' do
  def qcheck(input)
    oneQueenPerRow?(input) && oneQueenPerDiagonal?(input)
  end

  def oneQueenPerRow?(input)
    onEachRow?(input) do |i|
      onlyOneQueenOnRowN?(input, i + 1)
    end
  end

  def onEachRow?(input, &block)
    input.size.times.all?(&block)
  end

  def onlyOneQueenOnRowN?(input, n)
    queenCountOnRowN(input, n) == 1
  end

  def queenCountOnRowN(input, n)
    input.count { |x| x == n }
  end

  def oneQueenPerDiagonal?(input)
    input.each_cons(2).all? do |(i, j)|
      (j != i + 1) && (j != i - 1)
    end
  end

  shared_examples 'calling qcheck' do |input, expected_output|
    context "given #{input.inspect}" do
      subject { qcheck(input) }
      it { is_expected.to be expected_output }
    end
  end

  {
    [1] => true,
    [1, 1] => false,
    [1, 2] => false,
    [1, 2, 2] => false,
    [1, 2, 3] => false,
    [1, 3, 2] => false,
    [2, 1] => false,
    [2, 1, 3] => false,
    [3, 1, 2] => false
  }.each do |input, expected_output|
    include_examples 'calling qcheck', input, expected_output
  end
end
