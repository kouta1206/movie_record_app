require 'rspec/core/formatters/base_text_formatter'

class ChristmasFormatter
    RSpec::Core::Formatters.register self, :example_passed, :example_failed, :start_dump

    attr_accessor :success_count, :failed_count

    def initialize(output)
    @output = output
    self.success_count = 0
    self.failed_count = 0
    end
    def example_passed(notification)
      @output <<  "success!\n"
      self.success_count += 1
    end
    def example_failed(notification)
      @output << "failed!\n"
      self.failed_count += 1
    end
    def start_dump(_notification)
        puts"#{success_count} success!"
        puts "#{failed_count} failed!"
      end
    
  end
