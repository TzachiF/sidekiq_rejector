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
        Helpers::Validator.new(ENV[REJECT_VALUES]).reject?(item)
      end
    end
  end
end
