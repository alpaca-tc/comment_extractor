require 'spec_helper'

module CommentParser
  describe Parser do
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
      @scanners = Parser.class_variable_get(:@@scanners)
      Parser.class_variable_set(:@@scanners, scanners)
    end

    after do
      Parser.class_variable_set(:@@scanners, @scanners)
    end

    describe '.can_parse_by_shebang' do
      subject { Parser.can_parse_by_shebang(shebang) }

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
      subject { Parser.can_parse_by_filename(filename) }

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
      subject { Parser.can_parse(file_object) }

      let(:binary?) { false }
      let(:content) { '' }
      let(:path) { '/path/to/file' }
      let(:shebang) { nil }
      let(:file_object) do
        double(FileObject).tap do |f|
          allow(f).to receive(:shebang) { shebang }
          allow(f).to receive(:content) { content }
          allow(f).to receive(:binary?) { binary? }
          allow(f).to receive(:path) { path }
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

    describe '.regist_scanner' do
      let(:rule) { :key }
      before do
        Parser.regist_scanner(scanner, rule)
      end

      subject { Parser.class_variable_get(:@@scanners)[:key] }

      context 'given symbal' do
        let(:scanner) { :Object }
        it { should eql :Object }
      end
    end

    describe '.for' do
      subject { Parser.for(file_object) }

      before do
        expect(Parser).to receive(:can_parse).and_return(scanner)
      end

      let(:file_object) do
        double(FileObject).tap do |f|
          allow(f).to receive(:content).and_return('')
        end
      end

      context 'when scanner is found' do
        context 'and which is defined as class' do
          let(:scanner) { double }
          it 'initializes Scanner' do
            expect(scanner).to receive(:new).and_return('HelloWorld')
            expect(subject).to eql 'HelloWorld'
          end
        end

        context 'and which is defined as symbol' do
          before do
            class StubScanner;end
            allow(StubScanner).to receive(:new).and_return('HelloWorld')
            Parser.const_set(scanner, StubScanner)
          end

          after do
            Parser.send(:remove_const, scanner)
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
end
