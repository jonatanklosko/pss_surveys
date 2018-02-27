Delayed::Worker.destroy_failed_jobs = false
Delayed::Worker.max_run_time = 10.minutes
Delayed::Worker.delay_jobs = !Rails.env.test?
Delayed::Worker.logger = Logger.new(File.join(Rails.root, 'log', 'delayed_job.log'))
