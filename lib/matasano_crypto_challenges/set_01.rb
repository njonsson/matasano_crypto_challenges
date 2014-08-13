pattern = /^#{Regexp.escape File.expand_path('../..', __FILE__)}\/(.+)\.rb$/
Dir.glob(File.expand_path("../#{File.basename __FILE__, '.rb'}/*.rb", __FILE__ )) do |f|
  require f.gsub(pattern, '\1')
end

module MatasanoCryptoChallenges

  module Set01; end

end
