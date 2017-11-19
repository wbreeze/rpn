RSpec.describe RpnDclovell::CliController do
  before :example do
    @terminal = instance_double(RpnDclovell::TerminalInteractor)
    @calculator = RpnDclovell::Calculator.new
    @controller = RpnDclovell::CliController.new(@terminal, @calculator)
  end

  it 'computes a sum, prints it, and quits' do
    token_list = [
      RpnDclovell::Token.number(2),
      RpnDclovell::Token.number(3),
      RpnDclovell::Token.operator('+'),
      RpnDclovell::Token::QUIT
    ]
    expect(@terminal).to receive(:greeting)
    expect(@terminal).to receive(:prompt_input).and_return(token_list)
    expect(@terminal).to receive(:display_result).with(5)
    expect(@terminal).to receive(:goodbye)
    @controller.serve
  end

  it 'provides help and says goodbye' do
    token_list = [
      RpnDclovell::Token::HELP,
      RpnDclovell::Token::QUIT
    ]
    expect(@terminal).to receive(:greeting)
    expect(@terminal).to receive(:prompt_input).and_return(token_list)
    expect(@terminal).to receive(:show_help)
    expect(@terminal).to receive(:display_result)
    expect(@terminal).to receive(:goodbye)
    @controller.serve
  end
end
