require 'spec_helper'

describe SidekiqRejector::Middleware::Client do
  describe 'call' do

    let(:subject) { SidekiqRejector::Middleware::Client.new }
    
    context 'when rejector enabled' do
      let(:worker) do
        d = double('worker')
        d
      end

      let(:msg) { { 'class' => 'SomeWorker', 'args' => ['bob', 1, :foo => 'bar'] }.to_json }
      let(:queue) { '' }

      let(:block) do
        d = double('block')
        d
      end

      it "should return nil AND block should NOT be exceuted" do
        ENV[SidekiqRejector::Middleware::Client::ENABLE_VAR] = 'true'
        ENV[SidekiqRejector::Middleware::Client::REJECT_VALUES] = { worker: ['SomeWorker'] }.to_json
        block_to_exec = Proc.new { block.exec_block }
        expect(block).to receive(:exec_block).never
        result = subject.call nil, msg, queue, &block_to_exec 
        expect(result).to be false
      end
    end

    context 'when rejector disabled' do
      let(:queue) { 'some queue' }
      let(:block) do
        d = double('block')
        allow(d).to receive(:exec_block)
        d
      end
      let(:msg) { { 'class' => 'SomeWorker', 'args' => [] }.to_json }
      
      it "should call the block" do
        ENV[SidekiqRejector::Middleware::Client::ENABLE_VAR] = 'false'
        block_to_exec = Proc.new { block.exec_block }
        expect(block).to receive(:exec_block)
        subject.call nil, msg, queue, &block_to_exec
      end
    end
  end 
end
