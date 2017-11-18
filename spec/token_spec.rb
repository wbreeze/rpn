RSpec.describe RpnDclovell::Token do
  context 'constructor and accessors' do
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

  context 'commands' do
    it 'captures help' do
      token = RpnDclovell::Token.command(RpnDclovell::Token::HELP)
      expect(token.command?).to be true
    end

    it 'captures quit' do
      token = RpnDclovell::Token.command(RpnDclovell::Token::QUIT)
      expect(token.command?).to be true
    end
  end

  context 'provides a factory' do
    it 'for numbers' do
      value = 21.4
      token = RpnDclovell::Token.number(value)
      expect(token.type).to eq(:number)
      expect(token.value).to eq(value)
    end

    it 'for operators' do
      operator = '+'
      token = RpnDclovell::Token.operator(operator)
      expect(token.type).to eq(:operator)
      expect(token.value).to eq(operator)
    end

    it 'for commands' do
      command = RpnDclovell::Token::HELP
      token = RpnDclovell::Token.command(command)
      expect(token.type).to eq(:command)
      expect(token.value).to eq(command)
    end

    it 'for errors' do
      error = 'abracadabra'
      token = RpnDclovell::Token.error(error)
      expect(token.type).to eq(:error)
      expect(token.value).to eq(error)
    end
  end

  context 'provides type check functions' do
    it 'for number type' do
      token = RpnDclovell::Token.number(7)
      expect(token.number?).to be true
      expect(token.operator?).to be false
      expect(token.command?).to be false
      expect(token.error?).to be false
    end

    it 'for operator type' do
      token = RpnDclovell::Token.operator('+')
      expect(token.number?).to be false
      expect(token.operator?).to be true
      expect(token.command?).to be false
      expect(token.error?).to be false
    end

    it 'for command type' do
      token = RpnDclovell::Token.command(RpnDclovell::Token::QUIT)
      expect(token.number?).to be false
      expect(token.operator?).to be false
      expect(token.command?).to be true
      expect(token.error?).to be false
    end

    it 'for error type' do
      token = RpnDclovell::Token.error('nonsense')
      expect(token.number?).to be false
      expect(token.operator?).to be false
      expect(token.command?).to be false
      expect(token.error?).to be true
    end
  end
end
