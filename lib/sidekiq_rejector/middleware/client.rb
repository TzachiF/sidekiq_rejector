# Client middleware that removes jobs 
# if they answer the condition of being part of the
# configured strings (worker or method)
module SidekiqRejector
  module Middleware
    class Client
      ENABLE_VAR = 'SIDEKIQ_REJECTOR_ENABLED'
      REJECT_VALUES = 'SIDEKIQ_REJECTOR_VALUES'
      TRUE = 'true'

      def call(worker_class, item, queue, redis_pool = nil)
        if enabled?
          if empty?
            yield
          else
            return false if remove_job?(item)
          end
        else
          yield
        end  
      end

      private

      def enabled?
        ENV[ENABLE_VAR] == TRUE
      end

      def empty?
        ENV[REJECT_VALUES].nil?
      end

      def remove_job?(item)
        splited_reject_values.each do |value|
          return true if item.include?(value)
        end
        false
      end

      def splited_reject_values
        @splited_reject_values ||= ENV[REJECT_VALUES].split(',')
      end
    end
  end
end
