# Sometimes it's a README fix, or something like that - which isn't relevant for
# including in a project's CHANGELOG for example
declared_trivial = github.pr_title.include? "#trivial"

# Make it more obvious that a PR is a work in progress and shouldn't be merged yet
warn("PR is classed as Work in Progress") if github.pr_title.include? "[WIP]"

# Warn when there is a big PR
fail("More than 30 commits") if ENV['CIRCLE_BRANCH'] !~ /^epic/ && git.commits.size > 30

# Don't let testing shortcuts get into master by accident
# fail("fdescribe left in tests") if `grep -r fdescribe specs/ `.length > 1
# fail("fit left in tests") if `grep -r fit specs/ `.length > 1

DIRECTORIES_TO_IGNORE = ['db/', 'spec/'].freeze

# Trigger Rubocop on Modified Files
ruby_files = (git.modified_files + git.added_files - git.deleted_files).select { |path| path.include?(".rb") }
ruby_files = ruby_files.compact.reject do |file_path|
  file_path.empty? || DIRECTORIES_TO_IGNORE.any? { |directory| file_path.include?(directory) }
end

if !ruby_files.empty? && ENV['CIRCLE_BRANCH'] !~ /(development|master|staging)/
  rubocop.lint(files: ruby_files, report_danger: true, force_exclusion: true)
end

# Ensure Trello or PivotalTracker URL is included
prefixes = ["[NoTrello]", "[NoPivotalTracker]"]

if !prefixes.any? { |prefix| github.pr_title.include?(prefix) }
  if git.commits.any? { |c| c.message !~ /(trello|pivotaltracker)/ }
    warn('Please put Trello or PivotalTracker URL in each commit body')
  end
end

# Lint for commit messages
commit_lint.check warn: :all
