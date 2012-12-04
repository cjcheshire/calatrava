require 'spec_helper'

describe Calatrava::Shell do
  include Aruba::Api

  let(:shell) { Calatrava::Shell.new(current_dir) }

  before(:each) do
    create_dir 'shell/support'
    write_file 'shell/support/shell.coffee', ''
    write_file 'shell/support/fragment.haml', ''
    create_dir 'shell/pages/example'
    write_file 'shell/pages/example/page.coffee', ''
    write_file 'shell/pages/example/page.haml', ''

    create_dir 'shell/stylesheets'
    write_file 'shell/stylesheets/shell.css', ''
    write_file 'shell/stylesheets/template.sass', ''
    write_file 'shell/stylesheets/template.scss', ''
  end

  context 'coffee files' do
    subject { shell.coffee_files }

    it { should include 'shell/support/shell.coffee' }
  end

  context 'haml files' do
    subject { shell.haml_files }

    it { should include 'shell/support/fragment.haml' }
  end

  context 'css files' do
    subject { shell.css_files }
    
    it { should include 'shell/stylesheets/shell.css' }
    it { should include 'shell/stylesheets/template.sass' }
    it { should include 'shell/stylesheets/template.scss' }
  end

  context 'features' do
    subject { shell.features }

    it { should have(1).feature }

    context 'a single feature' do
      subject { shell.features[0] }

      it { should include :name => 'example' }
      it { should include :coffee => ['shell/pages/example/page.coffee'] }
      it { should include :haml => ['shell/pages/example/page.haml'] }
    end
  end
  
end
