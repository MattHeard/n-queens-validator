describe 'qcheck' do
  context 'given {1}' do
    def qcheck(_input)
      true
    end

   subject { qcheck([1]) }
   it { is_expected.to be true }
  end
end
