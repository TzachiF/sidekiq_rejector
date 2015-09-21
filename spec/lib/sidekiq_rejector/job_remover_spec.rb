require 'spec_helper'

describe SidekiqRejector::JobRemover do
  describe 'remove' do

    # Simple class to mock redis
    class RedisMock
      def initialize(q)
        @q = q
      end
      def lrange(m, m1, m2)
        @q
      end

      def lrem(m, m1, m2)
      end
    end

    let(:subject) { SidekiqRejector::JobRemover }
    let(:queue_name) { 'queue' }
    let(:string_identifier) { 'to_remove' }
    let(:remove_count) { 3 }

    context "when inputs are valid" do
      context "when queue includes jobs" do
        context "when identefier is part of jobs in queue" do
          it "should call remove on redis as the number of jobs" do
            mock_redis = RedisMock.new(['to_remove', 'to_remove', 'to_remove', 'stay'])
            allow(Redis).to receive(:new).and_return(mock_redis)
            expect(mock_redis).to receive(:lrem).exactly(remove_count).times
            expect(mock_redis).to receive(:lrange).with(any_args).and_return(['to_remove', 'to_remove', 'to_remove', 'stay']).once
            subject.remove(queue_name, string_identifier)
          end
        end

        context "when identefier is NOT part of jobs in queue" do
          it "should NOT call remove on redis" do
            mock_redis = RedisMock.new(['stay', 'stay', 'stay', 'stay'])
            allow(Redis).to receive(:new).and_return(mock_redis)
            expect(mock_redis).to receive(:lrem).never
            expect(mock_redis).to receive(:lrange).with(any_args).and_return(['stay', 'stay', 'stay', 'stay']).never
            subject.remove(queue_name, string_identifier)
          end
        end
      end
    end

    context "when inputs are NOT valid" do
      it "should return nil" do
        result = subject.remove(nil, nil)
        expect(result).to be_nil
      end
    end
    
  end 
end
