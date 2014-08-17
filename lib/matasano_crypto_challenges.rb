def require_contained(&block)
  options = Struct.new(:level).new(1)
  block.call options
  pattern_relative = (['..'] * options.level).join('/')
  filename = block.binding.eval('__FILE__')
  pattern = /^#{Regexp.escape File.expand_path(pattern_relative, filename)}\/(.+)\.rb$/
  Dir.glob(File.expand_path("../#{File.basename filename, '.rb'}/*.rb",
           filename)) do |f|
    require f.gsub(pattern, '\1')
  end
end

require_contained do |options|
  options.level = 1
end

module MatasanoCryptoChallenges; end
