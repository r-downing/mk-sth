# usage examples:
# {{ some_condition | assert: "error message"}}

module Jekyll
  module AssertFilter
    def assert(condition, message)
      unless condition
        current_file = @context.template_name || @context.registers[:page]['path'] rescue "unknown file"

        raise "\n[ASSERTION FAILED] in #{current_file}: #{message}\n"
      end
      # empty HTML output
      ""
    end
  end
end

Liquid::Template.register_filter(Jekyll::AssertFilter)
