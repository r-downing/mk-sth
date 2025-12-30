module Jekyll
  class RunCommandTag < Liquid::Tag
    def initialize(tag_name, command, tokens)
      super
      @command = command.strip
    end

    def render(context)
      `#{@command}`.rstrip
    rescue => e
      "Error executing command: #{e.message}"
    end
  end
end

Liquid::Template.register_tag('run_cmd', Jekyll::RunCommandTag)
