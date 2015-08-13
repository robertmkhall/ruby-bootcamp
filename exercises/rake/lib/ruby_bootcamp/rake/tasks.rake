namespace :tasks do

  desc 'List directory contents'
  task :list, [:path, :pattern] do |task, args|

    args.with_defaults(pattern: '*')

    path = args[:path].to_s
    pattern = args[:pattern].to_s

    begin
      if Dir.exists?(path)
        Dir.glob([path, pattern]).each { |r| puts r }
      else
        puts "Path '#{path}' not found!"
      end
    end
  end
end