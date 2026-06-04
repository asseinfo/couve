# frozen_string_literal: true

require_relative "couve/version"
require_relative "couve/parser"

module Couve
  def self.start
    coverage_file = ARGV[0]
    output_file = ARGV[1]

    coverage = File.read(coverage_file)
    parser = Couve::Parser.new(coverage)

    report = output_file.end_with?(".md") ? parser.to_markdown : parser.to_html

    File.open(output_file, "w") do |f|
      f.puts report
    end
  end
end
