RSpec.describe RpnDclovell::CliController do
  before :example do
    @terminal = instance_double(RpnDclovell::TerminalInteractor)
    @calculator = RpnDclovell::Calculator.new
    @controller = RpnDclovell::CliController.new(@terminal, @calculator)
    expect(@terminal).to receive(:greeting)
    expect(@terminal).to receive(:goodbye)
  end

  it 'computes a sum, prints it, and quits' do
    token_list = [
      RpnDclovell::Token.number(2),
      RpnDclovell::Token.number(3),
      RpnDclovell::Token.operator('+'),
      RpnDclovell::Token::QUIT
    ]
    expect(@terminal).to receive(:prompt_input).and_return(token_list)
    expect(@terminal).to receive(:display_result).with(5)
    @controller.serve
  end

  it 'provides help' do
    token_list = [
      RpnDclovell::Token::HELP,
      RpnDclovell::Token::QUIT
    ]
    expect(@terminal).to receive(:prompt_input).and_return(token_list)
    expect(@terminal).to receive(:show_help)
    expect(@terminal).to receive(:display_result)
    @controller.serve
  end

  it 'announces and recovers from bad number token' do
    expect(@terminal).to receive(:prompt_input).and_return(
      [RpnDclovell::Token.number('lexer mistake')]
    )
    expect(@terminal).to receive(:show_error)
    expect(@terminal).to receive(:prompt_input).and_return(
      [RpnDclovell::Token::QUIT]
    )
    expect(@terminal).to receive(:display_result).twice
    @controller.serve
  end

  it 'announces and recovers from bad operator token' do
    expect(@terminal).to receive(:prompt_input).and_return(
      [RpnDclovell::Token.operator('lexer mistake')]
    )
    expect(@terminal).to receive(:show_error)
    expect(@terminal).to receive(:prompt_input).and_return(
      [RpnDclovell::Token::QUIT]
    )
    expect(@terminal).to receive(:display_result).twice
    @controller.serve
  end

  it 'announces and recovers from error token' do
    bad_input = 'bad'
    expect(@terminal).to receive(:prompt_input).and_return(
      [RpnDclovell::Token.error(bad_input)]
    )
    expect(@terminal).to receive(:show_error).with(
      "input \"#{bad_input}\" not recognized"
    )
    expect(@terminal).to receive(:prompt_input).and_return(
      [RpnDclovell::Token::QUIT]
    )
    expect(@terminal).to receive(:display_result).twice
    @controller.serve
  end

  it 'announces and recovers from empty stack error' do
    op = '+'
    token_list = [
      RpnDclovell::Token.number(7),
      RpnDclovell::Token.operator(op),
      RpnDclovell::Token::QUIT
    ]
    expect(@terminal).to receive(:prompt_input).and_return(token_list)
    expect(@terminal).to receive(:show_error).with(
      "too few operands for operator \"#{op}\""
    )
    expect(@terminal).to receive(:display_result)
    @controller.serve
  end
end
