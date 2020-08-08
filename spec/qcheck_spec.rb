describe 'qcheck' do
  def qcheck(input)
    oneQueenPerRow?(input) && oneQueenPerDiagonal?(input)
  end

  def oneQueenPerRow?(input)
    input.uniq == input
  end

  def onEachRow?(input, &block)
    input.size.times.all?(&block)
  end

  def queenCountOnRowN(input, n)
    input.count { |x| x == n }
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

  shared_examples 'calling qcheck' do |input, expected_output|
    context "given #{input.inspect}" do
      subject { qcheck(input) }
      it { is_expected.to be expected_output }
    end
  end

  {
    #
    #   a
    # 1 Q 1
    #   a
    #
    [1] => true,

    #
    #   a b
    # 2     2
    # 1 Q Q 1
    #   a b
    #
    [1, 1] => false,

    #
    #   a b
    # 2   Q 2
    # 1 Q   1
    #   a b
    #
    [1, 2] => false,

    #
    #   a b c
    # 3       3
    # 2   Q Q 2
    # 1 Q     1
    #   a b c
    #
    [1, 2, 2] => false,

    #
    #   a b c
    # 3     Q 3
    # 2   Q   2
    # 1 Q     1
    #   a b c
    #
    [1, 2, 3] => false,

    #
    #   a b c
    # 3   Q   3
    # 2     Q 2
    # 1 Q     1
    #   a b c
    #
    [1, 3, 2] => false,

    #
    #   a b c d e
    # 5     Q     5
    # 4         Q 4
    # 3   Q       3
    # 2       Q   2
    # 1 Q         1
    #   a b c d e
    #
    [1, 3, 5, 2, 4] => true,

    #
    #   a b c d e f
    # 6           Q 6
    # 5     Q   .   5
    # 4       . Q   4
    # 3   Q .       3
    # 2   .   Q     2
    # 1 Q           1
    #   a b c d e f
    #
    [1, 3, 5, 2, 4, 6] => false,

    #
    #   a b
    # 2 Q   2
    # 1   Q 1
    #   a b
    #
    [2, 1] => false,

    #
    #   a b c
    # 3     Q 3
    # 2 Q     2
    # 1   Q   1
    #   a b c
    #
    [2, 1, 3] => false,

    #
    #   a b c
    # 3 Q     3
    # 2     Q 2
    # 1   Q   1
    #   a b c
    #
    [3, 1, 2] => false,

    # TEST
    [4, 2, 7, 3, 6, 8, 5, 1] => true,
    [2, 5, 7, 4, 1, 8, 6, 3] => true,
    [5, 3, 1, 4, 2, 8, 6, 3] => false,
    [5, 8, 2, 4, 7, 1, 3, 6] => false,
    [4, 3, 1, 8, 1, 3, 5, 2] => false
  }.each do |input, expected_output|
    include_examples 'calling qcheck', input, expected_output
  end
end
