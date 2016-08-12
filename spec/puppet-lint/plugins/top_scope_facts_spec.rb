require 'spec_helper'

describe 'top_scope_facts' do
  let(:msg) { 'top scope fact instead of facts hash' }
  context 'with fix disabled' do
    context 'fact variable using $facts hash' do
      let(:code) { "$facts['operatingsystem']" }

      it 'should not detect any problems' do
        expect(problems).to have(0).problem
      end
    end    
    context 'non-fact variable with two colons ' do
      let(:code) { "$foo::bar" }

      it 'should not detect any problems' do
        expect(problems).to have(0).problem
      end
    end

    context 'fact variable using top scope' do
      let(:code) { '$::operatingsystem' }

      it 'should only detect a single problem' do
        expect(problems).to have(1).problem
      end

      it 'should create a warning' do
        expect(problems).to contain_warning(msg).on_line(1).in_column(1)
      end
    end
  end

  context 'with fix enabled' do
    before do
      PuppetLint.configuration.fix = true
    end

    after do
      PuppetLint.configuration.fix = false
    end

    context 'fact variable using $facts hash' do
      let(:code) { "$facts['operatingsystem']" }

      it 'should not detect any problems' do
        expect(problems).to have(0).problem
      end
    end    
    context 'non-fact variable with two colons ' do
      let(:code) { "$foo::bar" }

      it 'should not detect any problems' do
        expect(problems).to have(0).problem
      end
    end

    context 'fact variable using top scope' do
      let(:code) { '$::operatingsystem' }

      it 'should only detect a single problem' do
        expect(problems).to have(1).problem
      end

      it 'should fix the problem' do
        expect(problems).to contain_fixed(msg).on_line(1).in_column(1)
      end

      it 'should should use the facts hash' do
        expect(manifest).to eq("$facts['operatingsystem']")
      end
    end
  end
end

