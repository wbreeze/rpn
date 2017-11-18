RSpec.describe RpnDclovell::Token do
  before :context do
    @type = :number
    @value = 3.14
    @token = RpnDclovell::Token.new(@type, @value)
  end

  it 'captures a token type' do
    expect(@token.type).to eq(@type)
  end

  it 'captures a token value' do
    expect(@token.value).to eq(@value)
  end
end
