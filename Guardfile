# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard 'livereload' do
  watch(%r{.+\.rb})
  watch(%r{lib/.+})
  watch(%r{public/.+})
  watch(%r{views/.+})
end

guard 'rspec' do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^(.+)\.rb$})     { |m| "spec/#{m[1]}_spec.rb" }
  watch('spec/spec_helper.rb')  { "spec" }
end

