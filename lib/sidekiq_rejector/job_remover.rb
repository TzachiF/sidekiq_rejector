module SidekiqRejector
  # This class handels the remove of jobs from a queue
  # Inputs:
  # queue_name: name of the target queue
  # string_identifier: the name of the method(if called using delay) OR worket class name
  # or any other unique identefier that is perssited as part of the job.
  # Output: The number of removed jobs
  class JobRemover
    def self.remove(queue_name, string_identifier)
      return if queue_name.nil? || string_identifier.nil?
      remove_count = 0
      Sidekiq.redis do |r| 
        all_jobs_in_queue = r.lrange queue_name, 0,-1
        all_jobs_in_queue.each do |job|
          if job.include?(string_identifier)
            r.lrem queue_name, 1, job
            remove_count = remove_count + 1
          end
        end
      end
      remove_count
    end
  end
end