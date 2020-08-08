describe 'qcheck' do
  def qcheck(input)
    input == [1]
  end

  subject { qcheck(input) }

  context 'given [1]' do
    let(:input) { [1] }
    it { is_expected.to be true }
  end

  context 'given [1, 1]' do
    let(:input) { [1, 1] }
    it { is_expected.to be false }
  end
end
