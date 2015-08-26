RSpec::Core::RakeTask.new(:spec)

desc 'run cucumber features'
task :features => 'application:start' do
  Cucumber::Rake::Task.new(:cucumber) do |t|
    t.cucumber_opts = "features --format pretty port=#{Application.port}"
  end
  Rake::Task[:cucumber].invoke
end