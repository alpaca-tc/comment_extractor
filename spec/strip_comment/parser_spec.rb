require 'spec_helper'

describe StripComment::Parser do
  let(:scanners) do
    {
      {
        filename: /\.rb$/,
        filetype: 'ruby',
        shebang: /.*ruby$/,
      } => 'Ruby',
      {
        filename: /^Gemfile$/,
        filetype: 'Gemfile',
      } => 'Gemfile',
      {
        filename: /\.js$/,
        filetype: 'javascript',
        shebang: /.*(js|node)$/,
      } => 'JavaScript',
    }
  end

  before do
    @scanners = StripComment::Parser.class_variable_get(:@@scanners)
    StripComment::Parser.class_variable_set(:@@scanners, scanners)
  end

  after do
    StripComment::Parser.class_variable_set(:@@scanners, @scanners)
  end

  describe '.can_parse_by_shebang' do
    subject { StripComment::Parser.can_parse_by_shebang(shebang) }

    context 'given shebang of node' do
      let(:shebang) { '#! /usr/bin/node' }
      it { should eql 'JavaScript' }
    end

    context 'given empty string' do
      let(:shebang) { '' }
      it { should be_nil }
    end
  end

  describe '.can_parse_by_filename' do
    subject { StripComment::Parser.can_parse_by_filename(filename) }

    context 'given "rubyfile.rb"' do
      let(:filename) { 'rubyfile.rb' }
      it { should eql 'Ruby' }
    end

    context 'given "Gemfile"' do
      let(:filename) { 'Gemfile' }
      it { should eql 'Gemfile' }
    end
  end

  describe '.can_parse' do
    subject { StripComment::Parser.can_parse(file_object) }

    let(:binary?) { false }
    let(:content) { '' }
    let(:path) { '/path/to/file' }
    let(:shebang) { nil }
    let(:file_object) do
      double(StripComment::FileObject).tap do |f|
        f.stub(:shebang).and_return(shebang)
        f.stub(:content).and_return(content)
        f.stub(:binary?).and_return(binary?)
        f.stub(:path).and_return(path)
      end
    end

    context 'given file_object which parsed ruby file' do
      let(:path) { '/path/to/ruby.rb' }
      it { should eql 'Ruby' }
    end

    context 'given binary file' do
      let(:binary?) { true }
      it { should be_nil }
    end

    context 'given file_object which contains shebang' do
      let(:shebang) { '/usr/bin/node' }
      it { should eql 'JavaScript' }
    end
  end

  describe '.register_scanner' do
    let(:rule) { :key }
    before do
      StripComment::Parser.register_scanner(scanner, rule)
    end

    subject { StripComment::Parser.class_variable_get(:@@scanners)[:key] }

    context 'given symbal' do
      let(:scanner) { :Object }
      it { should eql :Object }
    end
  end

  describe '.for' do
    subject { StripComment::Parser.for(file_object) }

    before do
      StripComment::Parser.should_receive(:can_parse).and_return(scanner)
    end

    let(:file_object) do
      double(StripComment::FileObject).tap do |f|
        f.stub(:content).and_return('')
      end
    end

    context 'when scanner is found' do
      context 'and which is defined as class' do
        let(:scanner) { double }
        it 'initializes Scanner' do
          scanner.should_receive(:new).and_return('HelloWorld')
          expect(subject).to eql 'HelloWorld'
        end
      end

      context 'and which is defined as symbol' do
        before do
          class StubScanner;end
          StubScanner.should_receive(:new).and_return('HelloWorld')
          StripComment::Parser.const_set(scanner, StubScanner)
        end

        after do
          StripComment::Parser.send(:remove_const, scanner)
        end

        let(:scanner) { :StubScanner }

        it 'converts symbol to ScannerClass and returns it initialized' do
          expect(subject).to eql 'HelloWorld'
        end
      end
    end

    context 'when scanner is not found' do
      let(:scanner) { nil }
      it { should be_nil }
    end
  end
end
