require 'fileutils'
require 'open3'
require 'ruby-progressbar'
require 'safe_yaml/load'
require 'securerandom'

SafeYAML::OPTIONS[:default_mode] = :safe

all_cases_passed = true

base_dir       = File.absolute_path(File.dirname(__FILE__))
test_cases_dir = File.join(base_dir, "test_cases")
temp_dir       = File.join(base_dir, ".temp")
template_dir   = File.join(base_dir, "template")

FileUtils.mkdir_p(temp_dir)

test_cases = Dir.foreach(test_cases_dir).select do |fn|
  %w(yml yaml).include? File.extname(fn).downcase[1..-1]
end

progressbar = ProgressBar.create(:total => test_cases.length)

Dir.foreach(test_cases_dir) do |file_name|
  next unless %w(yml yaml).include? File.extname(file_name).downcase[1..-1]

  # Load the test case
  test_case = SafeYAML.load_file(File.join(test_cases_dir, file_name))

  # Setting up
  random_id = SecureRandom.hex
  test_dir  = File.join(temp_dir, random_id)
  FileUtils.cp_r(template_dir, test_dir)
  FileUtils.cd(test_dir)

  # Append extra config if needed
  if test_case.has_key?("config")
    yaml_string        = test_case["config"].to_yaml
    yaml_string["---"] = ""

    File.open("_config.yml", "a") do |f|
      f << yaml_string
    end
  end

  # Create posts if needed
  if test_case.has_key?("posts")
    Array[test_case["posts"]].each_with_index do |post, i|
      File.open("_posts/2015-01-19-post-#{i}.markdown", "w") do |f|
        f << post.select { |k, _| !%w(content expectations).include? k }.to_yaml
        f << "---\n"
        f << post["content"] if post.has_key?("content")
      end
    end
  end

  # Trigger jekyll build
  stdin, stdout, stderr, wait_thr = Open3.popen3("bundle exec jekyll build")
  unless wait_thr.value.to_i.zero?
    # something's wrong with jekyll build, display error message and run
    progressbar.log "Cannot build #{file_name}:"
    progressbar.log stdout.read
    progressbar.log ""
    progressbar.increment
    [stdin, stdout, stderr].each(&:close)
    next
  end
  [stdin, stdout, stderr].each(&:close)

  # Assertions
  should_appear_failures = should_not_appear_failures = []
  if test_case.has_key?("posts")
    Array[test_case["posts"]].each_with_index do |post, i|
      File.open("_site/post-#{i}.html") do |f|
        content = f.read

        if post.has_key?("expectations") && post["expectations"].has_key?("should_appear")
          should_appear_failures = Array(post["expectations"]["should_appear"]).reject do |str|
            content[str]
          end
        end

        if post.has_key?("expectations") && post["expectations"].has_key?("should_not_appear")
          should_not_appear_failures = Array(post["expectations"]["should_not_appear"]).select do |str|
            content[str]
          end
        end
      end
    end
  end

  test_passed = should_appear_failures.none? && should_not_appear_failures.none?

  # Report failure
  if !test_passed
    all_cases_passed = false

    progressbar.log "#{file_name} (#{random_id}) failed:"

    if should_appear_failures.any?
      progressbar.log "Should appear but does not:"
      should_appear_failures.each { |str| progressbar.log " - #{str.inspect}" }
    end

    if should_not_appear_failures.any?
      progressbar.log "Should not appear but appears:"
      should_not_appear_failures.each { |str| progressbar.log " - #{str.inspect}" }
    end

    progressbar.log ""
  end

  # Clean up
  FileUtils.cd(base_dir)
  FileUtils.rm_r(test_dir) if test_passed

  progressbar.increment
end

exit(1) unless all_cases_passed
