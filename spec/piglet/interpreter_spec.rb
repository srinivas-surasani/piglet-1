require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')


describe Piglet::Interpreter do

  before do
    @interpreter = Piglet::Interpreter.new
  end

  it 'does nothing with no commands' do
    @interpreter.interpret.to_pig_latin.should == ''
  end

  context 'load' do
    it 'constructs a LOAD statement' do
      @interpreter.interpret { load('some/path') }
      @interpreter.to_pig_latin.should eql(%{LOAD 'some/path'})
    end
    
    it 'constructs a LOAD statement without a USING clause if none specified' do
      @interpreter.interpret { load('some/path') }
      @interpreter.to_pig_latin.should_not include('USING')
    end
    
    it 'constructs a LOAD statement with a USING clause with a specified method' do
      @interpreter.interpret { load('some/path').using('Test') }
      @interpreter.to_pig_latin.should eql(%{LOAD 'some/path' USING Test})
    end
    
    it 'knows that the load method :pig_latin means PigLatin' do
      @interpreter.interpret { load('some/path').using(:pig_latin) }
      @interpreter.to_pig_latin.should eql(%{LOAD 'some/path' USING PigLatin})
    end
    
    it 'constructs a LOAD statement with an AS clause' do
      @interpreter.interpret { load('some/path').as(:a, :b, :c) }
      @interpreter.to_pig_latin.should eql(%{LOAD 'some/path' AS (a, b, c)})
    end
    
    it 'constructs a LOAD statement with an AS clause with types' do
      @interpreter.interpret { load('some/path').as(:a, [:b, :chararray], :c) }
      @interpreter.to_pig_latin.should eql(%{LOAD 'some/path' AS (a, b:chararray, c)})
    end
  end

end
