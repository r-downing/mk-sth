module Jekyll
  class GitCommitGenerator < Generator
    priority :highest
    def generate(site)
      commit_hash = ENV['JEKYLL_BUILD_REVISION'] || `git rev-parse --short HEAD`.strip
      if !`git status --short`.strip.empty?
        commit_hash += "-dirty"
      end
      site.config['commit_hash'] = commit_hash
      site.config['commit_timestamp'] = `TZ="America/New_York" git log -1 --format=%cd --date=iso-local`.strip
    end
  end
end
