RSpec.describe RpnDclovell::Lexer do
  before :context do
    @lexer = RpnDclovell::Lexer.new
  end

  context 'returns a number token' do
    def check_number(tokens, expected)
      expect(tokens.length).to eq 1
      expect(tokens.first.number?).to be true
      expect(tokens.first.value).to eq expected
    end

    it 'for 21' do
      tokens = @lexer.lex('21')
      check_number(tokens, 21)
    end

    it 'for 3.14' do
      tokens = @lexer.lex('3.14')
      check_number(tokens, 3.14)
    end

    it 'for -2' do
      tokens = @lexer.lex('-2')
      check_number(tokens, -2)
    end
  end

  it 'returns an operator token' do
    %w[+ - / *].each do |operator|
      tokens = @lexer.lex(operator)
      expect(tokens.length).to eq 1
      expect(tokens.first.operator?).to be true
      expect(tokens.first.value).to eq operator
    end
  end

  context 'returns a command token' do
    it 'for quit' do
      tokens = @lexer.lex('q')
      expect(tokens.length).to eq 1
      expect(tokens.first.command?).to be true
      expect(tokens.first).to eq(RpnDclovell::Token::QUIT)
    end

    it 'for bye' do
      tokens = @lexer.lex('bye')
      expect(tokens.length).to eq 1
      expect(tokens.first.command?).to be true
      expect(tokens.first).to eq(RpnDclovell::Token::QUIT)
    end

    it 'for help' do
      tokens = @lexer.lex('h')
      expect(tokens.length).to eq 1
      expect(tokens.first.command?).to be true
      expect(tokens.first).to eq(RpnDclovell::Token::HELP)
    end
  end

  it 'returns an error token' do
    error = 'abracadabra'
    tokens = @lexer.lex(error)
    expect(tokens.length).to eq 1
    expect(tokens.first.error?).to be true
    expect(tokens.first.value).to eq error
  end

  it 'recognizes a sentence' do
    tokens = @lexer.lex('21 42 33 * + q')
    expect(tokens.length).to eq(6)
    tokens[0..2].each do |token|
      expect(token.number?).to eq true
    end
    tokens[3..4].each do |token|
      expect(token.operator?).to eq true
    end
    expect(tokens.last).to eq(RpnDclovell::Token::QUIT)
  end
end
