RSpec.describe RpnDclovell::TerminalInteractor do
  class IOEmulator
    attr_accessor :input_list
    attr_reader :output_list

    def initialize
      @output_list = []
    end

    def gets
      input_list.shift || "\C-d"
    end

    def puts(str)
      @output_list << str
    end

    def write(str)
      puts(str)
    end

    def eof?
      input_list.empty?
    end
  end

  before :example do
    @ioe = IOEmulator.new
    @ti = RpnDclovell::TerminalInteractor.new(@ioe, @ioe)
  end

  it 'captures input' do
    sentence = '2 3 + q'
    @ioe.input_list = [sentence]
    expect(@ti.prompt_input).to eq(sentence)
  end

  it 'captures quit' do
    @ioe.input_list = %w[q]
    expect(@ti.prompt_input).to eq 'q'
  end

  it 'captures eof' do
    @ioe.input_list = []
    expect(@ti.prompt_input).to eq 'q'
  end

  it 'prompts' do
    @ioe.input_list = []
    @ti.prompt_input
    outputs = @ioe.output_list
    expect(outputs.length).to eq 1
    expect(outputs.first).to match('rpn=> ')
  end


  it 'shows help' do
    @ti.show_help
    outputs = @ioe.output_list
    expect(outputs.length).to eq 1
    expect(outputs.first).to match('This is a calculator')
  end

  it 'greets you' do
    @ti.greeting
    outputs = @ioe.output_list
    expect(outputs.length).to eq 1
    expect(outputs.first).to match('Type "q" to quit, "h" for help.')
  end

  it 'says goodbye' do
    @ti.goodbye
    outputs = @ioe.output_list
    expect(outputs.length).to eq 1
    expect(outputs.first).to match('So long and thank you')
  end
end
